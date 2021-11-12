package com.jiankang.gouqi.ui.my.activity;

import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;

import com.jiankang.gouqi.R;
import com.jiankang.gouqi.base.BaseMvpActivity;
import com.jiankang.gouqi.service.ApiResponse;
import com.jiankang.gouqi.service.OnNetRequestListener;
import com.jiankang.gouqi.service.RetrofitService;
import com.jiankang.gouqi.service.ServiceListFinal;
import com.jiankang.gouqi.util.StringUtils;
import com.jiankang.gouqi.util.ToastShow;

/**
 * @author: ljx
 * 反馈
 * @createDate: 2020/11/19  9:36
 */
public class SuggestActivity extends BaseMvpActivity {

    @BindView(R.id.et_phont)
    EditText et_phone;
    @BindView(R.id.et_title)
    EditText et_title;
    @BindView(R.id.et_reson)
    EditText etReson;
    @BindView(R.id.tv_commit)
    TextView tvCommit;


    public static void launch(Context context) {
        Intent intent = new Intent(context, SuggestActivity.class);
        context.startActivity(intent);
    }

    @Override
    protected int provideContentViewId() {
        return R.layout.activity_give_up;
    }

    @Override
    public void initView() {
    }

    @Override
    public void initEvent() {
        tvCommit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                commitData();
            }
        });
    }

    @Override
    public void initData() {
    }

    public void commitData() {
        if (StringUtils.isNullOrEmpty(et_phone.getText().toString())) {
            ToastShow.showMsg("请输入您的手机号");
            return;
        }
        if (StringUtils.isNullOrEmpty(et_title.getText().toString())) {
            ToastShow.showMsg("请输入反馈标题");
            return;
        }
        if (StringUtils.isNullOrEmpty(etReson.getText().toString())) {
            ToastShow.showMsg("请输入反馈内容");
            return;
        }

        Map map = new HashMap<>();
        map.put("phone", et_phone.getText().toString().trim());
        map.put("title", et_title.getText().toString());
        map.put("cont", etReson.getText().toString());
        RetrofitService.postData(mContext, ServiceListFinal.help, map, new OnNetRequestListener<ApiResponse<Void>>() {
            @Override
            public void onSuccess(ApiResponse<Void> response) {
                if (response.isSuccess()) {
                    ToastShow.showLongMsg(mContext, "我们已经收到您的反馈");
                    finish();
                } else {
                    ToastShow.showLongMsg(mContext, response.getMsg(), handler);
                }
            }

            @Override
            public void onFailure(Throwable t) {
                ToastShow.showLongMsg(mContext, t.getMessage(), handler);
            }
        }, bindAutoDispose());
    }
}
