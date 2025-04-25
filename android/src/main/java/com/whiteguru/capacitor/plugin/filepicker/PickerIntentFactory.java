package com.whiteguru.capacitor.plugin.filepicker;
import android.app.Activity;
import android.content.Intent;

import java.util.List;

public class PickerIntentFactory {

    public static Intent create(Activity activity, List<String> types) {
        if (isOnlyImages(types)) {
            return createImageIntent(types.get(0));
        }

        return createDocumentIntent(types);
    }

    private static boolean isOnlyImages(List<String> types) {
        return types.size() == 1 && types.get(0).startsWith("image/");
    }

    private static Intent createImageIntent(String mime) {
        return new Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI).setType(mime);
    }

    private static Intent createDocumentIntent(List<String> types) {
        Intent i = new Intent(Intent.ACTION_OPEN_DOCUMENT).addCategory(Intent.CATEGORY_OPENABLE);

        if (types.size() == 1) {
            i.setType(types.get(0));
        } else {
            i.setType("*/*").putExtra(Intent.EXTRA_MIME_TYPES, types.toArray(new String[0]));
        }

        return i;
    }
}
