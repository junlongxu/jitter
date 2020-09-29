package com.example.jitter.my

import android.app.Dialog
import android.content.ContentUris
import android.content.Context
import android.content.Intent
import android.database.Cursor
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.drawable.Drawable
import android.net.Uri
import android.os.Bundle
import android.provider.DocumentsContract
import android.provider.MediaStore
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.bigkoo.pickerview.builder.TimePickerBuilder
import com.example.jitter.BaseActivity
import com.example.jitter.R
import com.example.jitter.bean.GlobalConstant.*
import com.example.jitter.factory.ViewModelFactory
import com.example.jitter.util.SelectZoneUtils
import com.example.jitter.util.UIUtils
import com.example.jitter.viewmode.PerInfoUpdateViewModel
import com.example.jitter.widget.CircleTransform
import com.squareup.picasso.Picasso
import kotlinx.android.synthetic.main.activity_personal_info.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import java.io.BufferedOutputStream
import java.io.File
import java.io.FileOutputStream
import java.io.OutputStream
import java.text.SimpleDateFormat


/**
 * Time : 2020年9月12日
 * Author : Bing
 * Description : “我的”模块个人资料编辑界面
 */

class PersonalInfoActivity : BaseActivity(), View.OnClickListener {

    override fun getBarTitle(): String = "编辑个人资料"

    override fun getLayoutResId(): Int = R.layout.activity_personal_info

    private val context: Context by lazy {
        this
    }

    private val bottomDialog: Dialog by lazy {
        Dialog(context, R.style.ActionSheetDialogStyle)
    }

    private val avator: ImageView by lazy {
        findViewById<ImageView>(R.id.perinfo_avator)
    }

    private val userinfoViewmodel by lazy {
        ViewModelProvider(this, ViewModelFactory(supportFragmentManager)).get(PerInfoUpdateViewModel::class.java)
    }

    override fun initView() {
        Picasso.get().load(R.mipmap.icon).transform(CircleTransform()).into(avator)

        perinfo_rl_nickname.setOnClickListener(this)
        perinfo_rl_gender.setOnClickListener(this)
        perinfo_rl_perdesc.setOnClickListener(this)
        perinfo_rl_birth.setOnClickListener(this)
        perinfo_rl_location.setOnClickListener(this)
        avator.setOnClickListener(this)

    }

    override fun initData() {
        userinfoViewmodel.getUserInfo()

        userinfoViewmodel.userinfoViewmodel.observe(this, Observer {
            Picasso.get().load(it.headImage).into(avator)
            perinfo_tv_birth.text = it.birthday
            perinfo_tv_location.text = it.area
            perinfo_tv_perdesc.text = it.remark
            perinfo_tv_nickname.text = it.nickName
            perinfo_tv_gender.text = when (it.sex) {
                0 -> "男"
                1 -> "女"
                2 -> "保密"
                else -> "男"
            }
        })

        userinfoViewmodel.updateViewModel.observe(this, Observer {
            if (it.code == 200) {
                userinfoViewmodel.getUserInfo()
                showToast(it.msg)
            } else
                showToast(it.msg)
        })
    }

    private val zoneDialog: SelectZoneUtils by lazy {
        SelectZoneUtils()
    }

    // 初始化省市区数据
    private fun initZone() {
        zoneDialog.initJsonData(context)
    }

