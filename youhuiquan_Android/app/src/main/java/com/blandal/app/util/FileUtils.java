package com.blandal.app.util;

import android.content.Context;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.security.MessageDigest;

/**
 * 
 ****************************************** 
 * @author 程章伟
 * @文件名称 : FileUtils.java
 * @创建时间 : 2015年3月24日
 * @文件描述 : 文件工具类
 ****************************************** 
 */
public class FileUtils {
	private static MappedByteBuffer[] mappedByteBuffers;
	private static int bufferCount;

	/**
	 * 读取渠道名配置文件
	 * 
	 * @param context
	 * @return
	 */
	public static String getQDFile(Context context) {
		try {
			InputStream in = context.getResources().getAssets()
					.open("ChannelConfig.json");
			BufferedReader br = new BufferedReader(new InputStreamReader(in,
					"UTF-8"));
			String str = br.readLine();
			br.close();
			in.close();
			return str;
		} catch (IOException e) {

		}
		return null;
	}

	// 写， 读data/data/目录(相当AP工作目录)上的文件，用openFileOutput
	/**
	 * 写文件在./data/data/<package name>/files/下面
	 * 
	 * @param fileName
	 * @param message
	 */

	public synchronized static boolean writeFileData(Context context,
                                                     String fileName, String message) {

		try {

			FileOutputStream fout = context.openFileOutput(fileName,
					Context.MODE_PRIVATE);

			byte[] bytes = message.getBytes();

			fout.write(bytes);

			fout.close();

			bytes = null;

			return true;
		}

		catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	/**
	 * 读取 /data/data/<package name>/files/fileName.txt中的数据
	 * 
	 * @param fileName
	 * @return
	 */

	public synchronized static String readFileData(Context context,
                                                   String fileName) {

		StringBuffer res = new StringBuffer();

		try {

			FileInputStream fin = context.openFileInput(fileName);

			InputStreamReader read = new InputStreamReader(fin, "UTF-8");// 考虑到编码格式

			BufferedReader bufferedReader = new BufferedReader(read);

			String lineTxt = null;

			while ((lineTxt = bufferedReader.readLine()) != null) {
				res.append(lineTxt);
			}

			bufferedReader.close();

			read.close();

			fin.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return res.toString();
	}

	/**
	 * File2byte
	 * 
	 * @param filePath
	 * @return
	 */
	public static byte[] File2byte(String filePath) {
		byte[] buffer = null;
		try {
			File file = new File(filePath);
			FileInputStream fis = new FileInputStream(file);
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			byte[] b = new byte[1024];
			int n;
			while ((n = fis.read(b)) != -1) {
				bos.write(b, 0, n);
			}
			fis.close();
			bos.close();
			buffer = bos.toByteArray();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return buffer;
	}

	/**
	 * 获取单个文件的MD5值！
	 * @param file
	 * @return
	 * 解决首位0被省略问题
	 * 解决超大文件问题
	 */
	public static String getFileMD5(File file) {

		StringBuffer stringbuffer = null;
		try {
			char[] hexDigits = { '0', '1', '2','3', '4','5', '6','7','8', '9', 'a','b' ,'c', 'd','e', 'f' };
			FileInputStream in = new FileInputStream(file);
			FileChannel ch = in.getChannel();

			long fileSize = ch.size();
			bufferCount = (int) Math.ceil((double) fileSize / (double) Integer.MAX_VALUE);
			mappedByteBuffers = new MappedByteBuffer[bufferCount];

			long preLength = 0;
			long regionSize = Integer.MAX_VALUE;
			for (int i = 0; i < bufferCount; i++) {
				if (fileSize - preLength < Integer.MAX_VALUE) {
					regionSize = fileSize - preLength;
				}
				mappedByteBuffers[i] = ch.map(FileChannel.MapMode.READ_ONLY, preLength, regionSize);
				preLength += regionSize;
			}

			MessageDigest messagedigest = MessageDigest.getInstance("MD5");

			for(int i = 0; i < bufferCount; i ++){
				messagedigest.update(mappedByteBuffers[i]);
			}
			byte[] bytes = messagedigest.digest();
			int n = bytes.length;
			stringbuffer = new StringBuffer(2 * n);
			for (int l = 0; l < n; l++) {
				byte bt = bytes[l];
				char c0 = hexDigits[(bt & 0xf0) >> 4];
				char c1 = hexDigits[bt & 0xf];
				stringbuffer.append(c0);
				stringbuffer.append(c1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return stringbuffer.toString();

	}

}
