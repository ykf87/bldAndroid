package com.blandal.app.util;

import android.text.Editable;
import android.text.TextWatcher;
import android.widget.EditText;

public class AmountListener implements TextWatcher {

	EditText edt_recharge_amount;

	public AmountListener(EditText pEdt_recharge_amount) {
		edt_recharge_amount = pEdt_recharge_amount;
	}

	@Override
	public void onTextChanged(CharSequence s, int start, int before, int count) {

		// 如果输入串中包含小数点
		if (s.toString().contains(".")) {
			// 取小数点后2位
			if (s.length() - 1 - s.toString().indexOf(".") > 2) {
				s = s.toString().subSequence(0, s.toString().indexOf(".") + 3);
				edt_recharge_amount.setText(s);
				edt_recharge_amount.setSelection(s.length());
			}
		}
		// 如果不包含小数点
		else {
			// 最大取值6位
			if (s.length() > 6) {
				s = s.toString().subSequence(0, 6);
				edt_recharge_amount.setText(s);
				edt_recharge_amount.setSelection(s.length());
			}
		}

		// 如果以小数点开头
		if (s.toString().trim().substring(0).equals(".")) {
			s = "0" + s;
			edt_recharge_amount.setText(s);
			edt_recharge_amount.setSelection(2);
		}

		// 如果以0开头
		if (s.toString().startsWith("0") && s.toString().trim().length() > 1) {
			if (!s.toString().substring(1, 2).equals(".")) {
				edt_recharge_amount.setText(s.subSequence(0, 1));
				edt_recharge_amount.setSelection(1);
				return;
			}
		}
	}

	@Override
	public void beforeTextChanged(CharSequence s, int start, int count,
                                  int after) {
	}

	@Override
	public void afterTextChanged(Editable s) {
	}
}
