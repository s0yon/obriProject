package music.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import music.mail.mailHandler;
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

	// 로그인 실행(인증)
	@RequestMapping("checkLogin.do")
	public String lCheck(@RequestParam String userId, @RequestParam String userPw, String toURL, HttpSession session, Model model)
			throws Exception {
		
		int result = 0;
		
		// 존재하는 아이디의 객체를 얻어옴
		memberVO m = ms.checkId(userId);

		// 1. 등록되지 않은 회원일 때
		if (m == null) {
			result = 1;
			model.addAttribute("result", result);
			return "member/loginResult";
		// 2. 등록되었지만 이메일 인증을 하지 않은 회원일 때
		}else if(ms.emailAuthFail(userId) != 1) {
			return "member/emailAuthFail";
		// 3. 아이디 비밀번호 일치 여부
		}else {
//			if(m.getUserPw().equals(userPw)) { // 비밀번호가 같을 때
			// 	비밀번호 복호화
			if(passwordEncoder.matches(userPw, m.getUserPw())) {
				session.setAttribute("userId", userId);
				String userName = m.getUserName();
				model.addAttribute("userName", userName);
				// 홈으로 이동
				toURL = toURL==null || toURL.equals("") ? "/" : toURL;
				return "redirect:"+toURL;
			} else { // 비밀번호가 다를 때
				result = 2;
				model.addAttribute("result", result);
				return "member/loginResult";
			}
		}
	}

	// 아이디 중복확인(Ajax)
	@RequestMapping(value = "checkMemberId.do", method = RequestMethod.POST)
	public String iCheck(@RequestParam("memid") String userId, Model model) throws Exception {

		int result = ms.checkMemberId(userId);
		model.addAttribute("result", result);

		return "member/checkIdResult";
	}
	
	// 회원가입 실행
	@RequestMapping(value = "insertMember.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String mInsert(@ModelAttribute memberVO member, Model model) throws Exception {
		
		// 비밀번호 암호화
		String encpw = passwordEncoder.encode(member.getUserPw());
		member.setUserPw(encpw);
		
		ms.insertMember(member);
		return "member/joinMemResult";
	}

	// 이메일 인증
	@GetMapping("registerEmail.do")
	public String emailConfirm(memberVO member) throws Exception {
		ms.updateMailAuth(member);
		return "member/emailAuthOk";
	}
	
	// 아이디찾기 실행
	@RequestMapping(value = "findIdCheck.do", method = RequestMethod.POST)
	public String iFindCheck(@ModelAttribute memberVO mem, Model model) throws Exception {
		memberVO member = ms.findId(mem);
		
		if(member == null) { // 회원이 존재하지 않을 때
			return "member/findIdFail";
		}else {	// 회원이 존재할 때
			String result = member.getUserId();
			model.addAttribute("findid", result);
			return "member/findId";
		}
	}

	// 비밀번호찾기 실행
	@RequestMapping(value = "findPwCheck.do", method = RequestMethod.POST)
	public String pFindCheck(@ModelAttribute memberVO m, Model model) throws Exception {
		memberVO member = ms.findPw(m);
		
		if(member == null) { // 회원이 존재하지 않을 때
			return "member/findPwFail";
		}else {	// 회원이 존재할 때
			ms.updatePw(member);
			model.addAttribute("findpw", 1);
			return "member/findPw";
		}
	}
	
	// 회원정보수정 전 비밀번호인증 실행
	@RequestMapping("editMemCheck.do")
	public String eMemCheckOk(@ModelAttribute memberVO m, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");		

		memberVO editm = ms.checkId(userId);	// 아이디로 객체를 얻어옴
		String userPw = editm.getUserPw();		// 객체로부터 비밀번호를 얻어옴
		
		// 비밀번호 복호화
		if(passwordEncoder.matches(m.getUserPw(),userPw)) {
//		if(userPw.equals(m.getUserPw())) {		// 객체의 비밀번호와 입력값이 일치하는지 확인
			return "redirect:/editMember.do";	// 맞으면 수정페이지 이동 요청
		}else {
			return "member/editMemCheckFail";	// 틀리면 실패 안내창 띄우기
		}
	}
	
	// 회원정보 수정 페이지
	@RequestMapping("editMember.do")
	public String goEditMember(HttpServletRequest request, Model model) throws Exception{
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		
		if(userId == null) {
			return "redirect:/loginMember.do?toURL="+request.getRequestURL();
		}
		
		memberVO editm = ms.checkId(userId);	// 아이디로 객체를 얻어옴
		model.addAttribute("editm", editm);	// 수정양식에 기존 값 보여주기 위함
		
		return "member/editMember";
	}

	// 회원정보 수정 실행
	@RequestMapping(value = "editMemberOk.do", method= {RequestMethod.POST, RequestMethod.GET})
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
		
		ms.updateMember(member);
		
		return "member/editMemberOk";
	}
	
	// 비밀번호 변경
	@RequestMapping("editPwOk.do")
	public String pEditOk(@ModelAttribute memberVO member, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");		

		String userPw = request.getParameter("userPw");
		
		// 비밀번호 암호화
		String encpw = passwordEncoder.encode(userPw);
		member.setUserPw(encpw);
//		member.setUserPw(userPw);
		
		ms.updateMemPw(member);
		
		return "member/editPwOk";
	}
	
	// 회원탈퇴 전 비밀번호인증 실행
	@RequestMapping("delMemCheck.do")
	public String dMemCheckOk(@ModelAttribute memberVO m, HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");		

		memberVO delm = ms.checkId(userId);	// 아이디로 객체를 얻어옴
		String userPw = delm.getUserPw();		// 객체로부터 비밀번호를 얻어옴
		
		// 비밀번호 복호화
		if(passwordEncoder.matches(request.getParameter("userPw"),userPw)) {		
//		if(userPw.equals(request.getParameter("userPw"))) {		// 객체의 비밀번호와 입력값이 일치하는지 확인
			ms.deleteMember(m);	// 맞으면 탈퇴
			return "member/delMemCheckOk";	// 성공 안내창 띄우기
		}else {
			return "member/delMemCheckFail";	// 틀리면 실패 안내창 띄우기
		}
	}
	
}
