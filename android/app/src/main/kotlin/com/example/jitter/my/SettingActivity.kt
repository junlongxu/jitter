package com.example.jitter.my

import android.content.Context
import android.util.Log
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.jitter.BaseActivity
import com.example.jitter.R
import com.example.jitter.bean.NetworkStrBean
import com.example.jitter.my.adapter.OnRightClick
import com.example.jitter.util.ApiUrls
import com.example.jitter.util.VersionUtils
import com.example.jitter.viewmode.CacheViewModel
import com.example.jitter.widget.MyDialog
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import kotlinx.android.synthetic.main.activity_version.*
import rxhttp.wrapper.param.RxHttp

class SettingActivity : BaseActivity() {

    private val mContext: Context by lazy {
        this
    }

    private val cacheViewModel: CacheViewModel by lazy {
        ViewModelProvider(this, ViewModelProvider.AndroidViewModelFactory.getInstance(application)).get(CacheViewModel::class.java)
    }

    override fun getBarTitle(): String = "设置"

    override fun getLayoutResId(): Int = R.layout.activity_version

    override fun initView() {

        cacheViewModel.dataManager.observe(this, Observer<String> { t -> ver_tv_cache.text = t })

        ver_rl_clean.setOnClickListener {
            cacheViewModel.delData()
            showToast("缓存清理成功")
        }

        ver_rl_logout.setOnClickListener {
            val logDialog = MyDialog(mContext)
            logDialog.setStrContent("确定要退出吗？")
            logDialog.setStrLeft("取消")
            logDialog.setStrRight("确定")

            logDialog.setOnRightClick(object : OnRightClick {
                override fun onclick() {
                    RxHttp.get(ApiUrls.MSG_GET_LOGOUT)
                            .asClass(NetworkStrBean::class.java)
                            .observeOn(AndroidSchedulers.mainThread())
                            .subscribe({
                                if (it.code == 200) {
                                    showToast("退出成功")
                                    finish()
                                } else {
                                    showToast("退出失败,${it.msg})")
                                }
                            }, {
                                Log.e("tag", "----->$it")
                            })
                }
            })

            logDialog.showDia()
        }
    }

    override fun initData() {
        cacheViewModel.getData()
        ver_tv_version.text = VersionUtils.getAppVerName(this)
    }
}