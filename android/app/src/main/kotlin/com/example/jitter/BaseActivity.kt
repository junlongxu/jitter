package com.example.jitter

import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.AppCompatImageView
import androidx.appcompat.widget.AppCompatTextView
import androidx.constraintlayout.widget.ConstraintLayout
import com.example.jitter.bean.GlobalConstant
import com.example.jitter.widget.LoadingDialog

/**
 * author: Warrior
 * created: 2020/9/10 17:38
 * descript:
 */
abstract class BaseActivity : AppCompatActivity(), GlobalConstant {

    private lateinit var toolbarView: ConstraintLayout
    private lateinit var backView: AppCompatImageView
    private lateinit var titleView: AppCompatTextView
    private lateinit var settingView: AppCompatTextView

    private val contentLayout by lazy {
        LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setBackgroundColor(Color.parseColor("#242a37"))
        }
    }

    private val loadView by lazy {
        LoadingDialog()
    }

    protected abstract fun getBarTitle(): String

    protected abstract fun getLayoutResId(): Int

    protected abstract fun initView()

    protected abstract fun initData()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val option: Int = View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
        window.decorView.systemUiVisibility = option
        window.statusBarColor = Color.TRANSPARENT

        initContentView()
        initTitleBar()
        setContentView(getLayoutResId())
        initView()
        initData()
        setBarTitle(getBarTitle())
    }

    private fun initContentView() {
        findViewById<ViewGroup>(android.R.id.content).apply {
            removeAllViews()
            addView(contentLayout)
        }

        LayoutInflater.from(this).inflate(R.layout.layout_base_toolbar, contentLayout, true)
//        //获取状态栏资源Id
//        val resId = resources.getIdentifier("status_bar_height","dimen","android")
        //通过资源id获取高度
//        contentLayout.setPadding(0,resources.getDimensionPixelSize(resId),0,0)
    }

    private fun initTitleBar() {
        backView = findViewById(R.id.toolbar_back)
        titleView = findViewById(R.id.toolbar_title)
        settingView = findViewById(R.id.toolbar_setting)
        toolbarView = findViewById(R.id.toolbar_layout)

        backView.setOnClickListener {
            finish()
        }
    }

    override fun setContentView(layoutResID: Int) {
        LayoutInflater.from(this).inflate(layoutResID, contentLayout, true)
    }

    override fun setContentView(view: View?) {
        contentLayout.addView(view)
    }

    fun setBarTitle(title: String) {
        titleView.text = title
    }

    protected fun startActivity(clas: Class<*>){
        val intent = Intent(this,clas)
        startActivity(intent)
    }

    protected fun showToast(content: String){
        Toast.makeText(this, content, Toast.LENGTH_LONG).show()
    }

    protected fun showLoading(content: String = "请稍后...") {
        loadView.showContent(supportFragmentManager, "loading", content)
    }

    protected fun updateProgress(@NonNull content: String) {
        loadView.updateProgress(content)
    }

    protected fun hidLoading() {
        if (loadView.isAdded) {
            loadView.dismiss()
        }
    }

    protected fun hidToolBar() {
        toolbarView.visibility = View.GONE
    }

    override fun onDestroy() {
        super.onDestroy()
        hidLoading()
    }

}