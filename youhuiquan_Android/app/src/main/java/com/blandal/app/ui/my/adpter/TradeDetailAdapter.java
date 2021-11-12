package com.blandal.app.ui.my.adpter;

import android.content.Context;

import com.chad.library.adapter.base.BaseQuickAdapter;
import com.chad.library.adapter.base.viewholder.BaseViewHolder;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.List;

import com.blandal.app.R;
import com.blandal.app.ui.my.entity.TradeIList;
import com.blandal.app.util.TimeUtil;


/**
 * @author: ljx
 * @createDate: 2020/12/03  09:59
 */
public class TradeDetailAdapter extends BaseQuickAdapter<TradeIList, BaseViewHolder> {
    private Context mContext;

    public TradeDetailAdapter(@Nullable List<TradeIList> data, Context context) {
        super(R.layout.item_trade_detail, data);
        this.mContext = context;
    }

    @Override
    protected void convert(@NotNull BaseViewHolder viewHolder, TradeIList bean) {
        viewHolder.setText(R.id.tv_title, "获得积分");
        viewHolder.setText(R.id.tv_money,"+"+ bean.added);
        viewHolder.setText(R.id.tv_date, TimeUtil.stampToDate(bean.created_at));
    }
}
