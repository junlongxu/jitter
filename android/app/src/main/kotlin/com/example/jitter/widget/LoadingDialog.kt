package com.example.jitter.widget

import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.NonNull
import androidx.appcompat.widget.AppCompatTextView
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.FragmentManager
import com.airbnb.lottie.LottieAnimationView
import com.example.jitter.R

/**
 * author: Warrior
 * created: 2020/9/10 15:39
 * descript:
 */
class LoadingDialog : DialogFragment() {

    private var contentMsg = "请稍后..."
    private lateinit var animView: LottieAnimationView
    private lateinit var contentView: AppCompatTextView
    private lateinit var progressView: AppCompatTextView

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.layout_loading,container,false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        progressView = view.findViewById(R.id.progressView)
        contentView = view.findViewById(R.id.contentView)
        animView = view.findViewById(R.id.animation_view)

        contentView.text = contentMsg
    }

    override fun onStart() {
        super.onStart()
        animView.playAnimation()
        val mDialog =  dialog
        mDialog?.setCancelable(false)
        mDialog?.setCanceledOnTouchOutside(false)
        mDialog?.window?.let {
            it.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
            val attri = it.attributes
            attri.width = (it.context.resources.displayMetrics.widthPixels * 0.7).toInt()
            it.attributes = attri
        }
    }


    fun  showContent(manager: FragmentManager, tag: String?, @NonNull content: String){
        super.show(manager, tag)
        contentMsg = content
    }

    fun updateProgress(text: String){
        progressView.text = text
    }

    override fun onPause() {
        super.onPause()
        animView.pauseAnimation()
    }

    override fun onDestroy() {
        super.onDestroy()
        animView.cancelAnimation()
    }

}