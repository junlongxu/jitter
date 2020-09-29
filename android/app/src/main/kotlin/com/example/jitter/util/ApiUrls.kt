package com.example.jitter.util

/**
 * author: Warrior
 * created: 2020/9/12 16:12
 * descript:
 */
object ApiUrls {

    //开发环境
//    @DefaultDomain
    const val URL_MAIN = "http://172.24.135.209:8011/app/"
//    const val URL_MAIN = "http://146.196.78.142:10007/app/"

    //uat环境
//    @DefaultDomain
//    const val URL_MAIN = "http://172.24.135.209:8011/app/"

    /**视频上传，临时接口*/
    const val upload = "videos/uploadVideoAPPTemp"

    /**钱包流水*/
    const val FLOWS = "wallet/myFlows"

    /**钱包余额*/
    const val WALLET = "wallet/myWallet"

    // 获取消息状态
    const val MSG_STATUS = "messageStatus/add"

    // 设置消息开关
    const val MSG_POST_SETTING_STATUS = "message/updateOff"

    // 获取消息设置状态
    const val MSG_GET_SETTING_STATUS = "message/turnOffList"

    // 一级消息详情
    const val MSG_GET_LIST = "message/list"

    // 二级消息详情
    const val MSG_GET_LIST_DETAIL = "message/messageList"

    // 账号退出
    const val MSG_GET_LOGOUT = "login/out"

    /**会员类型*/
    const val VIP_TYPE = "wallet/getToMemType"

    /**提现类型*/
    const val WITHDRAW_LIST = "wallet/getWithdrawType"

    /**兑换会员*/
    const val EXCHANGE_VIP = "wallet/chargeVIP"

    // 金币兑换
    const val EXCHANGE_COIN = "wallet/chargeGold"

    // 获取用户余额数据
    const val USER_WALLET_INFO = "wallet/myWallet"

    // 获取用户信息
    const val USER_GET_INFO = "userInfo/myUserInfo"

    //更新用户信息
    const val USER_UPDATE_INFO = "userInfo/update"

    //上传用户图像
    const val USER_UPDATE_AVATOR = "userInfo/uploadImage"
}
