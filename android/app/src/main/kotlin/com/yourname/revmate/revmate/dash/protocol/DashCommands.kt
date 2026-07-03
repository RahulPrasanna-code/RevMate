package com.yourname.revmate.revmate.dash.protocol

import java.io.ByteArrayOutputStream
import java.util.Calendar

object DashCommands {
    fun authRequest() = "0016000200000000020100054b314720000804000101".hexToBytes()

    fun authSendKey(ciphertext: ByteArray): ByteArray {
        require(ciphertext.size == 128) { "q3c.d expects 128B RSA ciphertext, got ${ciphertext.size}" }
        return "0095000200000000020100054B3147200008000080".hexToBytes() + ciphertext
    }

    fun initialBurst(hostname: String): List<ByteArray> = listOf(
        authRequest(),
        hostnameAnnounce(hostname),
        timeSync(),
        "0016000200000000020100054b314720030557000155".hexToBytes(),
        "0016000200000000020100054b3147200405560001aa".hexToBytes(),
        "0016000200000000020100054b3147200506050001aa".hexToBytes(),
        "0016000200000000020100054b3147200605170001aa".hexToBytes(),
        "001d000200000000020100054b314720080a020008aa55000000000000".hexToBytes(),
        ("0044000a00000000020100054b3147200906080001ff060300015506040001a2060f0001aa" +
         "0601000101054c000113052d00020000051b0001190521000132054d000132").hexToBytes(),
    )

    fun timeSync(): ByteArray {
        val cal = Calendar.getInstance()
        return K1GPacket.build(
            K1GPacket.tlv(
                0x06, 0x06,
                cal.get(Calendar.HOUR_OF_DAY),
                cal.get(Calendar.MINUTE),
                cal.get(Calendar.SECOND),
            )
        )
    }

    fun hostnameAnnounce(hostname: String): ByteArray {
        val raw = hostname.toByteArray(Charsets.UTF_8).let {
            if (it.size > 200) it.copyOf(200) else it
        }
        val out = ByteArrayOutputStream()
        out.write("0021000200000000020100054b314720".hexToBytes())
        out.write(byteArrayOf(0x01, 0x06, 0x0B, 0x00, (raw.size + 1).toByte()))
        out.write(raw)
        out.write(0x00)
        val bytes = out.toByteArray()
        bytes[0] = ((bytes.size shr 8) and 0xFF).toByte()
        bytes[1] = (bytes.size and 0xFF).toByte()
        return bytes
    }

    fun heartbeat(tempC: Int = 25): ByteArray {
        val hb = ("0049000b00000000020100054b3147200006080001050610000139060300015506040001a2060f0001aa" +
                  "0601000101054c000113052d00020000051b0001190521000132054d000132").hexToBytes()
        val marker = byteArrayOf(0x06, 0x10, 0x00, 0x01)
        val i = indexOf(hb, marker)
        if (i >= 0 && i + 4 < hb.size) hb[i + 4] = ((tempC + 40) and 0xFF).toByte()
        return hb
    }

    private fun indexOf(haystack: ByteArray, needle: ByteArray): Int {
        for (i in 0..haystack.size - needle.size) {
            var found = true
            for (j in needle.indices) {
                if (haystack[i + j] != needle[j]) {
                    found = false
                    break
                }
            }
            if (found) return i
        }
        return -1
    }
}
