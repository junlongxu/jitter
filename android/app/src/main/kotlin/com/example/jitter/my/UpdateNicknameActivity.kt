package com.example.jitter.my

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.jitter.BaseActivity
import com.example.jitter.R
import com.example.jitter.bean.GlobalConstant.PERSONAL_INFO_S_NICKNAME
import com.example.jitter.factory.ViewModelFactory
import com.example.jitter.viewmode.PerInfoUpdateViewModel
import kotlinx.android.synthetic.main.activity_update_nickname.*

/**
 * Time : 2020年9月14日
 * Author : Bing
 * Description : 修改昵称界面
 */

class UpdateNicknameActivity : BaseActivity() {
    private val context: Context by lazy {
        this
    }

    private val userinfoViewmodel by lazy {
        ViewModelProvider(this, ViewModelFactory(supportFragmentManager)).get(PerInfoUpdateViewModel::class.java)
    }

    override fun getBarTitle(): String = "修改昵称"

    override fun getLayoutResId(): Int = R.layout.activity_update_nickname

    override fun initView() {
        val oldName = intent.getStringExtra(PERSONAL_INFO_S_NICKNAME)
        upnn_et_name.setText(oldName)

        upnn_tv_submit.setOnClickListener {
            val nameLen = upnn_et_name.text?.length ?: 0
            if (nameLen < 4 || nameLen > 6) {
                showToast("昵称不能低于四个字符")
                return@setOnClickListener
            }
            userinfoViewmodel.updateInfo("nickName", upnn_et_name.text.toString())
        }

        userinfoViewmodel.updateViewModel.observe(this, Observer {
            if (it.code == 200) {
                val intent = Intent()
                showToast(it.msg)
                intent.putExtra(PERSONAL_INFO_S_NICKNAME, upnn_et_name.text.toString())
                setResult(Activity.RESULT_OK, intent)
                finish()
            } else
                showToast(it.msg)
        })
    }

    override fun initData() {

    }


}