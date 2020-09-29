package com.example.jitter.viewmode

import android.util.Log
import androidx.collection.ArrayMap
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.MutableLiveData
import com.example.jitter.bean.VipPriceBean
import com.example.jitter.util.ApiUrls
import rxhttp.wrapper.param.RxHttp
import rxhttp.wrapper.param.asResponse

/**
 * author: Warrior
 * created: 2020/9/21 15:37
 * descript: 钱包相关
 */
class WalletViewModel(fm: FragmentManager) : BaseViewModel(fm){

    /**会员数据,  提现列表  json格式是一样，所以共用*/
    val vipData = MutableLiveData<VipPriceBean>()

    /**会员兑换结果*/
    val exchangeResult = MutableLiveData<ArrayMap<String,String>>()

    /**获取会员信息*/
    fun getVipType(){
        showLoading()
        RxHttp.get(ApiUrls.VIP_TYPE)
                .asResponse<VipPriceBean>()
                .subscribe({
                    hidLoading()
                    vipData.postValue(it)
                }, {
                    hidLoading()
                    it.message?.let { message->
                        showToast(message)
                    }
                    Log.e("tag","----->${it.toString()}")
                })
    }

    /**提现的列表*/
    fun getWithdrawList(){
        RxHttp.get(ApiUrls.WITHDRAW_LIST)
                .asResponse<VipPriceBean>()
                .subscribe({
                    hidLoading()
                    vipData.postValue(it)
                }, {
                    hidLoading()
                    it.message?.let { message->
                        showToast(message)
                    }
                    Log.e("tag","----->${it.toString()}")
                })
    }

    /**
     * 兑换会员
     * @param vipDay 会员天数
     */
    fun postExchangeVip(vipDay: String){
        showLoading()
        RxHttp.postForm(ApiUrls.EXCHANGE_VIP)
                .add("vipDay",vipDay)
                .asResponse<ArrayMap<String,String>>()
                .subscribe({
                    hidLoading()
                    exchangeResult.postValue(it)
                }, {
                    hidLoading()
                    it.message?.let { message->
                        showToast(message)
                    }
                    Log.e("tag","----->${it.toString()}")
                })
    }

}