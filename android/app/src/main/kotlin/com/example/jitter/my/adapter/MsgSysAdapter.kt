package com.example.jitter.my.adapter

import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.viewholder.BaseViewHolder
import com.example.jitter.R
import com.example.jitter.bean.MsgDetailLevelTwo

/**
 * Time : 2020/9/19
 * Author : Bing
 * Description : 更新系统消息
 */
class MsgSysAdapter : BaseQuickAdapter<MsgDetailLevelTwo, BaseViewHolder>(R.layout.layout_item_msgsys) {
    override fun convert(holder: BaseViewHolder, item: MsgDetailLevelTwo) {
        holder.setText(R.id.item_msgsys_content, item.context)
        holder.setText(R.id.item_msgsys_time, item.createTime)
    }
}