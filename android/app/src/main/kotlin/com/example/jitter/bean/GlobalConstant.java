package com.example.jitter.bean;

/**
 * Time : 2020/9/15
 * Author : Bing
 * Description : 保存全局常量
 */
public interface GlobalConstant {
    // 测试Authorization
    String TEST_AUTHORIZATION = "f7aec29528848eb03ca2013fe97c0d14";
    // 闪屏页apk下载地址
    String DOWNLOAD_APK_URL = "https://bt.5li2v2.com/channel/android/hqbetgame_6215472_2.0.2_0913213641.apk";
    String BUTTON_LEFT      = "BUTTON_LEFT";
    String BUTTON_RIGHT     = "BUTTON_RIGHT";

    String PERSONAL_INFO_S_NICKNAME   = "PERSONAL_INFO_S_NICKNAME";
    String PERSONAL_INFO_S_SIGNATURE  = "PERSONAL_INFO_S_SIGNATURE";
    String USERDETAIL_USERID          = "USERDETAIL_USERID";
    String USERDETAIL_TYPE            = "USERDETAIL_TYPE";
    String USERDETAIL_TYPE_FOLLOW     = "USERDETAIL_TYPE_FOLLOW";
    String USERDETAIL_TYPE_FOLLOWER   = "USERDETAIL_TYPE_FOLLOWER";
    String MESSAGE_DETAIL_TYPE        = "MESSAGE_DETAIL_TYPE";

    // 0,消息,1,粉丝,2.评论
    String MESSAGE_DETAIL_TYPE_FOLLOW = "1";
    String MESSAGE_DETAIL_TYPE_COMMON = "2";
    String MESSAGE_DETAIL_TYPE_SYSTEM = "0";

    int PERSONAL_INFO_I_SIGNATURE = 100;
    int PERSONAL_INFO_I_NIKENAME  = 101;
    int PERSONAL_INFO_I_TAKEPHOTO = 102;
    int PERSONAL_INFO_I_GALLEY    = 103;
}
