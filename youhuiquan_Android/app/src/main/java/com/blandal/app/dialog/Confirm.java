package com.blandal.app.dialog;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.TextView;

import com.blandal.app.R;
import com.blandal.app.common.enums.ConfirmEnum;
import com.blandal.app.util.AppUtils;
import com.blandal.app.util.DisplayUtil;
import com.blandal.app.util.StringUtils;


public class Confirm implements OnClickListener {

	private Dialog dialogPhoto;

	private Button btnOk;

	private Button btnCancel;

	private TextView txtContent;

	Context mContext;
	TextView txtTitle;
	TextView txtWeb;

	String Weburl;

	public void setCancelGone() {
		btnCancel.setVisibility(View.GONE);
	}

	public Confirm(Context context, String txtOk, String txtCancel,
                   String txtContext) {
		init(context, txtOk, txtCancel, txtContext, ConfirmEnum.defaultEnum,
				null, null, null);
	}

	public Confirm(Context context, String txtOk, String txtCancel,
                   String txtContext, String title) {
		init(context, txtOk, txtCancel, txtContext, ConfirmEnum.defaultEnum,
				title, null, null);
	}

	// 带标题+链接
	public Confirm(Context context, String txtOk, String txtCancel,
                   String txtContext, String txtTitle, String Url, String WebContent) {
		init(context, txtOk, txtCancel, txtContext, ConfirmEnum.defaultEnum,
				txtTitle, Url, WebContent);
	}

	public Confirm(Context context, String txtOk, String txtCancel,
                   CharSequence txtContext, ConfirmEnum confirmEnum) {
		init(context, txtOk, txtCancel, txtContext, confirmEnum, null, null,
				null);
	}
	
	public Confirm(Context context, String txtOk, String txtCancel,
                   CharSequence txtContext, ConfirmEnum confirmEnum, String title) {
		init(context, txtOk, txtCancel, txtContext, confirmEnum, title, null,
				null);
	}

	// 只带右下角ok按钮
	public Confirm(Context context, String txtOk, CharSequence txtContext) {
		init(context, txtOk, null, txtContext, ConfirmEnum.defaultEnum, null,
				null, null);
	}

	private void init(Context context, String txtOk, String txtCancel,
                      CharSequence txtContext, ConfirmEnum confirmEnum, String title,
                      String Url, String WebContent) {
		mContext = context;
		dialogPhoto = new Dialog(mContext, R.style.my_dialog);

		dialogPhoto.setContentView(R.layout.dialog_confirm);

		dialogPhoto.setCancelable(true);
		dialogPhoto.setCanceledOnTouchOutside(true);
		WindowManager.LayoutParams lp = dialogPhoto.getWindow().getAttributes();

		// 设置宽度
		lp.width = DisplayUtil.getWidth(mContext);
		txtTitle = (TextView) dialogPhoto.findViewById(R.id.txtTitle);
		dialogPhoto.getWindow().setAttributes(lp);

		// 标题
		if (StringUtils.isNotNullOrEmpty(title)) {
			txtTitle.setVisibility(View.VISIBLE);
			txtTitle.setText(title);
		} else {
			txtTitle.setVisibility(View.GONE);
		}
		btnCancel = (Button) dialogPhoto.findViewById(R.id.btnCancel);
		btnCancel.setOnClickListener(this);
		// 取消按钮
		if (StringUtils.isNotNullOrEmpty(txtCancel)) {
			btnCancel.setVisibility(View.VISIBLE);
			setCancelText(txtCancel);
		} else {
			btnCancel.setVisibility(View.GONE);
		}
		// web页面
		txtWeb = (TextView) dialogPhoto.findViewById(R.id.txtWeb);
		txtWeb.setOnClickListener(this);
		if (StringUtils.isNotNullOrEmpty(Url)) {
			txtWeb.setVisibility(View.VISIBLE);
			txtWeb.setText(WebContent);
			Weburl = Url;
		} else {
			txtWeb.setVisibility(View.GONE);
		}

		btnOk = (Button) dialogPhoto.findViewById(R.id.btnOk);
		btnOk.setOnClickListener(this);

		txtContent = (TextView) dialogPhoto.findViewById(R.id.txtContent);
		if (context instanceof Activity) {
			if (((Activity) context).isFinishing() == false) {
				dialogPhoto.show();
			} else {
				return;
			}
		}
		setOkText(txtOk);

		txtContent.setText(txtContext);
	}

	private void setCancelText(String str) {
		btnCancel.setText(str);
	}

	private void setOkText(String str) {
		btnOk.setText(str);
	}

	public void setCancelable(boolean b) {
		dialogPhoto.setCancelable(b);
	}

	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.btnOk:

			dialogPhoto.dismiss();
			if (btnOkClick != null) {
				btnOkClick.btnOkClickMet();
			}

			break;
		case R.id.btnCancel:
			dialogPhoto.dismiss();
			if (btnCancelClick != null) {
				btnCancelClick.btnCancelClickMet();
			}

			break;
		case R.id.txtWeb:
			AppUtils.toWap(mContext,
					Weburl + "?version=" + AppUtils.getVersionName(mContext));
			break;
		default:
			break;
		}
	}

	private MyBtnOkClick btnOkClick;

	public interface MyBtnOkClick {
		void btnOkClickMet();
	}

	public void setBtnOkClick(MyBtnOkClick l) {
		btnOkClick = l;
	}

	private MyBtnCancelClick btnCancelClick;

	public interface MyBtnCancelClick {
		void btnCancelClickMet();
	}

	public void setBtnCancelClick(MyBtnCancelClick l) {
		btnCancelClick = l;
	}
}
