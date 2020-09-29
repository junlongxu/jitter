package com.example.jitter.my

import android.content.Context
import android.content.Intent
import android.view.View
import androidx.core.text.HtmlCompat
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.jitter.BaseActivity
import com.example.jitter.R
import com.example.jitter.factory.ViewModelFactory
import com.example.jitter.my.adapter.OnRightClick
import com.example.jitter.my.adapter.RecordAdapter
import com.example.jitter.util.Utils
import com.example.jitter.viewmode.UserViewMode
import com.example.jitter.wallet.ExchangeVipActivity
import com.example.jitter.wallet.WithdrawActivity
import com.example.jitter.widget.MyDialog
import kotlinx.android.synthetic.main.activity_myflows.*
import kotlinx.android.synthetic.main.layout_mybalance.*
import kotlinx.android.synthetic.main.layout_mycoins.*

/**
 * author: Warrior
 * created: 2020/9/10 17:37
 * descript: 用户金币流水/余额流水
 */
class MyFlowsActivity : BaseActivity() {

    private var pageNum = 1

    /**0金币流水，1余额流水*/
    private var flowsType = 0

    private val adapter by lazy {
        RecordAdapter()
    }

    companion object {
        const val TYPE = "showType"

        fun startActivity(context: Context, flowsType: Int) {
            val intent = Intent(context, MyFlowsActivity::class.java)
            intent.putExtra(TYPE, flowsType)
            context.startActivity(intent)
        }
    }

    private val userModel by lazy {
        ViewModelProvider(this, ViewModelFactory(supportFragmentManager))[UserViewMode::class.java]
    }

    override fun getBarTitle(): String {
        return if (flowsType == 1) {
            "我的余额"
        } else {
            "我的抖币"
        }
    }

    override fun getLayoutResId(): Int = R.layout.activity_myflows

    override fun initView() {
        recyclerView.adapter = adapter

        //点击兑换会员
        changeView.setOnClickListener {
            startActivity(ExchangeVipActivity::class.java)
        }

        //点击提现
        withdrawView.setOnClickListener {
            val balance = sumsView.text.toString().toFloat()
            if (balance < 0) {
                Utils.showDialog(supportFragmentManager, "余额不足", false, null)
            } else {
                val intent = Intent(this, WithdrawActivity::class.java)
                intent.putExtra("balance", balance)
                startActivity(intent)
            }
        }

        // 金币兑换
        coin_changeView.setOnClickListener {
            val coinNum: String = coin_sumsView.text.toString()
            if (coinNum == "0") {
                showToast("还没有那么多的抖币，赶快去赚吧！")
            } else {
                val tempCoin = String.format("%.2f", (coinNum.toLong() / 10000.0))
                val dialog = MyDialog(this@MyFlowsActivity)
                dialog.setStrTitle("兑换余额")
                val textSource = "您当前的金币数量为 <font color='#f54b64'> $coinNum </font>个，可兑换的余额为<font color='#f54b64'> $tempCoin </font>元，确认兑换吗？"
                dialog.setSpaned(HtmlCompat.fromHtml(textSource, HtmlCompat.FROM_HTML_MODE_LEGACY))
                dialog.setOnRightClick(object : OnRightClick {
                    override fun onclick() {
                        userModel.exchangeCoin()
                    }
                })
                dialog.showDia()
            }
        }
    }

    override fun initData() {
        flowsType = intent.getIntExtra(TYPE, 0)
        if (flowsType == 0) {
            coinsView.visibility = View.VISIBLE
            myflow_title.text = "————金币流水————"

            // 获取用户钱包信息
            userModel.getUserInfo()
        } else {
            balanceView.visibility = View.VISIBLE
            myflow_title.text = "————余额流水————"
            //获取余额
            userModel.getUserWallet()
        }

        // 兑换结果
        userModel.exCoinRes.observe(this, Observer {
            if (it.code == 200) {
                // 兑换结束后，更新用户钱包信息及流水信息
                userModel.getUserInfo()
            } else
                showToast(it.msg)
        })

        //显示金币数量
        userModel.walletInfo.observe(this, Observer {
            coin_sumsView.text = it.goldNumber
            //获取金币流水
            userModel.getFlows(pageNum, flowsType)
        })

        //显示余额
        userModel.userInfo.observe(this, Observer {
            sumsView.text = it.balance
            //获取余额流水
            userModel.getFlows(pageNum, flowsType)
        })

        //金币 or 余额 流水数据
        userModel.userFlows.observe(this, Observer {
            adapter.setNewInstance(it.list)
        })
    }
}