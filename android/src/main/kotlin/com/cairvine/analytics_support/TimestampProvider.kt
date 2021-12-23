package com.cairvine.analytics_support

import androidx.annotation.Keep
import com.google.android.gms.tagmanager.CustomVariableProvider

// https://developers.google.com/tag-manager/android/v5/advanced-config
@Keep
class TimestampProvider : CustomVariableProvider {
    override fun getValue(map: MutableMap<String, Any>): String {
        return System.currentTimeMillis().toString()
    }
}
