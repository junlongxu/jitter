package com.example.jitter.util

import android.content.Context
import android.util.TypedValue
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.fragment.app.FragmentManager
import com.example.jitter.widget.PromptDialog
import java.text.DecimalFormat

/**
 * author: Warrior
 * created: 2020/9/8 12:49
 * descript:
 */
object Utils {

    lateinit var mContext: Context

    private val promptDialog by lazy {
        PromptDialog()
    }

    fun dpToPx(dip: Float): Int {
        return TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, dip, mContext.resources.displayMetrics).toInt()
    }

    /**
     * @param content 要显示的内容
     * @param listener 回调
     */
    fun showDialog(@NonNull manager: FragmentManager, content: String, listener: PromptDialog.OnDialogClickListener?){
        promptDialog.showDialog(manager, content, listener)
    }

    /**
     * @param content 要显示的内容
     * @param title
     */
    fun showDialog(@NonNull manager: FragmentManager, title: String, content: String, listener: PromptDialog.OnDialogClickListener?){
        promptDialog.showDialog(manager, content, listener)
    }

    /**
     * @param content 要显示的内容
     * @param isCance false 不显示取消按钮
     * @param listener 回调
     */
    fun showDialog(@NonNull manager: FragmentManager, content: String, isCance: Boolean, listener: PromptDialog.OnDialogClickListener?){
        promptDialog.showDialog(manager, content, isCance, listener)
    }

    /**
     * @param content 要显示的内容
     * @param canceText 取消按钮显示的内容
     * @param confirmText 确认按钮显示的内容
     * @param listener 回调
     */
    fun showDialog(@NonNull manager: FragmentManager, content: String, canceText: String, confirmText: String, listener: PromptDialog.OnDialogClickListener?){
        promptDialog.showDialog(manager, content, canceText, confirmText, listener)
    }

    fun showToast(content: String){
        Toast.makeText(mContext, content, Toast.LENGTH_LONG).show()
    }

    fun getByteSize(size: Long): String{
        val GB = 1024 * 1024 * 1024   //定义GB的计算常量
        val MB = 1024 * 1024          //定义MB的计算常量
        val KB = 1024                 //定义KB的计算常量
        val df = DecimalFormat("0.00")
        var resultSize: String
        if (size / GB >= 1) {
            resultSize = "${df.format(size / GB.toFloat())}GB"
        } else if (size / MB >= 1) {
            resultSize = "${df.format(size / MB.toFloat())}MB"
        }else if (size / KB >= 1) {
            resultSize = "${df.format(size / KB.toFloat())}KB"
        } else {
            resultSize = "${size}B"
        }
        return resultSize
    }

}