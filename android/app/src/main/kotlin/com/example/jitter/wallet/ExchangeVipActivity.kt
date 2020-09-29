package com.example.jitter.wallet

import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.jitter.BaseActivity
import com.example.jitter.R
import com.example.jitter.bean.VipItem
import com.example.jitter.factory.ViewModelFactory
import com.example.jitter.interfa.OnItemClickListener
import com.example.jitter.util.Utils
import com.example.jitter.viewmode.WalletViewModel
import com.example.jitter.widget.DividerGridItemDecoration
import com.example.jitter.widget.PromptDialog
import kotlinx.android.synthetic.main.activity_exchange_vip.*

/**
 * author: Warrior
 * created: 2020/9/21 14:16
 * descript: 兑换会员
 */
class ExchangeVipActivity : BaseActivity(){

    private lateinit var vipDay: VipItem

    private val vipAdapter = VipDaysAdapter()

    private val viewModel by lazy {
        ViewModelProvider(this, ViewModelFactory(supportFragmentManager))[WalletViewModel::class.java]
    }

    override fun getBarTitle(): String = getString(R.string.exchange_vip)

    override fun getLayoutResId(): Int = R.layout.activity_exchange_vip

    override fun initView() {
        recyclerView.apply {
            adapter = vipAdapter
            addItemDecoration(DividerGridItemDecoration(Utils.dpToPx(12f)))
        }

        vipAdapter.setOnOnItemListener(object : OnItemClickListener{
            override fun onItemClick(objec: Any, position: Int) {
                vipDay = objec as VipItem
            }
        })

        //提交兑换会员
        confirmButton.setOnClickListener {
            Utils.showDialog(supportFragmentManager,"兑换会员", "是否用${vipDay.value}元，兑换${vipDay.key}天",object : PromptDialog.OnDialogClickListener{
                override fun onCance() {}
                override fun onConfirm() {
                    viewModel.postExchangeVip(vipDay.key)
                }
            })
        }
    }

    override fun initData() {
        //获取会员信息
        viewModel.getVipType()

        //会员列表
        viewModel.vipData.observe(this, Observer {
            vipAdapter.setNewInstance(it.selectVo)
            if (it.isVip){
                expireView.text = "${it.validDate}到期"
            }
        })

        //兑换结果
        viewModel.exchangeResult.observe(this, Observer {
            expireView.text = "${it["validDate"]}到期"
            showToast("兑换成功")
        })
    }
}