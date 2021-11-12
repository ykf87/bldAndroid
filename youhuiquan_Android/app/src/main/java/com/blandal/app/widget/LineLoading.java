package com.blandal.app.widget;

import android.content.Context;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.blandal.app.R;
import com.blandal.app.common.MyHandler;
import com.blandal.app.interfaces.LineLoadingInterface;
import com.blandal.app.interfaces.ObjectClick;
import com.blandal.app.util.DisplayUtil;

public class LineLoading extends LinearLayout {

	Context mContext;

	TextView txtLoadingErr;

	TextView txtLoadingErrMiaoShu;

	ImageView imgMain;

	LinearLayout ll_loadding;

	LinearLayout ll_loading_top;

	RelativeLayout rlLoadingMain;

	/**
	 * 是否允许触发回调
	 */
	boolean isAllowCallback = true;

	LineLoadingInterface.LineLoadingClick lineLoadingClick;

	/**
	 * 提示用户去登录
	 */
	TextView tv_btn_txt;

	TextView tv_fresh;

	ObjectClick llLoginObjectClick;

	/**
	 * 设置单击事件回调
	 * 
	 * @param pLineLoadingClick
	 */
	public void setLineLoadingClick(LineLoadingInterface.LineLoadingClick pLineLoadingClick) {
		lineLoadingClick = pLineLoadingClick;
	}

	public LineLoading(Context context) {
		super(context);
		init(context);
	}

	public LineLoading(Context context, AttributeSet attrs) {
		super(context, attrs);
		init(context);
	}

	public void setShowLoadding() {
		setVisibility(View.VISIBLE);
		rlLoadingMain.setVisibility(View.VISIBLE);
		ll_loadding.setVisibility(View.VISIBLE);
		ll_loading_top.setVisibility(View.GONE);
		isAllowCallback = false;
	}

	public void setHideLoadding(MyHandler mHandler) {
		if (mHandler != null) {
			mHandler.mPost(new Runnable() {
				@Override
				public void run() {
					ll_loadding.setVisibility(View.GONE);
					isAllowCallback = false;
				}
			});
		}
	}

