package music.model;

import java.util.Date;

import lombok.Data;

@Data
public class memberVO {
	private String userId;
	private String userPw;
	private String userName;
	private String userPhone;
	private String userEmail;
	private String userMajor;
	private char userGru;
	private Date userDate;
	private Date userUpdate;
	private char userDelYn;
	private char mailAuth;
	private String mailKey;
}
