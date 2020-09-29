package com.example.jitter

import android.app.DownloadManager
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.os.Environment
import com.example.jitter.my.MyFlowsActivity
import com.example.jitter.my.PersonalInfoActivity
import com.example.jitter.my.SettingActivity
import com.example.jitter.my.message.MessagActivity
import com.example.jitter.util.Utils
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import rxhttp.wrapper.param.Param
import rxhttp.wrapper.param.RxHttp

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.jitter/MainActivity"

    companion object {
        var screenWidth = 0
        var screenHeight = 0
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Utils.mContext = applicationContext
        RxHttp.setDebug(BuildConfig.DEBUG)
        screenWidth = resources.displayMetrics.widthPixels
        screenHeight = resources.displayMetrics.heightPixels
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, _ ->
            call.argument<String>("token")?.let { token ->
                RxHttp.setOnParamAssembly { param: Param<*> ->
                    param.addHeader("Authorization", token)
                }
            }
            when (call.method) {
                "myBalance" -> {  //跳转我的余额
                    MyFlowsActivity.startActivity(this, 0)
                }
                "myCoins" -> {  //跳转我的金币
                    MyFlowsActivity.startActivity(this, 1)
                }
                "invitedFriend" -> { //跳转邀请朋友

                }
                "invitedCode" -> { //跳转邀请码

                }
                "help" -> { //跳转帮助界面

                }
                "startShoot" -> { //跳转授权界面
                    redirect(PermissionAcrivity::class.java)
                }
                "apkdownLoad" -> {
                    downLoad(call.argument<String>("url"))
                }
                "message" -> {   // 跳转到消息界面
                    redirect(MessagActivity::class.java)
                }
                "setting" -> {  // 跳转到设置界面
                    redirect(SettingActivity::class.java)
                }
                "updateInfo" -> {  // 跳转到个人资料设置
                    redirect(PersonalInfoActivity::class.java)
                }
            }
        }
    }

    //页面重定向
    private fun redirect(clas: Class<*>) {
        startActivity(Intent(this@MainActivity, clas))
    }

    private fun downLoad(apkUrl: String?) {
        apkUrl?.let {
            val request = DownloadManager.Request(Uri.parse(it))
            //设置通知栏标题
            request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE)
            request.setTitle("环球体育正在下载")
            request.setDescription("首存即送，赢了带走")
            //设置文件存放目录
            request.setDestinationInExternalFilesDir(this, Environment.DIRECTORY_DOWNLOADS, "apk")

            val downManager = getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
            downManager.enqueue(request)
        }
    }

}
