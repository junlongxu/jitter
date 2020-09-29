package com.example.jitter.util

import android.app.Activity
import android.app.Notification
import android.app.NotificationManager
import android.content.Context
import android.content.Context.NOTIFICATION_SERVICE
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.example.jitter.R


/**
 * Time : 2020/9/17
 * Author : Bing
 * Description : 通知工具类
 */
object NotifUtils {

    // 发送优先级高的消息
    fun sendHighMsg(context: Context, title: String, content: String, notifId: Int) {
        val manager: NotificationManager = context.getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        val notification: Notification = NotificationCompat.Builder(context, "notify")
                .setContentTitle(title)
                .setContentText(content)
                .setWhen(System.currentTimeMillis())
                .setSmallIcon(R.mipmap.icon)
                .setAutoCancel(true)
                .build()
        manager.notify(notifId, notification)
    }

    // 发送优先级低的消息
    fun sendDefaultMsg(context: Context, title: String, content: String, notifId: Int) {
        val manager: NotificationManager = context.getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        val notification: Notification = NotificationCompat.Builder(context, "subscribe")
                .setContentTitle(title)
                .setContentText(content)
                .setWhen(System.currentTimeMillis())
                .setSmallIcon(R.mipmap.icon)
                .setAutoCancel(true)
                .build()
        manager.notify(notifId, notification)
    }

    fun isNotificationEnabled(context: Context): Boolean {
        return NotificationManagerCompat.from(context.applicationContext).areNotificationsEnabled()
    }

    // 跳转设置界面
    fun openPush(activity: Activity) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            //这种方案适用于 API 26, 即8.0（含8.0）以上可以用
            val intent = Intent()
            intent.action = Settings.ACTION_APP_NOTIFICATION_SETTINGS
            intent.putExtra(Settings.EXTRA_APP_PACKAGE, activity.packageName)
            intent.putExtra(Settings.EXTRA_CHANNEL_ID, activity.applicationInfo.uid)
            activity.startActivity(intent)
        } else {
            toPermissionSetting(activity)
        }
    }

    private fun toPermissionSetting(activity: Activity) {
        if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.LOLLIPOP_MR1) {
            toSystemConfig(activity)
        } else {
            try {
                toApplicationInfo(activity)
            } catch (e: Exception) {
                e.printStackTrace()
                toSystemConfig(activity)
            }
        }
    }

    /**
     * 应用信息界面
     */
    private fun toApplicationInfo(activity: Activity) {
        val localIntent = Intent()
        localIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        localIntent.action = Settings.ACTION_APPLICATION_DETAILS_SETTINGS
        localIntent.data = Uri.fromParts("package", activity.packageName, null)
        activity.startActivity(localIntent)
    }

    /**
     * 系统设置界面
     */
    private fun toSystemConfig(activity: Activity) {
        try {
            val intent = Intent(Settings.ACTION_SETTINGS)
            activity.startActivity(intent)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}