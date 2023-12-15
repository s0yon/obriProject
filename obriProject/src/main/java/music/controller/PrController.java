package music.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import music.model.prLikeVO;
import music.model.prVO;
import music.service.PagingPgm;
import music.service.msgService;
import music.service.prService;

@Controller
public class PrController {

	@Autowired
	private prService service;

//	@RequestMapping("home.do")
//	public String prList() {
//		return "prList";
//	}

//	@RequestMapping("main.do")
//	public String prInsertForm() {
//		return "pr/main";
//		return "pr/chatModal";
//	}

	// 홍보 게시판 글 목록
	@RequestMapping(value = "prCardList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String prList(@RequestParam(value="pageNum" ,defaultValue="1") String pageNum, prVO pr ,@RequestParam( value="sortOrder",required = false )String sortOrder,  Model model) {
		
		System.out.println("오더" + sortOrder);
		// 한 화면에서 출력하고자 하는 리스트의 갯수를 정하는 변수
		final int rowPerPage = 10; 

		System.out.println("받아온 pageNum"+pageNum);
		System.out.println("선택키워드"+pr.getSearch());
		System.out.println("검색내용"+pr.getKeyword());
		
		int currentPage = Integer.parseInt(pageNum);
		
		int total = service.getPrTotal(pr); // 검색 전체 게시물 수
		System.out.println("토탈"+ total);
		int startRow = (currentPage - 1) * rowPerPage + 1; // 이거는 해당 화면에서 출력될 리스트의 처음 숫자
		int endRow = startRow + rowPerPage -1 ;	// 이거는 해당 화면에서 출력될 리스트의 마지막 숫자
		PagingPgm pp = new PagingPgm(total, rowPerPage, currentPage);
		pr.setStartRow(startRow);
		pr.setEndRow(endRow);
		
		System.out.println("스타트row"+pr.getStartRow());
		System.out.println("엔드row"+pr.getEndRow());
		
		List<prVO> prList = service.selectPrList(pr);
		
		System.out.println("pp값들 보기" + pp);
		
		model.addAttribute("prList", prList);
		model.addAttribute("pp", pp);
		
		System.out.println("페이지 정보들 " + pp.toString());
		
		// 검색
		model.addAttribute("search", pr.getSearch());
		model.addAttribute("keyword", pr.getKeyword());
		
		// 정렬
		model.addAttribute("sortOrder", pr.getSortOrder());

		System.out.println(prList);

		return "pr/prCardList";
	}

	// 홍보 작성 폼
	@RequestMapping("prInsertForm.do")
	public String insertPrForm() {

		return "pr/prInsertForm";
	}

//	리스트에 대한 List<Map> 은 String key 형이 컬럼명이다 

	// 홍보 상세 페이지
	@RequestMapping(value = "prDetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String prDeail(@RequestParam int prNo,@RequestParam String pageNum , HttpServletRequest request, Model model) {

		System.out.println("prNo:" + prNo);
		System.out.println("상세페이지:" + pageNum);
		
		HttpSession idsession = request.getSession();
	    String userId = (String) idsession.getAttribute("userId");

	    prLikeVO prLike = new prLikeVO();
	    prLike.setPrNo(prNo);
	    prLike.setUserId(userId);
	    
	    System.out.println("세션에서 가져온 ID" + userId);
	    
	    if(userId != null && !userId.equals("")) {
	    	System.out.println("들어오면 안되는데");
	    	prLike = service.selectPrLikeYn(prLike);
	    }
	    System.out.println("ttt");
	    //request.setAttribute("id", userId);
	    
		service.updatePrRdCount(prNo); // 조회수 1 증가
		System.out.println("ttt");
		System.out.println("번호"+prNo);
		Map<String, Object> map = (Map<String, Object>) service.selectPrDeail(prNo);
		System.out.println("ttt");
		System.out.println("상세페이지");
		System.out.println(map.get("USERNAME"));
		System.out.println(map.get("PRNO"));
		System.out.println(map);
		
		int prlikeNumber = service.selectLikeCount(prNo);
		
		model.addAttribute("prLikeStatus", prLike == null ? 'N' : prLike.getPrLike());
		model.addAttribute("map", map);
		model.addAttribute("prlikeNumber", prlikeNumber);
		model.addAttribute("pageNum", pageNum);

		
//		System.out.println("여기는 어떤가??");
//		System.out.println(prLike);
//		System.out.println(prLike.getPrLike());
		// 임시로 login session 삽입
//		request.setAttribute("id", "test01");

		System.out.println(map.get("PRVIDEO"));

		return "pr/prDetail";
	}

	// 자기 홍보 insert
	@RequestMapping(value = "pr_insert_ok.do", method = RequestMethod.POST)
	public String prInsert(@ModelAttribute prVO pr, @RequestParam("prFile1") MultipartFile mf,
			HttpServletRequest request, Model model) throws Exception {
		System.out.println("들어왔어?");

		System.out.println(pr);

		String fileName = mf.getOriginalFilename(); // 첨부파일명

		int size = (int) mf.getSize(); // 첨부파일의 크기 (단위 : byte)

		String path = request.getRealPath("upload"); // 실제 업로드 되는 파일의 위치
		System.out.println("mf" + mf);
		System.out.println("fileName" + fileName);
		System.out.println("size" + size);
		System.out.println("path" + path);

		int result = 0;

		String file[] = new String[2];

		String newFileName = "";

		if (fileName != "") { // 첨부파일 전송될 경우

			String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length()); // 확장자명
			System.out.println(extension);

			UUID uuid = UUID.randomUUID();

			newFileName = uuid.toString() + extension;

			System.out.println("newFileName" + newFileName);

			if (size > 1000000) { // 100KB
				result = 1;
				model.addAttribute("result", result);
				System.out.println("파일이 커서 에러가 나옴");
				return "pr/uploadPrErrorResult";

			} else if (!extension.equals(".jpg") && !extension.equals(".jpeg") && !extension.equals(".gif")
					&& !extension.equals(".png")) {

				result = 2;
				model.addAttribute("result", result);
				System.out.println("형식이 안맞아서 에러가 나옴");
				return "pr/uploadPrErrorResult";
			}
		}

