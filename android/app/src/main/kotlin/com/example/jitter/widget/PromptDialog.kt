package com.example.jitter.widget

import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import androidx.annotation.NonNull
import androidx.annotation.Nullable
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.FragmentManager
import com.example.jitter.R
import kotlinx.android.synthetic.main.dialog_layout_prompt.view.*

/**
 * author: Warrior
 * created: 2020/9/16 14:23
 * descript: 温馨提示
 */
class PromptDialog : DialogFragment(), View.OnClickListener{

    /**消息内容*/
    private var dialogContent = ""
    /**消息标题*/
    private var dialogTitle = "温馨提示"

    private var contentView: TextView? = null

    private var dialogCance: String? = "取消"
    private var dialogConfirm = "确定"

    /**是否显示取消按钮*/
    private var isCance = true

    /**取消文字的颜色*/
    private var dialogCanceColor = 0

    private var listener: OnDialogClickListener? = null

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.dialog_layout_prompt,container,false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        view.dialogConfirm.text = dialogConfirm
        view.dialogTitle.text = dialogTitle
        view.dialogConfirm.setOnClickListener(this)

        if (isCance){
            view.dialogCance.text = dialogCance
            view.dialogCance.setOnClickListener(this)
        } else {
            view.dialogCance.visibility = View.GONE
        }

        if (contentView == null){
            view.dialogContent.text = dialogContent
        } else {
            val params = view.dialogContent.layoutParams as LinearLayout.LayoutParams
            contentView!!.layoutParams = params
        }

    }

    override fun onStart() {
        super.onStart()
        val mDialog =  dialog
        mDialog?.setCancelable(false)
        mDialog?.setCanceledOnTouchOutside(false)
        mDialog?.window?.let {
            it.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
            val attri = it.attributes
            attri.width = (it.context.resources.displayMetrics.widthPixels * 0.8).toInt()
            it.attributes = attri
        }
    }


    fun showDialog(@NonNull manager: FragmentManager,contentText: String, listener: OnDialogClickListener?){
        super.show(manager, "prompt")
        this.listener = listener
        dialogContent = contentText
    }

    fun showDialog(@NonNull manager: FragmentManager,title: String, contentText: String, listener: OnDialogClickListener?){
        super.show(manager, "prompt")
        this.dialogTitle = title
        this.listener = listener
        dialogContent = contentText
    }

    /**
     * @param contentView 自定义
     */
    fun showDialog(@NonNull manager: FragmentManager,contentView: TextView, listener: OnDialogClickListener?){
        super.show(manager, "prompt")
        this.listener = listener
        this.contentView = contentView
    }

    fun showDialog(@NonNull manager: FragmentManager, @Nullable contentText: String,canceText: String, confirmText: String,listener: OnDialogClickListener?){
        super.show(manager, "prompt")
        dialogContent = contentText
        dialogCance = canceText
        dialogConfirm = confirmText
        this.listener = listener
    }

    fun showDialog(@NonNull manager: FragmentManager, @Nullable contentText: String, isCance: Boolean, listener: OnDialogClickListener?){
        super.show(manager, "prompt")
        this.isCance = isCance
        this.listener = listener
        dialogContent = contentText
    }

    override fun onClick(v: View) {
        dismiss()
        if (v.id == R.id.dialogCance){
            listener?.onCance()
        } else {
            listener?.onConfirm()
        }
    }

    interface OnDialogClickListener {
        fun onCance()
        fun onConfirm()
    }
}