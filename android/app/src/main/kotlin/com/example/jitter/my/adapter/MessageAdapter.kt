package com.example.jitter.my.adapter

import android.view.View
import android.widget.ImageView
import android.widget.TextView
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.viewholder.BaseViewHolder
import com.example.jitter.R
import com.example.jitter.bean.MsgListOneItem
import com.example.jitter.widget.CircleTransform
import com.squareup.picasso.Picasso

/**
 * author: Warrior
 * created: 2020/9/11 12:26
 * descript: 2020年9月21日 bing 实现
 */
class MessageAdapter : BaseQuickAdapter<MsgListOneItem, BaseViewHolder>(R.layout.item_layout_message) {

    override fun convert(holder: BaseViewHolder, item: MsgListOneItem) {
        val ivIcon = holder.getView<ImageView>(R.id.item_msg_iv_icon)
        val tvNum = holder.getView<TextView>(R.id.item_msg_tv_num)
        Picasso.get().load(item.messageIcon).transform(CircleTransform()).into(ivIcon)
        if (item.infoNumber == 0) {
            tvNum.visibility = View.INVISIBLE
        } else {
            tvNum.visibility = View.VISIBLE
            tvNum.text = item.infoNumber.toString()
        }
        holder.setText(R.id.item_msg_tv_title, item.title)
        holder.setText(R.id.item_msg_tv_des, item.context)
        holder.setText(R.id.item_msg_tv_time, item.createTime)
    }

}