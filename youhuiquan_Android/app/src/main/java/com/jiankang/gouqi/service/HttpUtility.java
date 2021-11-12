package com.jiankang.gouqi.service;


import com.jiankang.gouqi.BuildConfig;

public class HttpUtility {

	public static boolean isOutLog = !BuildConfig.BUILD_TYPE.equals("release");

}
