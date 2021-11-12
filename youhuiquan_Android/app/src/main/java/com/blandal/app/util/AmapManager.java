package com.blandal.app.util;

import android.content.Context;
import android.util.Log;

import com.amap.api.location.AMapLocation;
import com.amap.api.location.AMapLocationClient;
import com.amap.api.location.AMapLocationClientOption;
import com.amap.api.location.AMapLocationListener;

/**
 * 高德地图相关工具类
 *
 * @author: ljx
 * @createDate: 2020/6/17 11:45
 */

public class AmapManager {
    /**
     * 内容 ：
     * 获取对象
     * 定位数据回调接口
     * poi回调接口
     * 开启定位
     * 在地图上画一条线
     * 在地图上画一个圆
     * 坐标转地址
     * 地址转坐标
     * 销毁对象
     */
    private String TAG = getClass().getSimpleName();


    /**
     * 单例模式获取对象，请务必在onDestory()方法中销毁对象。
     */
    private static AmapManager mAmapManager;
    /**
     * 定位
     */
    private AMapLocationClient mLocationClient = null;
    /**
     * 定位参数
     */
    private AMapLocationClientOption mLocationOption = null;
    /**
     * 是否处于定位中
     */
    private boolean mIsLocation = false;

    public static AmapManager getInstance() {
        if (mAmapManager == null) {
            synchronized (AmapManager.class) {
                if (mAmapManager == null) {
                    mAmapManager = new AmapManager();
                }
            }
        }
        return mAmapManager;
    }

    /**
     * 定位数据回调接口
     */
    public interface OnLocationListener {
        void onLocationSuccessListener(AMapLocation location);

        void onLocationErrorListener(AMapLocation location);
    }


    /**
     * 开启定位
     *
     * @param locationClient
     * @param locationOption 定位参数 可以为null
     * @param isOneLocate     是否一次定位 true：是    false : 否
     * @param interval        连续定位时时间间隔（isOneLocate = false ）
     * @param listener        定位信息的回调
     */
    public void startLocate(Context context, AMapLocationClient locationClient, AMapLocationClientOption locationOption, boolean isOneLocate, long interval, final OnLocationListener listener) {
        // 定位中
        mIsLocation = true;
        if (locationClient == null) {
            if (mLocationClient == null) {
                mLocationClient = new AMapLocationClient(context);
            }
        } else {
            mLocationClient = locationClient;
        }
        if (locationOption == null) {
            //设置定位参数AMapLocationClientOption对象
            if (mLocationOption == null) {
                mLocationOption = new AMapLocationClientOption();
                //设置定位模式为AMapLocationMode.Hight_Accuracy，高精度模式。AMapLocationMode.Battery_Saving，低功耗模式  。AMapLocationMode.Device_Sensors，仅设备模式。
                mLocationOption.setLocationMode(AMapLocationClientOption.AMapLocationMode.Hight_Accuracy);
                //获取一次定位结果：
                mLocationOption.setOnceLocation(isOneLocate);
                if (!isOneLocate) {
                    //设置定位间隔,单位毫秒,默认为2000ms，最低1000ms。
                    mLocationOption.setInterval(interval);
                }
                //设置是否返回地址信息（默认返回地址信息）
                mLocationOption.setNeedAddress(true);
                // 设置是否开启缓存
                mLocationOption.setLocationCacheEnable(true);
                // 设置是否等待设备wifi刷新，如果设置为true,会自动变为单次定位，持续定位时不要使用
                mLocationOption.setOnceLocationLatest(false);
                //单位是毫秒，默认30000毫秒，建议超时时间不要低于8000毫秒。
                mLocationOption.setHttpTimeOut(12000);
            }
        }
        //给定位客户端对象设置定位参数
        mLocationClient.setLocationOption(mLocationOption);
        //设置定位回调监听
        mLocationClient.setLocationListener(new AMapLocationListener() {
            @Override
            public void onLocationChanged(AMapLocation aMapLocation) {
                if (aMapLocation != null && aMapLocation.getErrorCode() == 0) {
                    //可在其中解析amapLocation获取相应内容。
                    listener.onLocationSuccessListener(aMapLocation);
                    Log.d("110", "定位结果：" + aMapLocation.getLatitude() + "," + aMapLocation.getLongitude());
                } else {
                    listener.onLocationErrorListener(aMapLocation);
                    //定位失败时，可通过ErrCode（错误码）信息来确定失败的原因，errInfo是错误信息，详见错误码表。
                    Log.e("AmapError", "location Error, ErrCode:"
                            + aMapLocation.getErrorCode() + ", errInfo:"
                            + aMapLocation.getErrorInfo());
                }
            }
        });
        mLocationClient.startLocation();
    }

