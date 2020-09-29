package com.example.jitter.viewmode

import android.util.Log
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.jitter.bean.MsgSettingBean
import com.example.jitter.bean.MsgSettingBeanItem
import com.example.jitter.bean.NetworkStrBean
import com.example.jitter.util.ApiUrls
import rxhttp.wrapper.param.RxHttp
import rxhttp.wrapper.param.asResponse

/**
 * Time : 2020/9/21
 * Author : Bing
 * Description : 消息设置界面
 */
class MsgSettingViewmodel : ViewModel() {
    var msgSysSet = MutableLiveData<MsgSettingBeanItem>()
    var msgComSet = MutableLiveData<MsgSettingBeanItem>()
    var msgFolSet = MutableLiveData<MsgSettingBeanItem>()
    private var msgSet = MutableLiveData<MsgSettingBeanItem>() // 消息总开关

    fun getData() {
        RxHttp.get(ApiUrls.MSG_GET_SETTING_STATUS)
                .asResponse<MsgSettingBean>()
                .subscribe({
                    for (bean in it) {
                        when (bean.type) {
                            0 -> msgSysSet.postValue(bean)
                            1 -> msgFolSet.postValue(bean)
                            2 -> msgComSet.postValue(bean)
                            3 -> msgSet.postValue(bean)
                        }
                    }
                }, {
                    Log.e("tag", "----->$it")
                })
    }

    fun upData(id: String, status: String, type: String) {
        RxHttp.postForm(ApiUrls.MSG_POST_SETTING_STATUS)
                .add("id", id)
                .add("status", status)
                .add("type", type)
                .asClass(NetworkStrBean::class.java)
                .subscribe({
                    getData()
                }, {
                    Log.e("tag", "----->$it")
                })
    }
}