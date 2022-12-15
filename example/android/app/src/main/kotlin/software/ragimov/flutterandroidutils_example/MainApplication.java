package software.ragimov.flutterandroidutils_example;

import android.content.BroadcastReceiver;
import android.content.Intent;
import android.content.Context;
import android.content.IntentFilter;

import java.util.Date;

import io.flutter.app.FlutterApplication;
import city.russ.GetScreenCaptureActivity;
import city.russ.MyUtils;

public class MainApplication extends FlutterApplication {
	Intent mediaIntent;
	BroadcastReceiver broadcastReceiver;

	@Override
	public void onCreate() {
		super.onCreate();
		MyUtils.initChannels(this);
		broadcastReceiver = new BroadcastReceiver() {
			@Override
			public void onReceive(Context context, Intent intent) {
				Intent intent1 = new Intent("BROADCAST_CHANNEL_LISTENER");
				intent1.putExtra("message", new Date().toString());
				sendBroadcast(intent1);
			}
		};
		registerReceiver(broadcastReceiver, new IntentFilter("BROADCAST_CHANNEL_SENDER"));
	}

	public void setMediaIntent(Intent intent) {
		mediaIntent = intent;
	}

	public Intent getMediaIntent() {
		return mediaIntent;
	}

	public void requestVideoIntent() {
		Intent intent = new Intent(this, GetScreenCaptureActivity.class);
		intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
		this.startActivity(intent);
	}

	public static MainApplication getInstance(Context context) {
		return ((MainApplication) context.getApplicationContext());
	}
}
