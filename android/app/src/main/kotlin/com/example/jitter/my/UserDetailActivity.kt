package com.example.jitter.my

import android.content.Context
import android.content.Intent
import android.view.View
import android.widget.Toast
import androidx.recyclerview.widget.GridLayoutManager
import com.example.jitter.BaseActivity
import com.example.jitter.R
import com.example.jitter.bean.GlobalConstant.*
import com.example.jitter.bean.VideoBean
import com.example.jitter.my.adapter.OnItemClick
import com.example.jitter.my.adapter.VideoAdapter
import kotlinx.android.synthetic.main.activity_user_detail.*

/**
 * Time : 2020年9月15日
 * Author : Bing
 * Description : 用户详情界面
 */

class UserDetailActivity : BaseActivity() {
    private val context: Context by lazy {
        this
    }

    companion object {
        private var isFollow = false
    }

    private val mlist: ArrayList<VideoBean> by lazy {
        ArrayList<VideoBean>()
    }

    private val videoAdapter: VideoAdapter by lazy {
        mlist.add(VideoBean(0, "https://i.imgur.com/DvpvklR.png", 1))
        mlist.add(VideoBean(0, "https://i.imgur.com/DvpvklR.png", 2))
        mlist.add(VideoBean(2, "https://i.imgur.com/DvpvklR.png", 3))
        mlist.add(VideoBean(0, "https://i.imgur.com/DvpvklR.png", 4))
        mlist.add(VideoBean(1, "https://i.imgur.com/DvpvklR.png", 5))
        mlist.add(VideoBean(0, "https://i.imgur.com/DvpvklR.png", 6))
        mlist.add(VideoBean(0, "https://i.imgur.com/DvpvklR.png", 7))
        mlist.add(VideoBean(2, "https://i.imgur.com/DvpvklR.png", 8))
        mlist.add(VideoBean(0, "https://i.imgur.com/DvpvklR.png", 9))
        mlist.add(VideoBean(2, "https://i.imgur.com/DvpvklR.png", 10))
        mlist.add(VideoBean(1, "https://i.imgur.com/DvpvklR.png", 11))
        mlist.add(VideoBean(0, "https://i.imgur.com/DvpvklR.png", 12))
        mlist.add(VideoBean(0, "https://i.imgur.com/DvpvklR.png", 13))
        mlist.add(VideoBean(1, "https://i.imgur.com/DvpvklR.png", 14))
        mlist.add(VideoBean(0, "https://i.imgur.com/DvpvklR.png", 15))
        mlist.add(VideoBean(2, "https://i.imgur.com/DvpvklR.png", 16))
        mlist.add(VideoBean(1, "https://i.imgur.com/DvpvklR.png", 17))
        mlist.add(VideoBean(0, "https://i.imgur.com/DvpvklR.png", 18))
        VideoAdapter(context, mlist)
    }

    override fun getBarTitle(): String = ""

    override fun getLayoutResId(): Int = R.layout.activity_user_detail

    override fun initView() {
        userdetail_tv_follow.setOnClickListener {
            if (isFollow) {
                userdetail_tv_follow.text = "关注"
                userdetail_tv_follow.background = resources.getDrawable(R.drawable.bg_paled_rounded)
                isFollow = false
            } else {
                isFollow = true
                userdetail_tv_follow.text = "已关注"
                userdetail_tv_follow.background = resources.getDrawable(R.drawable.drawable_shape_bg_follow)
            }
        }

        val intent = Intent(context, FollowerActivity::class.java)
        // 传递当前用户id，获取关注列表
        intent.putExtra(USERDETAIL_USERID,"xxxxxx")
        userdetail_ll_follow.setOnClickListener {
            intent.putExtra(USERDETAIL_TYPE, USERDETAIL_TYPE_FOLLOW)
            startActivity(intent)
        }

        userdetail_ll_follower.setOnClickListener {
            intent.putExtra(USERDETAIL_TYPE, USERDETAIL_TYPE_FOLLOWER)
            startActivity(intent)
        }
    }

    override fun initData() {
        // 视频数据为0时候
        if (mlist.size == 0){
            userdetail_rv.visibility = View.GONE
            userdetail_empty.visibility = View.VISIBLE
        }else{
            userdetail_rv.visibility = View.VISIBLE
            userdetail_empty.visibility = View.GONE
            // 加载用户视频列表
            userdetail_rv.layoutManager = GridLayoutManager(context, 3)
            userdetail_rv.adapter = videoAdapter
            videoAdapter.setOnItemClick(object : OnItemClick {
                override fun onClick(id: String?) {
                    Toast.makeText(context, "打开视频" + id, Toast.LENGTH_SHORT).show()
                }
            })
        }

    }

}
