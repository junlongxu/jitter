package com.example.jitter.record

import android.content.Intent
import android.content.pm.ActivityInfo
import android.media.MediaMetadataRetriever
import android.media.ThumbnailUtils
import android.provider.MediaStore
import android.view.View
import android.widget.Toast
import androidx.appcompat.widget.AppCompatButton
import androidx.appcompat.widget.AppCompatEditText
import androidx.appcompat.widget.AppCompatImageView
import androidx.appcompat.widget.AppCompatTextView
import com.example.jitter.BaseActivity
import com.example.jitter.R
import com.example.jitter.util.ApiUrls
import com.example.jitter.util.PicassoEngine
import com.example.jitter.util.Utils
import com.example.jitter.widget.PromptDialog
import com.zhihu.matisse.Matisse
import com.zhihu.matisse.MimeType
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.core.Observer
import io.reactivex.rxjava3.disposables.Disposable
import kotlinx.android.synthetic.main.activity_upload.*
import org.json.JSONObject
import rxhttp.wrapper.param.RxHttp
import java.io.File

/**
 * author: Warrior
 * created: 2020/9/8 15:07
 * descript: 上传
 */
class UploadActivity : BaseActivity() {


    private val REQUEST_CODE_CHOOSE = 10024

    private var filePath = ""
    private lateinit var videoFile: File

    private val backView by lazy {
        findViewById<AppCompatImageView>(R.id.view_back)
    }

    private val delView by lazy {
        findViewById<AppCompatImageView>(R.id.view_cover_del)
    }

    private val shootView by lazy {
        findViewById<AppCompatTextView>(R.id.view_shoot)
    }

    private val coverView by lazy {
        findViewById<AppCompatImageView>(R.id.view_cover)
    }

    private val confirmView by lazy {
        findViewById<AppCompatButton>(R.id.view_confirm)
    }

    private val escripView by lazy {
        findViewById<AppCompatEditText>(R.id.view_descrip)
    }

    override fun getBarTitle(): String = ""

    override fun getLayoutResId(): Int = R.layout.activity_upload

    override fun initData() {
        intent.getStringExtra("videoFile")?.let {
            setVideoCover(it)
        }
    }

    override fun initView() {
        hidToolBar()
        backView.setOnClickListener {
            finish()
        }

        //跳转上传须知
        uploadStated.setOnClickListener {
            startActivity(Intent(backView.context, UploadStatedActivity::class.java))
        }

        shootView.setOnClickListener {
//            startActivity(Intent(backView.context, ShootActivity::class.java))
//            finish()
            showToast("敬请期待！")
        }

        confirmView.setOnClickListener {
            if (!statedView.isChecked){
                Toast.makeText(backView.context, "请阅读并同意上传须知！", Toast.LENGTH_LONG).show()
                return@setOnClickListener
            }
            upload()
        }

        //删除
        delView.setOnClickListener {
            delVideo()
        }

        //跳转相册
        coverView.setOnClickListener {
            if (!delView.isShown){
                Matisse.from(this@UploadActivity)
                        .choose(MimeType.of(MimeType.MP4))
                        .countable(true)
                        .showSingleMediaType(true)
                        .maxSelectable(1)
                        .gridExpectedSize(120)
                        .restrictOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT)
                        .thumbnailScale(0.85f)
                        .imageEngine(PicassoEngine())
                        .forResult(REQUEST_CODE_CHOOSE)
            }
        }
    }

    private fun delVideo(){
        videoFile.delete()
        coverView.setImageResource(R.drawable.img_add)
        delView.visibility = View.GONE
    }

    private fun setVideoCover(filePath: String){
        if (!filePath.isNullOrEmpty()){
            this.filePath = filePath
            videoFile = File(filePath)
            val cover = ThumbnailUtils.createVideoThumbnail(filePath, MediaStore.Images.Thumbnails.MICRO_KIND)
            coverView.setImageBitmap(cover)
            coverView.visibility = View.VISIBLE
            delView.visibility = View.VISIBLE
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        data?.let {
            if (requestCode == REQUEST_CODE_CHOOSE){
                setVideoCover(Matisse.obtainPathResult(data)[0])
            } else {
                val filePath = it.getStringExtra("videoFile")
                setVideoCover(filePath!!)
            }
        }
    }

    private var size = ""
    private fun upload(){
        RxHttp.postForm(ApiUrls.upload)
                .add("videoTime", getVideoDuration(filePath))
                .add("videoArticle", escripView.text.toString())
                .addFile("file", videoFile)
                .connectTimeout(20 * 1000)
                .readTimeout(20 * 1000)
                .writeTimeout(20 * 1000)
                .upload(AndroidSchedulers.mainThread()) { progress ->
                    if (size.isEmpty()){
                        size = Utils.getByteSize(progress.totalSize)
                    }
                    updateProgress("${progress.progress}%/$size")
                }.asString()
                .subscribe(object : Observer<String> {
                    override fun onSubscribe(d: Disposable) {
                        showLoading("正在上传中...")
                    }

                    override fun onNext(body: String) {
                        hidLoading()
                        val json = JSONObject(body)
                        if (json.getInt("code") == 200){
                            Utils.showDialog(supportFragmentManager,"上传成功", object: PromptDialog.OnDialogClickListener{
                                override fun onCance() {}
                                override fun onConfirm() {
                                    delVideo()
                                    escripView.setText("")
                                }
                            })
                        } else {
                            showToast("上传失败：${json.getInt("code")}\n${json.getString("msg")}")
                        }
                    }

                    override fun onError(e: Throwable) {
                        showToast("上传异常：${e.toString()}")
                    }

                    override fun onComplete() {
                        hidLoading()
                    }

                })
    }

    private fun getVideoDuration(videoPath: String?): String? {
        val mmr = MediaMetadataRetriever()
        mmr.setDataSource(videoPath)
        return mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DURATION)
    }

}