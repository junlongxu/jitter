package com.example.jitter.bean

/**
 * author: Warrior
 * created: 2020/9/21 15:02
 * descript:
 */
data class VipPriceBean (
        val isVip: Boolean,
        val validDate: String,
        val balance: String,
        val selectVo: MutableList<VipItem>
)

data class VipItem(
        val id: String,
        val key: String,
        val value: String,
        val needDays: String,
        val needFriends: String
)