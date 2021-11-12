package com.jiankang.gouqi.ui.main.adapter;

import android.app.Activity;
import android.view.View;

import com.chad.library.adapter.base.BaseQuickAdapter;
import com.chad.library.adapter.base.viewholder.BaseViewHolder;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.List;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.common.enums.OpenAdvertisementEnum;
import com.jiankang.gouqi.entity.AdEntity;
import com.jiankang.gouqi.util.GlideUtil;
import com.jiankang.gouqi.widget.RoundImageView2;


/**
 * @author: ljx
 * @createDate: 2021/4/1  16:40
 */
public class MyBannerAdapter extends BaseQuickAdapter<AdEntity, BaseViewHolder> {

    private Activity activity;

    public MyBannerAdapter(@Nullable List<AdEntity> data, Activity activity) {
        super(R.layout.item_my_banner, data);
        this.activity = activity;
    }

    @Override
    protected void convert(@NotNull BaseViewHolder viewHolder, AdEntity entity) {
        OpenAdvertisementEnum adEnum = OpenAdvertisementEnum
                .valueOf(entity.ad_type);
        RoundImageView2 imageView = viewHolder.getView(R.id.iv_ad);
        GlideUtil.loadImage(entity.img_url, imageView);
        imageView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
            }
        });
    }
}
