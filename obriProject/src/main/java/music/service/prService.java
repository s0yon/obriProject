package music.service;

import java.util.List;
import java.util.Map;

import music.model.prLikeVO;
import music.model.prVO;

public interface prService {
	
	void inserPr(prVO pr);
	
	int getPrTotal(prVO pr);

	List<prVO> selectPrList(prVO pr);
	
	Map<String, Object> selectPrDeail(int prNo);

	void updatePrRdCount(int prNo);
	
	prVO selctPrInfo(int prNo);

	int updatePr(prVO pr);

	void deletePr(int prNo);

	// 상세페이지 좋아요 유무 체크
	prLikeVO selectPrLikeYn(prLikeVO prLike);

	// 홍보 좋아요 insert
	void insertPrLike(prLikeVO prLike);
	
	// 홍보 좋아요 update
	void updatePrLike(prLikeVO prLike);

	// 좋아요 갯수 조회
	int selectLikeCount(int prNo);

	

	 
	
}
