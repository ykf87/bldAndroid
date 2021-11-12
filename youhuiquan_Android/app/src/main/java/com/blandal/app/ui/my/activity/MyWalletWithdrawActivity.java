package com.blandal.app.ui.my.activity;

import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jakewharton.rxbinding4.widget.RxTextView;

import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;
import butterknife.OnClick;

import com.blandal.app.R;
import com.blandal.app.base.BaseMvpActivity;
import com.blandal.app.common.UserGlobal;
import com.blandal.app.common.event.WithdrawSuccEvent;
import com.blandal.app.service.ApiResponse;
import com.blandal.app.service.OnNetRequestListener;
import com.blandal.app.service.RetrofitService;
import com.blandal.app.service.ServiceListFinal;
import com.blandal.app.ui.login.entity.LoginEntity;
import com.blandal.app.ui.my.contract.MyWalletWithdrawContract;
import com.blandal.app.ui.my.entity.CenterEntity;
import com.blandal.app.ui.my.entity.WithDrawTipsEntity;
import com.blandal.app.ui.my.presenter.MyWallectWithdrawPresenter;
import com.blandal.app.util.EventBusManager;
import com.blandal.app.util.KeyBoardUtils;
import com.blandal.app.util.StringUtils;
import com.blandal.app.util.ToastShow;
import com.blandal.app.util.UserShared;
import com.blandal.app.util.ViewHelper;
import com.blandal.app.widget.LineEditView;

import io.reactivex.rxjava3.functions.Consumer;

public class MyWalletWithdrawActivity extends BaseMvpActivity<MyWallectWithdrawPresenter> implements MyWalletWithdrawContract.View {
    @BindView(R.id.tv_xuzhi)
    TextView tvXuZhi;
    @BindView(R.id.tv_can_withdraw_money)
    TextView tvCanWithdrawMoney;
    @BindView(R.id.btn_withdrawal)
    Button btnWithdrawal;
    @BindView(R.id.edt_money_num)
    LineEditView edtMoneyNum;
    @BindView(R.id.tv_bind_zhi_fu_bao)
    TextView tvBindZhiFuBao;
    @BindView(R.id.ll_no_bind)
    LinearLayout llNoBind;
    @BindView(R.id.tv_zhi_fu_bao_account)
    TextView tvZhiFuBaoAccount;
    @BindView(R.id.tv_alipay_withdraw_hours)
    TextView tvAlipayWithdrawHours;
    @BindView(R.id.ll_has_bind)
    LinearLayout llHasBind;
    @BindView(R.id.tv_all_withdraw)
    TextView tvAllWithdraw;

    /**
     * 可提现金额
     */
    private int canWithrawMoey;
    /**
     * 提现金额
     */
    private int withrawMoey;

    private boolean hasBindCard = false;

    private LoginEntity.BankEntity bankInfo;


    @Override
    protected int provideContentViewId() {
        return R.layout.activity_my_wallet_withdraw;
    }


    @Override
    public void initView() {
        mPresenter = new MyWallectWithdrawPresenter(this);
    }

    private void setView() {
        canWithrawMoey = UserShared.getJinBi(mContext);
        tvCanWithdrawMoney.setText("可取出枸币：" + canWithrawMoey + "个");
    }

    @Override
    protected void onResume() {
        super.onResume();
        getData();
    }

    @Override
    public void getWithdrawTipsSucc(WithDrawTipsEntity entity) {

    }

    @Override
    public void getWithdrawTipsFail(String errMsg) {
    }

    @Override
    public void initEvent() {
        RxTextView.textChanges(edtMoneyNum.getEditText())
                .to(bindAutoDispose())
                .subscribe(new Consumer<CharSequence>() {
                    @Override
                    public void accept(CharSequence charSequence) throws Throwable {
                        btnWithdrawal.setEnabled(StringUtils.toDouble(charSequence.toString().trim()) != 0);
                    }
                });
        withdraw(btnWithdrawal);
        allWithDraw(tvAllWithdraw);
    }


