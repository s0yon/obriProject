package music.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
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
			if (m.getUserPw().equals(userPw)) { // 비밀번호가 같을 때
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

	// 회원정보 수정 - 마이페이지 임시 대체
	@RequestMapping("editMember.do")
	public String mEdit(HttpServletRequest request, Model model) throws Exception {
		
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		
		if(userId == null) {
			return "redirect:/loginMember.do?toURL="+request.getRequestURL();
		}
		
		memberVO editm = ms.checkId(userId);
		model.addAttribute("editm", editm);
		
		return "member/editMember";
	}
	
	// 아이디 중복확인(Ajax)
	@RequestMapping(value = "checkMemberId.do", method = RequestMethod.POST)
	public String iCheck(@RequestParam("memid") String userId, Model model) {

		int result = ms.checkMemberId(userId);
		model.addAttribute("result", result);

		return "member/checkIdResult";
	}
	
	// 회원가입 실행
	@RequestMapping(value = "insertMember.do", method = RequestMethod.POST)
	public String mInsert(@ModelAttribute memberVO member, Model model) throws Exception {
		ms.insertMember(member);
		return "member/joinMemResult";
	}

	// 이메일 인증
	@GetMapping("registerEmail.do")
	public String emailConfirm(memberVO member) throws Exception {
		ms.updateMailAuth(member);
		return "member/emailAuthSuccess";
	}
	
	// 아이디찾기 실행
	@RequestMapping(value = "findIdCheck.do", method = RequestMethod.POST)
	public String iFindCheck(@ModelAttribute memberVO mem, Model model) {
		memberVO member = ms.findId(mem);
		
		if(member == null) { // 회원이 존재하지 않을 때
			return "member/findIdResult";
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
			return "member/findPwResult";
		}else {	// 회원이 존재할 때
			ms.updatePw(member);
			model.addAttribute("findpw", 1);
			return "member/findPw";
		}
	}
}
