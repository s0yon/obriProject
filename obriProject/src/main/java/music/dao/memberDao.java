package music.dao;

import org.apache.ibatis.annotations.Mapper;

import music.model.memberVO;

@Mapper
public interface memberDao {
	
	// 아이디 존재 여부 확인
	public memberVO checkId(String userId) throws Exception;
	
	// 로그인 실행(이메일 인증)
	public int emailAuthFail(String userId) throws Exception;
	
	// 회원 가입(저장)
	public void insertMember(memberVO m) throws Exception;

	// 아이디 중복확인
	public int checkMemberId(String userId) throws Exception;
	
	// 이메일 인증 키 저장
	public int updateMailKey(memberVO mb) throws Exception;
	
	// 이메일 인증 시 권한 변경
	public int updateMailAuth(memberVO mb) throws Exception;
	
	// 아이디 찾기
	public memberVO findId(memberVO fm) throws Exception;
	
	// 비밀번호 찾기
	public memberVO findPw(memberVO pm) throws Exception;
	
	// 비밀번호 초기화
	public void updatePw(memberVO mb) throws Exception;
	
	// 회원정보 수정
	public void updateMember(memberVO mb) throws Exception;
	
	// 비밀번호 변경
	public void updateMemPw(memberVO mb) throws Exception;
	
	// 회원탈퇴
	public void deleteMember(memberVO mb) throws Exception;
	
}
