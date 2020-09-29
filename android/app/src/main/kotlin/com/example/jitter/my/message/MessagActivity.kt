package com.example.jitter.my.message

import android.content.Context
import android.content.Intent
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import com.chad.library.adapter.base.BaseQuickAdapter
import com.example.jitter.BaseActivity
import com.example.jitter.R
import com.example.jitter.bean.GlobalConstant
import com.example.jitter.bean.MsgListOneBean
import com.example.jitter.my.adapter.MessageAdapter
import com.example.jitter.viewmode.MsgStatuViewModel
import kotlinx.android.synthetic.main.avtivity_message.*
import kotlinx.android.synthetic.main.layout_base_toolbar.*


/**
 * author: Warrior
 * created: 2020/9/11 10:37
 * descript: 消息界面，2020年9月17日 Bing 开发
 */
class MessagActivity : BaseActivity() {
    private val mContext: Context by lazy {
        this
    }

    override fun getBarTitle(): String = "消息"

    override fun getLayoutResId(): Int = R.layout.avtivity_message

    private val numModel by lazy {
        ViewModelProvider(this, ViewModelProvider.NewInstanceFactory()).get(MsgStatuViewModel::class.java)
    }

    override fun initView() {
        toolbar_setting.text = "设置"
        toolbar_setting.setOnClickListener {
            startActivity(Intent(mContext, SettingsMessageActivity::class.java))
        }
    }

    override fun initData() {
        numModel.getSysNum()

        msg_rv.layoutManager = LinearLayoutManager(mContext)
        numModel.sysNum.observe(this, Observer<MsgListOneBean> { bean ->
            val adapter = MessageAdapter()
            adapter.addData(bean!!.data)
            msg_rv.adapter = adapter
            if (bean.data.isEmpty()) {
                setEmptyVVV(adapter)
            }
            adapter.setOnItemClickListener { _, _, position ->
                val tempData = bean.data[position]
                tempData.infoNumber = 0
                adapter.setData(position, tempData)
                val intent = Intent(mContext, MsgSystemActivity::class.java)
                intent.putExtra(GlobalConstant.MESSAGE_DETAIL_TYPE, bean.data[position].type.toString())
                startActivity(intent)
            }
        })
    }

    // 加载rv空布局
    private fun setEmptyVVV(adapter: BaseQuickAdapter<*, *>) {
        adapter.data.clear()
        adapter.setEmptyView(R.layout.layout_item_empty)
        adapter.notifyDataSetChanged()
    }
}