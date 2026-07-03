package com.yourname.revmate.revmate.dash

import com.yourname.revmate.revmate.dash.protocol.DashCommands
import com.yourname.revmate.revmate.dash.protocol.Tlv
import java.security.KeyFactory
import java.security.SecureRandom
import java.security.spec.RSAPublicKeySpec
import java.math.BigInteger
import javax.crypto.Cipher

sealed class AuthEvent {
    data class SendKey(val packet: ByteArray) : AuthEvent()
    object Confirmed : AuthEvent()
    object Rejected : AuthEvent()
}

class DashAuth(private val ssid: String) {
    private var modulus: ByteArray? = null
    private var exponent: ByteArray? = null
    var sessionKey: ByteArray? = null
        private set

    fun ingest(tlv: Tlv): AuthEvent? {
        when (tlv.type) {
            0x07 -> when (tlv.sub) {
                0x00 -> { modulus = tlv.value; return checkKey() }
                0x03 -> { exponent = tlv.value; return checkKey() }
                0x01 -> return if (tlv.value.firstOrNull()?.toInt() == 0x01) AuthEvent.Confirmed else AuthEvent.Rejected
            }
        }
        return null
    }

    private fun checkKey(): AuthEvent? {
        val m = modulus ?: return null
        val e = exponent ?: return null
        
        val key = SecureRandom().generateSeed(32)
        sessionKey = key
        
        val rsa = Cipher.getInstance("RSA/ECB/PKCS1Padding")
        val pub = KeyFactory.getInstance("RSA").generatePublic(
            RSAPublicKeySpec(BigInteger(1, m), BigInteger(1, e))
        )
        rsa.init(Cipher.ENCRYPT_MODE, pub)
        
        val payload = ssid.toByteArray(Charsets.UTF_8) + key
        val encrypted = rsa.doFinal(payload)
        
        return AuthEvent.SendKey(DashCommands.authSendKey(encrypted))
    }

    fun reset() {
        modulus = null
        exponent = null
    }
}
