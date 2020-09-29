package com.example.jitter.bean

/**
 * Time : 2020/9/16
 * Author : Bing
 * Description : 用户视频数据bean
 */

data class VideoBean(
        val status: Int,        // 0 正常 1 审核 2 异常，需删除
        val url: String,
        val zan: Int
)