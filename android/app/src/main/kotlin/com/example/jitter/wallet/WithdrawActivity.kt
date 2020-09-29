package com.example.jitter.wallet

import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.jitter.BaseActivity
import com.example.jitter.R
import com.example.jitter.bean.VipItem
import com.example.jitter.factory.ViewModelFactory
import com.example.jitter.interfa.OnItemClickListener
import com.example.jitter.util.SpannUtils
import com.example.jitter.util.Utils
import com.example.jitter.viewmode.WalletViewModel
import com.example.jitter.widget.DividerGridItemDecoration
import kotlinx.android.synthetic.main.activity_withdraw.*

/**
 * author: Warrior
 * created: 2020/9/23 15:21
 * descript: 提现
 */
class WithdrawActivity : BaseActivity() {

    private lateinit var vipDay: VipItem

    private val vipAdapter = VipDaysAdapter()

    private val viewModel by lazy {
        ViewModelProvider(this, ViewModelFactory(supportFragmentManager))[WalletViewModel::class.java]
    }

    override fun getBarTitle(): String = getString(R.string.balance_withdraw)

    override fun getLayoutResId(): Int = R.layout.activity_withdraw

    override fun initView() {
        recyclerView.apply {
            adapter = vipAdapter
            addItemDecoration(DividerGridItemDecoration(Utils.dpToPx(6f)))
        }

        SpannUtils.getBuilder(balanceView)
                .append("${intent.getFloatExtra("balance",0f)}")
                .setGradient(R.color.color_f54b64,R.color.color_f78361)
                .append("\n可提现金额(元)")
                .setTextColor(R.color.color_ffffff)
                .build()

        vipAdapter.setDataType(1)
        vipAdapter.setOnOnItemListener(object : OnItemClickListener {
            override fun onItemClick(objec: Any, position: Int) {
                vipDay = objec as VipItem
            }
        })
    }

    override fun initData() {

        viewModel.getWithdrawList()

        viewModel.vipData.observe(this, Observer {
            vipAdapter.setNewInstance(it.selectVo)
        })

    }
}