package com.example.jitter.my.adapter

import android.text.Spannable
import android.text.SpannableString
import android.text.style.ForegroundColorSpan
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.viewholder.BaseViewHolder
import com.example.jitter.R
import com.example.jitter.bean.GlobalConstant
import com.example.jitter.bean.MsgDetailLevelTwo

/**
 * Time : 2020/9/19
 * Author : Bing
 * Description : 更新粉丝、评论消息适配器
 */
class MsgDetailAdapter(private val type: String) : BaseQuickAdapter<MsgDetailLevelTwo, BaseViewHolder>(R.layout.layout_item_msgdetail) {
    override fun convert(holder: BaseViewHolder, item: MsgDetailLevelTwo) {
//        val ivAvator = holder.getView<ImageView>(R.id.item_msgdetail_avator)
//        Picasso.get().load(item.userAvator).into(ivAvator)

        val name = item.userId
        val spanString = SpannableString("$name 评论了你的视频 " + item.videoName)
        val spanString1 = SpannableString("$name 成为了你的新粉丝")
        val span = ForegroundColorSpan(context.resources.getColor(R.color.color_f54b64))
        if (type == GlobalConstant.MESSAGE_DETAIL_TYPE_COMMON) {
            spanString.setSpan(span, 0, name.length, Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
            holder.setText(R.id.item_msgdetail_content, spanString)
        } else {
            spanString1.setSpan(span, 0, name.length, Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
            holder.setText(R.id.item_msgdetail_content, spanString1)
        }

        holder.setText(R.id.item_msgdetail_time, item.createTime)
    }
}