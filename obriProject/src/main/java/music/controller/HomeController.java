package music.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import music.model.memberVO;

@Controller
public class HomeController {
	
	// 메인 페이지
	@RequestMapping(value = "home.do", method = RequestMethod.GET)
	public String goHome() {
		return "home";
	}
	
	// 로그인 페이지
	@RequestMapping("loginMember.do")
	public String goLogin() {
		return "member/loginMember";
	}

	// 로그아웃
	@GetMapping("logoutMember.do")
	public String logout(HttpSession session, String toURL) {
		session.invalidate();
		// 홈으로 이동
		toURL = toURL==null || toURL.equals("") ? "/" : toURL;
		return "redirect:"+toURL;
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
	
	// 회원정보수정 전 비밀번호인증 페이지
	@RequestMapping(value = "goEdit.do", method= {RequestMethod.POST, RequestMethod.GET})
	public String mEditCheck(@ModelAttribute memberVO m, Model model, HttpServletRequest request) throws Exception {
//		HttpSession session = request.getSession();
//		String userId = (String)session.getAttribute("userId");
//		
//		if(userId == null) {
//			return "redirect:/loginMember.do?toURL="+request.getRequestURL();
//		}else {
			return "member/editMemCheck";
//		}
	}
	
	// 비밀번호변경 페이지
	@RequestMapping("goEditPw.do")
	public String goEditPw() {
		return "member/editPw";
	}
	
	// 회원 탈퇴 페이지
	@RequestMapping(value = "goDelete.do", method= {RequestMethod.POST, RequestMethod.GET})
	public String mDelCheck(@ModelAttribute memberVO m, Model model, HttpServletRequest request) throws Exception {
//		HttpSession session = request.getSession();
//		String userId = (String)session.getAttribute("userId");
//		
//		if(userId == null) {
//			return "redirect:/loginMember.do?toURL="+request.getRequestURL();
//		}else {
			return "member/delMember";
//		}
	}
}
