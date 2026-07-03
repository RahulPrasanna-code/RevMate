package com.yourname.revmate.revmate.dash

import android.os.Handler
import android.os.Looper
import android.util.Log
import com.yourname.revmate.revmate.dash.protocol.DashCommands
import com.yourname.revmate.revmate.dash.protocol.K1GPacket
import com.yourname.revmate.revmate.dash.protocol.Tlv
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.Executors
import javax.crypto.Cipher
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec

class HimalayanDashboardService {
    private val executor = Executors.newSingleThreadExecutor()
    private val handler = Handler(Looper.getMainLooper())
    private var socket: DashSocket? = null
    private var auth: DashAuth? = null
    private var isRunning = false
    
    var eventSink: EventChannel.EventSink? = null

    fun connect(ssid: String) {
        if (isRunning) return
        isRunning = true
        executor.execute {
            try {
                val sock = DashSocket()
                socket = sock
                auth = DashAuth(ssid)
                
                // Send initial burst
                DashCommands.initialBurst("RevMate").forEach {
                    sock.send(it)
                    Thread.sleep(20)
                }
                
                // Receive loop
                while (isRunning) {
                    val pkt = sock.receive() ?: continue
                    val tlvs = K1GPacket.parseIncoming(pkt)
                    for (tlv in tlvs) {
                        handleTlv(tlv, sock)
                    }
                }
            } catch (e: Exception) {
                Log.e("HimalayanDash", "Error: ${e.message}")
                stop()
            }
        }
    }

    private fun handleTlv(tlv: Tlv, sock: DashSocket) {
        when (tlv.type) {
            0x07 -> {
                val event = auth?.ingest(tlv)
                if (event is AuthEvent.SendKey) {
                    sock.send(event.packet)
                } else if (event == AuthEvent.Confirmed) {
                    sendToFlutter("status", "connected")
                }
            }
            0x09 -> if (tlv.sub == 0x00) {
                sendToFlutter("button", tlv.value.last().toInt() and 0xFF)
            }
            0x0F -> {
                val key = auth?.sessionKey
                if (key != null) {
                    val plain = decryptTelemetry(tlv.value, key)
                    if (plain != null) {
                        sendToFlutter("telemetry", plain.joinToString(",") { (it.toInt() and 0xFF).toString() })
                    }
                }
            }
        }
    }

    private fun decryptTelemetry(data: ByteArray, key: ByteArray): ByteArray? {
        if (data.size <= 16) return null
        return try {
            val cipher = Cipher.getInstance("AES/CBC/PKCS5Padding")
            cipher.init(Cipher.DECRYPT_MODE, SecretKeySpec(key, "AES"), IvParameterSpec(data.copyOfRange(0, 16)))
            cipher.doFinal(data.copyOfRange(16, data.size))
        } catch (e: Exception) { null }
    }

    private fun sendToFlutter(type: String, data: Any) {
        handler.post {
            eventSink?.success(mapOf("type" to type, "data" to data))
        }
    }

    fun stop() {
        isRunning = false
        socket?.close()
        socket = null
        sendToFlutter("status", "disconnected")
    }
}
