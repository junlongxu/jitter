package com.example.jitter.bean

/**
 * Time : 2020/9/16
 * Author : Bing
 * Description : 用户关注列表数据bean
 */

data class FollowListBean(
        val avatorUrl: String,
        val name: String,
        val userId: String,
        val signature: String,
        val follower: Int,
        val status: Int // 1关注，0未关注
)