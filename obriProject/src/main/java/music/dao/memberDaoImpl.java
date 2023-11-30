package music.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import music.model.memberVO;

@Repository
public class memberDaoImpl implements memberDao {

	@Autowired
	private SqlSession sqlSession;
	
	// 아이디 존재 여부 확인
	@Override
	public memberVO checkId(String userId) {
		return sqlSession.selectOne("checkLogin", userId);
	}
	
	// 로그인 실행(이메일 인증)
	@Override
	public int emailAuthFail(String userId) throws Exception{
		return sqlSession.selectOne("emailAuthFail", userId);
	}

	// 회원가입 실행
	@Override
	public void insertMember(memberVO m) throws Exception{
		sqlSession.insert("insertMember", m);
	}
	
	// 아이디 중복확인
	@Override
	public int checkMemberId(String userId) {
		int re;
		memberVO mb = sqlSession.selectOne("checkMemberId", userId);
		
		if(mb == null) {
			re = -1;	// 사용 가능한 이메일
		}else {
			re = 1;		// 사용 불가능한 이메일
		}
		return re;
	}
	
	// 이메일 인증 키 저장
	@Override
	public int updateMailKey(memberVO mb) throws Exception{
		return sqlSession.update("updateMailKey", mb);
	}
	
	// 이메일 인증 시 권한 변경
	@Override
	public int updateMailAuth(memberVO mb) throws Exception{
		return sqlSession.update("updateMailAuth", mb);
	}

	// 아이디 찾기
	@Override
	public memberVO findId(memberVO fm) {
		return sqlSession.selectOne("findIdCheck", fm);
	}
	
	// 비밀번호 찾기
	@Override
	public memberVO findPw(memberVO pm) {
		return sqlSession.selectOne("findPwCheck", pm);
	}
	
	// 비밀번호 초기화
	@Override
	public void updatePw(memberVO mb) throws Exception{
		System.out.println("이메일 주소"+mb.getUserEmail());
		System.out.println("아이디"+mb.getUserId());
		System.out.println("패스워드"+mb.getUserPw());
		sqlSession.update("updatePw", mb);
	}
}
