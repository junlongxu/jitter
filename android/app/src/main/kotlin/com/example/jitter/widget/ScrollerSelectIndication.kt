package com.example.jitter.widget

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Color
import android.graphics.LinearGradient
import android.graphics.Shader
import android.util.AttributeSet
import android.view.MotionEvent
import android.widget.HorizontalScrollView
import android.widget.LinearLayout
import android.widget.Space
import androidx.appcompat.widget.AppCompatTextView

/**
 * author: Warrior
 * created: 2020/9/7 20:50
 * descript:
 */
class ScrollerSelectIndication @JvmOverloads constructor(
    context: Context?,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : HorizontalScrollView(context, attrs, defStyleAttr){

    var count = 0 //记录当前Tab的个数
    var tabWidth = 0 //当前Tab的宽度
    var tabSelectPoint = 0 //当前Tab的命中点位置

    var selectPoint = mutableListOf<Int>() //记录每个Tab命中的点
    var selectTextView = mutableListOf<AppCompatTextView>() //记录每个TextView

    var leftSpace = 0 //当前文本最左边的距离
    var rightSpace = 0 //当前文本最右边的距离
    var currentX = -9999 //记录当前滚动的距离
    var scrollType = ScrollType.IDLE //当前滚动状态

    var currentSelected = 0 //当前命中位置，从0开始
    var onPageSelectListener: OnScrollerListener? = null

    override fun fling(velocityX: Int) {
        super.fling(velocityX / 5)
    }

    override fun onSizeChanged(w: Int, h: Int, oldw: Int, oldh: Int) {
        super.onSizeChanged(w, h, oldw, oldh)
        selectPoint.clear() //避免缓存多次利用
        tabSelectPoint = measuredWidth / 2 //命中的落点是在控件的中间

        var layout = getChildAt(0) as LinearLayout

        for (i in 0 until layout.childCount) {
            var text = layout.getChildAt(i)

            if (text is AppCompatTextView) {
                var textWidth = text.layoutParams.width
                tabWidth = textWidth
                selectPoint.add(leftSpace + textWidth / 2 + count++ * textWidth) //记录每个Tab命中的点
                selectTextView.add(text) //记录每个TextView
            } else if (text is Space) {
                if (leftSpace == 0) leftSpace = text.layoutParams.width //第一个肯定是左边的Space
                else if (rightSpace == 0) rightSpace = leftSpace + count * tabWidth //第二个自然是右边的Space
            }
        }

        for (i in 0 until selectTextView.size) {
            selectTextView[i].setOnClickListener {
                smoothScrollToPosition(selectPoint[i] - tabSelectPoint, i)
            }
        }

        postDelayed({
            scrollToPosition(selectPoint[currentSelected] - tabSelectPoint, currentSelected)
        }, 20)
    }

    @SuppressLint("LongLogTag")
    override fun onTouchEvent(ev: MotionEvent?): Boolean {
        when (ev?.action) {
            MotionEvent.ACTION_MOVE -> {
                scrollType = ScrollType.TOUCH_SCROLL
                handler.removeCallbacks(scrollRunnable)
            }
            MotionEvent.ACTION_UP -> {
                handler.post(scrollRunnable)
            }
            MotionEvent.ACTION_DOWN -> {
            }
        }
        return super.onTouchEvent(ev)
    }

    @SuppressLint("LongLogTag")
    var scrollRunnable: Runnable = object : Runnable {
        override fun run() {
            if (scrollX == currentX) {
                scrollType = ScrollType.IDLE
                for (i in 0 until selectPoint.size) {
                    val selectPointWidth = selectPoint[i]
                    // 计算当前点和命中点的距离，如果在某个Tab的一半距离内，那么就自动命中那个Tab
                    if (kotlin.math.abs(scrollX + tabSelectPoint - selectPointWidth) <= tabWidth / 2) {
                        smoothScrollToPosition(selectPoint[i] - tabSelectPoint, i)
                        break
                    } else if (scrollX + tabSelectPoint <= leftSpace) { //左边界计算
                        smoothScrollToPosition(selectPoint[0] - tabSelectPoint, 0)
                        break
                    } else if (scrollX + tabSelectPoint >= rightSpace) { //右边界计算
                        smoothScrollToPosition(selectPoint[count - 1] - tabSelectPoint, count - 1)
                        break
                    }
                }
                handler.removeCallbacks(this)
                return
            } else {
                scrollType = ScrollType.FLING
            }
            currentX = scrollX
            handler.postDelayed(this, 50)
        }
    }

    private fun scrollToPosition(scrollX: Int, currentSelected: Int) {
        this.currentSelected = currentSelected
        scrollTo(scrollX, 0)
        updateTextView(currentSelected)
        onPageSelectListener?.onPageSelect(currentSelected)
    }

    private fun smoothScrollToPosition(scrollX: Int, currentSelected: Int) {
        this.currentSelected = currentSelected
        smoothScrollTo(scrollX, 0)
        updateTextView(currentSelected)
        onPageSelectListener?.onPageSelect(currentSelected)
    }

    private fun updateTextView(currentSelected: Int) {
        for (i in 0 until selectTextView.size) {
            var textView = selectTextView[i]
            if (currentSelected == i) {
                textView.alpha = 1.0f
                setTextViewStyles(textView)
            } else {
                textView.alpha = 0.4f
                textView.paint.shader = null
                textView.setTextColor(Color.parseColor("#FFFFFF"))
                textView.invalidate()
            }
        }
    }

    private fun setTextViewStyles(textView: AppCompatTextView) {
        val mLinearGradient = LinearGradient(0f, 0f,
                textView.paint.textSize * textView.text.length, 0f,
                Color.parseColor("#f54b64"),
                Color.parseColor("#f78361"),
                Shader.TileMode.CLAMP)
        textView.paint.shader = mLinearGradient;
        textView.invalidate()
    }

        interface OnScrollerListener {
        fun onPageSelect(position: Int)
    }

    enum class ScrollType {
        IDLE, TOUCH_SCROLL, FLING
    }

}