    override fun onClick(v: View?) {
        when (v?.id) {
            R.id.perinfo_avator -> {
                val inflate: View = LayoutInflater.from(context).inflate(R.layout.layout_bottom, null, false)
                val tvOne = inflate.findViewById<TextView>(R.id.bottom_tv_one)
                val tvTwo = inflate.findViewById<TextView>(R.id.bottom_tv_two)
                val tvThree = inflate.findViewById<TextView>(R.id.bottom_tv_three)
                tvOne.text = "拍照"
                tvTwo.text = "从相册选择"
                tvThree.text = "取消"
                tvOne.setOnClickListener {
                    val takePhotoIntent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
                    if (takePhotoIntent.resolveActivity(packageManager) != null) {//这句作用是如果没有相机则该应用不会闪退，要是不加这句则当系统没有相机应用的时候该应用会闪退
                        startActivityForResult(takePhotoIntent, PERSONAL_INFO_I_TAKEPHOTO);//启动相机
                    }
                    bottomDialog.dismiss()
                }
                tvTwo.setOnClickListener {
                    val openAlbumIntent = Intent(Intent.ACTION_GET_CONTENT)
                    openAlbumIntent.type = "image/*"
                    startActivityForResult(openAlbumIntent, PERSONAL_INFO_I_GALLEY) //打开相册
                    bottomDialog.dismiss()
                }
                tvThree.setOnClickListener {
                    bottomDialog.dismiss()
                }
                bottomDialog.setContentView(inflate)
                bottomDialog.show()
                bottomDialog.window?.setGravity(Gravity.BOTTOM)
                bottomDialog.window?.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            }
            R.id.perinfo_rl_nickname -> {
                val intent = Intent(context, UpdateNicknameActivity::class.java)
                intent.putExtra(PERSONAL_INFO_S_NICKNAME, perinfo_tv_nickname.text)
                startActivityForResult(intent, PERSONAL_INFO_I_NIKENAME)
            }
            R.id.perinfo_rl_gender -> {
                val inflate: View = LayoutInflater.from(context).inflate(R.layout.layout_bottom, null, false)
                val tvOne = inflate.findViewById<TextView>(R.id.bottom_tv_one)
                val tvTwo = inflate.findViewById<TextView>(R.id.bottom_tv_two)
                val tvThree = inflate.findViewById<TextView>(R.id.bottom_tv_three)
                tvOne.text = "男"
                tvTwo.text = "女"
                tvThree.text = "取消"
                tvOne.setOnClickListener {
                    userinfoViewmodel.updateInfo("sex", "0")
                    bottomDialog.dismiss()
                }
                tvTwo.setOnClickListener {
                    perinfo_tv_gender.text = tvTwo.text
                    userinfoViewmodel.updateInfo("sex", "1")
                    bottomDialog.dismiss()
                }
                tvThree.setOnClickListener {
                    bottomDialog.dismiss()
                }
                bottomDialog.setContentView(inflate)
                bottomDialog.show()
                bottomDialog.window?.setGravity(Gravity.BOTTOM)
                bottomDialog.window?.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            }
            R.id.perinfo_rl_birth -> {
                val pvTime = TimePickerBuilder(context) { date, _ ->
                    val sdf = SimpleDateFormat("yyyy-MM-dd")
                    userinfoViewmodel.updateInfo("birthday", sdf.format(date).toString())
                }.setSubmitColor(resources.getColor(R.color.color_f54b64))
                        .setCancelColor(resources.getColor(R.color.color_f54b64))
                        .setCancelText("取消")
                        .setSubmitText("确定")
                        .build()
                pvTime.show()
            }
            R.id.perinfo_rl_perdesc -> {
                val intent = Intent(context, UpdateSignatureActivity::class.java)
                intent.putExtra(PERSONAL_INFO_S_SIGNATURE, perinfo_tv_perdesc.text)
                startActivityForResult(intent, PERSONAL_INFO_I_SIGNATURE)
            }
            R.id.perinfo_rl_location -> {
                GlobalScope.launch(Dispatchers.Main) {
                    initZone()
                    zoneDialog.showPickerView(this@PersonalInfoActivity)
                }
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        when (requestCode) {
            PERSONAL_INFO_I_SIGNATURE -> {
                if (resultCode == RESULT_OK) {
//                    val sig = data?.getStringExtra(PERSONAL_INFO_S_SIGNATURE)
//                    perinfo_tv_perdesc.text = sig
                    userinfoViewmodel.getUserInfo()
                }
            }
            PERSONAL_INFO_I_NIKENAME -> {
                if (resultCode == RESULT_OK) {
//                    val name = data?.getStringExtra(PERSONAL_INFO_S_NICKNAME)
//                    perinfo_tv_nickname.text = name
                    userinfoViewmodel.getUserInfo()
                }
            }
            PERSONAL_INFO_I_TAKEPHOTO -> {
                if (resultCode == RESULT_OK) {
                    val extras: Bundle? = data!!.extras
                    val bitmap: Bitmap = extras?.get("data") as Bitmap
                    avator.setImageBitmap(bitmap)
                    updateAvator()
                }
            }
            PERSONAL_INFO_I_GALLEY -> {
                if (resultCode == RESULT_OK) {
                    data?.let {
                        handleImageOnKitKat(it)
                        updateAvator()
                    }
                }
            }
        }
    }

    // 上传图像
    fun updateAvator() {
        val tempFile = File(context.getFilesDir(), "avator.png")
        var os: OutputStream? = null
        try {
            os = BufferedOutputStream(FileOutputStream(tempFile))
            val drawable: Drawable = avator.drawable
            val bitmap: Bitmap? = UIUtils.drawableToBitmap(drawable)
            bitmap?.compress(Bitmap.CompressFormat.JPEG, 100, os)
            os.close()
        } catch (e: Exception) {
            e.printStackTrace()
        }
        userinfoViewmodel.updateAvator(tempFile)
    }

    fun getZoneData(zone: String) {
        userinfoViewmodel.updateInfo("area", zone)
    }

    // 获取相册图片
    private fun handleImageOnKitKat(data: Intent) {
        var imagePath: String? = null
        val uri: Uri? = data.data
        if (DocumentsContract.isDocumentUri(this, uri)) {
            //如果是document类型的Uri，则提供document id处理
            val docId: String = DocumentsContract.getDocumentId(uri)
            if ("com.android.providers.media.documents" == uri?.authority) {
                val id = docId.split(":".toRegex()).toTypedArray()[1] //解析出数字格式的id
                val selection = MediaStore.Images.Media._ID + "=" + id
                imagePath = getImagePath(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, selection)
            } else if ("com.android.providers.downloads.documents" == uri?.authority) {
                val contentUri: Uri = ContentUris.withAppendedId(Uri.parse("content://downloads/public_downloads"), java.lang.Long.valueOf(docId))
                imagePath = getImagePath(contentUri, null)
            }
        } else if ("content".equals(uri?.scheme, ignoreCase = true)) {
            //如果是content类型的uri，则进行普通处理
            imagePath = getImagePath(uri, null)
        } else if ("file".equals(uri?.scheme, ignoreCase = true)) {
            //如果是file类型的uri，则直接获取路径
            imagePath = uri?.path
        }
        displayImage(imagePath)
    }

    /**
     * 将imagePath指定的图片显示到ImageView上
     */
    private fun displayImage(imagePath: String?) {
        if (imagePath != null) {
            val bitmap: Bitmap = BitmapFactory.decodeFile(imagePath)
            avator.setImageBitmap(bitmap)
        } else {
            Toast.makeText(context, "failed to get image", Toast.LENGTH_SHORT).show()
        }
    }

    /**
     * 将Uri转化为路径
     * @param uri 要转化的Uri
     * @param selection 4.4之后需要解析Uri，因此需要该参数
     * @return 转化之后的路径
     */
    private fun getImagePath(uri: Uri?, selection: String?): String? {
        var path: String? = null
        val cursor: Cursor? = uri?.let { contentResolver.query(it, null, selection, null, null) }
        if (cursor != null) {
            if (cursor.moveToFirst()) {
                path = cursor.getString(cursor.getColumnIndex(MediaStore.Images.Media.DATA))
            }
            cursor.close()
        }
        return path
    }
}