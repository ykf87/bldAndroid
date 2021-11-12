package com.blandal.app.common;

import android.graphics.drawable.Drawable;

import java.util.List;

import com.blandal.app.entity.AdvertisementListEntity;
import com.blandal.app.entity.ListAdertisementsEntity;


/**
 * @author: ljx
 * @createDate: 2020/9/22  19:44
 */
public class GlobalAdvertisement {

    /**
     * 启动页广告
     */
    public static AdvertisementListEntity mMainLoading;

    /**
     * 首页弹窗广告
     */
    public static AdvertisementListEntity mHomeAddialog;

    /**
     * 我的页面广告
     */
    public static AdvertisementListEntity mMineAd;

    /**
     * 搜索页面广告
     */
    public static AdvertisementListEntity mSearchAd;

    /**
     * 职位详情软文广告
     */
    public static AdvertisementListEntity mSoftPaper;

    /**
     * 线上--职位流广告
     */
    public static List<AdvertisementListEntity> mOnlinePostListAd;

    /**
     * 线下--职位流广告
     */
    public static List<AdvertisementListEntity> mOfflinePostListAd;

    /**
     * 精选广告
     */
    public static ListAdertisementsEntity mSelectionAd;


    /**
     * 职位-线上
     */
    public static ListAdertisementsEntity mOnlinePostAd;


    /**
     * 职位-线下
     */
    public static ListAdertisementsEntity mOfflinePostAd;


    /**
     * 报名成功页
     */
    public static AdvertisementListEntity mApplySuccessAd;


    /**
     * 职位详情页底部广告
     */
    public static AdvertisementListEntity mJobDetailAd;

    /**
     * 广告样式5 左一大右四小 线上
     */
    public static List<AdvertisementListEntity> onePlusFourEntity;
    /**
     * 广告样式5 左一大右四小 线下
     */
    public static List<AdvertisementListEntity> onePlusFourEntityOffLine;
    /**
     * 广告样式5 左一大右四小 精选
     */
    public static List<AdvertisementListEntity> onePlusFourEntityMain;

    /**
     * 云蜻sdk-底部tab
     */
    public static AdvertisementListEntity mYDTabAd;
    public static Drawable tabIconClick;
    public static Drawable tabIconNoClick;
    public static String AdTabName;
    /**
     * 0直接展示， 1新开页面展示(跳转到webview)
     */
    public static int pageAdShowType;
    /**
     * 底部tab的样式
     */
    public static int tabAdType;


}
