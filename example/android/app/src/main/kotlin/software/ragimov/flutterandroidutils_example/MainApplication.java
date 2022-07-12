package software.ragimov.flutterandroidutils_example;

import android.content.Intent;

import io.flutter.app.FlutterApplication;

public class MainApplication extends FlutterApplication {
    Intent mediaIntent;

    @Override
    public void onCreate() {
        super.onCreate();
        setMediaIntent(new Intent());
    }

    public void setMediaIntent(Intent intent) {
        mediaIntent = intent;
    }

    public Intent getMediaIntent() {
        return mediaIntent;
    }
}
