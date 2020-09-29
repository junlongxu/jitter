package com.example.jitter.bean
/**
 * Time : 2020/9/21
 * Author : Bing
 * Description : 一级消息列表
 */
data class MsgListOneBean(
        val code: Int,
        val data: List<MsgListOneItem>,
        val msg: String
)

data class MsgListOneItem(
        val context: String,
        val createTime: String,
        val id: String,
        var infoNumber: Int,
        val messageIcon: String,
        val status: Int,
        val title: String,
        val type: Int,
        val userId: String
)