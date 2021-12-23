package com.cairvine.analytics_support

import androidx.annotation.NonNull

import com.google.android.gms.analytics.GoogleAnalytics
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AnalyticsSupportPlugin */
class AnalyticsSupportPlugin: FlutterPlugin, MethodCallHandler {
    enum class TrackerMethod {
        GET_GOOGLE_CLIENT_ID { override val value = "getGoogleClientId" };
        abstract val value: String
    }

    enum class Channel {
        TRACKER { override fun valueWith(name: String) = "$name/tracker" };
        abstract fun valueWith(name: String): String
    }

    companion object {
        private const val CHANNEL_NAME = "com.cairvine.analytics_support"
    }

    private lateinit var channel : MethodChannel
    private lateinit var analytics : GoogleAnalytics

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        analytics = GoogleAnalytics.getInstance(flutterPluginBinding.applicationContext)
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, Channel.TRACKER.valueWith(CHANNEL_NAME))
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        val parameters = call.arguments<String>()
        if (call.method == TrackerMethod.GET_GOOGLE_CLIENT_ID.value && parameters != null) {
            result.success(if (parameters.isEmpty()) null else analytics.newTracker(parameters).get("&cid"))
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
