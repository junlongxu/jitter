package com.example.jitter.my.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.jitter.R
import com.example.jitter.bean.FollowListBean

/**
 * Time : 2020/9/16
 * Author : Bing
 * Description : 关注列表界面
 */

class FollowViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
    var followAvator: ImageView = itemView.findViewById(R.id.item_follow_avator)
    var followName: TextView = itemView.findViewById(R.id.item_follow_name)
    var followSig: TextView = itemView.findViewById(R.id.item_follow_signature)
    var followFollower: TextView = itemView.findViewById(R.id.item_follow_follower)
    var followAction: TextView = itemView.findViewById(R.id.item_follow_action)
}

internal class FollowerAdapter(var context: Context, var mList: ArrayList<FollowListBean>) : RecyclerView.Adapter<FollowViewHolder>(), View.OnClickListener {

    private var onItemClick: OnItemClick? = null

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): FollowViewHolder {
        val view = LayoutInflater.from(context).inflate(R.layout.layout_item_follow, parent, false)
        return FollowViewHolder(view)
    }

    override fun onBindViewHolder(holder: FollowViewHolder, position: Int) {
        holder.followAction.setOnClickListener(this)
        holder.followAction.tag = mList[position].userId

        holder.followName.text = mList[position].name

    }

    override fun getItemCount(): Int {
        return mList.size
    }

    override fun onClick(v: View?) {
        onItemClick?.onClick(v?.tag as String?)
    }

}
