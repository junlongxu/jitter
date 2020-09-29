package com.example.jitter.my.adapter

import android.content.Context
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.jitter.R
import com.example.jitter.bean.VideoBean
import com.squareup.picasso.Picasso

/**
 * Time : 2020/9/16
 * Author : Bing
 * Description : 用户详情界面viewholder
 */

class VideoViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
    var videoIvBg: ImageView = itemView.findViewById(R.id.item_video_bg)
    var videoIvDel: ImageView = itemView.findViewById(R.id.item_video_del)
    var videoTvHint: TextView = itemView.findViewById(R.id.item_video_hint)
}

internal class VideoAdapter(private val context: Context, private val mList: ArrayList<VideoBean>) : RecyclerView.Adapter<VideoViewHolder>(), View.OnClickListener {

    private var onItemClick: OnItemClick? = null

    fun setOnItemClick(onItemClick: OnItemClick?) {
        this.onItemClick = onItemClick
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): VideoViewHolder {
        val view = LayoutInflater.from(context).inflate(R.layout.layout_item_video, parent, false)
        return VideoViewHolder(view)
    }

    override fun onBindViewHolder(holder: VideoViewHolder, position: Int) {
        holder.itemView.tag = "xxx" + mList[position].status
        holder.itemView.setOnClickListener(this)
        // 初始化布局
        holder.videoIvDel.visibility = View.INVISIBLE
        holder.videoTvHint.visibility = View.VISIBLE

        Picasso.get().load(mList[position].url).into(holder.videoIvBg)
        holder.videoIvDel.setOnClickListener {
            mList.removeAt(holder.adapterPosition)
            notifyItemRemoved(holder.adapterPosition)
            notifyItemRangeChanged(holder.adapterPosition, mList.size)
        }
        when (mList[position].status) {
            0 -> {
                holder.videoTvHint.text = "♥" + mList[position].zan
                holder.videoTvHint.gravity = Gravity.START
            }
            1 -> {
                holder.videoTvHint.text = "审核中"
                holder.videoTvHint.gravity = Gravity.CENTER
            }
            2 -> {
                holder.videoIvDel.visibility = View.VISIBLE
                holder.videoTvHint.visibility = View.INVISIBLE
            }
        }
    }

    override fun getItemCount(): Int {
        return mList.size
    }

    override fun onClick(v: View?) {
        onItemClick?.onClick(v?.tag as String?)
    }
}