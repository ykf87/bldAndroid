package com.jiankang.gouqi.ui.main.adapter;

import android.content.Context;
import android.widget.ImageView;

import com.chad.library.adapter.base.BaseQuickAdapter;
import com.chad.library.adapter.base.viewholder.BaseViewHolder;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.List;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.entity.AdEntity;
import com.jiankang.gouqi.util.GlideUtil;


/**
 * @author: ljx
 * @createDate: 2020/10/15  19:59
 */
public class AdSpecialAdapter extends BaseQuickAdapter<AdEntity, BaseViewHolder> {
    private Context mContext;
    public AdSpecialAdapter(@Nullable List<AdEntity> data, Context context) {
        super(R.layout.item_grid_view_special, data);
        this.mContext = context;
    }

    @Override
    protected void convert(@NotNull BaseViewHolder baseViewHolder, AdEntity data) {
        ImageView imageView = baseViewHolder.getView(R.id.iv_special);
        GlideUtil.loadCircleImage(mContext,data.img_url,imageView);
        baseViewHolder.setText(R.id.tv_special_name,data.ad_name);
    }
}
