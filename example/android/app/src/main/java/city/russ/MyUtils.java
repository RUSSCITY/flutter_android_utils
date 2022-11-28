package city.russ;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.graphics.Color;
import android.os.Build;

import androidx.annotation.RequiresApi;


public class MyUtils {
	public static final String CHANNEL_ID_PERSISTENT_ALL_TIME_NOTIFICATION = "channel_id_persistent_all_time_notification";

	public static void initChannels(Context context) {
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
			createNotificationChannel(context, "service_notification_channel_id", "service_notification_channel_description");
		}
	}

	@RequiresApi(Build.VERSION_CODES.O)
	public static void createNotificationChannel(Context context, String channelId, String channelName) {
		try {
			NotificationChannel chan = new NotificationChannel(channelId,
					channelName, NotificationManager.IMPORTANCE_LOW);
			chan.setLightColor(Color.BLUE);
			chan.setLockscreenVisibility(Notification.VISIBILITY_PRIVATE);
			NotificationManager service = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
			if (service != null) {
				service.createNotificationChannel(chan);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
