package city.russ;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.drawable.ColorDrawable;
import android.media.projection.MediaProjectionManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import software.ragimov.flutterandroidutils_example.MainApplication;

@TargetApi(Build.VERSION_CODES.LOLLIPOP)
public class GetScreenCaptureActivity extends Activity {
    private static final int CAPTURE_PERMISSION_REQUEST_CODE = 1551;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));
        startScreenCapture();
    }

    private void startScreenCapture() {
        MediaProjectionManager mediaProjectionManager =
                (MediaProjectionManager) getApplication().getSystemService(
                        Context.MEDIA_PROJECTION_SERVICE);
        startActivityForResult(
                mediaProjectionManager.createScreenCaptureIntent(), CAPTURE_PERMISSION_REQUEST_CODE);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode != CAPTURE_PERMISSION_REQUEST_CODE) {
            Log.d("RRRR", "GetScreenCaptureActivity. No capture permissions.");
            return;
        }
        if (resultCode == Activity.RESULT_OK) {
            MainApplication.getInstance(this).setMediaIntent(data);
        }
        this.finish();
    }
}

