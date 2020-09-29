package com.example.jitter.my

import android.app.Activity
import android.content.Intent
import android.text.Editable
import android.text.TextWatcher
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.jitter.BaseActivity
import com.example.jitter.R
import com.example.jitter.bean.GlobalConstant.PERSONAL_INFO_S_SIGNATURE
import com.example.jitter.factory.ViewModelFactory
import com.example.jitter.viewmode.PerInfoUpdateViewModel
import kotlinx.android.synthetic.main.activity_update_signature.*

class UpdateSignatureActivity : BaseActivity() {
    private val userinfoViewmodel by lazy {
        ViewModelProvider(this, ViewModelFactory(supportFragmentManager)).get(PerInfoUpdateViewModel::class.java)
    }

    override fun getBarTitle(): String = "修改个性签名"
    override fun getLayoutResId(): Int = R.layout.activity_update_signature
    override fun initView() {
        val sig = intent.getStringExtra(PERSONAL_INFO_S_SIGNATURE)
        upsig_et_sig.setText(sig)

        upsig_et_sig.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
            }

            override fun afterTextChanged(s: Editable?) {
                upsig_tv_hint.text = "还可以输入" + (140 - upsig_et_sig.text.length) + "个字符"
            }
        })

        userinfoViewmodel.updateViewModel.observe(this, Observer {
            if (it.code == 200) {
                showToast(it.msg)
                val intent = Intent()
                intent.putExtra(PERSONAL_INFO_S_SIGNATURE, upsig_et_sig.text.toString())
                setResult(Activity.RESULT_OK, intent)
                finish()
            } else
                showToast(it.msg)
        })

        upsig_tv_submit.setOnClickListener {
            userinfoViewmodel.updateInfo("remark", upsig_et_sig.text.toString())
        }
    }

    override fun initData() {
    }
}