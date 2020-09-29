package com.example.jitter.widget

import android.content.Context
import android.graphics.Color
import android.graphics.LinearGradient
import android.graphics.Shader
import android.util.AttributeSet
import androidx.appcompat.widget.AppCompatTextView

/**
 * author: Warrior
 * created: 2020/9/9 12:38
 * descript:
 */
class GradientTextView : AppCompatTextView {

    constructor(context: Context) : super(context)
    constructor(context: Context, attrs: AttributeSet?) : super(context, attrs)
    constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr)

    override fun onLayout(changed: Boolean, left: Int, top: Int, right: Int, bottom: Int) {
        super.onLayout(changed, left, top, right, bottom)
        if (changed){
            paint.shader = LinearGradient(0f,0f,
                    paint.textSize * text.length, 0f,
                    Color.parseColor("#F54B64"),
                    Color.parseColor("#f78361"),
                    Shader.TileMode.CLAMP)
        }
    }

}