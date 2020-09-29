package com.example.jitter.viewmode

import android.util.Log
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.MutableLiveData
import com.example.jitter.bean.GlobalConstant
import com.example.jitter.bean.NetworkStrBean
import com.example.jitter.bean.UpdateUserInfoBean
import com.example.jitter.util.ApiUrls
import rxhttp.wrapper.param.RxHttp
import rxhttp.wrapper.param.asResponse
import java.io.File

/**
 * Time : 2020/9/25
 * Author : Bing
 * Description : 个人用户信息修改viewmodel
 */
class PerInfoUpdateViewModel(fm: FragmentManager) : BaseViewModel(fm) {
    var userinfoViewmodel = MutableLiveData<UpdateUserInfoBean>()
    var updateViewModel = MutableLiveData<NetworkStrBean>()

    // 获取用户信息
    fun getUserInfo() {
        showLoading()
        RxHttp.get(ApiUrls.USER_GET_INFO)
                .asResponse<UpdateUserInfoBean>()
                .subscribe({
                    userinfoViewmodel.postValue(it)
                    hidLoading()
                }, {
                    hidLoading()
                    it.message?.let { message ->

                    }
                    Log.e("tag", "----->${it.toString()}")
                })
    }

    // 更新用户数据
    fun updateInfo(name: String, value: String) {
        RxHttp.postForm(ApiUrls.USER_UPDATE_INFO)
                .add(name, value)
                .asClass(NetworkStrBean::class.java)
                .subscribe({
                    updateViewModel.postValue(it)
                }, {
                    it.message?.let { message ->

                    }
                    Log.e("tag", "----->${it.toString()}")
                })
    }

    // 上传用户图像
    fun updateAvator(file: File) {
        showLoading()
        RxHttp.postForm(ApiUrls.USER_UPDATE_AVATOR)
                .addFile("file", file)
                .asClass(NetworkStrBean::class.java)
                .subscribe({
                    updateViewModel.postValue(it)
                    hidLoading()
                }, {
                    hidLoading()
                    it.message?.let { message ->

                    }
                    Log.e("tag", "----->${it.toString()}")
                })
    }
}