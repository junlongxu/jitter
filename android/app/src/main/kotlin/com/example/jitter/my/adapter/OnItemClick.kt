package com.example.jitter.my.adapter

/**
 * Time : 2020/9/16
 * Author : Bing
 * Description : recyclyview 条目点击接口
 */
interface OnItemClick {
    fun onClick(id: String?)
}

internal interface OnLeftClick {
    fun onclick()
}

internal interface OnRightClick {
    fun onclick()
}