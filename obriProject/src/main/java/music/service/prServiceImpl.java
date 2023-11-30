package music.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import music.dao.prDao;
import music.model.prLikeVO;
import music.model.prVO;

@Service
public class prServiceImpl implements prService{

	@Autowired
	private prDao dao;
	
	@Override
	public void inserPr(prVO pr) {
		dao.insertPr(pr);
	}
	
	@Override
	public int getPrTotal(prVO pr) {
		// TODO Auto-generated method stub
		return dao.getPrTotal(pr);
	}

	@Override
	public List<prVO> selectPrList(prVO pr) {
		// TODO Auto-generated method stub
		return dao.selectPrList(pr);
	}
	
	@Override
	public void updatePrRdCount(int prNo) {
		dao.updatePrRdCount(prNo);
	}
	
	@Override
	public Map<String, Object> selectPrDeail(int prNo){
		return dao.selectPrDeail(prNo);
	}

	@Override
	public prVO selctPrInfo(int prNo) {
		return dao.selctPrInfo(prNo);
	}

	@Override
	public int updatePr(prVO pr) {
		// TODO Auto-generated method stub
		System.out.println(pr.getPrNo());
		return dao.updatePr(pr);
	}

	@Override
	public void deletePr(int prNo) {
		dao.deletePr(prNo);
	}

	// 상세 페이지 좋아요 유무
	@Override
	public prLikeVO selectPrLikeYn(prLikeVO prLike) {
		// TODO Auto-generated method stub
		return dao.selectPrLikeYn(prLike);
	}

	// 홍보 좋아요 insert
	@Override
	public void insertPrLike(prLikeVO prLike) {
		// TODO Auto-generated method stub
		dao.insertPrLike(prLike);
	}

	// 홍보 좋아요 update
	@Override
	public void updatePrLike(prLikeVO prLike) {
		// TODO Auto-generated method stub
		dao.updatePrLike(prLike);
	}

	// 좋아요 갯수 select
	@Override
	public int selectLikeCount(int prNo) {
		// TODO Auto-generated method stub
		return dao.selectLikeCount(prNo);
	}

	

	


}
