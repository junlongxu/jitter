package com.example.jitter

import android.Manifest.permission.*
import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.example.jitter.record.UploadActivity
import com.tbruyelle.rxpermissions3.RxPermissions

/**
 * author: Warrior
 * created: 2020/9/9 21:00
 * descript:
 */
class PermissionAcrivity : AppCompatActivity() {

    private val PERMISSIONS = arrayOf(
            CAMERA,
            RECORD_AUDIO,
            READ_EXTERNAL_STORAGE,
            WRITE_EXTERNAL_STORAGE
    )

    private val rxPermissions by lazy {
        RxPermissions(this)
    }

    override fun onResume() {
        super.onResume()
        check()
    }

    private fun check(){
        //CAMERA, RECORD_AUDIO,
        rxPermissions.request(READ_EXTERNAL_STORAGE, WRITE_EXTERNAL_STORAGE)
                .subscribe { granted: Boolean -> run {
                        if (!granted) {
                            AlertDialog.Builder(this)
                                    .setTitle("温馨提示！")
                                    .setMessage("需完整权限才能继续使用")
                                    .setPositiveButton("去授权") { p0, _ ->
                                        p0.dismiss()
                                        val intent = Intent("android.settings.APPLICATION_DETAILS_SETTINGS")
                                        intent.data = Uri.fromParts("package", packageName, null)
                                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                                        startActivityForResult(intent, 123)
                                    }.show()
                        } else {
                            startActivity(Intent(this@PermissionAcrivity,UploadActivity::class.java))
                            finish()
                        }
                    }
                }
    }

}