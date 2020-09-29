package com.example.jitter.splash

import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.Message
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.jitter.MainActivity
import com.example.jitter.R
import com.example.jitter.bean.GlobalConstant
import com.example.jitter.util.DownloadUtils
import com.squareup.picasso.Callback
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.activity_splash.*
/**
 * Time : 2020/9/14
 * Author : Bing
 * Description : 闪屏页逻辑
 */

class SplashActivity : AppCompatActivity(), GlobalConstant {
    companion object {
        private var JUMP_TIME = 4
    }

    var mHandler: Handler = object : Handler(Looper.getMainLooper()) {
        override fun handleMessage(msg: Message) {
            super.handleMessage(msg)
            when (msg.what) {
                10 -> if (JUMP_TIME == 0) {
                    sendEmptyMessage(11)
                } else {
                    sp_tv_jump.visibility = View.VISIBLE
                    sp_tv_jump.text = JUMP_TIME.toString() + "s|跳过"
                    JUMP_TIME--
                    sendEmptyMessageDelayed(10, 1000)
                }
                11 -> {
                    removeCallbacksAndMessages(null)
                    startActivity(Intent(context, MainActivity::class.java))
                    finish()
                }
                12 -> DownloadUtils(context, GlobalConstant.DOWNLOAD_APK_URL, "testad.apk")
            }
        }
    }

    private val context: Context by lazy {
        this
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val option: Int = View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
        window.decorView.systemUiVisibility = option
        window.statusBarColor = Color.TRANSPARENT
        window.navigationBarColor = Color.TRANSPARENT

        setContentView(R.layout.activity_splash)
        Picasso.get().load(R.drawable.splash_bg).into(sp_iv, object : Callback {
            override fun onSuccess() {
                mHandler.sendEmptyMessage(10)
            }

            override fun onError(e: Exception) {
                Toast.makeText(context, "图片加载异常，直接进入主页。", Toast.LENGTH_SHORT).show()
                mHandler.sendEmptyMessage(11)
            }
        })
        sp_iv.setOnClickListener { mHandler.sendEmptyMessage(12) }
        sp_tv_jump.setOnClickListener { mHandler.sendEmptyMessage(11) }
    }
}