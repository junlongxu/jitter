package com.example.jitter.viewmode

import android.util.Log
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.MutableLiveData
import com.example.jitter.bean.*
import com.example.jitter.util.ApiUrls
import rxhttp.wrapper.param.RxHttp
import rxhttp.wrapper.param.asResponse

/**
 * author: Warrior
 * created: 2020/9/12 17:42
 * descript:
 */
class UserViewMode(private val fm: FragmentManager) : BaseViewModel(fm) {

    val userFlows = MutableLiveData<BaseBean<FlowsBean>>()

    val exCoinRes = MutableLiveData<NetworkStrBean>()

    val walletInfo = MutableLiveData<WalletInfoBean>()

    val userInfo = MutableLiveData<UserBean>()

    /**用户钱包信息*/
    fun getUserWallet() {
        showLoading()
        RxHttp.postForm(ApiUrls.WALLET)
                .asResponse<UserBean>()
                .subscribe({
                    hidLoading()
                    userInfo.postValue(it)
                }, {
                    hidLoading()
                    it.message?.let { message ->
                        showToast(message)
                    }
                })
    }

    /**
     * 资金流水
     * @param type 0金币流水，1余额流水
     */
    fun getFlows(pageNum: Int, type: Int) {
        RxHttp.postForm(ApiUrls.FLOWS)
                .add("pageNum", pageNum)
                .add("pageSize", 10)
                .add("type", type)
                .asResponse<BaseBean<FlowsBean>>()
                .subscribe({
                    hidLoading()
                    userFlows.postValue(it)
                }, {
                    hidLoading()
                    it.message?.let { message ->
                        showToast(message)
                    }
                    Log.e("tag", "----->${it.toString()}")
                })

    }

    // 金币兑换
    fun exchangeCoin() {
        showLoading()
        RxHttp.postForm(ApiUrls.EXCHANGE_COIN)
//                .add("chargeGoldNum", 100)  //  默认全部兑换
                .asClass(NetworkStrBean::class.java)
                .subscribe({
                    hidLoading()
                    exCoinRes.postValue(it)
                }, {
                    hidLoading()
                    it.message?.let { message ->
                        showToast(message)
                    }
                    Log.e("tag", "----->${it.toString()}")
                })
    }

    // 获取用户数据
    fun getUserInfo() {
        showLoading()
        RxHttp.postForm(ApiUrls.USER_WALLET_INFO)
                .asResponse<WalletInfoBean>()
                .subscribe({
                    walletInfo.postValue(it)
                }, {
                    it.message?.let { message ->
                        showToast(message)
                    }
                    Log.e("tag", "----->${it.toString()}")
                })
    }

}