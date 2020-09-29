package com.example.jitter.viewmode

import android.util.Log
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.jitter.bean.MsgListOneBean
import com.example.jitter.util.ApiUrls
import rxhttp.wrapper.param.RxHttp

/**
 * Time : 2020/9/21
 * Author : Bing
 * Description : 消息首页数据
 */
class MsgStatuViewModel : ViewModel() {

    var sysNum = MutableLiveData<MsgListOneBean>()

    // 获取未读消息数量
    fun getSysNum() {
        RxHttp.get(ApiUrls.MSG_GET_LIST)
                .asClass(MsgListOneBean::class.java)
                .subscribe({
                    sysNum.postValue(it)
                }, {
                    Log.e("tag", "----->${it.toString()}")
                })
    }
}