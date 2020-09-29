package com.example.jitter.my.message

import android.app.Activity
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.jitter.BaseActivity
import com.example.jitter.R
import com.example.jitter.bean.MsgSettingBeanItem
import com.example.jitter.my.adapter.OnRightClick
import com.example.jitter.util.NotifUtils
import com.example.jitter.viewmode.MsgSettingViewmodel
import com.example.jitter.widget.MyDialog
import kotlinx.android.synthetic.main.activity_settingmsg.*

/**
 * author: Bing
 * created:2020年9月17日
 * descript: 消息设置模块
 */
class SettingsMessageActivity : BaseActivity() {
    private val mActivity: Activity by lazy {
        this
    }

    private val msgsetViewModel by lazy {
        ViewModelProvider(this, ViewModelProvider.NewInstanceFactory()).get(MsgSettingViewmodel::class.java)
    }

    override fun getBarTitle(): String = "消息设置"

    override fun getLayoutResId(): Int = R.layout.activity_settingmsg

    override fun initView() {
        if (NotifUtils.isNotificationEnabled(mActivity)) {
            msg_set_status.isClickable = false
            msg_set_status.text = "已开启"
        } else {
            msg_set_status.isClickable = false
            msg_set_status.text = "去开启"
            msg_set_rl.setOnClickListener {
                NotifUtils.openPush(mActivity)
            }
        }
    }

    override fun initData() {
        msgsetViewModel.msgSysSet.observe(this, Observer<MsgSettingBeanItem> { t -> msg_set_sys.isChecked = t?.status == 1 })

        msgsetViewModel.msgComSet.observe(this, Observer<MsgSettingBeanItem> { t -> msg_set_com.isChecked = t?.status == 1 })

        msgsetViewModel.msgFolSet.observe(this, Observer<MsgSettingBeanItem> { t -> msg_set_fol.isChecked = t?.status == 1 })

//        msgsetViewModel.msgSet.observe(this, Observer<MsgSettingBeanItem> { t -> msg_set_status.text = if (t?.status == 1) "已开启" else "未开启" })

        msg_set_sys.setOnClickListener {
            val tempBean = msgsetViewModel.msgSysSet.value
            val status = if (tempBean?.status == 1) 0 else 1
            msgsetViewModel.upData(tempBean?.id.toString(), status.toString(), tempBean?.type.toString())
        }

        msg_set_fol.setOnClickListener {
            val tempBean = msgsetViewModel.msgFolSet.value
            val status = if (tempBean?.status == 1) 0 else 1
            msgsetViewModel.upData(tempBean?.id.toString(), status.toString(), tempBean?.type.toString())
        }

        msg_set_com.setOnClickListener {
            val tempBean = msgsetViewModel.msgComSet.value
            val status = if (tempBean?.status == 1) 0 else 1
            msgsetViewModel.upData(tempBean?.id.toString(), status.toString(), tempBean?.type.toString())
        }

        // 设置开关消息
//        val logDialog = MyDialog(mActivity)
//        logDialog.setStrLeft("取消")
//        logDialog.setStrRight("确定")
//        msg_set_rl.setOnClickListener {
//            val tempBean = msgsetViewModel.msgSet.value
//            val status = if (tempBean?.status == 1) 0 else 1
//            if (status == 1) {
//                logDialog.setStrTitle("是否开启消息通知？")
//            } else {
//                logDialog.setStrTitle("是否关闭消息通知？")
//            }
//            logDialog.showDia()
//        }
//
//        logDialog.setOnRightClick(object : OnRightClick {
//            override fun onclick() {
//                val tempBean = msgsetViewModel.msgSet.value
//                val status = if (tempBean?.status == 1) 0 else 1
//                msgsetViewModel.upData(tempBean?.id.toString(), status.toString(), tempBean?.type.toString())
//            }
//        })

        // 获取消息设置数据
        msgsetViewModel.getData()
    }
}