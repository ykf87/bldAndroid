package com.blandal.app.util.coder;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.KeyGenerator;
import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

/**
 * @projectName:usercenter-secure
 * @Description: 基础加密组件
 * @author:CHENW_YH
 * @date:2014-7-22 上午10:11:41
 * @alterHistory:
 * @version:
 */
public abstract class Coder {

	public static final String KEY_SHA = "SHA";
	public static final String KEY_SHA1 = "SHA1";
	public static final String KEY_MD5 = "MD5";

	/**
	 * MAC算法可选以下多种算法
	 * 
	 * <pre>
	 * HmacMD5 
	 * HmacSHA1 
	 * HmacSHA256 
	 * HmacSHA384 
	 * HmacSHA512
	 * </pre>
	 */
	public static final String KEY_MAC = "HmacMD5";

	/**
	 * MD5加密
	 * 
	 * @param data
	 * @return
	 * @throws Exception
	 */
	public static byte[] encryptMD5(byte[]... datas) {
		if (datas.length == 0) {
			return null;
		}
		try {
			MessageDigest md5 = MessageDigest.getInstance(KEY_MD5);
			for (byte[] data : datas) {
				md5.update(data);
			}
			return md5.digest();
		} catch (NoSuchAlgorithmException e) {
			return null;
		}
	}

	/**
	 * MD5加密
	 * 
	 * @param data
	 * @return
	 * @throws Exception
	 */
	public static byte[] encryptMD5(String data) {
		try {
			return encryptMD5(data.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			return null;
		}
	}

	/**
	 * Md5 加密
	 * 
	 * @param data
	 * @return 返回二进制数组16进制大写
	 * @throws IOException
	 */
	public static String hexEncryptMD5By16(String data) {
		return HexUtil.bytesToHexString(encryptMD5(data)).substring(8, 24);
	}

	/**
	 * Md5 加密
	 * 
	 * @param data
	 * @return 返回二进制数组16进制大写
	 * @throws IOException
	 */
	public static String hexEncryptMD5By32(String data) {
		return HexUtil.bytesToHexString(encryptMD5(data));
	}

	/**
	 * SHA加密
	 * 
	 * @param data
	 * @return
	 * @throws Exception
	 */
	public static byte[] encryptSHA(byte[] data) throws Exception {
		MessageDigest sha = MessageDigest.getInstance(KEY_SHA);
		sha.update(data);
		return sha.digest();
	}

	/**
	 * SHA加密
	 * 
	 * @param data
	 * @return
	 * @throws Exception
	 */
	public static byte[] encryptSHA(String data) throws Exception {
		return encryptSHA(data.getBytes("UTF-8"));
	}

	/**
	 * @Description: 签名
	 * @param datas
	 *            要签名的信息数组
	 * @return
	 */
	public static byte[] encryptSHA1(byte[]... datas) {

		if (datas == null || datas.length == 0) {
			return null;
		}
		try {
			MessageDigest sha1 = MessageDigest.getInstance(KEY_SHA1);
			for (byte[] data : datas) {
				sha1.update(data);
			}
			return sha1.digest();
		} catch (NoSuchAlgorithmException e) {
			return null;
		}
	}

	/**
	 * 初始化HMAC密钥
	 * 
	 * @return
	 * @throws Exception
	 */
	public static String initMacKey() throws Exception {
		KeyGenerator keyGenerator = KeyGenerator.getInstance(KEY_MAC);
		SecretKey secretKey = keyGenerator.generateKey();
		return HexUtil.bytesToHexString(secretKey.getEncoded());
	}

	/**
	 * HMAC加密
	 * 
	 * @param data
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public static byte[] encryptHMAC(byte[] data, String key) throws Exception {
		SecretKey secretKey = new SecretKeySpec(HexUtil.hexStringToBytes(key),
				KEY_MAC);
		Mac mac = Mac.getInstance(secretKey.getAlgorithm());
		mac.init(secretKey);
		return mac.doFinal(data);
	}
}
