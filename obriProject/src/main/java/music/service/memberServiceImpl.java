package music.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;


import music.dao.memberDaoImpl;
import music.mail.mailHandler;
import music.mail.tempKey;
import music.model.memberVO;

@Service
public class memberServiceImpl implements memberService{
	
	// DAO 주입
	@Autowired
	private memberDaoImpl md;
	
	// JavaMailSender 주입
	@Autowired
	JavaMailSender mailSender;
	
	// 아이디 존재 여부 확인
	@Override
	public memberVO checkId(String userId){
		return md.checkId(userId);
	}
	
	// 로그인 인증(메일)
	@Override
	public int emailAuthFail(String userId) throws Exception {
		return md.emailAuthFail(userId);
	}
	
	// 회원 가입 + 인증 메일 발송
	@Override
	public void insertMember(memberVO mb) throws Exception {
		// 1. 랜덤 문자열을 생성해 mailKey에 저장
		String mailKey = new tempKey().getKey(30, false);	// 랜덤키 길이 설정
		mb.setMailKey(mailKey);
		
		// 2. 회원 가입
		md.insertMember(mb);
		
		// 3. 회원 가입 시 인증 메일 발송
		mailHandler sendMail = new mailHandler(mailSender);
		sendMail.setSubject("[오브리 인증 메일입니다.]"); // 메일 제목
		sendMail.setText(
				"<h1>오브리 메일 인증</h1>" +
				"<br>오브리에 오신 것을 환영합니다." +
				"<br>아래 [이메일 인증 확인]을 눌러주세요." +
				"<br><a href='http://localhost/obriProject/registerEmail.do?userEmail=" +
				mb.getUserEmail() + "&mailKey=" + mailKey +
				"' target='_blank'>이메일 인증 확인</a>");
		sendMail.setFrom("info0obri@gmail.com", "오브리");
		sendMail.setTo(mb.getUserEmail());
		sendMail.send();
		
	}

	// 아이디 중복확인
	@Override
	public int checkMemberId(String userId) {
		return md.checkMemberId(userId);
	}
	
	// 이메일 인증 키 저장
	@Override
	public int updateMailKey(memberVO mb) throws Exception{
		return md.updateMailKey(mb);
	}
	
	// 이메일 인증 시 권한 변경
	@Override
	public int updateMailAuth(memberVO mb) throws Exception{
		return md.updateMailAuth(mb);
	}

	// 아이디 찾기
	@Override
	public memberVO findId(memberVO m) {
		return md.findId(m);
	}
	
	// 비밀번호 찾기
	@Override
	public memberVO findPw(memberVO m) {
		return md.findPw(m);
	}

	// 비밀번호 초기화
	@Override
	public void updatePw(memberVO mb) throws Exception{
		
		// 1. 랜덤 문자열을 생성해 임시 비밀번호 저장
		String tempPw = new tempKey().getKey(8, false);	// 랜덤키 길이 설정
		mb.setUserPw(tempPw);
		
		// 2. 초기화 메일 발송
		mailHandler sendMail = new mailHandler(mailSender);
		sendMail.setSubject("[오브리 임시 비밀번호 안내 메일입니다.]"); // 메일 제목
		sendMail.setText(
				"<h1>오브리 임시 비밀번호 안내</h1>" +
				"<br>아래 [임시 비밀번호]로 로그인하신 후 비밀번호를 변경해주세요." +
				"<br> 임시 비밀번호: " + tempPw);
		sendMail.setFrom("info0obri@gmail.com", "오브리");
		sendMail.setTo(mb.getUserEmail());
		sendMail.send();
		
		// 3. 임시 비밀번호로 변경 
		md.updatePw(mb);
		
	}
	
}
