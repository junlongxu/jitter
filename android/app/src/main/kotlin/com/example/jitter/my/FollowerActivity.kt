package com.example.jitter.my

import com.example.jitter.BaseActivity
import com.example.jitter.R
import com.example.jitter.bean.GlobalConstant
import com.example.jitter.bean.GlobalConstant.USERDETAIL_TYPE_FOLLOW
import com.example.jitter.bean.GlobalConstant.USERDETAIL_USERID

/**
 * Time : 2020/9/16
 * Author : Bing
 * Description : 用户关注列表
 */

class FollowerActivity : BaseActivity() {
    override fun getBarTitle(): String {
        val showType = intent.getStringExtra(GlobalConstant.USERDETAIL_TYPE)
        return if (showType == USERDETAIL_TYPE_FOLLOW) {
            "TA的关注"
        } else {
            "TA的粉丝"
        }
    }

    override fun getLayoutResId(): Int = R.layout.activity_follower

    override fun initView() {
        val userID = intent.getStringExtra(USERDETAIL_USERID)

    }

    override fun initData() {

    }

}