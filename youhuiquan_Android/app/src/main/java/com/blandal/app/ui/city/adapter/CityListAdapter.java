package com.blandal.app.ui.city.adapter;

import android.content.Context;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.GridLayoutManager;

import com.chad.library.adapter.base.BaseSectionQuickAdapter;
import com.chad.library.adapter.base.viewholder.BaseViewHolder;

import org.jetbrains.annotations.NotNull;

import java.util.List;

import com.blandal.app.R;
import com.blandal.app.ui.city.entity.CitySectionEntity;

/**
 * 城市选择列表item
 *
 * @author: ljx
 * @createDate: 2020/7/6 8:58
 */

public class CityListAdapter extends BaseSectionQuickAdapter<CitySectionEntity, BaseViewHolder> {
    private Context mContext;
    public static final int SPAN_COUNT = 3;
    private List<CitySectionEntity> mData;
    private GridLayoutManager mLayoutManager;

    public CityListAdapter(Context context, List<CitySectionEntity> data) {
        super(R.layout.item_city_select_section, data);
        this.mContext = context;
        this.mData = data;
        setNormalLayout(R.layout.item_city_select);
    }

    public void setLayoutManager(GridLayoutManager manager){
        this.mLayoutManager = manager;
    }

    @Override
    protected void convertHeader(@NotNull BaseViewHolder helper, @NotNull CitySectionEntity item) {
        helper.setText(R.id.tv_section_name, item.getCityEntity().getName());
    }

    @Override
    protected void convert(@NotNull BaseViewHolder helper, @NotNull CitySectionEntity item) {
        //设置item宽高
        DisplayMetrics dm = mContext.getResources().getDisplayMetrics();
        int screenWidth = dm.widthPixels;
        //TypedValue typedValue = new TypedValue();
        //mContext.getTheme().resolveAttribute(R.dimen.dp_16, typedValue, true);
        int space = mContext.getResources().getDimensionPixelSize(R.dimen.dp_16);
        int padding = mContext.getResources().getDimensionPixelSize(R.dimen.dp_16);
        int indexBarWidth = mContext.getResources().getDimensionPixelSize(R.dimen.dp_36);
        int itemWidth = (screenWidth - padding - space * (SPAN_COUNT - 1) - indexBarWidth) / SPAN_COUNT;
        ViewGroup.LayoutParams lp = helper.getView(R.id.fl_layout).getLayoutParams();
        lp.width = itemWidth;
        lp.height = ViewGroup.LayoutParams.WRAP_CONTENT;
        helper.getView(R.id.fl_layout).setLayoutParams(lp);

        TextView tvCityName = helper.getView(R.id.tv_city_name);
        tvCityName.setText(item.getCityEntity().getName());
        if (item.getCityEntity().isSelect()) {
            tvCityName.setBackground(ContextCompat.getDrawable(getContext(), R.drawable.rect_2_stroke_primary_primary_select));
        } else {
            tvCityName.setBackground(ContextCompat.getDrawable(getContext(), R.drawable.sel_rect_2_stroke_gray_primary));
            tvCityName.setTextColor(ContextCompat.getColor(getContext(), R.color.text_title_info));
        }
    }

    /**
     * 滚动RecyclerView到索引位置
     * @param index
     */
    public void scrollToSection(String index){
        if (mData == null || mData.isEmpty()) {
            return;
        }
        if (TextUtils.isEmpty(index)) {
            return;
        }
        int size = mData.size();
        for (int i = 0; i < size; i++) {
            if (mData.get(i).isHeader() && TextUtils.equals(index.substring(0, 1), mData.get(i).getCityEntity().getName())){
                mLayoutManager.scrollToPositionWithOffset(i, 0);
                return;
            }
        }
    }
}
