package city.russ.services;

import android.app.Service;
import android.app.Notification;
import android.content.Intent;
import android.os.IBinder;

import androidx.core.app.NotificationCompat;

public class MainService extends Service {
    final int MAIN_SERVICE_NOTIFICATION = 323;

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        startForeground(
                MAIN_SERVICE_NOTIFICATION,
                getNotification()
        );
        return Service.START_NOT_STICKY;
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    Notification getNotification() {
        NotificationCompat.Builder builder = new NotificationCompat.Builder(
                        this,
                        "service_notification_channel_id"
                )
                .setOngoing(true)
                .setPriority(Notification.PRIORITY_LOW)
                .setWhen(System.currentTimeMillis());

        String title = "getString(R.string.device_under_control)";
        String contentText = "";

        builder.setContentTitle(title)
                .setContentText(contentText);
        return builder.build();
    }
}