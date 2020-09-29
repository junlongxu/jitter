package com.example.jitter.util;

import android.app.Activity;
import android.content.Context;
import android.content.res.AssetManager;
import android.graphics.Color;
import android.util.Log;
import android.view.View;

import com.bigkoo.pickerview.builder.OptionsPickerBuilder;
import com.bigkoo.pickerview.listener.OnOptionsSelectListener;
import com.bigkoo.pickerview.view.OptionsPickerView;
import com.example.jitter.R;
import com.example.jitter.bean.ZoneJsonBean;
import com.example.jitter.my.PersonalInfoActivity;
import com.google.gson.Gson;

import org.json.JSONArray;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

/**
 * Time : 2020/9/14
 * Author : Bing
 * Description : 地区选择器
 */
public class SelectZoneUtils {
    private static final String TAG = "SelectZoneUtils";

    private List<ZoneJsonBean>                      options1Items = new ArrayList<>();
    private ArrayList<ArrayList<String>>            options2Items = new ArrayList<>();
    private ArrayList<ArrayList<ArrayList<String>>> options3Items = new ArrayList<>();

    // 弹出选择器
    public void showPickerView(Activity context) {
        OptionsPickerView pvOptions = new OptionsPickerBuilder(context, new OnOptionsSelectListener() {
            @Override
            public void onOptionsSelect(int options1, int options2, int options3, View v) {
                //返回的分别是三个级别的选中位置
                String opt1tx = options1Items.size() > 0 ?
                        options1Items.get(options1).getPickerViewText() : "";

                String opt2tx = options2Items.size() > 0
                        && options2Items.get(options1).size() > 0 ?
                        options2Items.get(options1).get(options2) : "";

                String opt3tx = options2Items.size() > 0
                        && options3Items.get(options1).size() > 0
                        && options3Items.get(options1).get(options2).size() > 0 ?
                        options3Items.get(options1).get(options2).get(options3) : "";

                String tx = opt1tx + opt2tx;
                Log.e(TAG, "onOptionsSelect: " + tx);
                // 数据回传给activity
                ((PersonalInfoActivity) context).getZoneData(tx);
            }
        })
                .setDividerColor(context.getResources().getColor(R.color.color_dfdfdf))
                .setTextColorCenter(Color.BLACK) //设置选中项文字颜色
                .setContentTextSize(20)
                .setCancelText("取消")
                .setSubmitText("确定")
                .setCancelColor(context.getResources().getColor(R.color.color_f54b64))
                .setSubmitColor(context.getResources().getColor(R.color.color_f54b64))
                .build();

        //pvOptions.setPicker(options1Items);//一级选择器
        pvOptions.setPicker(options1Items, options2Items);//二级选择器
        //pvOptions.setPicker(options1Items, options2Items, options3Items);//三级选择器
        pvOptions.show();
    }

    // 初始化省市数据
    public void initJsonData(Context context) {
        String                  JsonData     = getJson(context, "province.json");//获取assets目录下的json文件数据
        ArrayList<ZoneJsonBean> zoneJsonBean = parseData(JsonData);//用Gson 转成实体
        options1Items = zoneJsonBean;

        for (int i = 0; i < zoneJsonBean.size(); i++) {//遍历省份
            ArrayList<String>            cityList          = new ArrayList<>();//该省的城市列表（第二级）
            ArrayList<ArrayList<String>> province_AreaList = new ArrayList<>();//该省的所有地区列表（第三极）

            for (int c = 0; c < zoneJsonBean.get(i).getCityList().size(); c++) {//遍历该省份的所有城市
                String cityName = zoneJsonBean.get(i).getCityList().get(c).getName();
                cityList.add(cityName);//添加城市
                //该城市的所有地区列表
                ArrayList<String> city_AreaList = new ArrayList<>(zoneJsonBean.get(i).getCityList().get(c).getArea());
                province_AreaList.add(city_AreaList);//添加该省所有地区数据
            }
            options2Items.add(cityList);
            options3Items.add(province_AreaList);
        }
    }

    private ArrayList<ZoneJsonBean> parseData(String result) {//Gson 解析
        ArrayList<ZoneJsonBean> detail = new ArrayList<>();
        try {
            JSONArray data = new JSONArray(result);
            Gson      gson = new Gson();
            for (int i = 0; i < data.length(); i++) {
                ZoneJsonBean entity = gson.fromJson(data.optJSONObject(i).toString(), ZoneJsonBean.class);
                detail.add(entity);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return detail;
    }

    private String getJson(Context context, String fileName) {
        StringBuilder stringBuilder = new StringBuilder();
        try {
            AssetManager assetManager = context.getAssets();
            BufferedReader bf = new BufferedReader(new InputStreamReader(
                    assetManager.open(fileName)));
            String line;
            while ((line = bf.readLine()) != null) {
                stringBuilder.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return stringBuilder.toString();
    }
}
