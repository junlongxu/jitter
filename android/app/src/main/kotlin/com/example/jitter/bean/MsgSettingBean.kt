package com.example.jitter.bean

class MsgSettingBean : ArrayList<MsgSettingBeanItem>()

data class MsgSettingBeanItem(
        val context: String,
        val createTime: String,
        val id: Long,
        val messageIcon: String,
        val status: Int,
        val title: String,
        val type: Int,
        val userId: Long
)