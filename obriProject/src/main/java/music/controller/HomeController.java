package music.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import music.model.communityVO;
import music.model.jobBoardVO;
import music.service.PagingPgm;
import music.service.communityService;
import music.service.jobBoardService;

@Controller
public class HomeController {
	
	// 구인 서비스 주입
	@Autowired
	private jobBoardService jbs;
	
	// 커뮤니티 서비스 주입
	@Autowired
	private communityService service;	
	
	// 메인 페이지
	@RequestMapping("home.do")
	public String goHome() {
		return "home";
	}

	// 메인 페이지 게시판 연동 - 구인 목록
	@RequestMapping("jobboardListShow.do")
	public String jobList(String pageNum, jobBoardVO job, Model model) {

		final int rowPerPage = 7; // 화면에 출력할 데이터 갯수
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int total = 0;

		int currentPage = Integer.parseInt(pageNum); // 현재 페이지번호

		total = jbs.getJobTotal(job); // 검색

		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		job.setStartRow(startRow);
		job.setEndRow(endRow);

		int no = total - startRow + 1;
		
		List<Map<String, Object>> joblist = new ArrayList<Map<String,Object>>();
		joblist = jbs.jobList(job);
		
		model.addAttribute("joblist", joblist);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);
		model.addAttribute("pageNum", pageNum);		

		return "jobboardListShow";
	}
	
	// 메인 페이지 게시판 연동 - 커뮤니티 목록
	@RequestMapping("commboardListShow.do")
	public String commList(String pageNum, communityVO community,  Model model) {

		// 정렬 값(sort)이 없는 경우(초기 실행)
		if (community.getSort() == null) {
			community.setSort("recent");
		}
		String sort = community.getSort();

		final int rowPerPage = 7; // 화면에 출력할 데이터 갯수
		if (pageNum == null || pageNum.equals("")) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호

		int total = service.getTotal(community); // 검색 (데이터 갯수)

		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;

		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		community.setStartRow(startRow);
		community.setEndRow(endRow);

		int no = total - startRow + 1; // 화면 출력 번호
		List<communityVO> list = service.list(community);

		// 좋아요 갯수
		int likeCnt = service.count(community.getCommNo());

		model.addAttribute("likeCnt", likeCnt);
		model.addAttribute("sort", sort);
		model.addAttribute("list", list);
		model.addAttribute("no", no);
		model.addAttribute("pp", pp);

		return "commboardListShow";
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
