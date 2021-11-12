package com.blandal.app.interfaces;

import android.graphics.Bitmap;
import android.widget.ImageView;
import android.widget.TextView;

public class AppInterfaces {


	/**
	 * 首页个人服务商人口回调方法
	 * 
	 * @author csy
	 * 
	 */
	public interface LineIndexPersonalServiceCallback {
		public void onClick();
	}

	/**
	 * 职位管理、个人服务、团队服务、推广服务点击回调
	 * 
	 * @author csy
	 * 
	 */
	public interface LibFragmentManagementTopCallback {
		public void onClick(TextView view, String text);
	}

	/**
	 * 回调方法，用于更新ui
	 * 
	 * @author csy
	 * 
	 */
	public interface ImageCallback {
		public void imageLoaded(ImageView view, Bitmap imageBitmap,
                                String queryString, int pWindowWidth, int pWindowHeight);
	}


	/**
	 * 键盘影藏弹出回调
	 * 
	 * @author Administrator
	 * 
	 */
	public interface KeyboardScrollInterface {
		/**
		 * 键盘显示
		 */
		void keyboardShow();

		/**
		 * 键盘隐藏
		 */
		void keyboardHide();
	}

	/**
	 * 点击登录后触发的回调
	 * 
	 * @author chengzhangwei
	 * 
	 */
	public interface ToLoginTipCallBackInterface {
		/**
		 * 点击登录后触发的回调
		 */
		void callback();
	}

	/**
	 * 页面触发回调
	 * 
	 * @author chengzhangwei
	 * 
	 */
	public interface ActivityCallBackInterface {
		/**
		 * 成功后回调
		 */
		void callback(Object obj);
	}

	/**
	 * 考勤管理，发放工资头部控件回调接口
	 */
	public interface WorkPayTopInterface {
		/**
		 * 左右单击事件
		 * 
		 * @param pIsLeft
		 */
		void onClick(boolean pIsLeft);

		/**
		 * 选择时间点击事件
		 */
		void onSelTimeClick();
	}

	/**
	 * 待办事项头部控件回调接口
	 */
	public interface SwichTopInterface {
		/**
		 * 左右单击事件
		 */
		void onClick(boolean pIsLeft);
	}

	/**
	 * 钱袋子流水页面适配器接口
	 * 
	 * @author Administrator
	 * 
	 */
	public interface WalletAdapterInterface {
		/**
		 * item的点击事件
		 */
		void onClick();
	}

	public interface FeedBackAdapterInterface {

		void onClick();
	}

	public interface PermissionCallback{
		void hasPermission();
		void noPermission();
		void alwaysNoPermission();
	}

	public interface InterfaceJobExperience {

		void editResume();

		void deleteResume();
	}

	public interface ObjReturnMet {
		void callback(Object obj);
	}
}
