package software.ragimov.flutterandroidutils.camera;

import android.content.Context;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraManager;
import android.hardware.camera2.CameraMetadata;
import android.os.Build;

import androidx.annotation.RequiresApi;

import org.json.JSONArray;
import org.json.JSONObject;

public class MCameraManager {

	public static String getAvailableCameras(Context context) {
		try {
			CameraManager manager = (CameraManager) context.getSystemService(Context.CAMERA_SERVICE);
			String[] cameraIdList = manager.getCameraIdList();
			JSONArray result = new JSONArray();
			for (String cameraId : cameraIdList) {
				CameraCharacteristics characteristics = manager.getCameraCharacteristics(cameraId);
				Integer orientation = characteristics.get(CameraCharacteristics.LENS_FACING);
				boolean flashAvailable = characteristics.get(CameraCharacteristics.FLASH_INFO_AVAILABLE);
				if (orientation == CameraMetadata.LENS_FACING_FRONT) {
					result.put(new JSONObject().put("id", cameraId).put("orientation", "front").put("flashAvailable", flashAvailable));
				} else if (orientation == CameraMetadata.LENS_FACING_BACK) {
					result.put(new JSONObject().put("id", cameraId).put("orientation", "back").put("flashAvailable", flashAvailable));
				} else {
					result.put(new JSONObject().put("id", cameraId).put("orientation", "external").put("flashAvailable", flashAvailable));
				}
			}
			return result.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "[]";
	}
}
