package com.example.jitter.bean

/**
 * author: Warrior
 * created: 2020/9/12 15:50
 * descript:
 */
data class BaseResponse<T>(
        val code: Int,
        val msg: String,
        val data: T
)