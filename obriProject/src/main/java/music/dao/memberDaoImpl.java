package music.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import music.model.memberVO;

@Repository
public class memberDaoImpl implements memberDao {

	@Autowired
	private SqlSession sqlSession;
	
	// 네이버 로그인
	public int insertScMem(memberVO mb) throws Exception{
		return sqlSession.insert("insertScMem", mb);
	}	
	
	// 아이디 정보 확인
	@Override
	public memberVO checkId(String userId) throws Exception{
		return sqlSession.selectOne("checkId", userId);
	}
	
	// 아이디 중복확인(Ajax)
	@Override
	public int checkMemId(String userId) throws Exception{
		int re;
		memberVO mb = sqlSession.selectOne("checkId", userId);
		
		if(mb == null) {
			re = -1;	// 사용 가능한 아이디(없음)
		}else {
			re = 1;		// 사용 불가능한 아이디(존재)
		}
		return re;
	}
	
	// 회원 가입(저장)
	@Override
	public void insertMem(memberVO mb) throws Exception{
		sqlSession.insert("insertMem", mb);
	}

	// 메일 인증키 저장
	@Override
	public int updateMailKey(memberVO mb) throws Exception{
		return sqlSession.update("updateMailKey", mb);
	}
	
	// 메일 인증 시 권한 변경
	@Override
	public int updateMailAuth(memberVO mb) throws Exception{
		return sqlSession.update("updateMailAuth", mb);
	}

	// 아이디 찾기
	@Override
	public memberVO findIdCheck(memberVO mb) throws Exception{
		return sqlSession.selectOne("findIdCheck", mb);
	}
	
	// 비밀번호 찾기
	@Override
	public memberVO findPwCheck(memberVO mb) throws Exception{
		return sqlSession.selectOne("findPwCheck", mb);
	}
	
	// 비밀번호 초기화
	@Override
	public void updatePw(memberVO mb) throws Exception{
		System.out.println("이메일 주소"+mb.getUserEmail());
		System.out.println("아이디"+mb.getUserId());
		System.out.println("패스워드"+mb.getUserPw());
		sqlSession.update("updatePw", mb);
	}
	
	// 회원정보 수정
	public void updateMem(memberVO mb) throws Exception{
		sqlSession.update("updateMem", mb);
	}

	// 비밀번호 변경
	public void updateMemPw(memberVO mb) throws Exception{
		sqlSession.update("updateMemPw", mb);
	}
	
	// 회원탈퇴
	public void deleteMem(memberVO mb) throws Exception{
		sqlSession.update("deleteMem", mb);
	}
}
