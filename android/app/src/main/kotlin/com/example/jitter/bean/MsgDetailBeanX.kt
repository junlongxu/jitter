package com.example.jitter.bean

data class MsgDetailBeanX(
        val endRow: String,
        val hasNextPage: Boolean,
        val hasPreviousPage: Boolean,
        val isFirstPage: Boolean,
        val isLastPage: Boolean,
        val list: List<MsgDetailLevelTwo>,
        val navigateFirstPage: Int,
        val navigateLastPage: Int,
        val navigatePages: Int,
        val navigatepageNums: List<Int>,
        val nextPage: Int,
        val pageNum: Int,
        val pageSize: Int,
        val pages: Int,
        val prePage: Int,
        val size: Int,
        val startRow: String,
        val total: String
)

data class MsgDetailLevelTwo(
        val context: String,
        val createTime: String,
        val createUser: String,
        val groupId: String,
        val id: String,
        val isPublish: Any,
        val messageOff: String,
        val pubUserId: String,
        val publishTime: String,
        val receiveType: String,
        val remindWay: String,
        val sectionId: String,
        val title: String,
        val type: String,
        val updateTime: Any,
        val updateUser: String,
        val userId: String,
        val userType: String,
        val videoName: String
)