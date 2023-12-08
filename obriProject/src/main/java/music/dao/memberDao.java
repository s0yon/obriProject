package music.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.ui.Model;

import music.model.memberVO;

@Mapper
public interface memberDao {
	
	// 네이버 로그인
	public int insertScMem(memberVO mb) throws Exception;
	
	// 아이디 정보 확인
	public memberVO checkId(String userId) throws Exception;

	// 아이디 중복확인(Ajax)
	public int checkMemId(String userId) throws Exception;
	
	// 회원 가입(저장)
	public void insertMem(memberVO mb) throws Exception;

	// 메일 인증키 저장
	public int updateMailKey(memberVO mb) throws Exception;
	
	// 메일 인증 시 권한 변경
	public int updateMailAuth(memberVO mb) throws Exception;
	
	// 아이디 찾기
	public memberVO findIdCheck(memberVO mb) throws Exception;
	
	// 비밀번호 찾기
	public memberVO findPwCheck(memberVO mb) throws Exception;
	
	// 비밀번호 초기화
	public void updatePw(memberVO mb) throws Exception;
	
	// 회원정보 수정
	public void updateMem(memberVO mb) throws Exception;
	
	// 비밀번호 변경
	public void updateMemPw(memberVO mb) throws Exception;
	
	// 회원탈퇴
	public void deleteMem(memberVO mb) throws Exception;
	
}
