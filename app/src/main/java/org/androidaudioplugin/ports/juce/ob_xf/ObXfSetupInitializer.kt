package org.androidaudioplugin.ports.juce.ob_xf

import android.content.Context
import androidx.startup.Initializer
import java.io.File
import java.io.FileOutputStream

class ObXfSetupInitializer : Initializer<Any?> {

    private fun xcopyFromAssetsToLocalStorage(context: Context, dst: File, src: String) {
        val list = context.assets.list(src) ?: return
        if (list.any()) {
            if (!dst.exists()) dst.mkdirs()
            for (sub in list)
                xcopyFromAssetsToLocalStorage(context, File(dst, sub), "$src/$sub")
        } else {
            FileOutputStream(dst).use { w ->
                context.assets.open(src).use { r -> r.copyTo(w) }
            }
        }
    }

    override fun create(context: Context): Any {
        val factoryDir = File(context.filesDir, ".local/share/Surge Synth Team/OB-Xf")
        if (!factoryDir.exists())
            xcopyFromAssetsToLocalStorage(context, factoryDir, "Surge Synth Team/OB-Xf")
        return ""
    }

    override fun dependencies(): MutableList<Class<out Initializer<*>>> = mutableListOf()
}
