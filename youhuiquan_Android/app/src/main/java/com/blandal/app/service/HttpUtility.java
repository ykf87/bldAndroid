package com.blandal.app.service;


import com.blandal.app.BuildConfig;

public class HttpUtility {

	public static boolean isOutLog = !BuildConfig.BUILD_TYPE.equals("release");

}
