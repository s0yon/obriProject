package music.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import music.mail.tempKey;
import music.model.memberVO;
import music.service.memberServiceImpl;

@Controller
public class MemberController {

	// Service 주입
	@Autowired
	private memberServiceImpl ms;
	// JavaMailSender 주입
	@Autowired
	JavaMailSender mailSender;
	// BCryptPasswordEncoder 주입
	@Autowired
	BCryptPasswordEncoder passwordEncoder;	
	
	// 카카오 소셜로그인
	@RequestMapping("joinKakaoMem.do")
	@ResponseBody
	public String joinKakaoMem(@RequestParam("userId") String userId,
							   @RequestParam("userName") String userName,
							   HttpSession session, memberVO member) throws Exception{
		
		// 카카오로부터 제공받은 정보 입력
		member.setUserId(userId);
		member.setUserName(userName);
		
		// 임의 비밀번호 생성 후 입력
		String userPw = new tempKey().getKey(10, false);
		member.setUserPw(userPw);
		
		// 나머지 항목 널값 입력
		member.setUserPhone(null);
		member.setUserEmail(null);
		
		// 이용자식별자(네이버로부터 제공받은 고유ID)로 연동기록 확인
		// 아이디로 조회해 객체를 불러옴
		memberVO mb = ms.checkId(userId);
				
		// 1. 연동기록이 없을 경우 가입
		if(mb == null) {
			// 1-1. 가입 성공
			if(ms.insertScMem(member) == 1) {
				session.setAttribute("userId", userId);
				return "Y";
			// 1-2. 가입 실패
			}else {
				return "E";
			}
		// 2. 연동기록이 있을 경우 상태에 따라 로그인 처리
		// 2-1. 탈퇴한 회원일 때
		}else if(mb.getUserDelYn() == 'Y'){
			return "N";
		// 2-2. 관리자에 의해 정지된 회원일 때
		}else if(mb.getUserDelYn() == 'X'){
			return "X";
		// 2-3. 해당 없으면 자동로그인
		}else {
			session.setAttribute("userId", userId);
			return "Y";
		}
	}
	
	// 네이버 소셜로그인
	@RequestMapping("joinNaverMem.do")
	@ResponseBody
	public String joinScMem(@RequestParam("userId") String userId,
						 @RequestParam("userName") String userName, 
						 @RequestParam("userEmail") String userEmail,
						 HttpSession session, memberVO member) throws Exception{
		
		// 네이버로부터 제공받은 정보 입력
		member.setUserId(userId);
		member.setUserName(userName);
		member.setUserEmail(userEmail);

		// 임의 비밀번호 생성 후 입력
		String userPw = new tempKey().getKey(10, false);
		member.setUserPw(userPw);
		
		// 나머지 항목 널값 입력
		member.setUserPhone(null);
		
		// 이용자식별자(네이버로부터 제공받은 고유ID)로 연동기록 확인
		// 아이디로 조회해 객체를 불러옴
		memberVO mb = ms.checkId(userId);
		
		// 1. 연동기록이 없을 경우 가입
		if(mb == null) {
			// 1-1. 가입 성공
			if(ms.insertScMem(member) == 1) {
				session.setAttribute("userId", userId);
				return "Y";
			// 1-2. 가입 실패
			}else {
				return "E";
			}
		// 2. 연동기록이 있을 경우 상태에 따라 로그인 처리
		// 2-1. 탈퇴한 회원일 때
		}else if(mb.getUserDelYn() == 'Y'){
			return "N";
		// 2-2. 관리자에 의해 정지된 회원일 때
		}else if(mb.getUserDelYn() == 'X'){
			return "X";
		// 2-3. 해당 없으면 자동로그인
		}else {
			session.setAttribute("userId", userId);
			return "Y";
		}
	}
	
	// 로그인 시 계정, 인증 상태 검증
	@RequestMapping("checkLogin.do")
	public String logCheck(@RequestParam String userId, @RequestParam String userPw,
						   String toURL, HttpSession session, Model model) throws Exception {
		
		memberVO m = ms.checkId(userId);
		int result;
		
		// 1. 존재하지 않는 아이디일 때
		if(m == null) {
			result = 1;
			model.addAttribute("result", result);
			return "member/loginResult";
		// 2. 탈퇴한 회원일 때
		}else if(m.getUserDelYn() == 'Y') {
			result = 1;
			model.addAttribute("result", result);
			return "member/loginResult";
		// 3. 관리자에 의해 정지된 회원일 때
		}else if(m.getUserDelYn() == 'X') {
			result = 2;
			model.addAttribute("result", result);
			return "member/loginResult";
		// 4. 가입 후 메일 인증을 하지 않은 회원일 때
		}else if(m.getMailAuth() != 'Y') {
			result = 3;
			model.addAttribute("result", result);
			return "member/loginResult";
		// 5. 1~4 해당 없고 아이디, 비밀번호 일치하면 로그인
		}else {
			// 5-1. 비밀번호 일치
			// 비밀번호 복호화
			if(passwordEncoder.matches(userPw, m.getUserPw())) {
				session.setAttribute("userId", userId);
				String userName = m.getUserName();
				model.addAttribute("userName", userName);
				// 홈으로 이동
				toURL = toURL==null || toURL.equals("") ? "/" : toURL;
				return "redirect:"+toURL;
			// 5-2. 비밀번호 불일치
			}else {
				result = 4;
				model.addAttribute("result", result);
				return "member/loginResult";
			}
		}
	}

