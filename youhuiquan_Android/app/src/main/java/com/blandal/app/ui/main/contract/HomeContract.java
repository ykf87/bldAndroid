package com.blandal.app.ui.main.contract;

import android.content.Context;

import java.util.List;
import java.util.Map;

import autodispose2.AutoDisposeConverter;
import com.blandal.app.base.mvp.IModel;
import com.blandal.app.base.mvp.IView;
import com.blandal.app.entity.GlobalEntity;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.ui.main.entity.ClassifyBean;

/**
 * @author: ljx
 * @createDate: 2020/11/20  15:10
 */
public class HomeContract {
    public interface Model extends IModel {
        //首页分类
        void getClassifyList(Map map, Context context, OnNetRequestListener listener, final AutoDisposeConverter<ApiResponse> bindAutoDispose);

        //获取全局
        void getGlobalClientData(Map map, Context context, OnNetRequestListener listener, final AutoDisposeConverter<ApiResponse> bindAutoDispose);

    }
    public interface HomeView extends IView {
        //首页分类
        void getClassifyListSucc(List<ClassifyBean> list);
        void getClassifyListFail();

        void getGlobalClientDataSucc(GlobalEntity entity);
        void getGlobalClientDataFail();
    }
}
