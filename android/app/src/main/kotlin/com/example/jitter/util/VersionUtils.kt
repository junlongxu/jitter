package com.example.jitter.util

import android.content.Context
import android.os.Build
import android.util.Log

/**
 * Time:2020/9/11
 * Author:Bing
 */
object VersionUtils {
    // 获取app版本号
    fun getAppVerCode(context: Context): Int {
        var versioncode = 0
        try {
            val pm = context.packageManager
            val pi = pm.getPackageInfo(context.packageName, 0)
            versioncode = pi.versionCode
        } catch (e: Exception) {
            Log.e("VersionInfo", "Exception", e)
        }
        return versioncode
    }

    // 获取app版本名
    fun getAppVerName(context: Context): String? {
        var versionName = ""
        try {
            // ---get the package info---
            val pm = context.packageManager
            val pi = pm.getPackageInfo(context.packageName, 0)
            versionName = pi.versionName
            if (versionName.isEmpty()) {
                return ""
            }
        } catch (e: Exception) {
            Log.e("VersionInfo", "Exception", e)
        }
        return versionName
    }

    // 获取系统版本
    val sdkVersion: String
        get() = Build.VERSION.RELEASE
}