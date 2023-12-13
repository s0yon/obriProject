package music.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
	// BCryptPasswordEncoder 주입
	@Autowired
	BCryptPasswordEncoder passwordEncoder;	
	
	// 네이버 로그인
	public int insertScMem(memberVO mb) throws Exception {
		return md.insertScMem(mb);
	}

	// 아이디 정보 확인
	@Override
	public memberVO checkId(String userId) throws Exception {
		return md.checkId(userId);
	}
	
	// 아이디 중복확인(Ajax)
	@Override
	public int checkMemId(String userId) throws Exception {
		return md.checkMemId(userId);
	}
	
	// 회원 가입(저장) + 인증 메일 발송
	@Override
	public void insertMem(memberVO mb) throws Exception {
		// 1. 랜덤 문자열을 생성해 mailKey에 저장
		String mailKey = new tempKey().getKey(30, false);	// 랜덤키 길이 설정
		mb.setMailKey(mailKey);
		
		// 2. 회원 가입
		md.insertMem(mb);
		
		// 3. 회원 가입 시 인증 메일 발송
		mailHandler sendMail = new mailHandler(mailSender);
		sendMail.setSubject("[오브리 인증 메일입니다.]"); // 메일 제목
		sendMail.setText(
				"<h1>오브리 메일 인증</h1>" +
				"<br>오브리에 오신 것을 환영합니다." +
				"<br>아래 [이메일 인증 확인]을 눌러주세요." +
				"<br><a href='http://localhost/obriProject/registerMail.do?userEmail=" +
				mb.getUserEmail() + "&mailKey=" + mailKey +
				"' target='_blank'>이메일 인증 확인</a>");
		sendMail.setFrom("info0obri@gmail.com", "오브리");
		sendMail.setTo(mb.getUserEmail());
		sendMail.send();
	}

	// 메일 인증키 저장
	@Override
	public int updateMailKey(memberVO mb) throws Exception {
		return md.updateMailKey(mb);
	}
	
	// 메일 인증 시 권한 변경
	@Override
	public int updateMailAuth(memberVO mb) throws Exception {
		return md.updateMailAuth(mb);
	}

	// 아이디 찾기
	@Override
	public memberVO findIdCheck(memberVO m) throws Exception {
		return md.findIdCheck(m);
	}
	
	// 비밀번호 찾기
	@Override
	public memberVO findPwCheck(memberVO m) throws Exception {
		return md.findPwCheck(m);
	}

	// 비밀번호 초기화
	@Override
	public void updatePw(memberVO mb) throws Exception {
		
		// 1. 랜덤 문자열을 생성해 임시 비밀번호 저장
		String tempPw = new tempKey().getKey(6, false);	// 랜덤키 길이 설정
		
		// 비밀번호 암호화
		String encpw = passwordEncoder.encode(tempPw);
		mb.setUserPw(encpw);
//		mb.setUserPw(tempPw);
		
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

	// 회원정보 수정
	@Override
	public void updateMem(memberVO member) throws Exception {
		md.updateMem(member);
	}
	
	// 비밀번호 변경
	public void updateMemPw(memberVO mb) throws Exception {
		md.updateMemPw(mb);
	}

	// 회원탈퇴
	public void deleteMem(memberVO m) throws Exception {
		md.deleteMem(m);
	}

}
