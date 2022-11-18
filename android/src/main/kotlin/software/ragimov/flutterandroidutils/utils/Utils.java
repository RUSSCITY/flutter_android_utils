package software.ragimov.flutterandroidutils.utils;

import android.content.ComponentName;
import android.content.Context;
import android.provider.Settings;
import android.text.TextUtils;

import java.lang.reflect.Method;
import android.content.Intent;
import android.os.Build;

public class Utils {

    public static boolean isAccessibilityServiceEnabled(Context context, String accessibilityServiceName) {
        if (accessibilityServiceName != null) {
            try {
                Class<?> accessibilityService = Class.forName(accessibilityServiceName);
                return isAccessibilityServiceEnabled(
                        context,
                        accessibilityService
                );
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }
        return false;
    }

    public static boolean isAccessibilityServiceEnabled(Context context, Class<?> accessibilityService) {
        try {
            ComponentName expectedComponentName = new ComponentName(context, accessibilityService);

            String enabledServicesSetting = Settings.Secure.getString(context.getContentResolver(), Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES);
            if (enabledServicesSetting == null)
                return false;

            TextUtils.SimpleStringSplitter colonSplitter = new TextUtils.SimpleStringSplitter(':');
            colonSplitter.setString(enabledServicesSetting);

            while (colonSplitter.hasNext()) {
                String componentNameString = colonSplitter.next();
                ComponentName enabledService = ComponentName.unflattenFromString(componentNameString);

                if (enabledService != null && enabledService.equals(expectedComponentName))
                    return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public static boolean startService(Context context, String accessibilityServiceName) {
        try {
            Class<?> accessibilityService = Class.forName(accessibilityServiceName);
            Intent intent = new Intent(context, accessibilityService);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent);
            } else {
                context.startService(intent);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public static boolean isScreenAccessProvided(Context context) {
        try {
            Context mainApplicationContext = context.getApplicationContext();
            Method m = mainApplicationContext.getClass().getMethod("getMediaIntent");
            Object rv = m.invoke(mainApplicationContext);
            return rv != null;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean requestScreenAccess(Context context) {
        try {
            Context mainApplicationContext = context.getApplicationContext();
            Method m = mainApplicationContext.getClass().getMethod("requestVideoIntent");
            Object rv = m.invoke(mainApplicationContext);
            return rv != null;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean test(Context context) {
        try {
            Class[] cArg = new Class[1];
            cArg[0] = Intent.class;
            Context mainApplicationContext = context.getApplicationContext();
            Method m = mainApplicationContext.getClass().getMethod("setMediaIntent", cArg);
            m.invoke(mainApplicationContext, new Intent());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }
}
