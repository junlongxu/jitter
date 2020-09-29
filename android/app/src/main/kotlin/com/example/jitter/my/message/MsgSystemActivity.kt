package com.example.jitter.my.message

import android.content.Context
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import com.chad.library.adapter.base.BaseQuickAdapter
import com.example.jitter.BaseActivity
import com.example.jitter.R
import com.example.jitter.bean.BaseBean
import com.example.jitter.bean.GlobalConstant.*
import com.example.jitter.bean.MsgDetailLevelTwo
import com.example.jitter.my.adapter.MsgDetailAdapter
import com.example.jitter.my.adapter.MsgSysAdapter
import com.example.jitter.viewmode.MsgDetailViewModel
import kotlinx.android.synthetic.main.activity_msg_system.*

class MsgSystemActivity : BaseActivity() {
    // 当前起始界面
    companion object {
        // 索引从1开始
        var index = 1
        var hasNext = true
    }

    private val mContext: Context by lazy {
        this
    }

    private val showType: String by lazy {
        intent.getStringExtra(MESSAGE_DETAIL_TYPE) ?: "0"
    }

    override fun getBarTitle(): String {
        return when (showType) {
            MESSAGE_DETAIL_TYPE_COMMON -> {
                "评论"
            }
            MESSAGE_DETAIL_TYPE_FOLLOW -> {
                "粉丝"
            }
            else -> {
                "系统消息"
            }
        }
    }

    override fun getLayoutResId(): Int = R.layout.activity_msg_system

    private val msgDetailViewmodel by lazy {
        ViewModelProvider(this, ViewModelProvider.NewInstanceFactory()).get(MsgDetailViewModel::class.java)
    }

    override fun initView() {
    }

    override fun initData() {
        msgDetailViewmodel.getData(showType, index.toString())

        msgsys_rv.layoutManager = LinearLayoutManager(mContext)
        msgDetailViewmodel.msgDetailLD.observe(this, Observer<BaseBean<MsgDetailLevelTwo>> { bean ->
            if (showType == MESSAGE_DETAIL_TYPE_FOLLOW || showType == MESSAGE_DETAIL_TYPE_COMMON) {
                val adapter = MsgDetailAdapter(showType)
                adapter.setOnItemClickListener { _, _, position ->
                    showToast("xxx$position")
                }
                msgsys_rv.adapter = adapter
                adapter.setNewInstance(bean.list)
                if (bean.list.size == 0) {
                    setEmptyVVV(adapter)
                }
            } else {
                val adapter = MsgSysAdapter()
                adapter.setNewInstance(bean.list)
                msgsys_rv.adapter = adapter
                if (bean.list.size == 0) {
                    setEmptyVVV(adapter)
                }
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