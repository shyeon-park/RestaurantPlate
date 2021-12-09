package utils;

import java.util.Random;

public class AuthNumberCreate {
	   
	 public String AuthNumberCreate(int certNumLength) {
   	 //중복방지
       Random random = new Random(System.currentTimeMillis());
      
       //인증 번호 자리수를 제곱하여서 Range를 구한다. 
       int range = (int)Math.pow(10,certNumLength);  //10*10^6 ==> 10^7
       int trim = (int)Math.pow(10, certNumLength-1); //10*10^5 == 10^6
       int result = random.nextInt(range)+trim;
        
       // 결과값이 range보다 높다면 빼줘서 자리수를 맞춘다.
       if(result>range){ 
           result = result - trim;
       }
       //형변환
       return String.valueOf(result);
   }


}
