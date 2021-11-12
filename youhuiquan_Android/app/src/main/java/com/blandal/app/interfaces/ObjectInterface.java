package com.blandal.app.interfaces;

import android.view.View;

public class ObjectInterface {

	/**
	 * 万能的回调方法
	 */
	public interface ObjReturnMet {
		void callback(Object obj);
	}

	public interface ObjReturnMet2 {
		void callback(Object obj, Object obj2);
	}

	public interface ObjReturnMet3 {
		void callback();
	}

	public interface ObjReturnMet4 {
		void callback(int viewId, Object obj);
	}
	
	public interface ObjReturnMet5 {
		void callback(View view, Object obj);
	}

	public interface BooleanReturnMet {
		void callback(boolean b);
	}

	/**
	 * 回复接口
	 */
	public interface EntAnswerClickListener {
		void OnEntAnswerClick(long question_id, String answer);
	}

	/**
	 * 选择城市区域的回调
	 */
	public interface SelAreaCallback {
		void callback(int cityId, int areaId, String cityNm, String areaNm);
	}

	/**
	 * 添加方法对象 or 补录人员的控件 接口
	 * 
	 * @author chengzhangwei
	 * 
	 */
	public interface ManualMakeupItemLayoutInterface {
		/**
		 * 删除回调方法
		 * 
		 * @param pManualMakeupItemLayout
		 */
		//void delCallback(ManualMakeupItemLayout pManualMakeupItemLayout);
	}

	/**
	 * 键盘的隐藏和显示回调
	 * 
	 * @author chengzhangwei
	 * 
	 */
	public interface KeyboardHiddenShowInterface {

		/**
		 * 键盘显示
		 */
		void showCallback();

		/**
		 * 键盘隐藏
		 */
		void hideCallback();
	}

}
