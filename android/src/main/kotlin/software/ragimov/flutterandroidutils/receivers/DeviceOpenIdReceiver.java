package software.ragimov.flutterandroidutils.receivers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;

import java.util.UUID;

import android.util.Log;


public class DeviceOpenIdReceiver extends BroadcastReceiver {
    public static final String ACTION_DEVICE_OPEN_ID = "software.ragimov.openid";
    public static final String DEVICE_OPEN_ID = "DEVICE_OPEN_ID";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (ACTION_DEVICE_OPEN_ID.equals(intent.getAction())) {
            Log.i("RRR", "SOMETHING RECEIVED");

            String packageName = intent.getStringExtra("package_name");
            String myPackageName = context.getPackageName();
            if (!myPackageName.equals(packageName) && packageName != null) {
                if (intent.getStringExtra("m_action").equals("request")) {

                    String deviceOpenId = getDeviceOpenId(context);

                    Intent response = new Intent(ACTION_DEVICE_OPEN_ID);
                    response.putExtra("m_action", "response");
                    response.putExtra("package_name", myPackageName);
                    response.putExtra("open_id", deviceOpenId);

                    context.sendBroadcast(response);
                } else if (intent.getStringExtra("m_action").equals("response")) {
                    String openId = intent.getStringExtra("open_id");
                    if (openId != null && !openId.equals("-")) {
                        SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(context.getApplicationContext());
                        sharedPreferences.edit().putString(DEVICE_OPEN_ID, openId).commit();
                    }
                }
            }
        }
    }

    public static void init(Context context) {
        String deviceOpenId = getDeviceOpenId(context);
        Log.i("RRR", "Init device open id: " + deviceOpenId);
        if (deviceOpenId.equals("-")) {
            Intent intent = new Intent(ACTION_DEVICE_OPEN_ID);
            intent.putExtra("m_action", "request");
            intent.putExtra("package_name", context.getPackageName());
            context.sendBroadcast(intent);
        }
    }

    public static String getDeviceOpenId(Context context) {
        SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(context.getApplicationContext());
        String deviceOpenId = sharedPreferences.getString(DEVICE_OPEN_ID, "-");
        Log.i("RRR", "Get Device Open Id: " + deviceOpenId);
        return deviceOpenId;
    }

    public static String generateOpenId(Context context) {
        SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(context.getApplicationContext());
        String deviceOpenId = UUID.randomUUID().toString();
        sharedPreferences.edit().putString(DEVICE_OPEN_ID, deviceOpenId).apply();
        Log.i("RRR", "Generate Device Open Id: " + deviceOpenId);
        return deviceOpenId;
    }
}
