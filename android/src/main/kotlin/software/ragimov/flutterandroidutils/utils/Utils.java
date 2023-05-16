package software.ragimov.flutterandroidutils.utils;

import android.app.Activity;
import android.app.ActivityManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.SharedPreferences;
import android.media.projection.MediaProjection;
import android.media.projection.MediaProjectionManager;
import android.preference.PreferenceManager;
import android.provider.Settings;
import android.text.TextUtils;
import android.content.pm.PackageManager;

import java.lang.reflect.Method;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;

import org.jetbrains.annotations.NotNull;

import software.ragimov.flutterandroidutils.camera.MCameraManager;

public class Utils {

    public static boolean isAccessibilityServiceEnabled(Context context, String accessibilityServiceName) {
        if (accessibilityServiceName != null) {
            try {
                Class<?> accessibilityService = Class.forName(accessibilityServiceName);
                return isAccessibilityServiceEnabled(context, accessibilityService);
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
            if (enabledServicesSetting == null) return false;

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

    public static boolean openAccessibilityServiceSettings(Context context, String accessibilityServiceName) {
        if (accessibilityServiceName != null) {
            try {
                Class<?> accessibilityService = Class.forName(accessibilityServiceName);
                return openAccessibilityServiceSettings(context, accessibilityService);
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }
        return false;
    }

    public static boolean openAccessibilityServiceSettings(Context context, Class<?> accessibilityService) {
        try {
            Intent intentToSamsung = new Intent("com.samsung.accessibility.installed_service");
            Intent intent = null;
            if (context.getPackageManager().resolveActivity(intentToSamsung, PackageManager.MATCH_DEFAULT_ONLY) != null) {
                intent = intentToSamsung;
            } else {
                intent = new Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS);
            }

            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            String str = context.getPackageName() + "/" + accessibilityService.getName();
            intent.putExtra(":settings:fragment_args_key", str);
            Bundle bundle = new Bundle();
            bundle.putString(":settings:fragment_args_key", str);
            intent.putExtra(":settings:show_fragment_args", bundle);

            context.startActivity(intent);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public static boolean isServiceRunning(Context context, String accessibilityServiceName) {
        ActivityManager manager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        for (ActivityManager.RunningServiceInfo service : manager.getRunningServices(Integer.MAX_VALUE)) {
            if (accessibilityServiceName.equals(service.service.getClassName())) {
                return true;
            }
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

    public static boolean stopService(Context context, String accessibilityServiceName) {
        try {
            Class<?> accessibilityService = Class.forName(accessibilityServiceName);
            Intent intent = new Intent(context, accessibilityService);
            context.stopService(intent);
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

    public static boolean stopScreenAccess(Context context) {
        try {
            Context mainApplicationContext = context.getApplicationContext();
            Method m = mainApplicationContext.getClass().getMethod("getMediaIntent");
            Object rv = m.invoke(mainApplicationContext);
            if (rv != null && android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
                MediaProjectionManager mediaProjectionManager = (MediaProjectionManager) mainApplicationContext.getSystemService(Context.MEDIA_PROJECTION_SERVICE);
                MediaProjection mediaProjection = mediaProjectionManager.getMediaProjection(Activity.RESULT_OK, (Intent) rv);
                mediaProjection.stop();
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static Boolean getSharedPreferencesBool(Context context, String name, Boolean defaultValue) {
        try {
            Context mainApplicationContext = context.getApplicationContext();
            SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(mainApplicationContext);
            return sharedPreferences.getBoolean(name, defaultValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return defaultValue;
    }

    public static Integer getSharedPreferencesInt(Context context, String name, Integer defaultValue) {
        try {
            Context mainApplicationContext = context.getApplicationContext();
            SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(mainApplicationContext);
            return sharedPreferences.getInt(name, defaultValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return defaultValue;
    }

    public static Long getSharedPreferencesLong(Context context, String name, Long defaultValue) {
        try {
            Context mainApplicationContext = context.getApplicationContext();
            SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(mainApplicationContext);
            return sharedPreferences.getLong(name, defaultValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return defaultValue;
    }

    public static String getSharedPreferencesString(Context context, String name, String defaultValue) {
        try {
            Context mainApplicationContext = context.getApplicationContext();
            SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(mainApplicationContext);
            return sharedPreferences.getString(name, defaultValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return defaultValue;
    }

    public static boolean putSharedPreferencesBool(Context context, String name, Boolean value) {
        try {
            Context mainApplicationContext = context.getApplicationContext();
            SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(mainApplicationContext);
            SharedPreferences.Editor edit = sharedPreferences.edit();
            edit.putBoolean(name, value);
            edit.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean putSharedPreferencesInt(Context context, String name, Integer value) {
        try {
            Context mainApplicationContext = context.getApplicationContext();
            SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(mainApplicationContext);
            SharedPreferences.Editor edit = sharedPreferences.edit();
            edit.putInt(name, value);
            edit.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean putSharedPreferencesLong(Context context, String name, Long value) {
        try {
            Context mainApplicationContext = context.getApplicationContext();
            SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(mainApplicationContext);
            SharedPreferences.Editor edit = sharedPreferences.edit();
            edit.putLong(name, value);
            edit.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean putSharedPreferencesString(Context context, String name, String value) {
        try {
            Context mainApplicationContext = context.getApplicationContext();
            SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(mainApplicationContext);
            SharedPreferences.Editor edit = sharedPreferences.edit();
            edit.putString(name, value);
            edit.commit();
            return true;
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

    @NotNull
    public static String getAvailableCameras(@NotNull Context mContext) {
        try {
            return MCameraManager.getAvailableCameras(mContext);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "[]";
    }
}
