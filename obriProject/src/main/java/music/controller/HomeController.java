package music.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	
	// 메인 페이지
	@RequestMapping("home.do")
	public String goHome() {
		return "home";
	}
	
	// 로그인 페이지
	@RequestMapping("loginMember.do")
	public String goLogin() {
		return "member/loginMember";
	}

	// 로그아웃
	@RequestMapping("logoutMember.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	// 회원가입 페이지
	@RequestMapping("joinMember.do")
	public String goJoin() {
		return "member/joinMember";
	}

	// 아이디찾기 페이지
	@RequestMapping("findId.do")
	public String goFindId() {
		return "member/findId";
	}

	// 비밀번호찾기 페이지
	@RequestMapping("findPw.do")
	public String goFindPw() {
		return "member/findPw";
	}
	
}
