package music.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import music.model.prLikeVO;
import music.model.prVO;

@Repository
public class prDao {

	@Autowired
	private SqlSession sqlSession;
	
	public void insertPr(prVO pr) {
		sqlSession.insert("insertPr", pr);
	}
	
	public int getPrTotal(prVO pr) {
		// TODO Auto-generated method stub
		System.out.println("요기 들어오나?");
		System.out.println(pr.getSearch());
		return sqlSession.selectOne("getPrTotal", pr);
	}
	
	public List<prVO> selectPrList(prVO pr){
		System.out.println("dao쪽 startRow"+pr.getStartRow());
		System.out.println("dao쪽 endRow"+pr.getEndRow());
		return sqlSession.selectList("selectPrList",pr);
	}
	
	public void updatePrRdCount(int prNo) {
		// TODO Auto-generated method stub
		sqlSession.update("updatePrRdCount", prNo);
	}

	public Map<String, Object> selectPrDeail(int prNo){
		return (Map<String, Object>) sqlSession.selectOne("selectPrDeail", prNo);
	}

	
	public prVO selctPrInfo(int prNo) {
		return sqlSession.selectOne("selctPrInfo", prNo);
	}

	public int updatePr(prVO pr) {
		// TODO Auto-generated method stub
		return sqlSession.update("updatePr", pr);
	}

	public void deletePr(int prNo) {
		sqlSession.update("deletePr", prNo);
		
	}
	
	public prLikeVO selectPrLikeYn(prLikeVO prLike) {
		return sqlSession.selectOne("selectPrLikeYn", prLike);
	}
	
	public void insertPrLike(prLikeVO prLike) {
		sqlSession.insert("insertPrLike", prLike);
	}
	
	public void updatePrLike(prLikeVO prLike) {
		System.out.println(prLike.getPrLike().getClass());
		sqlSession.update("updatePrLike", prLike);
	}
	
	public int selectLikeCount(int prNo) {
		return sqlSession.selectOne("selectLikeCount", prNo);
	}

}