	// 아이디 중복확인(Ajax)
	@RequestMapping(value = "checkMemId.do", method = RequestMethod.POST)
	public String idCheck(@RequestParam("memid") String userId, Model model) throws Exception {

		int result = ms.checkMemId(userId);
		
		model.addAttribute("result", result);
		return "member/checkIdResult";
	}
	
	// 회원 가입(저장)
	@RequestMapping("insertMem.do")
	public String mInsert(memberVO member) throws Exception {
		
		// 비밀번호 암호화
		String encpw = passwordEncoder.encode(member.getUserPw());
		member.setUserPw(encpw);
		
		ms.insertMem(member);
		return "member/joinResult";
	}

	// 이메일 인증
	@GetMapping("registerMail.do")
	public String mailConfirm(memberVO member) throws Exception {
		ms.updateMailAuth(member);
		return "member/mailAuthOk";
	}
	
	// 아이디 찾기
	@RequestMapping(value = "findIdCheck.do", method = RequestMethod.POST)
	public String fIdCheck(memberVO member, Model model) throws Exception {
	
		memberVO m = ms.findIdCheck(member);
		
		// 1. 조회한 회원이 없을 때
		if(m == null) {
			return "member/findIdFail";
		// 2. 조회한 회원이 있을 때
		}else {
			String result = m.getUserId();
			model.addAttribute("findid", result);
			return "member/findId";
		}
	}

	// 비밀번호 찾기
	@RequestMapping(value = "findPwCheck.do", method = RequestMethod.POST)
	public String pFindCheck(memberVO m, Model model) throws Exception {
		
		memberVO member = ms.findPwCheck(m);
		
		// 1. 조회한 회원이 없을 때
		if(member == null) {
			return "member/findFail";
		// 2. 조회한 회원이 있을 때
		}else {
			ms.updatePw(member);
			model.addAttribute("findpw", 1);
			return "member/findPw";
		}
	}
	
	// 회원정보수정 전 비밀번호인증 실행
	@RequestMapping("editCheckOk.do")
	public String eCheckOk(memberVO member, HttpSession session, Model model) throws Exception {

		String userId = (String)session.getAttribute("userId");

		memberVO editm = ms.checkId(userId);	// 아이디로 객체를 얻어옴
		String userPw = editm.getUserPw();		// 객체로부터 비밀번호를 얻어옴
		
		// 비밀번호 복호화
		if(passwordEncoder.matches(member.getUserPw(),userPw)) {
			return "redirect:/editMem.do";	// 맞으면 수정페이지 이동 요청
		}else {
			return "member/memCheckFail";	// 틀리면 실패 안내창 띄우기
		}
	}
	
	// 회원정보수정 페이지
	@RequestMapping("editMem.do")
	public String goEditMem(HttpServletRequest request, Model model) throws Exception{

		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		
		if(userId == null) {
			return "redirect:/login.do?toURL="+request.getRequestURL();
		}
		
		memberVO editm = ms.checkId(userId);	// 아이디로 객체를 얻어옴
		model.addAttribute("editm", editm);		// 수정양식에 기존 값 보여주기 위함
		
		return "member/editMem";
	}

	// 회원정보수정 실행
	@RequestMapping("editMemOk.do")
	public String mEditOk(memberVO member, Model model, HttpServletRequest request) throws Exception {

		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		
		String userName = request.getParameter("userName");
		String userPhone = request.getParameter("userPhone");
		String userEmail = request.getParameter("userEmail");
		String userMajor = request.getParameter("userMajor");
		char userGru = (request.getParameter("userGru")).charAt(0);
		
		member.setUserId(userId);
		member.setUserName(userName);
		member.setUserPhone(userPhone);
		member.setUserEmail(userEmail);
		member.setUserMajor(userMajor);
		member.setUserGru(userGru);
		
		ms.updateMem(member);
		
		return "member/editMemOk";
	}
	
	// 비밀번호 변경
	@RequestMapping("editPwOk.do")
	public String pEditOk(memberVO member, HttpServletRequest request, Model model) throws Exception {
	
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");		

		String userPw = request.getParameter("userPw");
		
		// 비밀번호 암호화
		String encpw = passwordEncoder.encode(userPw);
		member.setUserPw(encpw);
		
		ms.updateMemPw(member);
		
		return "member/editPwOk";
	}
	
	// 회원탈퇴 전 비밀번호인증 실행
	@RequestMapping("delCheckOk.do")
	public String dCheckOk(memberVO member, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");		

		memberVO delm = ms.checkId(userId);		// 아이디로 객체를 얻어옴
		String userPw = delm.getUserPw();		// 객체로부터 비밀번호를 얻어옴
		
		// 비밀번호 복호화
		if(passwordEncoder.matches(request.getParameter("userPw"),userPw)) {		
			ms.deleteMem(member);			// 맞으면 탈퇴
			return "member/delCheckOk";	// 성공 안내창 띄우기
		}else {
			return "member/memCheckFail";	// 틀리면 실패 안내창 띄우기
		}
	}
}
