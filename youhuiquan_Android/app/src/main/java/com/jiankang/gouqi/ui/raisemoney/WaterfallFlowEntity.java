package com.jiankang.gouqi.ui.raisemoney;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.entity.BaseEntity;

/**
 * @author: ljx
 * @createDate: 2021/8/23  9:32
 */
public class WaterfallFlowEntity extends BaseEntity {
//    {
//        "id": 1,
//            "title": "新手福利",
//            "max": 20,
//            "min": 1,
//            "prize": 1,
//            "times": 3
//    }


    public int id;
    public String title;
    public int max;//一天最多可以看几次
    public int min;// 为1时表示每一次都有奖励，min为max时表示要全部完成一次性奖励
    public int prize;//枸币奖励
    public int times;//表示当前做了多少次任务
    public String videoId;
    public int resType;
    public int platform;//1:穿山甲 2：优量汇

    public int leftCout() {
        return max - times;
    }


    public int getResId() {
        if (resType == 0) {
            return R.drawable.integral_bg_waterfall_flow_1;
        }
        if (resType == 1) {
            return R.drawable.integral_bg_waterfall_flow_2;
        }
        if (resType == 2) {
            return R.drawable.integral_bg_waterfall_flow_3;
        }
        if (resType == 3) {
            return R.drawable.integral_bg_waterfall_flow_4;
        }
        return R.drawable.integral_bg_waterfall_flow_1;
    }

    public int getTextColor() {
        if (resType == 0) {
            return R.color.color_water_blue;
        }
        if (resType == 1) {
            return R.color.color_water_red;
        }
        if (resType == 2) {
            return R.color.color_water_yellow;
        }
        if (resType == 3) {
            return R.color.color_water_green;
        }
        return R.color.color_water_blue;
    }
}
