package music.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	
	// 메인 페이지
	@RequestMapping("home.do")
	public String goHome() {
		return "home";
	}
	
	// 네이버 로그인
	@RequestMapping("loginNaver.do")
	public String logNaver() {
		return "member/loginNaver";
	}
	
	// 로그인 페이지
	@RequestMapping("login.do")
	public String goLogin() {
		return "member/login";
	}
	
	// 로그아웃
	@GetMapping("logout.do")
	public String goLogout(HttpSession session, String toURL) {
		session.invalidate();
		// 홈으로 이동
		toURL = toURL==null || toURL.equals("") ? "/" : toURL;
		return "redirect:"+toURL;
	}
	
	// 회원가입 페이지
	@RequestMapping("join.do")
	public String goJoin() {
		return "member/join";
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
	
	// 회원정보수정 전 비밀번호인증 페이지
	@RequestMapping("editCheck.do")
	public String goEditCheck() {
		return "member/editCheck";
	}
	
	// 비밀번호변경 페이지
	@RequestMapping("editPw.do")
	public String goEditPw() {
		return "member/editPw";
	}
	
	// 회원탈퇴 페이지
	@RequestMapping("delMem.do")
	public String goDelete() {
		return "member/delMem";
	}
	
	// 신청 페이지
	@RequestMapping("appHome.do")
	public String goAppHome() {
		return "apply/appHome";
	}
	
	// 신청자 목록 페이지
	@RequestMapping("appList.do")
	public String goAppList() {
		return "apply/appList";
	}
}
