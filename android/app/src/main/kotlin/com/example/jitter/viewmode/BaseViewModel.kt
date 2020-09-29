package com.example.jitter.viewmode

import androidx.fragment.app.FragmentManager
import androidx.lifecycle.ViewModel
import com.example.jitter.util.Utils
import com.example.jitter.widget.LoadingDialog

/**
 * author: Warrior
 * created: 2020/9/21 13:43
 * descript:
 */
open class BaseViewModel(private val fm: FragmentManager) : ViewModel(){

    private val loadingView by lazy(mode = LazyThreadSafetyMode.SYNCHRONIZED) {
        LoadingDialog()
    }

    protected fun showLoading(content: String = "请稍后...") {
        if (!loadingView.isAdded) {
            loadingView.showContent(fm, "loading", content)
        }
    }

    protected fun hidLoading() {
        if (loadingView.isAdded) {
            loadingView.dismiss()
        }
    }

    protected fun showToast(content: String){
        Utils.showToast(content)
    }

}