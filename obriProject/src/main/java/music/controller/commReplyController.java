package music.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import music.model.commReplyVO;
import music.model.communityVO;
import music.service.commReplyService;
import music.service.communityService;

@Controller
public class commReplyController {

	@Autowired
	private commReplyService replyService;

	@Autowired
	private communityService service;

	// 댓글 입력
	@RequestMapping("commReInsert.do")
	public String comReInsert(commReplyVO  commReply, Model model) {
		System.out.println("댓글 입력 컨트롤러");
		System.out.println("commReId:" + commReply.getCommReId());
		System.out.println("commno:" + commReply.getCommno());
		System.out.println("commReText:" + commReply.getCommReText());
		
		
		
		replyService.commReInsert(commReply);
		return "redirect:commReList.do?commno=" + commReply.getCommno();
	}

	// 댓글 목록
	@RequestMapping("commReList.do")
	public String reList(int commno, commReplyVO  commReply,Model model) {
		System.out.println("댓글 목록 컨트롤러");
		System.out.println("commno:"+ commno);

		// 부모 테이블 상세정보 
		communityVO community = service.Content(commno);
		System.out.println("community:" + community);

		// 댓글목록 구해오기
		List<communityVO> commReList = replyService.comReList(commno);
		System.out.println("commReList:" + commReList);

		// 댓글 갯수
		int reTotal = replyService.getTotal(commReply); // 검색 (데이터 갯수)
		System.out.println("reTotal:" + reTotal);
		
		model.addAttribute("commReList", commReList);
		model.addAttribute("community", community);
		model.addAttribute("reTotal",reTotal);
		return "community/commReList";
	}
	
	// 댓글 삭제
			@RequestMapping("commReDelete.do")
			public String delete(commReplyVO  commReply, Model model) {
				System.out.println("댓글 삭제 컨트롤러");
				replyService.comReDelete(commReply.getCommReNo());
				return "redirect:commReList.do?commno="+commReply.getCommno();
			}
	
	
}
