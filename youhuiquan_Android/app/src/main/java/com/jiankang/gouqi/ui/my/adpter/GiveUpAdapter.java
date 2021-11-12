package com.jiankang.gouqi.ui.my.adpter;

import android.content.Context;
import android.widget.CheckBox;

import com.chad.library.adapter.base.BaseQuickAdapter;
import com.chad.library.adapter.base.viewholder.BaseViewHolder;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.List;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.ui.my.entity.GiveUpCommonMsg;


/**
 * @author: ljx
 * @createDate: 2020/10/15  19:59
 */
public class GiveUpAdapter extends BaseQuickAdapter<GiveUpCommonMsg.AbandonCommonMsg, BaseViewHolder> {
    private Context mContext;

    public GiveUpAdapter(@Nullable List<GiveUpCommonMsg.AbandonCommonMsg> data, Context context) {
        super(R.layout.item_give_up, data);
        this.mContext = context;
    }

    @Override
    protected void convert(@NotNull BaseViewHolder viewHolder, GiveUpCommonMsg.AbandonCommonMsg bean) {
        CheckBox checkBox = viewHolder.getView(R.id.checkbox);
        viewHolder.setText(R.id.checkbox, bean.content);
        checkBox.setChecked(bean.isCheck);
        if (bean.isCheck) {
            viewHolder.setVisible(R.id.iv_check, true);
        } else {
            viewHolder.setVisible(R.id.iv_check, false);
        }
    }
}
