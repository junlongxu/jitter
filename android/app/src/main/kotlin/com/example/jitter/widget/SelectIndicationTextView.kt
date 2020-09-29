package com.example.jitter.widget

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.widget.LinearLayout
import com.example.jitter.R

/**
 * author: Warrior
 * created: 2020/9/7 20:47
 * descript:
 */
class SelectIndicationTextView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : LinearLayout(context, attrs, defStyleAttr) {

    private val view_ssi by lazy {
        findViewById<ScrollerSelectIndication>(R.id.view_ssi)
    }

    init {
        initView(context)
    }

    private fun initView(context: Context) {
        LayoutInflater.from(context).inflate(R.layout.layout_select_indication, this)
    }

    fun setOnPageSelectListenter(listener: ScrollerSelectIndication.OnScrollerListener) {
        view_ssi.onPageSelectListener = listener
    }
}