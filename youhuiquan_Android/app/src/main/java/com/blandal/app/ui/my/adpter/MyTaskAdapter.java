package com.blandal.app.ui.my.adpter;

import android.content.Context;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.style.AbsoluteSizeSpan;
import android.text.style.ForegroundColorSpan;

import androidx.core.content.ContextCompat;

import com.chad.library.adapter.base.BaseMultiItemQuickAdapter;
import com.chad.library.adapter.base.viewholder.BaseViewHolder;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.List;

import com.blandal.app.R;
import com.blandal.app.ui.my.entity.ApplyTaskListBean;
import com.blandal.app.util.TimeUtil;
import com.blandal.app.widget.TimeTextView;

import static com.blandal.app.ui.my.entity.MyZhaiTaskEntiy.TASK_TYPE_1;
import static com.blandal.app.ui.my.entity.MyZhaiTaskEntiy.TASK_TYPE_2;
import static com.blandal.app.ui.my.entity.MyZhaiTaskEntiy.TASK_TYPE_3;
import static com.blandal.app.ui.my.entity.MyZhaiTaskEntiy.TASK_TYPE_4;
import static com.blandal.app.ui.my.entity.MyZhaiTaskEntiy.TASK_TYPE_5;
import static com.blandal.app.ui.my.entity.MyZhaiTaskEntiy.TASK_TYPE_6;


/**
 * @author: ljx
 * @createDate: 2020/10/15  19:59
 */
public class MyTaskAdapter extends BaseMultiItemQuickAdapter<ApplyTaskListBean, BaseViewHolder> {
    private Context mContext;
    private TimesUpListener mTimeUpListener;
    public MyTaskAdapter(@Nullable List<ApplyTaskListBean> data, Context context) {
        super(data);
        this.mContext = context;
        addItemType(TASK_TYPE_1, R.layout.item_my_task_type_1);//待提交
        addItemType(TASK_TYPE_2, R.layout.item_my_task_type_2);//审核中
        addItemType(TASK_TYPE_3, R.layout.item_my_task_type_3);//已失效
        addItemType(TASK_TYPE_4, R.layout.item_my_task_type_4);//已完成
        addItemType(TASK_TYPE_5, R.layout.item_my_task_type_5);//被拒绝
        addItemType(TASK_TYPE_6, R.layout.item_my_task_type_6);//放弃任务
    }

    public interface TimesUpListener {
        void onTimeUp(ApplyTaskListBean bean);
    }

    public void setTimesUpListener(TimesUpListener timeUpListener) {
        this.mTimeUpListener = timeUpListener;
    }

    TimeTextView.OnTimesUpListener timesUpListener =  new TimeTextView.OnTimesUpListener() {
        @Override
        public void onTimeUp(ApplyTaskListBean bean) {
            mTimeUpListener.onTimeUp(bean);
        }
    };
    @Override
    protected void convert(@NotNull BaseViewHolder baseViewHolder, ApplyTaskListBean bean) {
        SpannableString spannableString = new SpannableString("¥"+TimeUtil.taskFee(bean.getZhai_task().getTask_fee()));
        ForegroundColorSpan colorSpan = new ForegroundColorSpan(ContextCompat.getColor(mContext, R.color.color_black_333333));
        spannableString.setSpan(new AbsoluteSizeSpan(12, true), 0, 1, Spanned.SPAN_INCLUSIVE_INCLUSIVE);
        spannableString.setSpan(new AbsoluteSizeSpan(18, true), 1, spannableString.length(), Spanned.SPAN_INCLUSIVE_INCLUSIVE);
        switch (baseViewHolder.getItemViewType()) {
            case TASK_TYPE_1:
            case TASK_TYPE_2:
                baseViewHolder.setText(R.id.tv_task_title, bean.getZhai_task().getTask_title());
                if (bean.getStu_submit_dead_time()== 0) {
                    baseViewHolder.setVisible(R.id.ll_time_container, false);
                }
                baseViewHolder.setText(R.id.tv_task_fee, spannableString);
                TimeTextView tvTime = baseViewHolder.getView(R.id.tv_time);
                tvTime.setTimes(bean);
                tvTime.setTimesUpListener(timesUpListener);
                break;
            case TASK_TYPE_3:
                baseViewHolder.setText(R.id.tv_task_fee, spannableString);
                baseViewHolder.setText(R.id.tv_task_title, bean.getZhai_task().getTask_title());
                if (bean.getShow_reapply_btn() == 0) {
                    baseViewHolder.setGone(R.id.tv_recommit, true);
                } else {
                    baseViewHolder.setGone(R.id.tv_recommit, false);
                }
                break;
            case TASK_TYPE_4:
                baseViewHolder.setText(R.id.tv_task_fee, spannableString);
                baseViewHolder.setText(R.id.tv_task_title, bean.getZhai_task().getTask_title());
                break;
            case TASK_TYPE_5:
                baseViewHolder.setText(R.id.tv_task_fee, spannableString);
                baseViewHolder.setText(R.id.tv_task_title, bean.getZhai_task().getTask_title());
                if (bean.getZhai_task().getTask_close_time() != 0) {
                    baseViewHolder.setText(R.id.tv_refuse_describe, "如有疑问请在" + TimeUtil.stampToDate(bean.getZhai_task().getTask_close_time()+1000*60*60*24*3) + "前进行申诉");
                }
                if (bean.getShow_complain_btn() == 0) {
                    baseViewHolder.setGone(R.id.tv_appeal, true);
                } else {
                    baseViewHolder.setGone(R.id.tv_appeal, false);
                }
                break;
            case TASK_TYPE_6:
                baseViewHolder.setText(R.id.tv_task_title, bean.getZhai_task().getTask_title());
                baseViewHolder.setText(R.id.tv_task_fee, spannableString);
                break;
            default:
                break;
        }
    }

}
