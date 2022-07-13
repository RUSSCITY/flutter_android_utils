package software.ragimov.flutterandroidutils_example;

import android.content.Intent;
import android.content.Context;

import io.flutter.app.FlutterApplication;
import city.russ.GetScreenCaptureActivity;

public class MainApplication extends FlutterApplication {
    Intent mediaIntent;

    @Override
    public void onCreate() {
        super.onCreate();
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
