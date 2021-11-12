package com.blandal.app.util.lifephotosbrowse;


import org.apache.http.conn.ConnectTimeoutException;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import com.blandal.app.util.DisplayUtil;

/**
 * 网络访问类
 * 
 * @author chengzhangwei
 * 
 */
public class HttpConnet {

	private static final int TIME = 1000 * 20;

	/**
	 * 检查网络状态并且发送请求
	 * 
	 * @param path
	 *            请求地址
	 * @param queryString
	 *            文件名字
	 * @param context
	 *            当前上下文（当前activity）
	 * @return 服务器返回的结果，
	 */

	private static Object lock = new Object();

	public byte[] checkGet(String path) {

		byte[] result = null;

		// 保证同一时刻只能有一个线程请求
		synchronized (lock) {
			try {
				result = doGet(path);
			} catch (ConnectTimeoutException e) {
			} catch (Exception e) {
			}
		}
		return result;
	}

	/**
	 * get请求，用于下载图片
	 * 
	 * @param path
	 *            图片地址
	 * @param queryString
	 *            图片的名字
	 * @return
	 */
	byte[] buffer = null;

	private byte[] doGet(String path) throws ConnectTimeoutException, Exception {

		HttpURLConnection conn = null;

		if (path != null && path.length() > 0) {

			try {
				// path = URLEncoder.encode(path, "utf8");
				URL url = new URL(path);
				conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("GET");
				conn.setDoInput(true);
				conn.setConnectTimeout(TIME);
				conn.connect();

				int length = conn.getContentLength();

				if (conn.getResponseCode() == 200) {
					InputStream inStream = conn.getInputStream();
					ByteArrayOutputStream outSteam = new ByteArrayOutputStream();
					buffer = new byte[length];
					System.gc();
					int len = 0;

					try {
						while ((len = inStream.read(buffer)) != -1) {
							outSteam.write(buffer, 0, len);
						}
					} catch (OutOfMemoryError o) {
					}

					buffer = null;
					outSteam.close();
					inStream.close();
					byte[] b = outSteam.toByteArray();
					return b;
				}
			} catch (Exception e) {
				DisplayUtil.outLog(e.getMessage());
			} finally {
				try {
					conn.disconnect();
				} catch (Exception e) {
				}
			}
		}

		return null;
	}
}
