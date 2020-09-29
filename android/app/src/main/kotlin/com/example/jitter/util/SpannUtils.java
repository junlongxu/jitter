package com.example.jitter.util;

import android.graphics.LinearGradient;
import android.graphics.Shader;
import android.graphics.Typeface;
import android.text.SpannableStringBuilder;
import android.text.Spanned;
import android.text.TextPaint;
import android.text.style.AbsoluteSizeSpan;
import android.text.style.BackgroundColorSpan;
import android.text.style.CharacterStyle;
import android.text.style.ForegroundColorSpan;
import android.text.style.StyleSpan;
import android.text.style.UpdateAppearance;
import android.widget.TextView;

import androidx.annotation.ColorInt;
import androidx.annotation.NonNull;

public class SpannUtils {

    public static Builder getBuilder(@NonNull TextView textView) {
        return new Builder(textView);
    }

    public static class Builder {

        private int textColor = 0;
        private int textSize = 0;
        private int backgroundColor = 0;
        private int spannFlag = Spanned.SPAN_EXCLUSIVE_EXCLUSIVE;

        private boolean isBold = false;

        private CharSequence text;
        private TextView textView;
        private LinearGradient linearGradient;
        private SpannableStringBuilder spannBuilder;

        private Builder(@NonNull TextView textView) {
            this.textView = textView;
            this.text = textView.getText().toString();
//            this.textColor = textView.getTextColors();
            spannBuilder = new SpannableStringBuilder();
        }

        /**
         * 设置标识
         *
         * @param spannFlag <ul>
         *             <li>{@link Spanned#SPAN_INCLUSIVE_EXCLUSIVE}</li>
         *             <li>{@link Spanned#SPAN_INCLUSIVE_INCLUSIVE}</li>
         *             <li>{@link Spanned#SPAN_EXCLUSIVE_EXCLUSIVE}</li>
         *             <li>{@link Spanned#SPAN_EXCLUSIVE_INCLUSIVE}</li>
         *             </ul>
         * @return {@link Builder}
         */
        public Builder setFlag(int spannFlag) {
            this.spannFlag = spannFlag;
            return this;
        }

        public Builder setTextColor(int color){
            this.textColor = textView.getContext().getResources().getColor(color);
            return this;
        }

        public Builder setTextSize(int size){
            this.textSize = size;
            return this;
        }

        public Builder setGradient(int startColor, int endColor){
            linearGradient = new LinearGradient(0f,0f,
                    textView.getWidth(),textView.getHeight(),
                    textView.getContext().getResources().getColor(startColor),
                    textView.getContext().getResources().getColor(endColor), Shader.TileMode.CLAMP);
            return this;
        }

        /**
         * 设置背景色
         * @param color 背景色
         * @return {@link Builder}
         */
        public Builder setBackgroundColor(@ColorInt int color) {
            this.backgroundColor = color;
            return this;
        }

        /**
         * 设置粗体
         * @return {@link Builder}
         */
        public Builder setBold() {
            isBold = true;
            return this;
        }

        /**
         * 追加样式字符串
         * @param text 样式字符串文本
         * @return {@link Builder}
         */
        public Builder append(@NonNull CharSequence text) {
            setSpan();
            this.text = text;
            return this;
        }

        private void setSpan() {
            if (text == null){
                return;
            }

            int start = spannBuilder.length();
            int end = spannBuilder.append(text).length();
            if (textColor != 0){
                spannBuilder.setSpan(new ForegroundColorSpan(textColor),start,end,spannFlag);
                textColor = 0;
            }
            if (backgroundColor != 0){
                spannBuilder.setSpan(new BackgroundColorSpan(backgroundColor),start,end,spannFlag);
                backgroundColor = 0;
            }
            if (textSize != 0){
                spannBuilder.setSpan(new AbsoluteSizeSpan(textSize,true),start,end,spannFlag);
                textSize = 0;
            }
            if (isBold){
                spannBuilder.setSpan(new StyleSpan(Typeface.BOLD),start,end,spannFlag);
                isBold = false;
            }
            if (linearGradient != null){
                spannBuilder.setSpan(new LinearGradientSpan(linearGradient),start,end,spannFlag);
                linearGradient = null;
            }
            spannFlag = Spanned.SPAN_EXCLUSIVE_EXCLUSIVE;
        }

        /**
         * 创建样式字符串
         * @return 样式字符串
         */
        public void build() {
            setSpan();
            if (textView != null) {
                textView.setText(spannBuilder);
            }
        }

    }

    private static class LinearGradientSpan extends CharacterStyle implements UpdateAppearance {

        private LinearGradient linearGradient;

        public LinearGradientSpan(LinearGradient linearGradient) {
            this.linearGradient = linearGradient;
        }

        @Override
        public void updateDrawState(TextPaint tp) {
            tp.setShader(linearGradient);
        }
    }

}