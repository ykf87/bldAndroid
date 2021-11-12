package com.jiankang.gouqi.util;

import android.app.Activity;
import android.content.Context;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;

import com.jiankang.gouqi.widget.LineEditView;


//打开或关闭软键盘
public class KeyBoardUtils {
	/**
	 * 打开某一个输入框软键盘
	 * 
	 * @param mEditText 输入框
	 * @param mContext 上下文
	 */
	public static void openKeybord(EditText mEditText, Context mContext) {
		InputMethodManager imm = (InputMethodManager) mContext
				.getSystemService(Context.INPUT_METHOD_SERVICE);
		imm.showSoftInput(mEditText, InputMethodManager.RESULT_SHOWN);
		imm.toggleSoftInput(InputMethodManager.SHOW_FORCED,
				InputMethodManager.HIDE_IMPLICIT_ONLY);
	}

	/**
	 * 隐藏整个界面中的软键盘
	 */
	public static void hideInput(Context mContext) {
		if (((Activity) mContext).getCurrentFocus() == null)
			return;
		InputMethodManager inputMethodManager = (InputMethodManager) mContext
				.getSystemService(Context.INPUT_METHOD_SERVICE);
		inputMethodManager.hideSoftInputFromWindow(((Activity) mContext)
				.getCurrentFocus().getWindowToken(),
				InputMethodManager.HIDE_NOT_ALWAYS);
	}

	/**
	 * 关闭某一个输入框的软键盘
	 * 
	 * @param mEditText 输入框
	 * @param mContext 上下文
	 */
	public static void closeKeybord(EditText mEditText, Context mContext) {
		InputMethodManager imm = (InputMethodManager) mContext
				.getSystemService(Context.INPUT_METHOD_SERVICE);

		imm.hideSoftInputFromWindow(mEditText.getWindowToken(), 0);
	}
	
	/**
	 * 关闭某一个输入框的软键盘
	 * 
	 * @param mEditText 自定义输入框
	 * @param mContext 上下文
	 */
	public static void closeKeybord(LineEditView mEditText, Context mContext) {
		InputMethodManager imm = (InputMethodManager) mContext
				.getSystemService(Context.INPUT_METHOD_SERVICE);

		imm.hideSoftInputFromWindow(mEditText.getWindowToken(), 0);
	}
}
