package com.example.jitter.bean
/**
 * author: Warrior
 * created: 2020年9月23日
 * descript: 获取用户信息，编辑用户信息界面~
 */
data class UpdateUserInfoBean(
    val account: String,
    val age: String,
    val areSelf: Boolean,
    val area: String,
    val attention: Boolean,
    val balance: String,
    val birthday: String,
    val constellation: String,
    val fansNum: Int,
    val focusNum: Int,
    val goldNumber: String,
    val headImage: String,
    val id: String,
    val isVip: Boolean,
    val nickName: String,
    val phone: String,
    val praiseNum: String,
    val publicVideoNum: String,
    val remark: String,
    val sex: Int,
    val userId: String,
    val videoPraiseNum: String,
    val vipTime: String
)