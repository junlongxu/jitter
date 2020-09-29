package com.example.jitter.widget;

import android.app.Dialog;
import android.content.Context;
import android.text.Spanned;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.jitter.R;
import com.example.jitter.bean.GlobalConstant;
import com.example.jitter.my.adapter.OnLeftClick;
import com.example.jitter.my.adapter.OnRightClick;

/**
 * Time:2020/9/11
 * Author:Bing
 * Description : 弹出式对话框
 */
public class MyDialog implements View.OnClickListener, GlobalConstant {

    private OnLeftClick  onLeftClick;
    private OnRightClick onRightClick;
    private Dialog       dialog;
    private TextView     tvTitle;
    private TextView     tvContent;
    private TextView     tvLeft;
    private TextView     tvRight;

    private String strTitle;
    private String strContent;
    private String strLeft;
    private String strRight;

    public MyDialog(Context mContext) {
        int mWindowWidth, mWindowHeight;
        dialog = new Dialog(mContext, R.style.MyDialog);
        dialog.setCancelable(false);
        View           view           = LayoutInflater.from(mContext).inflate(R.layout.layout_dialog, null, false);
        DisplayMetrics displayMetrics = mContext.getResources().getDisplayMetrics();
        mWindowWidth = displayMetrics.widthPixels;
        mWindowHeight = displayMetrics.heightPixels;
        dialog.setContentView(view, new ViewGroup.MarginLayoutParams(mWindowWidth,
                ViewGroup.MarginLayoutParams.MATCH_PARENT));

        tvTitle = view.findViewById(R.id.mydialog_title);
        tvContent = view.findViewById(R.id.mydialog_content);
        tvLeft = view.findViewById(R.id.mydialog_left);
        tvRight = view.findViewById(R.id.mydialog_right);

        tvLeft.setTag(BUTTON_LEFT);
        tvRight.setTag(BUTTON_RIGHT);
    }

    @Override
    public void onClick(View v) {
        switch ((String) v.getTag()) {
            case BUTTON_LEFT:
                if (onLeftClick != null) {
                    onLeftClick.onclick();
                }
                dialog.dismiss();
                break;
            case BUTTON_RIGHT:
                if (onRightClick != null) {
                    onRightClick.onclick();
                }
                dialog.dismiss();
                break;
            default:
                break;
        }
    }

    public void setOnLeftClick(OnLeftClick onLeftClick) {
        this.onLeftClick = onLeftClick;
    }

    public void setOnRightClick(OnRightClick onRightClick) {
        this.onRightClick = onRightClick;
    }

    public void setStrTitle(String strTitle) {
        this.strTitle = strTitle;
        tvTitle.setVisibility(View.VISIBLE);
    }

    public void setStrContent(String strContent) {
        this.strContent = strContent;
    }

    // 设置对话框内容，html格式字体颜色
    public void setSpaned(Spanned spaned){
        tvContent.setText(spaned);
    }

    public void setStrLeft(String strLeft) {
        this.strLeft = strLeft;
    }

    public void setStrRight(String strRight) {
        this.strRight = strRight;
    }

    public void showDia() {
        dialog.show();
        if (!TextUtils.isEmpty(strTitle)) {
            tvTitle.setText(strTitle);
        }
        if (!TextUtils.isEmpty(strContent)) {
            tvContent.setText(strContent);
        }
        if (!TextUtils.isEmpty(strLeft)) {
            tvLeft.setText(strLeft);
        }
        if (!TextUtils.isEmpty(strRight)) {
            tvRight.setText(strRight);
        }
        tvRight.setOnClickListener(this);
        tvLeft.setOnClickListener(this);
    }
}
