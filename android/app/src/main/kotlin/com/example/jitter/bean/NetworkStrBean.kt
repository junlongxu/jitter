package com.example.jitter.bean

/**
 * Time : 2020/9/21
 * Author : Bing
 * Description : 网络返回值为字符串
 */
data class NetworkStrBean(
        val code: Int,
        val data: String,
        val msg: String
)