package com.yourname.revmate.revmate.revmate

import com.yourname.revmate.revmate.dash.HimalayanDashboardService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val dashService = HimalayanDashboardService()
    private val METHOD_CHANNEL = "com.revmate/himalayan_dash"
    private val EVENT_CHANNEL = "com.revmate/himalayan_events"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "connect" -> {
                    val ssid = call.argument<String>("ssid") ?: "RE_Himalayan"
                    dashService.connect(ssid)
                    result.success(null)
                }
                "disconnect" -> {
                    dashService.stop()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    dashService.eventSink = events
                }

                override fun onCancel(arguments: Any?) {
                    dashService.eventSink = null
                }
            }
        )
    }
}
