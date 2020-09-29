package com.example.jitter.wallet

import android.view.View
import com.chad.library.adapter.base.BaseQuickAdapter
import com.chad.library.adapter.base.viewholder.BaseViewHolder
import com.example.jitter.R
import com.example.jitter.bean.VipItem
import com.example.jitter.interfa.OnItemClickListener

/**
 * author: Warrior
 * created: 2020/9/21 15:00
 * descript:
 */
class VipDaysAdapter : BaseQuickAdapter<VipItem,BaseViewHolder>{

    //记录上次点击
    private var tempView: View? = null

    //数据显示类型，0会员，1提现
    private var dataType = 0

    private var listener: OnItemClickListener? = null

    constructor(): super(R.layout.item_vip_price)

    fun setOnOnItemListener(listener: OnItemClickListener?){
        this.listener = listener
    }

    fun setDataType(dataType:Int = 0){
        this.dataType = dataType
    }

    override fun convert(holder: BaseViewHolder, item: VipItem) {
        if (dataType == 0){
            holder.setText(R.id.daysView, "${item.key}天")
            holder.setText(R.id.priceView, "¥${item.value}元")
        } else {
            holder.setText(R.id.daysView, "¥${item.value}元")
            holder.setGone(R.id.priceView,true)
        }
        if (holder.layoutPosition == 0){
            listener?.onItemClick(item,holder.layoutPosition)
            tempView = holder.itemView.apply { isSelected = true }
        } else {
            holder.itemView.isSelected = false
        }
        holder.itemView.setOnClickListener {
            tempView?.isSelected = false
            tempView = it.apply { isSelected = true }
            listener?.onItemClick(item,holder.layoutPosition)
        }
    }

}