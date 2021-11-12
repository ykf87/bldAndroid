package com.blandal.app.util;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;

import java.util.List;

import com.blandal.app.ui.main.entity.HomeTaskEntity;

/**
 * 任务是否阅读过
 */
public class JobReadRecordUtil {

	/**
	 * 表名
	 */
	private String tabName = "JobReadRecord";

	private Context context;

	/**
	 * 岗位阅读记录本地缓存类
	 */
	private static JobReadRecordUtil jobReadRecordUtil;

	/**
	 * 获取岗位阅读记录本地缓存类对象
	 * 
	 * @param pContext
	 * @return
	 */
	public static JobReadRecordUtil getJobReadRecordUtil(Context pContext) {
		if (jobReadRecordUtil == null) {
			jobReadRecordUtil = new JobReadRecordUtil(pContext);
		}
		return jobReadRecordUtil;
	}

	public JobReadRecordUtil(Context pContext) {
		context = pContext;
	}

	/**
	 * 岗位id是否在缓存表里面
	 * 
	 * @param pTaskId
	 * @return
	 */
	public static boolean isExistTaskId(Context pContext, long pTaskId) {

		if (pTaskId < 1)
			return false;

		return getJobReadRecordUtil(pContext).getCount("TaskId=" + pTaskId) > 0;
	}

	/**
	 * 插入数据
	 */
	public static void insertData(Context pContext, int pTaskId) {

		if (pTaskId < 1)
			return;

		if (isExistTaskId(pContext, pTaskId))
			return;

		getJobReadRecordUtil(pContext).insertData(pTaskId);
	}

	/**
	 * 插入数据
	 */
	public void insertData(int pTaskId) {

		if (pTaskId < 1)
			return;

		synchronized (DatabaseHelper.objLockDb) {
			DatabaseHelper.openDb(context);
			ContentValues cvOfLiHua = new ContentValues();
			cvOfLiHua.put("TaskId", pTaskId);
			cvOfLiHua.put("CreateTime", 0);
			DatabaseHelper.db.insert(tabName, null, cvOfLiHua);
		}
	}

	/**
	 * 查询总条数
	 * 
	 * @return
	 */
	public int getCount(String where) {
		synchronized (DatabaseHelper.objLockDb) {
			DatabaseHelper.openDb(context);
			String sql = "select count(*) from " + tabName;
			if (where != null)
				sql += " where " + where;
			Cursor c = DatabaseHelper.db.rawQuery(sql, null);
			c.moveToFirst();
			int length = c.getInt(0);
			c.close();
			return length;
		}
	}

	/**
	 * 查询数据
	 * @return
	 */
	public int getDelMinId() {
		synchronized (DatabaseHelper.objLockDb) {
			DatabaseHelper.openDb(context);

			String sql = "select * from " + tabName;

			sql += " ORDER BY ID ASC limit ? offset ?";

			int starIndex = 100;

			// 查询表中的数据
			Cursor cursor = DatabaseHelper.db.rawQuery(sql, new String[] {
					1 + "", starIndex + "" });

			int returnId = -1;

			for (cursor.moveToFirst(); !(cursor.isAfterLast()); cursor
					.moveToNext()) {
				returnId = cursor.getInt(cursor.getColumnIndex("ID"));
				break;
			}

			cursor.close();

			return returnId;
		}
	}

	public void mExecSQL(String sql) {
		synchronized (DatabaseHelper.objLockDb) {
			DatabaseHelper.openDb(context);
			DatabaseHelper.db.execSQL(sql);
		}
	}

	/**
	 * 查询总页数
	 * 
	 * @return
	 */
	public int gePage(int pageNumber, String where) {
		int count = getCount(where);
		return ((count + 1) / pageNumber);
	}

	/**
	 * 删除超过条数的岗位阅读记录
	 */
	public static void delExceedData(final Context pContext) {
		new Thread(new Runnable() {
			@Override
			public void run() {
				JobReadRecordUtil util = getJobReadRecordUtil(pContext);
				int delMinId = util.getDelMinId();
				if (delMinId < 1) {
					return;
				}
				util.mExecSQL("delete from JobReadRecord where id <" + delMinId);
			}
		}).start();
	}


	/**
	 * 判断岗位是否阅读过,建议在线程里面调用
	 *
	 * @param pDatas
	 */
	public static void judgmentTaskRead(Context mContext, List<HomeTaskEntity> pDatas) {

		if (pDatas == null || pDatas.size() < 1) {
			return;
		}

		for (HomeTaskEntity data : pDatas) {
			data.isReadTask = JobReadRecordUtil.isExistTaskId(mContext,
					data.getTask_id());
		}
	}
}
