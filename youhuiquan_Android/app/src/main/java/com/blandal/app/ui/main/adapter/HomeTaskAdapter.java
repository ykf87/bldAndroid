package com.blandal.app.ui.main.adapter;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.view.View;
import android.widget.FrameLayout;

import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdDislike;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTNativeExpressAd;
import com.chad.library.adapter.base.BaseQuickAdapter;
import com.chad.library.adapter.base.viewholder.BaseViewHolder;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.List;

import com.blandal.app.R;
import com.blandal.app.ui.main.entity.ZhaiTaskListEntity;
import com.blandal.app.util.DisplayUtil;
import com.blandal.app.util.GlideUtil;
import com.blandal.app.util.TTAdManagerHolder;
import com.blandal.app.widget.RoundImageView2;


/**
 * @author: ljx
 * @createDate: 2020/10/15  19:59
 */
public class HomeTaskAdapter extends BaseQuickAdapter<ZhaiTaskListEntity, BaseViewHolder> {
    private Context mContext;
    private boolean isShowLastLine = true;
    private TTAdNative mTTAdNative;
    private List<TTNativeExpressAd> mTTAdlist;

    public HomeTaskAdapter(@Nullable List<ZhaiTaskListEntity> data, Context context) {
        this(data, context, true);
    }

    public HomeTaskAdapter(@Nullable List<ZhaiTaskListEntity> data, Context context, boolean showLastLine) {
        super(R.layout.item_article_normal, data);
        this.mContext = context;
        this.isShowLastLine = showLastLine;
    }


    @SuppressLint({"SetTextI18n", "UseCompatLoadingForDrawables"})
    @Override
    protected void convert(@NotNull BaseViewHolder viewHolder, ZhaiTaskListEntity bean) {
        if (bean.isCsjAd){
            viewHolder.setGone(R.id.ll_container,true);
            viewHolder.setGone(R.id.fl_ad,false);
            viewHolder.setGone(R.id.ll_ad_container,false);
            loadAd(viewHolder);
            return;
        }
        viewHolder.setText(R.id.tv_title,bean.getTitle())
                .setText(R.id.tv_scan,"浏览:"+bean.getViewed());
        RoundImageView2 ivCover = viewHolder.getView(R.id.iv_cover);
        if (bean.getCover() == null){
            bean.setCover("https://media.zhishukongjian.com/schoole/shengqian.png");
        }
        GlideUtil.loadImage(mContext,bean.getCover(),ivCover);

        viewHolder.setVisible(R.id.line, true);
        viewHolder.setGone(R.id.v_bottom, true);

        //最后一条数据并且添加了Footer就为最后一条item，隐藏掉横线,增加底部圆角
        if (getData().size() == (getItemPosition(bean) + 1) && getFooterLayoutCount() == 1) {
            if (!isShowLastLine) {
                viewHolder.setGone(R.id.line, true);
                viewHolder.setVisible(R.id.v_bottom, true);
            }
        }

    }

    public void loadAd(BaseViewHolder viewHolder){
        FrameLayout flAd = viewHolder.getView(R.id.fl_ad);
        if (mTTAdNative == null) {
            mTTAdNative = TTAdManagerHolder.get().createAdNative(mContext);
        }
        AdSlot adSlot = new AdSlot.Builder()
                .setCodeId("946427175") //广告位id
                .setSupportDeepLink(true)
                .setAdCount(1) //请求广告数量为1到3条
                .setExpressViewAcceptedSize(690, 0) //必填：期望个性化模板广告view的size,单位dp
                .build();
        mTTAdNative.loadNativeExpressAd(adSlot, new TTAdNative.NativeExpressAdListener() {
            @Override
            public void onError(int i, String s) {
                DisplayUtil.outLog("穿山甲广告加载错误: " + s);
                //AdManagerUtil.addAdLogPangolin(entity, AdManagerUtil.AD_OPT_FAIL, context);
                viewHolder.setGone(R.id.fl_ad, true);
                viewHolder.setGone(R.id.ll_ad_container,true);
            }

            @Override
            public void onNativeExpressAdLoad(List<TTNativeExpressAd> list) {
                if (list != null && list.size() > 0) {
                    mTTAdlist = list;
                    DisplayUtil.outLog("穿山甲广告加载条数" + list.size());

                    bindAdListener(flAd, list.get(0));
                    bindDislike(viewHolder, flAd, list.get(0));
                }
            }
        });
    }
    private void bindAdListener(FrameLayout adContainer, final TTNativeExpressAd ad) {
        final TTNativeExpressAd adTmp = ad;
        adTmp.setExpressInteractionListener(new TTNativeExpressAd.ExpressAdInteractionListener() {
            @Override
            public void onAdClicked(View view, int type) {
//                    TToast.show(NativeExpressListActivity.this, "广告被点击");
                //AdManagerUtil.addAdLogPangolin(entity, AdManagerUtil.AD_OPT_CLICK, context);
            }

            @Override
            public void onAdShow(View view, int type) {
//                    TToast.show(NativeExpressListActivity.this, "广告展示");
                //AdManagerUtil.addAdLogPangolin(entity, AdManagerUtil.AD_OPT_SHOW, context);
            }

            @Override
            public void onRenderFail(View view, String msg, int code) {
//                    TToast.show(NativeExpressListActivity.this, msg + " code:" + code);
            }

            @Override
            public void onRenderSuccess(View view, float width, float height) {
                //返回view的宽高 单位 dp
                adContainer.removeAllViews();
                adContainer.addView(adTmp.getExpressAdView());
            }
        });
        ad.render();
    }
    private void bindDislike(BaseViewHolder helper, FrameLayout adContainer, TTNativeExpressAd ad) {
        //使用默认模板中默认dislike弹出样式
        ad.setDislikeCallback((Activity) mContext, new TTAdDislike.DislikeInteractionCallback() {

            @Override
            public void onShow() {

            }

            @Override
            public void onSelected(int position, String value, boolean b) {
                //用户选择不喜欢原因后，移除广告展示
                adContainer.removeAllViews();
                adContainer.setVisibility(View.GONE);
                mTTAdlist.clear();
            }

            @Override
            public void onCancel() {
            }

        });
    }

}
