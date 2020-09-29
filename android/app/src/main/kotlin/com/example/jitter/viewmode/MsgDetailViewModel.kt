package com.example.jitter.viewmode

import android.util.Log
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.jitter.bean.BaseBean
import com.example.jitter.bean.MsgDetailLevelTwo
import com.example.jitter.util.ApiUrls
import rxhttp.wrapper.param.RxHttp
import rxhttp.wrapper.param.asResponse

/**
 * Time : 2020/9/21
 * Author : Bing
 * Description : 获取消息详情
 */
class MsgDetailViewModel : ViewModel() {
    var msgDetailLD = MutableLiveData<BaseBean<MsgDetailLevelTwo>>()

    fun getData(type: String, pageNum: String) {
        RxHttp.get(ApiUrls.MSG_GET_LIST_DETAIL)
                .add("type", type)
                .add("pageNum", pageNum)
                .add("pageSize", "20")
                .asResponse<BaseBean<MsgDetailLevelTwo>>()
                .subscribe({
                    Log.e("tag", "----->$it")
                    msgDetailLD.postValue(it)
                }, {
                    Log.e("tag", "----->$it")
                })
    }
}