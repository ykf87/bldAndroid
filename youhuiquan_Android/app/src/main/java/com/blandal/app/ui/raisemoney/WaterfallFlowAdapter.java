package com.blandal.app.ui.raisemoney;

import android.content.Context;

import com.chad.library.adapter.base.BaseQuickAdapter;
import com.chad.library.adapter.base.viewholder.BaseViewHolder;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.List;

import com.blandal.app.R;


public class WaterfallFlowAdapter extends BaseQuickAdapter<WaterfallFlowEntity, BaseViewHolder> {
    private Context mContext;

    public WaterfallFlowAdapter(@Nullable List<WaterfallFlowEntity> data, Context context) {
        super(R.layout.item_integral_water_fall, data);
        this.mContext = context;
    }

    @Override
    protected void convert(@NotNull BaseViewHolder viewHolder, WaterfallFlowEntity entity) {
        viewHolder.setImageResource(R.id.iv_bg, entity.getResId())
                .setText(R.id.tv_job_title, entity.title)
                .setText(R.id.tv_job_cout, "已完成"+entity.times+"次")
                .setText(R.id.tv_job_total_cout, "剩余可完成"+entity.leftCout()+"次")
                .setTextColorRes(R.id.tv_content, entity.getTextColor())
                .setText(R.id.tv_content, "看视频领" + entity.prize + "枸币");

        if (entity.min == entity.max){
            viewHolder.setText(R.id.tv_job_total_cout, "再完成"+entity.leftCout()+"次即可获得奖励");
        }
    }
}

