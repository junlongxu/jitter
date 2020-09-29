package com.example.jitter.record

import android.app.Activity
import android.content.Intent
import android.graphics.Point
import android.os.Bundle
import android.view.MotionEvent
import android.view.View
import android.widget.LinearLayout
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.AppCompatImageView
import com.example.jitter.MainActivity
import com.example.jitter.R
import com.example.jitter.record.other.MediaObject
import com.example.jitter.record.view.CameraView
import com.example.jitter.record.view.ProgressView
import com.example.jitter.util.Utils
import com.example.jitter.widget.PromptDialog
import com.example.jitter.widget.ScrollerSelectIndication
import com.example.jitter.widget.SelectIndicationTextView
import com.google.android.material.bottomsheet.BottomSheetDialog
import kotlinx.android.synthetic.main.activity_shoot.*
import kotlinx.android.synthetic.main.layout_bottom_dialog.view.*

/**
 * author: Warrior
 * created: 2020/9/8 13:22
 * descript: 拍摄界面
 */
class ShootActivity : AppCompatActivity(){

    //进度到达拍摄时间
    private var overTime = false
    private lateinit var activity: Activity

    private val progressView by lazy {
        findViewById<ProgressView>(R.id.view_progress)
    }

    private val lensView by lazy {
        findViewById<AppCompatImageView>(R.id.view_lens)
    }

    private val confirmView by lazy {
        findViewById<AppCompatImageView>(R.id.view_confirm)
    }

    private val delView by lazy {
        findViewById<AppCompatImageView>(R.id.view_del)
    }

    private val shootView by lazy {
        findViewById<AppCompatImageView>(R.id.view_shoot)
    }

    private val cameraView by lazy {
        findViewById<CameraView>(R.id.cameraView)
    }

    private val timeView by lazy {
        findViewById<SelectIndicationTextView>(R.id.view_time)
    }

    private val timeLayout by lazy {
        findViewById<LinearLayout>(R.id.timeLayout)
    }

    private var isRecording = false

    private var videoFileName = ""

    /**最短时间*/
    private val RECORD_MIN_TIME = 30 * 1000

    private val RECORD_TIME = arrayOf(
            60 * 1000,
            180 * 1000,
            300 * 1000
    )
    
    private val mMediaObject by lazy {
        MediaObject()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        activity = this@ShootActivity
        setContentView(R.layout.activity_shoot)
        initViews()
    }

    private fun initViews(){
        progressView.setMaxDuration(RECORD_TIME[0])

        //确认生成视频
        confirmView.setOnClickListener {
            if(mMediaObject.duration < RECORD_MIN_TIME){
                Toast.makeText(this, "拍摄时常不能少于30秒", Toast.LENGTH_LONG).show()
                return@setOnClickListener
            }

            videoFileName = mMediaObject.mergeVideo()
            val uintent = Intent(delView.context, UploadActivity::class.java)
            uintent.putExtra("videoFile", videoFileName)
            startActivity(uintent)
            finish()
        }

        //切换镜头
        lensView.setOnClickListener {
            cameraView.apply {
                switchCamera()
                if (cameraId == 1){
                    changeBeautyLevel(3);
                }else {
                    changeBeautyLevel(0);
                }
            }
        }

        //删除视频
        delView.setOnClickListener {
            val part = mMediaObject.currentPart
            if (part != null) {
                Utils.showDialog(supportFragmentManager, "是否删除上一段视频？", object : PromptDialog.OnDialogClickListener {
                    override fun onCance() {}
                    override fun onConfirm() {
                        mMediaObject.removePart(part, true)
                        if (mMediaObject.duration < RECORD_MIN_TIME) {
                            progressView.setShowEnouchTime(false)
                        }
                    }
                })
            }
        }

        // 录制/停止
        shootView.setOnClickListener {
            if (!overTime){
                if (isRecording){
                    onStopRecording()
                } else {
                    onStartRecording()
                }
            }
        }

        //设置拍摄时长
        timeView.setOnPageSelectListenter(object : ScrollerSelectIndication.OnScrollerListener {
            override fun onPageSelect(position: Int) {
                progressView.setMaxDuration(RECORD_TIME[position])
            }
        })

        //拍摄进度监听
        progressView.setOverTimeClickListener(object : ProgressView.OverTimeClickListener {
            override fun overTime() {
                overTime = true
            }

            override fun noEnoughTime() {}
            override fun isArriveCountDown() {}
        })

        backView.setOnClickListener {
            showBottomDialog()
        }
    }

    private fun onStartRecording() {
        isRecording = true
        val storageMp4 = "${cameraView.context.getExternalFilesDir(null)?.absolutePath}/${System.currentTimeMillis()}.mp4"
        mMediaObject.buildMediaPart(storageMp4)
        cameraView.setSavePath(storageMp4)
        cameraView.startRecord()
        progressView.start()

        backView.visibility = View.GONE
        delView.visibility = View.GONE
        confirmView.visibility = View.GONE
        timeLayout.visibility = View.GONE
        shootView.setImageResource(R.drawable.img_shoot_stop)
    }

    private fun onStopRecording() {
        isRecording = false
        cameraView.stopRecord()
        progressView.apply {
            stop()
            postDelayed({
                mMediaObject.stopRecord(context, mMediaObject)
            }, 500)
        }

        backView.visibility = View.VISIBLE
        delView.visibility = View.VISIBLE
        confirmView.visibility = View.VISIBLE
        shootView.setImageResource(R.drawable.img_shooting)
    }

    override fun onResume() {
        super.onResume()
        progressView.setData(mMediaObject)
    }


    override fun onTouchEvent(event: MotionEvent?): Boolean {
        if (event?.action == MotionEvent.ACTION_UP){
            val sRawX = event.rawX
            val sRawY = event.rawY
            var rawY = sRawY * MainActivity.screenWidth / MainActivity.screenHeight
            val rawX = rawY
            rawY = (MainActivity.screenWidth - sRawX) * MainActivity.screenHeight / MainActivity.screenWidth
            cameraView.onFocus(Point(rawX.toInt(),rawY.toInt())) { _, _ ->  }
        }
        return true
    }

    private fun showBottomDialog(){
        val bottomDialg = BottomSheetDialog(this)
        val view = View.inflate(this, R.layout.layout_bottom_dialog, null)
        view.resumeView.setOnClickListener {
            mMediaObject.deteleVideoPath()
            bottomDialg.dismiss()
            timeLayout.visibility = View.VISIBLE
        }
        view.quitView.setOnClickListener {
            bottomDialg.dismiss()
            finish()
        }
        view.canceView.setOnClickListener { bottomDialg.dismiss() }
        bottomDialg.setContentView(view)
        bottomDialg.show()
    }

}