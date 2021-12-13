package utils;

import java.util.Random;

public class AuthNumberCreate {

	private final char[] passwordTable = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
			'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
			'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' };

	private final char[] specialCharactersTable = { '!', '@', '#', '$', '%', '^', '&', '*' };
	private final char[] numberTable = { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };

	public String AuthNumberCreate(int certNumLength) {
		// 중복방지
		Random random = new Random(System.currentTimeMillis());

		// 인증 번호 자리수를 제곱하여서 Range를 구한다.
		int range = (int) Math.pow(10, certNumLength); // 10*10^6 ==> 10^7
		int trim = (int) Math.pow(10, certNumLength - 1); // 10*10^5 == 10^6
		int result = random.nextInt(range) + trim;

		// 결과값이 range보다 높다면 빼줘서 자리수를 맞춘다.
		if (result > range) {
			result = result - trim;
		}
		// 형변환
		return String.valueOf(result);
	}

	public String pwGenerate() {
		Random random = new Random(System.currentTimeMillis());
		StringBuffer buf = new StringBuffer();

		String english = ""; // 영문
		String specialCharacters = ""; // 특문
		String number = ""; // 숫자
		String ran = ""; // 셋중 암꺼나

		for (int i = 0; i < 2; i++) {
			english = String.valueOf(passwordTable[random.nextInt(passwordTable.length)]);
			specialCharacters = String.valueOf(specialCharactersTable[random.nextInt(specialCharactersTable.length)]);
			number = String.valueOf(numberTable[random.nextInt(numberTable.length)]);
			String[] pw = { english, specialCharacters, number };
			ran = String.valueOf(pw[random.nextInt(pw.length)]);
			buf.append(english + specialCharacters + number + ran);
		}
		return buf.toString();
	}

}
