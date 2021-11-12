package com.blandal.app.ui.city.activity;

import android.content.Intent;
import android.text.TextUtils;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.chad.library.adapter.base.BaseQuickAdapter;
import com.chad.library.adapter.base.listener.OnItemChildClickListener;
import com.chad.library.adapter.base.listener.OnItemClickListener;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import butterknife.BindView;
import com.blandal.app.R;
import com.blandal.app.base.BaseMvpActivity;
import com.blandal.app.common.event.CitySelectEvent;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.GsonHelper;
import com.blandal.app.service.ServiceListFinal;
import com.blandal.app.ui.city.entity.CityListEntity;
import com.blandal.app.ui.main.activity.MainAppActivity;
import com.blandal.app.dialog.ProgressDialogShow;
import com.blandal.app.entity.LocationInfoCitiesEntity;
import com.blandal.app.interfaces.LineLoadingInterface;
import com.blandal.app.ui.city.adapter.CityListAdapter;
import com.blandal.app.ui.city.adapter.decoration.GridSectionAverageGapItemDecoration;
import com.blandal.app.ui.city.contract.CitySelectContract;
import com.blandal.app.ui.city.entity.CityEntity;
import com.blandal.app.ui.city.entity.CitySectionEntity;
import com.blandal.app.ui.city.presenter.CitySelectPresenter;
import com.blandal.app.ui.city.view.CitySelectHeaderView;
import com.blandal.app.util.EventBusManager;
import com.blandal.app.util.FileUtils;
import com.blandal.app.util.JsonUtils;
import com.blandal.app.util.StringUtils;
import com.blandal.app.util.ToastShow;
import com.blandal.app.util.UserShared;
import com.blandal.app.widget.AppBackBar;
import com.blandal.app.widget.LineLoading;
import com.blandal.app.widget.SortLetterView;

/**
 * 城市选择界面
 *
 * @author: ljx
 * @createDate: 2020/7/2 10:32
 */
public class CitySelectActivity extends BaseMvpActivity<CitySelectPresenter> implements CitySelectContract.View {
    public static String CITY_LIST_FILENAME = "citylist.txt";

    @BindView(R.id.app_back_bar)
    AppBackBar appBackBar;
    @BindView(R.id.rv_city)
    RecyclerView rvCity;
    @BindView(R.id.sort_view)
    SortLetterView sortView;

    private CityListAdapter mAdapter;
    private CitySelectHeaderView mHeaderView;

    //这个List 包含热门城市被重复添加一次
    private ArrayList<CityEntity> mCityNameList;
    //这个List 是全部城市
    private List<CitySectionEntity> mAllCityNameList = new ArrayList<>();

    private List<CityEntity> mHotCitiesEntity;

    private List<LocationInfoCitiesEntity> mLocationInfoEntity;
    /*
     * 是否只获取城市
     */
    private boolean mIsGetCity;
    /**
     * 是否隐藏不选
     */
    private boolean mIsHideNoSel = false;
    /**
     * 是否隐藏区域不选
     */
    private boolean mIsHideAreaNoSel = false;
    /**
     * 是否处于定位中
     */
    private boolean mIsLocation = false;
    /**
     * 选中的城市Id
     */
    private int mCityId = 0;
    /**
     * 是否是首次定位 如果没有定位也要跳到首页 城市为当前定位所在的城市 如果定位失败那么就返回福州
     **/
    private boolean mIsMustToHomepage;
    /**
     * 加载错误层
     */
    private LineLoading lineLoading;

