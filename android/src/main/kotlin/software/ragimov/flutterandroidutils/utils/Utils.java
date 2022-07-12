package software.ragimov.flutterandroidutils.utils;

import android.content.ComponentName;
import android.content.Context;
import android.provider.Settings;
import android.text.TextUtils;

import java.lang.reflect.Method;

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

    public static boolean isScreenAccessProvided(Context context) {
        try {
            Context mainApplicationContext = context.getApplicationContext();
            Method m = context.getApplicationContext().getClass().getMethod("getMediaIntent");
            Object rv = m.invoke(mainApplicationContext);
            return rv != null;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
