package utils;

import java.util.Base64.Decoder;
import java.util.Base64.Encoder;
import java.io.*;
import java.util.*;
import java.security.*;
import java.net.*;
import java.util.Base64;
public class SmsSend {

		public static String nullcheck(String str,  String Defaultvalue ) throws Exception {
			  String ReturnDefault = "" ;
			  if (str == null) {
			    ReturnDefault =  Defaultvalue ;
			  }
			  else if (str == "" ) {
			    ReturnDefault =  Defaultvalue ;
			  }
			  else {
			    ReturnDefault = str ;
			  }
			    return ReturnDefault ;
			}
			/**
			* BASE64 Encoder
			* @param str
			* @return
			*/
			public static String base64Encode(String str)  throws java.io.IOException {
			  Encoder encoder = Base64.getEncoder();
			    byte[] strByte = str.getBytes("UTF-8");
			    String result = encoder.encodeToString(strByte);
			    return result ;
			}

			/**
			  * BASE64 Decoder
			  * @param str
			  * @return
			  */
			public static String base64Decode(String str)  throws java.io.IOException {
			  Decoder decoder = Base64.getDecoder();
			    byte[] strByte = decoder.decode(str);
			    String result = new String(strByte);
			    return result ;
			}

}