    @Override
    public void initData() {
    }


    @Override
    public void zhiFuBaoTakeoutSuccess(String msg) {
        UserShared.setJinBi(mContext, canWithrawMoey - withrawMoey);
        ToastShow.showMsg(StringUtils.isNotNullOrEmpty(msg) ? msg : "提现成功，请耐心等待到账信息！");
        edtMoneyNum.setText("");
        tvCanWithdrawMoney.setText("可取出枸币：" + UserShared.getJinBi(mContext) + "个");
        EventBusManager.getInstance().post(new WithdrawSuccEvent());
    }

    @Override
    public void zhiFuBaoTakeoutFail(String errMsg) {
        ToastShow.showMsg(errMsg);
    }

    @Override
    public void checkMyWalletPasswordSucc() {

    }

    @Override
    public void checkMyWalletPasswordFail(String erroMsg) {
    }

    @OnClick({R.id.tv_bind_zhi_fu_bao, R.id.tv_zhi_fu_bao_account})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.tv_bind_zhi_fu_bao:
                BindZhiFuBaoActivity.launch(mContext, hasBindCard);
                break;
        }
    }

    public void allWithDraw(View view) {

        ViewHelper.throttleClick(view, new Consumer() {
            @Override
            public void accept(Object o) throws Throwable {
                if (canWithrawMoey == 0){
                    ToastShow.showMsg("可取出枸币数量为0，快去任务中心做任务吧~");
                    return;
                }
                edtMoneyNum.setText(UserShared.getJinBi(mContext) + "");
                btnWithdrawal.setEnabled(true);
            }
        });
    }

    public void withdraw(View view) {
        ViewHelper.throttleClick(view, new Consumer() {
            @Override
            public void accept(Object o) throws Throwable {
                if (takeMoneyCheck() == false) {
                    return;
                }
                KeyBoardUtils.hideInput(mContext);
                withrawMoey = Integer.parseInt(edtMoneyNum.getText());
                Map map = new HashMap();
                map.put("jine", withrawMoey);
                map.put("cardid", UserShared.getBankId(mContext));
                mPresenter.withdraw(map, mContext);
            }
        });
    }

    private boolean takeMoneyCheck() {
        if (!hasBindCard) {
            ToastShow.showMsg(mContext, "请先绑定银行卡账号", handler);
            return false;
        }
        String noteContent = edtMoneyNum.getText().toString().trim();

        if (TextUtils.isEmpty(noteContent)) {
            ToastShow.showMsg(mContext, "请填写取出枸币个数", handler);
            return false;
        }

        int money = Integer.parseInt(noteContent);

        if (UserShared.getJinBi(mContext) - money < 0) {
            ToastShow.showMsg(mContext, "取出枸币个数不能大于" + canWithrawMoey + "个",
                    handler);
            return false;
        }
        return true;
    }

    private void getData() {
        if (!UserGlobal.isLogin()) {
            return;
        }
        RetrofitService.getData(mContext, ServiceListFinal.center, null, new OnNetRequestListener<ApiResponse<CenterEntity>>() {
            @Override
            public void onSuccess(ApiResponse<CenterEntity> response) {
                if (response.isSuccess()) {
                    CenterEntity entity = response.getData();
                    UserShared.setJinBi(mContext, entity.getJifen());
                    if (entity.getBank() != null) {
                        UserShared.setBankEntity(entity.getBank());
                        UserShared.setBankId(mContext, entity.getBank().getId());
                        bankInfo = entity.getBank();
                        hasBindCard = true;
                        String bankNum = bankInfo.number.substring(0, 3) + "****" + bankInfo.number.substring(bankInfo.number.length() - 4, bankInfo.number.length());
                        tvBindZhiFuBao.setText(bankNum + "");
                    }else {
                        hasBindCard = false;
                        tvBindZhiFuBao.setText( "绑定银行卡");
                    }
                    setView();
                }
            }

            @Override
            public void onFailure(Throwable t) {
            }
        }, bindAutoDispose());
    }
}