package com.blandal.app.ui.city.view;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.content.ContextCompat;

import com.amap.api.location.AMapLocation;
import com.yanzhenjie.permission.Action;
import com.yanzhenjie.permission.AndPermission;
import com.yanzhenjie.permission.Rationale;
import com.yanzhenjie.permission.RequestExecutor;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import com.blandal.app.R;
import com.blandal.app.common.MyHandler;
import com.blandal.app.dialog.Confirm;
import com.blandal.app.dialog.ProgressDialogShow;
import com.blandal.app.interfaces.AppInterfaces;
import com.blandal.app.util.AmapManager;
import com.blandal.app.util.AppUtils;
import com.blandal.app.util.UserShared;

/**
 * 城市选择列表头view
 *
 * @author: ljx
 * @createDate: 2020/7/3 11:43
 */

public class CitySelectHeaderView extends FrameLayout {

    @BindView(R.id.tv_location)
    TextView tvLocation;

    private Context mContext;
    private MyHandler mHandler;

    /**
     * 需要进行检测的权限数组
     */
    protected String[] needPermissions = {
            Manifest.permission.ACCESS_COARSE_LOCATION,
            Manifest.permission.ACCESS_FINE_LOCATION,};
    /**
     * 是否处于打开设置后
     */
    private boolean mIsSetting = false;
    /**
     * 是否处于定位中
     */
    private boolean mIsLocation = false;
    /**
     * 是否有定位权限
     */
    private boolean mIsPermission = true;
    /**
     * 是否定位成功
     */
    private boolean mIsLocationSucc = false;
    private String mCityCode;
    /**
     * 是否定位授权
     */
    private boolean mIsRequestLocation = false;

    public CitySelectHeaderView(@NonNull Context context, @Nullable AttributeSet attrs, int defStyleAttr, MyHandler handler) {
        this(context, attrs, defStyleAttr);
        mContext = context;
        this.mHandler = handler;
        initView();
    }

    public CitySelectHeaderView(@NonNull Context context) {
        this(context, null);
    }

    public CitySelectHeaderView(@NonNull Context context, @Nullable AttributeSet attrs) {
        this(context, null, 0);
    }

