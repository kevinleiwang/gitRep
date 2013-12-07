package com.sunivo.lgs.web.util;

import java.io.ObjectInputStream;
import java.security.Key;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.Cipher;

import org.apache.log4j.Logger;
import org.springframework.core.io.ClassPathResource;

import com.sunivo.lgs.web.base.configurer.MemoryPropertyPlaceholderConfigurer;




//import sun.misc.BASE64Encoder;



public class AESSecurity {

	static Logger logger=Logger.getLogger("AESSecurity");
	private static Map<String,Cipher>keyMap=new HashMap<String,Cipher>();
	
	static String encodeKey="encodeKey";
	static String decodeKey="decodeKey";
	static {
		
			try {
				initalMap();
			} catch (Exception e) {
			logger.error("初始化安全信息工具出错", e);
			}
		
	}

	private  static void initalMap() throws Exception {
		if(keyMap.isEmpty()){
			
			Cipher encipher = Cipher.getInstance("AES");
			Cipher decipher = Cipher.getInstance("AES");

	
			//FileInputStream fisKey = new FileInputStream("/secretKey.key");
			ClassPathResource resource=new ClassPathResource("secretKey.key");
			
			ObjectInputStream oisKey = new ObjectInputStream(resource.getInputStream());
			Key key = (Key) oisKey.readObject();
			oisKey.close();
			encipher.init(Cipher.ENCRYPT_MODE, key);
			decipher.init(Cipher.DECRYPT_MODE, key);
			
			keyMap.put(encodeKey, encipher);
			keyMap.put(decodeKey, decipher);
		}
	}

	public static byte[] secretEncrypt(String content) throws Exception {
		
		Cipher cipher = keyMap.get(encodeKey);
		byte[] encodeResult = cipher.doFinal(content.getBytes());		
		return encodeResult;

	} 

	
	public static String secretDecrypt(byte[]content) throws Exception {
		
		Cipher cipher = keyMap.get(decodeKey);
		// 执行解密
		byte[] decodeResult = cipher.doFinal(content);
		String result=new String(decodeResult);
		return result;
	}

	public static byte[] secretEncrypt() throws Exception {

		String name = MemoryPropertyPlaceholderConfigurer
				.getContextProperty("wsusername");
		String pass = MemoryPropertyPlaceholderConfigurer
				.getContextProperty("wspassword");

		return secretEncrypt(name + ":" + pass);
	} 
	public static boolean isValidateAuthority(byte[] content) {
		if (null == content) {
			return false;
		}
		try {
			String validateCode = secretDecrypt(content);
			String userName = (String) MemoryPropertyPlaceholderConfigurer
					.getContextProperty("wsusername");
			String pass = (String) MemoryPropertyPlaceholderConfigurer
					.getContextProperty("wsusername");
			String localCode = userName + ":" + pass;
			if (localCode.equalsIgnoreCase(validateCode));
			{
				return true;
			}

		} catch (Exception e) {
			logger.error("验证客户端信息异常:", e);
			e.printStackTrace();
			return false;
		}
	}

}
