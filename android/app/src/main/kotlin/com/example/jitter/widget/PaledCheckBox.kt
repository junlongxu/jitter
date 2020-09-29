package com.example.jitter.widget

import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.LinearGradient
import android.graphics.Shader
import android.util.AttributeSet
import androidx.appcompat.widget.AppCompatCheckBox

/**
 * author: Warrior
 * created: 2020/9/6 12:03
 * descript:
 */
class PaledCheckBox : AppCompatCheckBox {

    constructor(context: Context) : super(context)
    constructor(context: Context, attrs: AttributeSet?) : super(context, attrs)
    constructor(context: Context, attrs: AttributeSet?, defStyleAttr: Int) : super(context, attrs, defStyleAttr)

    override fun onDraw(canvas: Canvas?) {
        super.onDraw(canvas)
        paint.shader = LinearGradient(0f,0f,
            paint.textSize * text.length, 0f,
            Color.parseColor("#f54b64"),
            Color.parseColor("#f78361"),
            Shader.TileMode.CLAMP)
    }
}