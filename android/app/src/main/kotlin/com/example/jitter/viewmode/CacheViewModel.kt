package com.example.jitter.viewmode

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import com.example.jitter.util.CacheManager

/**
 * Time : 2020/9/19
 * Author : Bing
 * Description : 缓存管理
 */
class CacheViewModel(application: Application) : AndroidViewModel(application) {

    var dataManager = MutableLiveData<String>()

    fun getData() {
        dataManager.postValue(CacheManager.getTotalCacheSize(getApplication()))
    }

    fun delData() {
        CacheManager.clearAllCache(getApplication())
        dataManager.postValue(CacheManager.getTotalCacheSize(getApplication()))
    }
}