    private boolean mIsFromRegisterSucc;

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_city_select;
    }

    @Override
    public void initView() {
        mPresenter = new CitySelectPresenter(this);
        mIsMustToHomepage = getIntent().getBooleanExtra("isMustToHomepage", false);

        if (mIsMustToHomepage) {
            super.setEnableGesture(false);
            super.closeAnimation();
            overridePendingTransition(0, 0);
        }

        mIsGetCity = getIntent().getBooleanExtra("isGetCity", true);

        // 选择的城市id
        mCityId = getIntent().getIntExtra("pCityId", 0);

        mIsHideNoSel = getIntent().getBooleanExtra("isHideNoSel", false);

        mIsHideAreaNoSel = getIntent().getBooleanExtra("isHideAreaNoSel", false);

        mIsFromRegisterSucc = getIntent().getBooleanExtra("isFromRegisterSucc", false);

        init();
    }

    @Override
    public void initEvent() {

    }

    @Override
    public void initData() {
        getData(false);
    }

    private void initRecyclerView() {
        //LinearLayoutManager layoutManager = new LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false);
        mHeaderView = new CitySelectHeaderView(this, null, 0, handler);
        mHeaderView.setHeaderListener(new CitySelectHeaderView.HeaderViewListener() {
            @Override
            public void onClick(String cityCode) {
                for (CityEntity data : mCityNameList) {
                    if (TextUtils.equals(cityCode, data.cityId)) {
                        openSelArea(data);
                        return;
                    }
                }
            }

            @Override
            public void onLocationChanged(String cityCode) {
                for (CityEntity data : mCityNameList) {
                    if (TextUtils.equals(cityCode, data.cityId)) {
                        UserShared.setLocationCityId(mContext, data.id + "");
                        UserShared.setLocationCityName(mContext, data.name);

                        if (StringUtils.isNullOrEmpty(UserShared.getUserIndexCityId(mContext))) {
                            UserShared.setUserIndexCityId(mContext, data.id + "");
                            UserShared.setUserIndexCityNm(mContext, data.name);
                        }
                        return;
                    }
                }
            }
        });
        mAdapter = new CityListAdapter(this, mAllCityNameList);
        mAdapter.addHeaderView(mHeaderView);

        GridLayoutManager gridLayoutManager = new GridLayoutManager(this, 3);
        rvCity.setLayoutManager(gridLayoutManager);
        rvCity.addItemDecoration(new GridSectionAverageGapItemDecoration(10, 10, 20, 15));

        mAdapter.setLayoutManager(gridLayoutManager);
        mAdapter.setOnItemClickListener(new OnItemClickListener() {
            @Override
            public void onItemClick(@NonNull BaseQuickAdapter<?, ?> adapter, @NonNull View view, int position) {
                CitySectionEntity mySection = mAllCityNameList.get(position);
                if (mySection.isHeader()) {
                    return;
                }
                CityEntity cityEntity = mySection.getCityEntity();
                openSelArea(cityEntity);
                //ToastShow.showMsg(CitySelectActivity.this, mySection.getCityEntity().getName());
            }
        });
        mAdapter.setOnItemChildClickListener(new OnItemChildClickListener() {
            @Override
            public void onItemChildClick(@NonNull BaseQuickAdapter adapter, @NonNull View view, int position) {
                //openSelArea(cityEntity);
                //ToastShow.showMsg(CitySelectActivity.this, "onItemChildClick: " + position);
            }
        });
        rvCity.setAdapter(mAdapter);
        mAdapter.setHeaderWithEmptyEnable(true);
    }

    /**
     * 获取数据
     */
    private void getData(final boolean isdelay) {

        lineLoading.setShowLoadding();
        mPresenter.getCityList(this);
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (mHeaderView != null) {
            mHeaderView.onResume();
        }
    }

    @Override
    public void onDestroy() {

        super.onDestroy();
        if (mHeaderView != null) {
            mHeaderView.onDestroy();
        }
        mCityNameList = null;

        mHotCitiesEntity = null;

        mLocationInfoEntity = null;
    }

    private void init() {
        appBackBar.setOnBackClickListener(new AppBackBar.OnBarClickListener() {
            @Override
            public void onClick() {
                if (mIsMustToHomepage) {
                    mustToHomepage();
                    return;
                }
                myfinish();
            }
        });

        lineLoading = (LineLoading) findViewById(R.id.lineLoading);
        lineLoading.setLineLoadingClick(new LineLoadingInterface.LineLoadingClick() {
            @Override
            public void onClick() {
                getData(true);
            }
        });

        sortView.setMode(SortLetterView.UiMode.BOTH);
        sortView.setOnLetterChangedListener(new SortLetterView.OnLetterChangedListener() {
            @Override
            public void onChanged(String letter, int position) {
                mAdapter.scrollToSection(letter);
            }
        });
    }

    private void showData() {
        initRecyclerView();
        //lvArea.addHeaderView(topView, null, false);

        //AdapterArea adapter = new AdapterArea();
        //lvArea.setAdapter(adapter);
        //adapter.setData(mCityNameList);
    }

    /*
     * 选择城市下级(区域)
     */
    private void openSelArea(final CityEntity cityClass) {
        // 只选择城市的话
        if (mIsGetCity) {
            // 保存城市id，name
            UserShared.setUserIndexCityId(mContext, cityClass.id + "");
            UserShared.setUserIndexCityNm(mContext, cityClass.name);
            UserShared.setCityCode(mContext, cityClass.cityId + "");
            EventBusManager.getInstance().post(new CitySelectEvent(cityClass.id, cityClass.name));
            myfinish();
            overridePendingTransition(0, 0);
            /*Intent data = new Intent();
            data.putExtra("cityId", cityClass.id);
            data.putExtra("cityNm", cityClass.name);
            setResult(FinalActivityReturn.UserSelAreaActivityReturn_City, data);
            myfinish();
            overridePendingTransition(0, 0);*/
            return;
        }

        if (cityClass.childArea == null) {
            ProgressDialogShow.showLoadDialog(mContext, false, "加载中...");
            /*DisplayUtil.startThread(new Runnable() {
                @Override
                public void run() {
                    List<CityChildAreaEntity> cityChildAreaEntity = LocationUtils
                            .getAreaNms(mContext, cityClass.id + "", handler);
                    ProgressDialogShow.dismissDialog(handler);
                    if (cityChildAreaEntity == null) {
                        ToastShow.showMsg(mContext, LocationUtils.error,
                                handler);
                        return;
                    }
                    cityClass.childArea = cityChildAreaEntity;
                    handler.mPost(new Runnable() {
                        @Override
                        public void run() {
                            openSelAreaDlg(cityClass);
                        }
                    });
                }
            });*/
            return;
        }
        openSelAreaDlg(cityClass);
    }

    /**
     * 选择城市下级(区域)
     */
    private void openSelAreaDlg(CityEntity cityClass) {

        /*List<NomalEntity> list = new ArrayList<>();
        for (CityChildAreaEntity o : cityClass.childArea) {
            // 城市id，城市名称 区域id，区域名称
            JSONObject param = new JSONObject();
            try {
                param.put("cityId", cityClass.id);
                param.put("cityNm", cityClass.name);
                param.put("areaId", o.id);
                param.put("areaNm", o.name);
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }

            list.add(new NomalEntity(o.name, param.toString()));
        }

        if (mIsHideNoSel) {
            if (!mIsHideAreaNoSel) {
                try {
                    JSONObject param = new JSONObject();
                    param.put("cityId", cityClass.id);
                    param.put("cityNm", cityClass.name);
                    param.put("areaId", 0);
                    param.put("areaNm", "不限");
                    list.add(0, new NomalEntity("不限", param.toString()));
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
            if (list.size() < 1) {
                ToastShow.showMsg(mContext, "该城市没有所属区域");
                return;
            }
        } else {
            try {
                JSONObject param = new JSONObject();
                param.put("cityId", cityClass.id);
                param.put("cityNm", cityClass.name);
                param.put("areaId", 0);
                param.put("areaNm", "不限");
                list.add(0, new NomalEntity("不限", param.toString()));
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }

        ShowGridDataDlg gridDataDlg = new ShowGridDataDlg(mContext, "选择城市区域：", list);
        gridDataDlg.setReturnMet(new ShowGridDataDlg.ReturnMet() {
            @Override
            public void setData(String selName, String selId) {
                try {

                    JSONObject param = new JSONObject(selId);
                    *//*Intent data = new Intent();
                    data.putExtra("cityId", param.getInt("cityId"));
                    data.putExtra("cityNm", param.getString("cityNm"));
                    data.putExtra("areaId", param.getInt("areaId"));
                    data.putExtra("areaNm", param.getString("areaNm"));
                    setResult(FinalActivityReturn.UserSelAreaActivityReturn, data);*//*
                    EventBusManager.getInstance().post(new CitySelectEvent(param.getInt("cityId"), param.getString("cityNm")));
                    myfinish();
                    overridePendingTransition(0, 0);
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
        });*/
    }

    private void noSelMet() {
        Intent data = new Intent();
        data.putExtra("cityId", 0);
        data.putExtra("cityNm", "不限");
        data.putExtra("areaId", 0);
        data.putExtra("areaNm", "不限");
        /*if (mIsGetCity) {
            setResult(FinalActivityReturn.UserSelAreaActivityReturn_City, data);
        } else {
            setResult(FinalActivityReturn.UserSelAreaActivityReturn, data);
        }*/
        myfinish();
        overridePendingTransition(0, 0);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode,
                                 final Intent data) {


        super.onActivityResult(requestCode, resultCode, data);
    }

    /**
     * 释放之前必须把文本内容清除掉，不然会提示异常
     */
    private void myfinish() {
        finish();
    }

    /**
     * 必须选择页面
     */
    private void mustToHomepage() {
//        if (defaultArea == null) {
//            defaultArea = new MyCityClass();
//            defaultArea.id = 211;
//            defaultArea.name = "福州";
//        }
//        openSelArea(defaultArea);
        ToastShow.showMsg(mContext, "请选择工作城市", handler);
    }

    @Override
    public void onBackPressed() {
        if (mIsMustToHomepage) {
            mustToHomepage();
            return;
        }
        myfinish();
    }

    @Override
    public void getCityListSucc(ApiResponse<CityListEntity> response) {
        CityListEntity entity = response.getData();
        if (entity != null && entity.cities != null && entity.cities.size() > 0) {
            // 保存key
            UserShared.setData(mContext,
                    ServiceListFinal.getCityList + "md5_file",
                    response.getData().md5_hash);
            // 保存json字符串
            String json = JsonUtils.toJson(entity);
            FileUtils.writeFileData(mContext, CITY_LIST_FILENAME, json);
            mLocationInfoEntity = entity.cities;
        } else {
            // 拿到字符串
            String dataStr = FileUtils
                    .readFileData(mContext, CITY_LIST_FILENAME);

            // 重新转成对象
            entity = new GsonHelper<CityListEntity>()
                    .fromJsonToEntity(dataStr, CityListEntity.class);
            if (entity != null) {
                mLocationInfoEntity = entity.cities;
            }
        }
        if (mLocationInfoEntity == null) {
            lineLoading
                    .setError(handler, response.getMsg(), true);
            return;
        }
        mCityNameList = new ArrayList<>();

        mHotCitiesEntity = new ArrayList<>();

        CitySectionEntity citySectionEntity = new CitySectionEntity(true, new CityEntity("热门城市"));
        mAllCityNameList.clear();
        mAllCityNameList.add(citySectionEntity);
        List<CitySectionEntity> hotCitySection = new ArrayList<>();
        for (int i = 0; i < mLocationInfoEntity.size(); i++) {
            String name = mLocationInfoEntity.get(i).name;
            String namef = mLocationInfoEntity.get(i).pinyinFirstLetter;
            String jianpin = mLocationInfoEntity.get(i).jianPin;
            String spelling = mLocationInfoEntity.get(i).spelling;
            int id = mLocationInfoEntity.get(i).id;
            boolean isSelect = id == mCityId;
            CityEntity c = new CityEntity(jianpin, id, namef,
                    name, mLocationInfoEntity.get(i).areaCode,
                    spelling, isSelect);
            mCityNameList.add(c);
            // 添加热门城市
            if (mLocationInfoEntity.get(i).hotCities == 1) {
                mHotCitiesEntity.add(c);
                CitySectionEntity hotSectionEntity = new CitySectionEntity(false, c);
                mAllCityNameList.add(hotSectionEntity);
            }
        }

        // 排序
        Collections.sort(mCityNameList,
                new Comparator<CityEntity>() {
                    @Override
                    public int compare(CityEntity arg0,
                                       CityEntity arg1) {
                        return arg0.pinyin_first_letter
                                .toLowerCase().compareTo(
                                        arg1.pinyin_first_letter
                                                .toLowerCase());
                    }
                });

        //加入字母段城市
        addSection(mAllCityNameList, mCityNameList);
        //mAllCityNameList.addAll(mCityNameList);

        mCityNameList.addAll(0, mHotCitiesEntity);

        handler.mPost(new Runnable() {
            @Override
            public void run() {
                showData();
                lineLoading.setError(handler, null);
            }
        });
    }

    @Override
    public void getCityListFail() {

    }

    private void addSection(List<CitySectionEntity> dataList, List<CityEntity> cityList) {
        for (int i = 0; i < cityList.size(); i++) {
            CityEntity cityEntity = cityList.get(i);
            String section = cityEntity.getSection();
            if (i == 0) {
                CitySectionEntity headerSectionEntity = new CitySectionEntity(true, new CityEntity(section));
                dataList.add(headerSectionEntity);
                CitySectionEntity citySectionEntity = new CitySectionEntity(false, cityEntity);
                dataList.add(citySectionEntity);
            } else {
                if (cityEntity.getSection() != null && !cityEntity.getSection().equals(cityList.get(i - 1).getSection())) {
                    CitySectionEntity headerSectionEntity = new CitySectionEntity(true, new CityEntity(section));
                    dataList.add(headerSectionEntity);
                    CitySectionEntity citySectionEntity = new CitySectionEntity(false, cityEntity);
                    dataList.add(citySectionEntity);
                } else {
                    CitySectionEntity headerSectionEntity = new CitySectionEntity(false, cityEntity);
                    dataList.add(headerSectionEntity);
                }
            }
        }
    }


    public void toMain() {
        handler.post(new Runnable() {
            @Override
            public void run() {
                Intent toUserLogin = new Intent(mContext,
                        MainAppActivity.class);
                toUserLogin.putExtra("isFromRegisterSucc", mIsFromRegisterSucc);
                startActivity(toUserLogin);
                myfinish();
                overridePendingTransition(0, 0);
            }
        });
    }
}
