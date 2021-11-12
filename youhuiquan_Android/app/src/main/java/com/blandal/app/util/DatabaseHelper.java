package com.blandal.app.util;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class DatabaseHelper extends SQLiteOpenHelper {

	/**
	 * 数据库名称
	 */
	private static final String DB_NAME = "xianshijian.db";

	/**
	 * 数据库版本 2015年6月4日 11:08 版本变成2 主要更新Chats 添加了扩展字段 json 3、雇主用户合并，重新创建新表
	 * version 5 to 6 加一个 SignId 加一个签到id version 7 2015年11月5日14:21:06 加一个临时用户表 8
	 * version 8：2015年12月11日 15:45 创建本地群发表 version 9：2015年12月18日12:02 增加TaskId
	 * version 11：添加岗位阅读记录 version 12：2016年1月13日17:45增加群主相关功能 version 14：添加任务岗位阅读记录
	 */
	private static final int version = 15;

	/**
	 * 创建消息列表页面
	 */
	String creatMsgListSql = "CREATE TABLE if not exists MsgList(ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,Title varchar(100) NOT NULL DEFAULT '',Content varchar(500) NOT NULL DEFAULT '',ImgUrl varchar(500) NOT NULL DEFAULT '',MsgCount int NOT NULL DEFAULT 0,OwnUserId int NOT NULL DEFAULT 0,SendUserId int NOT NULL DEFAULT 0,MsgType int NOT NULL DEFAULT 0,RefreshTime long NOT NULL DEFAULT 0,ToType int NOT NULL DEFAULT 0,TaskId int NOT NULL DEFAULT 0,GroupId int NOT NULL DEFAULT 0,GroupUuid varchar(100) NOT NULL DEFAULT '',jsonchar varchar(2048) NOT NULL DEFAULT '');";

	/**
	 * 创建聊天内容表
	 */
	String creatChatsSql = "CREATE TABLE if not exists Chats(ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,OwnUserId int NOT NULL DEFAULT 0,SendUserId int NOT NULL DEFAULT 0,Content varchar(500) NOT NULL DEFAULT '',FriendId int NOT NULL DEFAULT 0,MsgTime long NOT NULL DEFAULT 0,IsMeMsg int NOT NULL DEFAULT 0,MsgType int NOT NULL DEFAULT 0,expand1 varchar(100) NOT NULL DEFAULT '',expand2 varchar(100) NOT NULL DEFAULT '',expand3 varchar(100) NOT NULL DEFAULT '',jsonchar varchar(2048) NOT NULL DEFAULT '',ToType int NOT NULL DEFAULT 0,SignId int NOT NULL DEFAULT 0,GroupId int NOT NULL DEFAULT 0);";

	/**
	 * 创建静音表
	 */
	String creatSilentListSql = "CREATE TABLE if not exists SilentList(ID  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,OwnUserId int NOT NULL DEFAULT 0,SendUserId int NOT NULL DEFAULT 0,ToType int NOT NULL DEFAULT 0);";

	/**
	 * 创建临时用户表
	 */
	String creatTemporaryUsersSql = "CREATE TABLE if not exists TemporaryUsers(ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,AccountId int NOT NULL DEFAULT 0,UserType int NOT NULL DEFAULT 1,UserNm varchar(100) NOT NULL DEFAULT '',Telephone varchar(100) NOT NULL DEFAULT '',HeadUrl   	varchar(500) NOT NULL DEFAULT '',Uuid   	varchar(500) NOT NULL DEFAULT '',ResumeId   	int NOT NULL DEFAULT 0,EntInfoId   	int NOT NULL DEFAULT 0,jsonchar varchar(2048) NOT NULL DEFAULT '');";

	/**
	 * 创建群发表
	 */
	String creatGroupChats = "CREATE TABLE if not exists GroupChats(ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,OwnUserId int NOT NULL DEFAULT 0,TaskId int NOT NULL DEFAULT 0,Title varchar(200) NOT NULL DEFAULT '',Content varchar(1024) NOT NULL DEFAULT '',CreateTime long NOT NULL DEFAULT 0,jsonchar varchar(2048) NOT NULL DEFAULT '',ToType int NOT NULL DEFAULT 0);";

	/**
	 * 添加岗位阅读记录
	 */
	String creatJobReadRecord = "CREATE TABLE if not exists JobReadRecord(ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,TaskId int NOT NULL DEFAULT 0,CreateTime long NOT NULL DEFAULT 0);";

	/**
	 * 添加任务岗位阅读记录
	 */
	String creatZhaiTaskReadRecord = "CREATE TABLE if not exists ZhaiTaskReadRecord(ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,TaskId long NOT NULL DEFAULT 0,CreateTime long NOT NULL DEFAULT 0);";

	public DatabaseHelper(Context context) {
		super(context, DB_NAME, null, version);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {

		db.execSQL(creatMsgListSql);

		// 好友申请添加记录
		String sql6 = "CREATE TABLE if not exists FriendApplys(ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,   FriendNm varchar(100) NOT NULL DEFAULT '',   Message varchar(500) NOT NULL DEFAULT '',   MessageId varchar(100) NOT NULL DEFAULT '',   UUID varchar(500) NOT NULL DEFAULT '',   PhotoUrl   	varchar(500) NOT NULL DEFAULT '',		   OwnUserId   	int NOT NULL DEFAULT 0,   SendUserId   	int NOT NULL DEFAULT 0,Status   	int NOT NULL DEFAULT 0,   RefreshTime   	long NOT NULL DEFAULT 0	);";
		db.execSQL(sql6);

		// 好友列表
		String sql2 = "CREATE TABLE if not exists Friends(ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,   AccountId varchar(100) NOT NULL DEFAULT '',   AddTime   	long NOT NULL DEFAULT 0,	   FriendNm varchar(100) NOT NULL DEFAULT '',   FriendRm varchar(100) NOT NULL DEFAULT '',   Telephone varchar(100) NOT NULL DEFAULT '',   HeadUrl   	varchar(500) NOT NULL DEFAULT '',		   Uuid   	varchar(500) NOT NULL DEFAULT '',   OwnUserId   	int NOT NULL DEFAULT 0,   ResumeId   	int NOT NULL DEFAULT 0,		   FirstStr   	varchar(10) NOT NULL DEFAULT '',	Expand   	varchar(500) NOT NULL DEFAULT ''	);";
		db.execSQL(sql2);

		// 关注的企业列表
		String sqlCreatFocusEnt = "CREATE TABLE if not exists FocusEnts(   ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,   AccountId varchar(100) NOT NULL DEFAULT '',   AddTime   	long NOT NULL DEFAULT 0,	   FriendNm varchar(100) NOT NULL DEFAULT '',   FriendRm varchar(100) NOT NULL DEFAULT '',   Telephone varchar(100) NOT NULL DEFAULT '',   HeadUrl   	varchar(500) NOT NULL DEFAULT '',		   Uuid   	varchar(500) NOT NULL DEFAULT '',   OwnUserId   	int NOT NULL DEFAULT 0,	EntInfoId   	int NOT NULL DEFAULT 0, SaveType   	int NOT NULL DEFAULT 0 ,	   FirstStr   	varchar(10) NOT NULL DEFAULT '',Expand   	varchar(500) NOT NULL DEFAULT ''	);";
		db.execSQL(sqlCreatFocusEnt);

		// 聊天内容
		db.execSQL(creatChatsSql);

		// 静音表
		db.execSQL(creatSilentListSql);

		// 字典表存万能数据
		String sql7 = "CREATE TABLE if not exists Dicts(ID  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,   OwnUserId int NOT NULL DEFAULT 0, Content  varchar(500) NOT NULL DEFAULT '',    AddTime long NOT NULL DEFAULT 0,   DictType int NOT NULL DEFAULT 0, expand varchar(500) NOT NULL DEFAULT '' );";
		db.execSQL(sql7);

		// 创建临时用户表
		db.execSQL(creatTemporaryUsersSql);

		// 创建群发表
		db.execSQL(creatGroupChats);

		// 创建岗位阅读记录
		db.execSQL(creatJobReadRecord);

		// 创建任务岗位阅读记录
		db.execSQL(creatZhaiTaskReadRecord);
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

		// 重新创建消息列表
		db.execSQL(creatMsgListSql);

		// 重新创建消聊天内容表
		db.execSQL(creatChatsSql);

		// 创建静音表
		db.execSQL(creatSilentListSql);

		// 2015年11月5日14:24:14 加了用户临时表
		db.execSQL(creatTemporaryUsersSql);

		// 创建群发表2015年12月11日 17:48
		db.execSQL(creatGroupChats);

		// 创建岗位阅读记录 2015年12月29日 17:15:11
		db.execSQL(creatJobReadRecord);
		
		// 创建任务岗位阅读记录2017年1月5日 14:12:11
		db.execSQL(creatZhaiTaskReadRecord);

		// 2016年1月13日17:47:18 增加群聊相关支持
		try {
			//2019年8月14日 11:11 更新 用户助手通知为系统通知
			db.execSQL("UPDATE MsgList set SendUserId = -101 where SendUserId = -102");
			db.execSQL("UPDATE Chats set SendUserId = -101 where SendUserId = -102");

			db.execSQL("ALTER TABLE MsgList ADD GroupId int NOT NULL DEFAULT 0");
			db.execSQL("ALTER TABLE MsgList ADD GroupUuid varchar(100) NOT NULL DEFAULT ''");
			db.execSQL("ALTER TABLE MsgList ADD jsonchar varchar(2048) NOT NULL DEFAULT ''");
			db.execSQL("UPDATE MsgList set GroupId = 0");
			db.execSQL("UPDATE MsgList set GroupUuid = ''");
			db.execSQL("UPDATE MsgList set jsonchar = ''");

			db.execSQL("ALTER TABLE Chats ADD GroupId int NOT NULL DEFAULT 0");
			db.execSQL("UPDATE Chats set GroupId = 0");
		} catch (Exception e) {
		}

		// 2016年1月29日 11:32:58 chats加一个ToType
		try {
			// Chats加一个ToType
			db.execSQL("ALTER TABLE Chats ADD ToType int NOT NULL DEFAULT 0");
			db.execSQL("UPDATE Chats set ToType = 0");
		} catch (Exception e) {
		}

		// 2015年12月29日14:34 MsgList加一个ToType
		try {
			// MsgList加一个ToType
			db.execSQL("ALTER TABLE MsgList ADD ToType int NOT NULL DEFAULT 0");
			db.execSQL("UPDATE MsgList set ToType = 0");
		} catch (Exception e) {
		}

		// 2015年12月18日12:03 MsgList加一个TaskId
		try {
			// MsgList加一个TaskId
			db.execSQL("ALTER TABLE MsgList ADD TaskId int NOT NULL DEFAULT 0");
			db.execSQL("UPDATE MsgList set TaskId = 0");
		} catch (Exception e) {
		}

		// 2015年10月22日 17:02:08 加一个打卡ID
		try {
			// 加一个打卡ID
			db.execSQL("ALTER TABLE Chats ADD SignId int NOT NULL DEFAULT 0");
			db.execSQL("UPDATE Chats set SignId = 0");
		} catch (Exception e) {
		}
	}

	public static SQLiteDatabase db;

	public static Object objLockDb = new Object();

	/**
	 * 打开数据库连接
	 * 
	 */
	public synchronized static void openDb(Context mContext) {
		if (db == null || db.isOpen() == false) {
			DatabaseHelper databaseHelper = new DatabaseHelper(mContext);
			db = databaseHelper.getWritableDatabase();
		}
	}
}
