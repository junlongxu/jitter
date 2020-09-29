package com.example.jitter.my.adapter

import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.viewholder.BaseViewHolder
import com.example.jitter.R
import com.example.jitter.bean.FlowsBean

/**
 * author: Warrior
 * created: 2020/9/10 19:54
 * descript: 订单流水Adapter
 */
class RecordAdapter() : BaseQuickAdapter<FlowsBean, BaseViewHolder>(R.layout.item_layout_record) {

    override fun convert(holder: BaseViewHolder, item: FlowsBean) {
        holder.setText(R.id.record_name,item.moneyType)
        holder.setText(R.id.record_time,item.createTime)
        holder.setText(R.id.record_state,item.amount)
        if (item.inOutType != 0){
            holder.setTextColor(R.id.record_state,holder.itemView.resources.getColor(R.color.color_ff2020))
        } else {
            holder.setTextColor(R.id.record_state,holder.itemView.resources.getColor(R.color.color_79bb24))
        }
    }


}