package com.yourname.revmate.revmate.dash

import android.util.Log
import com.yourname.revmate.revmate.dash.protocol.K1GPacket
import java.net.DatagramPacket
import java.net.DatagramSocket
import java.net.InetAddress
import java.net.InetSocketAddress
import java.util.concurrent.atomic.AtomicInteger

class DashSocket(private val network: android.net.Network? = null) : AutoCloseable {
    companion object {
        const val DASH_IP    = "192.168.1.1"
        const val BROADCAST  = "192.168.1.255"
        const val CTRL_PORT  = 2000
        const val RX_PORT    = 2002
        private const val BUF             = 65535
        private const val RECV_TIMEOUT_MS = 500
        private const val TAG             = "DashSocket"
    }

    private val broadcastAddr: InetAddress = InetAddress.getByName(BROADCAST)
    private val txSocket:  DatagramSocket
    private val rxSocket:  DatagramSocket

    private val seq = AtomicInteger(0)

    init {
        var tx:  DatagramSocket? = null
        var rx:  DatagramSocket? = null
        try {
            tx = DatagramSocket(null).also {
                it.reuseAddress = true
                it.broadcast = true
                it.bind(InetSocketAddress(CTRL_PORT))
                network?.bindSocket(it)
            }
            rx = DatagramSocket(null).also {
                it.reuseAddress = true
                it.soTimeout = RECV_TIMEOUT_MS
                it.bind(InetSocketAddress(RX_PORT))
                network?.bindSocket(it)
            }
            txSocket  = tx
            rxSocket  = rx
        } catch (e: Exception) {
            tx?.close(); rx?.close()
            throw e
        }
    }

    fun send(data: ByteArray) {
        val pkt = K1GPacket.patchSeq(data, seq.getAndIncrement())
        try {
            txSocket.send(DatagramPacket(pkt, pkt.size, broadcastAddr, CTRL_PORT))
        } catch (e: Exception) {
            Log.w(TAG, "TX send failed: ${e.message}")
        }
    }

    fun receive(): ByteArray? {
        val buf = DatagramPacket(ByteArray(BUF), BUF)
        return try {
            rxSocket.receive(buf)
            buf.data.copyOf(buf.length)
        } catch (_: java.net.SocketTimeoutException) {
            null
        }
    }

    override fun close() {
        runCatching { txSocket.close() }
        runCatching { rxSocket.close() }
    }
}
