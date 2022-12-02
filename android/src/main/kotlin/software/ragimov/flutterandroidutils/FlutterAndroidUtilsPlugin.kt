package software.ragimov.flutterandroidutils

import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import software.ragimov.flutterandroidutils.utils.Utils

/** FlutterAndroidUtilsPlugin */
class FlutterAndroidUtilsPlugin : FlutterPlugin, MethodCallHandler {
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

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "isAccessibilityEnabled") {
            val className = call.argument<String>("serviceClassName")
            result.success(Utils.isAccessibilityServiceEnabled(mContext, className))
        } else if (call.method == "isServiceRunning") {
            val className = call.argument<String>("serviceClassName")
            result.success(Utils.isServiceRunning(mContext, className))
        } else if (call.method == "startService") {
            val className = call.argument<String>("serviceClassName")
            result.success(Utils.startService(mContext, className))
        } else if (call.method == "stopService") {
            val className = call.argument<String>("serviceClassName")
            result.success(Utils.stopService(mContext, className))
        } else if (call.method == "isScreenAccessProvided") {
            result.success(Utils.isScreenAccessProvided(mContext))
        } else if (call.method == "requestScreenAccess") {
            result.success(Utils.requestScreenAccess(mContext))
        } else if (call.method == "stopScreenAccess") {
            result.success(Utils.stopScreenAccess(mContext))
        } else if (call.method == "test") {
            result.success(Utils.test(mContext))
        } else if (call.method == "getSharedPreferencesBool") {
            val name = call.argument<String>("name")
            val defaultValue = call.argument<Boolean>("defaultValue")
            result.success(Utils.getSharedPreferencesBool(mContext, name, defaultValue))
        } else if (call.method == "getSharedPreferencesInt") {
            val name = call.argument<String>("name")
            val defaultValue = call.argument<Int>("defaultValue")
            result.success(Utils.getSharedPreferencesInt(mContext, name, defaultValue))
        } else if (call.method == "getSharedPreferencesLong") {
            val name = call.argument<String>("name")
            val defaultValue = call.argument<Long>("defaultValue")
            result.success(Utils.getSharedPreferencesLong(mContext, name, defaultValue))
        } else if (call.method == "getSharedPreferencesString") {
            val name = call.argument<String>("name")
            val defaultValue = call.argument<String>("defaultValue")
            result.success(Utils.getSharedPreferencesString(mContext, name, defaultValue))
        } else if (call.method == "putSharedPreferencesBool") {
            val name = call.argument<String>("name")
            val value = call.argument<Boolean>("value")
            result.success(Utils.putSharedPreferencesBool(mContext, name, value))
        } else if (call.method == "putSharedPreferencesInt") {
            val name = call.argument<String>("name")
            val value = call.argument<Int>("value")
            result.success(Utils.putSharedPreferencesInt(mContext, name, value))
        } else if (call.method == "putSharedPreferencesLong") {
            val name = call.argument<String>("name")
            val value = call.argument<Long>("value")
            result.success(Utils.putSharedPreferencesLong(mContext, name, value))
        } else if (call.method == "putSharedPreferencesString") {
            val name = call.argument<String>("name")
            val value = call.argument<String>("value")
            result.success(Utils.putSharedPreferencesString(mContext, name, value))
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
