package com.example.jitter.factory

import androidx.fragment.app.FragmentManager
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider

/**
 * author: Warrior
 * created: 2020/9/21 13:32
 * descript:
 */
class ViewModelFactory(private val fm: FragmentManager) : ViewModelProvider.NewInstanceFactory() {

    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        return modelClass.getConstructor(FragmentManager::class.java).newInstance(fm)
    }

}