    public CitySelectHeaderView(@NonNull Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    private void initView() {
        inflate(getContext(), R.layout.header_city_select, this);
        ButterKnife.bind(this, this);
        starLocation();
    }


    public void onDestroy() {
    }

    private void setLocationVisible(boolean isSucc, String showInfo, int textColor) {
        tvLocation.setText(showInfo);
        tvLocation.setTextColor(textColor);
        if (isSucc) {
            try {
                Drawable drawable = getResources().getDrawable(R.drawable.city_location);
                drawable.setBounds(0, 0, drawable.getMinimumWidth(), drawable.getMinimumHeight());
                tvLocation.setCompoundDrawables(drawable, null, null, null);
                tvLocation.setCompoundDrawablePadding(2);
                mIsLocationSucc = true;
            } catch (Exception e) {

            }
        } else {
            tvLocation.setCompoundDrawables(null, null, null, null);
        }
    }

    @OnClick({R.id.tv_location})
    public void onClick(View view) {
        if (view.getId() == R.id.tv_location) {
            if (mIsPermission) {
                if (mIsLocationSucc) {
                    if (mHeaderListener != null) {
                        mHeaderListener.onClick(mCityCode);
                    }
                } else {
                    starLocation();
                }
            } else {
                mIsSetting = true;
                AppUtils.gotoAppDetailIntent(mContext);
            }
        }
    }

    public void onResume() {
        //定位权限判断
        if (!mIsPermission && mIsSetting) {
            mIsSetting = false;
            performCodeWithPermission(mContext.getString(R.string.location_permission_hint), new AppInterfaces.PermissionCallback() {
                @Override
                public void hasPermission() {
                    mIsPermission = true;
                    location();
                }

                @Override
                public void noPermission() {
                    mIsPermission = false;
                }

                @Override
                public void alwaysNoPermission() {

                }
            }, needPermissions);
        }
    }

    /**
     * 开始定位
     */
    private void starLocation() {
        // 如果处于定位中
        if (mIsLocation) {
            return;
        }
        //权限判断
        performCodeWithPermission(mContext.getString(R.string.location_permission_hint), new AppInterfaces.PermissionCallback() {
            @Override
            public void hasPermission() {
                mIsPermission = true;
                location();
            }

            @Override
            public void noPermission() {
                mIsPermission = false;
                setLocationVisible(false, mContext.getString(R.string.location_no_service), ContextCompat.getColor(mContext, R.color.colorPrimary));
            }

            @Override
            public void alwaysNoPermission() {

            }
        }, needPermissions);

    }

    /**
     * Android M运行时权限请求封装
     *
     * @param permissionDes 权限描述
     * @param runnable      请求权限回调
     * @param permissions   请求的权限（数组类型），直接从Manifest中读取相应的值，比如Manifest.permission.WRITE_CONTACTS
     */
    @SuppressLint("WrongConstant")
    public void performCodeWithPermission(@NonNull final String permissionDes, final AppInterfaces.PermissionCallback runnable, @NonNull String... permissions) {

        AndPermission.with(mContext)
                .runtime()
                .permission(permissions)
                .onGranted(new Action<List<String>>() {
                    @Override
                    public void onAction(List<String> data) {
                        if (runnable != null) {
                            runnable.hasPermission();
                        }
                    }
                })
                .onDenied(new Action<List<String>>() {
                    @Override
                    public void onAction(List<String> data) {
                        //hasAlwaysDeniedPermission()只能在onDenied()的回调中调用
//						if (AndPermission.hasAlwaysDeniedPermission(mContext, data)) {
//							// 这些权限被用户总是拒绝。
//						}
                        if (runnable != null) {
                            runnable.noPermission();
                        }
                    }
                })
                .rationale(new Rationale<List<String>>() {
                    @Override
                    public void showRationale(Context context, List<String> data, final RequestExecutor executor) {
                        openPermissionDialog(executor, permissionDes);
                    }
                })
                .start();
    }

    private void openPermissionDialog(final RequestExecutor executor, final String permissionDes) {
        final Confirm permissionDialog = new Confirm(mContext, "确定", "取消", permissionDes, "提示");
        permissionDialog.setBtnCancelClick(new Confirm.MyBtnCancelClick() {
            @Override
            public void btnCancelClickMet() {
                executor.cancel();
            }
        });
        permissionDialog.setBtnOkClick(new Confirm.MyBtnOkClick() {
            @Override
            public void btnOkClickMet() {
                executor.execute();
            }
        });
    }

    /**
     * 显示定位的城市
     */
    private void showLocationCity(String currCode, String cityName, String district) {
        setLocationVisible(true, cityName + "-" + district, ContextCompat.getColor(mContext, R.color.text_title_info));
    }

    public void setHeaderListener(HeaderViewListener headerListener) {
        mHeaderListener = headerListener;
    }

    private HeaderViewListener mHeaderListener;

    public interface HeaderViewListener {
        /**
         * 点击定位
         */
        void onClick(String cityCode);

        /**
         * 定位成功
         */
        void onLocationChanged(String cityCode);
    }

    /**
     * 定位并且保存自己所在城市Id
     */
    private void location() {
        setLocationVisible(false, mContext.getString(R.string.location_locationing), ContextCompat.getColor(mContext, R.color.text_describe_text));
        AmapManager.getInstance().startLocate(getContext(), false, 10000, new AmapManager.OnLocationListener() {
            @Override
            public void onLocationSuccessListener(AMapLocation location) {
                AmapManager.getInstance().onDestroy();
                ProgressDialogShow.dismissDialog(mHandler);
                // 获取当前城市cd
                mCityCode = location.getCityCode();

                UserShared.setCityCode(mContext, mCityCode);

                //春节补充：2020-02-07
                String currCityNm = location.getCity();
                String lat = location.getLatitude() + "";
                String lng = location.getLongitude() + "";



                showLocationCity(mCityCode, location.getCity(), location.getDistrict());
                if (mHeaderListener != null) {
                    mHeaderListener.onLocationChanged(mCityCode);
                }
            }

            @Override
            public void onLocationErrorListener(AMapLocation location) {
                setLocationVisible(false, mContext.getString(R.string.location_fail), ContextCompat.getColor(mContext, R.color.colorPrimary));
                AmapManager.getInstance().onDestroy();
            }
        });
    }

}