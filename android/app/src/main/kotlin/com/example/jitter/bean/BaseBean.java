package com.example.jitter.bean;

import java.util.List;

/**
 * author: Warrior
 * created: 2020/9/12 18:39
 * descript:
 */
public class BaseBean<T> {

    private boolean hasNextPage;
    private List<T> list;

    public boolean isHasNextPage() {
        return hasNextPage;
    }

    public void setHasNextPage(boolean hasNextPage) {
        this.hasNextPage = hasNextPage;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }
}
