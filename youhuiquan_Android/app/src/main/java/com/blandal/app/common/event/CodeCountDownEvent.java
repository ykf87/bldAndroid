package com.blandal.app.common.event;

/**
 * 验证码倒计时
 *
 * @author: ljx
 * @createDate: 2020/8/8 14:25
 */
public class CodeCountDownEvent {
    private String mPhone;
    private int mCountDown;

    public CodeCountDownEvent(String phone, int countDown) {
        mPhone = phone;
        mCountDown = countDown;
    }

    public String getPhone() {
        return mPhone;
    }

    public void setPhone(String phone) {
        this.mPhone = phone;
    }

    public int getCountDown() {
        return mCountDown;
    }

    public void setCountDown(int countDown) {
        this.mCountDown = countDown;
    }
}
