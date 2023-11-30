package music.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import music.model.msgVO;

@Repository
public class msgDao {

	@Autowired
	private SqlSession sqlSession;
	
	public int insertMsg(msgVO msg) {
		return sqlSession.insert("insertMsg", msg);
	}
	
}