	/**
	 * 初始化
	 */
	private void init(Context pContext) {
		mContext = pContext;
		LayoutInflater.from(mContext).inflate(R.layout.line_loading, this);
		if (isInEditMode()) {
			return;
		}
		rlLoadingMain = (RelativeLayout) findViewById(R.id.rlLoadingMain);
		tv_fresh = (TextView) findViewById(R.id.tv_fresh);
		tv_fresh.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View arg0) {
				// 已经处于回调中，限制重复回调
				if (!isAllowCallback) {
					return;
				}

				if (lineLoadingClick != null) {
					setShowLoadding();
					lineLoadingClick.onClick();
					tv_fresh.setVisibility(View.GONE);
				}
			}
		});
		tv_btn_txt = (TextView) findViewById(R.id.tv_btn_txt);
		txtLoadingErr = (TextView) findViewById(R.id.txtLoadingErr);
		tv_btn_txt.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View arg0) {
				if (llLoginObjectClick == null) {
					return;
				}
				llLoginObjectClick.callback(null);
			}
		});
		tv_btn_txt.setVisibility(View.GONE);
		txtLoadingErrMiaoShu = (TextView) findViewById(R.id.txtLoadingErrMiaoShu);
		ll_loadding = (LinearLayout) findViewById(R.id.ll_loadding);
		ll_loading_top = (LinearLayout) findViewById(R.id.ll_loading_top);
		imgMain = (ImageView) findViewById(R.id.imgMain);
		setShowLoadding();
	}

	/**
	 * 设置内容高度
	 */
	public void setPadingTop(Context pContext, int top) {
		ll_loading_top.setGravity(Gravity.CENTER_HORIZONTAL);
		RelativeLayout.LayoutParams lp = (RelativeLayout.LayoutParams) ll_loading_top
				.getLayoutParams();
		ll_loading_top.setPadding(0, DisplayUtil.dip2px(pContext, top), 0, 0);
		ll_loading_top.setLayoutParams(lp);
	}

	/**
	 * 设置内容高度
	 */
	public void setMainHeight(int height) {
		LayoutParams lp = (LayoutParams) rlLoadingMain
				.getLayoutParams();
		lp.height = height;
	}

	/**
	 * 隐藏加载中的滚动
	 */
	public void hideBar() {
		ll_loadding.setVisibility(View.GONE);
	}

	/**
	 * 隐藏图片
	 */
	public void hideImg() {
		imgMain.setVisibility(View.GONE);
	}

	/**
	 * 隐藏加载中文字
	 */
	public void hideError() {
		ll_loadding.setVisibility(View.GONE);
	}

	/**
	 * 设置错误消息
	 * @param error
	 *            出错内容 null 时候隐藏加载层
	 * @param isErr
	 *            是否出错，出错显示刷新试试看 ，false 显示放大镜 不显示刷新试试
	 */
	public void setError(final MyHandler handler, final String error,
			boolean isErr) {
		if (isErr) {
			setImgAndError(handler, error, R.drawable.user_net_no_data, 105,
					105, isErr);
		} else {
			setImgAndError(handler, error, R.drawable.bg_search_empty_result, 105,
					105, isErr);
		}
	}

	/**
	 * 设置图片
	 */
	public void setError(final MyHandler handler, final String error,
			int drawable) {
		setImgAndError(handler, error, null, drawable, 105, 105, false);
	}

	/**
	 * 错误信息 不带图标
	 */
	public void setError(final MyHandler handler, final String error) {
		setError(handler, false, error);
	}

	/**
	 * 显示错误信息与图片
	 */
	public void setImgAndError(final MyHandler handler, final String error,
			final int icon, final int width, final int height,
			final boolean isErr) {
		setImgAndError(handler, error, null, icon, width, height, isErr);
	}

	/**
	 * 登录按钮的隐藏显示
	 */
	public void setLoginBtnHideOrShow(boolean pIsShow, ObjectClick pObjectClick) {
		if (pIsShow) {
			tv_btn_txt.setVisibility(View.VISIBLE);
		} else {
			tv_btn_txt.setVisibility(View.GONE);
		}
		llLoginObjectClick = pObjectClick;
	}
	
	/**
	 * 登录按钮的隐藏显示
	 */
	public void setLoginBtnHideOrShow(boolean pIsShow) {
		if (pIsShow) {
			tv_btn_txt.setVisibility(View.VISIBLE);
		} else {
			tv_btn_txt.setVisibility(View.GONE);
		}
	}

	/**
	 * 错误信息 是否带图标
	 */
	public void setError(final MyHandler handler, final boolean isErr,
			final String error) {
		handler.mPost(new Runnable() {
			@Override
			public void run() {
				isAllowCallback = true;
				if (error == null) {
					setVisibility(View.GONE);
					rlLoadingMain.setVisibility(View.GONE);
					return;
				}
				ll_loadding.setVisibility(View.GONE);
				tv_fresh.setVisibility(View.GONE);
				setVisibility(View.VISIBLE);
				rlLoadingMain.setVisibility(View.VISIBLE);
				ll_loading_top.setVisibility(View.VISIBLE);
				if (isErr) {
					tv_fresh.setVisibility(View.VISIBLE);
				} else {
					tv_fresh.setVisibility(View.GONE);
					txtLoadingErrMiaoShu.setVisibility(View.GONE);
				}
				imgMain.setVisibility(View.INVISIBLE);
				txtLoadingErr.setVisibility(View.VISIBLE);
				txtLoadingErr.setText(error);
				tv_btn_txt.setVisibility(View.GONE);
			}
		});
	}

	/**
	 * 点击按钮文字
	 */
	public void setClicBtnText(String s) {

		tv_btn_txt.setText(s);
	}

	/**
	 * 显示错误信息与图片
	 */
	public void setImgAndError(final MyHandler handler, final String error,
                               final String errorDesc, final int icon, final int width,
                               final int height, final boolean pIsShowFreshBtn) {
		handler.mPost(new Runnable() {
			@Override
			public void run() {
				isAllowCallback = true;
				if (error == null) {
					setVisibility(View.GONE);
					rlLoadingMain.setVisibility(View.GONE);
					return;
				}
				if (pIsShowFreshBtn) {
					tv_fresh.setVisibility(View.VISIBLE);
				} else {
					tv_fresh.setVisibility(View.GONE);
				}

				if (!TextUtils.isEmpty(errorDesc)) {
					txtLoadingErrMiaoShu.setVisibility(View.GONE);
				} else {
					txtLoadingErrMiaoShu.setText(errorDesc);
					txtLoadingErrMiaoShu.setVisibility(View.VISIBLE);
				}				
				ll_loadding.setVisibility(View.GONE);
				setVisibility(View.VISIBLE);
				rlLoadingMain.setVisibility(View.VISIBLE);
				ll_loading_top.setVisibility(View.VISIBLE);
				txtLoadingErr.setText(error);

				if (icon == 0) {
					imgMain.setVisibility(View.GONE);
				} else {
					imgMain.setVisibility(View.VISIBLE);
					imgMain.setImageResource(icon);
					LayoutParams lp = (LayoutParams) imgMain.getLayoutParams();
					lp.width = DisplayUtil.dip2px(mContext, width);
					lp.height = DisplayUtil.dip2px(mContext, height);
					imgMain.setLayoutParams(lp);
				}
			}
		});
	}
}