    public void startLocate(Context context, boolean isOneLocate, long interval, final OnLocationListener listener) {
        // 定位中
        mIsLocation = true;
        if (mLocationClient == null) {
            mLocationClient = new AMapLocationClient(context);
        }
        //设置定位参数AMapLocationClientOption对象
        if (mLocationOption == null) {
            mLocationOption = new AMapLocationClientOption();
        }
        //设置定位模式为AMapLocationMode.Hight_Accuracy，高精度模式。AMapLocationMode.Battery_Saving，低功耗模式  。AMapLocationMode.Device_Sensors，仅设备模式。
        mLocationOption.setLocationMode(AMapLocationClientOption.AMapLocationMode.Hight_Accuracy);
        //获取一次定位结果：
        mLocationOption.setOnceLocation(isOneLocate);
        if (!isOneLocate) {
            //设置定位间隔,单位毫秒,默认为2000ms，最低1000ms。
            mLocationOption.setInterval(interval);
        }
        //设置是否返回地址信息（默认返回地址信息）
        mLocationOption.setNeedAddress(true);
        // 设置是否开启缓存
        mLocationOption.setLocationCacheEnable(true);
        // 设置是否等待设备wifi刷新，如果设置为true,会自动变为单次定位，持续定位时不要使用
        mLocationOption.setOnceLocationLatest(false);
        //单位是毫秒，默认30000毫秒，建议超时时间不要低于8000毫秒。
        mLocationOption.setHttpTimeOut(20000);
        //给定位客户端对象设置定位参数
        mLocationClient.setLocationOption(mLocationOption);
        //设置定位回调监听
        mLocationClient.setLocationListener(new AMapLocationListener() {
            @Override
            public void onLocationChanged(AMapLocation aMapLocation) {
                if (aMapLocation.getErrorCode() == 0) {
                    //可在其中解析amapLocation获取相应内容。
                    listener.onLocationSuccessListener(aMapLocation);
                    Log.d("110", "定位结果：" + aMapLocation.getLatitude() + "," + aMapLocation.getLongitude());
                } else {
                    listener.onLocationErrorListener(aMapLocation);
                    //定位失败时，可通过ErrCode（错误码）信息来确定失败的原因，errInfo是错误信息，详见错误码表。
                    Log.e("AmapError", "location Error, ErrCode:"
                            + aMapLocation.getErrorCode() + ", errInfo:"
                            + aMapLocation.getErrorInfo());
                }
            }
        });
        mLocationClient.startLocation();
    }

    /**
     * 请在Activity的onDestory()方法中调用此方法
     * 销毁对象，防止内存泄漏
     */
    public void onDestroy() {
        stopLocation();
        mAmapManager = null;
    }

    /**
     * 停止定位
     */
    public void stopLocation() {
        // 不处于单位中
        mIsLocation = false;
        if (mLocationClient != null) {
            // 停止定位
            mLocationClient.stopLocation();
            mLocationClient.onDestroy();
            mLocationClient = null;
            mLocationOption = null;
        }
    }
}