		if (size > 0) {
			System.out.println("ddd");
			mf.transferTo(new File(path + "/" + newFileName));
		}

		pr.setPrFile(newFileName); // 새롭게 업로드한 파일명을 다시 setter파일에 넣어줘야한다.

		System.out.println("두번째" + pr);

		service.inserPr(pr); // insertPr

		return "redirect:/prCardList.do";
	}

	// 홍보 수정 폼 이동
	@RequestMapping(value = "prUpdateForm.do")
	public String prUpdateForm(@RequestParam int prNo, Model model) {

		System.out.println("prUpdateForm22");
		System.out.println("prNo" + prNo);

		prVO pr = new prVO();

		// 수정을 위한 게시물 번호로 조회한 값 출력
		pr = service.selctPrInfo(prNo);

		System.out.println("파일명" + pr.getPrFile());

		model.addAttribute("pr", pr);

		return "pr/prUpdateForm";
	}

	// 홍보 수정 완료
	@RequestMapping(value = "pr_update_ok.do")
	public String prUpdate(@ModelAttribute prVO pr, @RequestParam("pr_file1") MultipartFile mf, 
									HttpServletRequest request, String pageNum, Model model) throws Exception{

		System.out.println("pr_update_ok");
		
		System.out.println("hidden된" + pr.getPrFile());
		System.out.println("hidden된" + pr.getPrNo());
		System.out.println("hidden된" + pr.getPrSub());
		System.out.println("hidden된" + pr.getPrCareer());

		String exFileName = pr.getPrFile(); // 이전에 업로드한 이미지
		
		String fileName = mf.getOriginalFilename(); // 첨부파일명

		int size = (int) mf.getSize(); // 첨부파일의 크기 (단위 : byte)

		String path = request.getRealPath("upload"); // 실제 업로드 되는 파일의 위치
		System.out.println("mf" + mf);
		System.out.println("fileName" + fileName);
		System.out.println("size" + size);
		System.out.println("path" + path);

		int result = 0;

		String file[] = new String[2];

		String newFileName = "";

		if (fileName != "") { // 첨부파일 전송될 경우

			String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length()); // 확장자명
			System.out.println(extension);

			UUID uuid = UUID.randomUUID();

			newFileName = uuid.toString() + extension;

			System.out.println("newFileName" + newFileName);

			if (size > 1000000) { // 100KB
				result = 1;
				model.addAttribute("result", result);

				return "uploadPrErrorResult";

			} else if (!extension.equals(".jpg") && !extension.equals(".jpeg") && !extension.equals(".gif")
					&& !extension.equals(".png")) {

				result = 2;
				model.addAttribute("result", result);

				return "pr/uploadPrErrorResult";
			}
		}

		if (size > 0) {
			
			mf.transferTo(new File(path + "/" + newFileName));
		}
		
		if(fileName != "") {
			pr.setPrFile(newFileName); // 새로운 첨부파일이 있으면 이미지 변경
		} else {
			pr.setPrFile(exFileName); // 없으면 기존에 있는 파일로 가기
		}
		System.out.println("업로드된 파일명" + pr.getPrFile());
		int updateResult = service.updatePr(pr);
		System.out.println("업데이트 결과"+ updateResult);
		
		model.addAttribute("result", updateResult);
		model.addAttribute("pr", pr);
		model.addAttribute("prNo", pr.getPrNo());
		model.addAttribute("pageNum", pageNum);
		
		return "pr/updateResult";
	}
	
	@RequestMapping(value = "prDetailDelete.do", method = RequestMethod.GET)
	public String prDelete(@RequestParam("prNo") int prNo, @RequestParam("pageNum") int pageNum,  RedirectAttributes redirect) {
		System.out.println("delte.do들어옴");
		System.out.println("번번호"+prNo);
		System.out.println("페이지넘넘"+pageNum);
		
		service.deletePr(prNo);
		
		redirect.addAttribute("pageNum", pageNum);
		
		return "redirect:/prCardList.do";
	}
	
	// 홍보 좋아요 유무 조회
	@ResponseBody
	@RequestMapping(value = "prLike.do", method= RequestMethod.POST)
	public prLikeVO prLike(@RequestBody prLikeVO prLike , Model model){
		System.out.println(prLike);
		System.out.println(prLike.getPrNo());
		System.out.println(prLike.getUserId());
		
		prLikeVO prLikeYn = service.selectPrLikeYn(prLike); 
		System.out.println("prLikeYn성공");
		// 조회했을때 아무것도 없으면 insert 
		if(prLikeYn == null || prLikeYn.equals("")) {
			service.insertPrLike(prLike);
		}else { // 있으면 update
			System.out.println("업데이트");
			service.updatePrLike(prLikeYn);
			System.out.println("업데이트성공");
		}
		
		prLikeVO prLikeOne = service.selectPrLikeYn(prLike);
		System.out.println(prLikeOne);
		return prLikeOne;
	}

}
