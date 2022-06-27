package software.ragimov.flutterandroidutils

import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import software.ragimov.flutterandroidutils.utils.Utils

/** FlutterandroidutilsPlugin */
class FlutterandroidutilsPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var mContext: Context

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutterandroidutils")
        channel.setMethodCallHandler(this)
        mContext = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "isAccessibilityEnabled") {
            val className = call.argument<String>("serviceClassName")
            if (className != null) {
                try {
                    val accessibilityService = Class.forName(className)
                    result.success(
                        Utils.isAccessibilityServiceEnabled(
                            mContext,
                            accessibilityService
                        )
                    )
                } catch (e: Exception) {
                    e.printStackTrace()
                    result.success(false)
                }
            } else {
                result.success(false)
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
