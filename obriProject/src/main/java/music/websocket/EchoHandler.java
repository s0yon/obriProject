package music.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.mysql.cj.util.StringUtils;

import music.dao.mypageDao;
import music.model.memberVO;

@Repository
public class EchoHandler extends TextWebSocketHandler{

	// WebSocket 세션과 사용자 이름을 매핑(누가 세션에 접속했는지 추적) -1:1
	Map<String, WebSocketSession> userSessionMap = new HashMap<String, WebSocketSession>();
	// 로그인 한 전체
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	
	// 웹 소켓 연결이 종료되고 나서 서버단에서 실행해야할 일들을 정의
	@Override    
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("afterConnectionClosed "+session+", "+status);
		
		userSessionMap.remove(session.getId());
		sessions.remove(session);
	}
	
	// 웹소켓 연결 직후에 처리
	@Override  	  
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessions.add(session);
		
		String senderEmail = getEmail(session);
		String senderId = session.getId();
		System.out.println(">>>>>>>>>"+senderId);
		
		userSessionMap.put(session.getId(), session);
	}
	
	// 웹소켓 email 가져오기
	private String getEmail(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		memberVO loginUser = (memberVO)httpSession.get("memberVO");
		
		if(loginUser == null) {
			return session.getId();
		} else {
			return loginUser.getUserEmail();
		}
	}
	
	
	// 웹소켓 연결후 서버단(소켓)으로 메세지가 도착했을때 해주어야할 일들을 정의
	@Override    
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 모든 유저에게 보냄
//		for (WebSocketSession sess : sessions) {
//			sess.sendMessage(new TextMessage(senderNickname + ": "+message.getPayload()));
//		}
		
		// message.getPayload()함수 : 메시지에 담긴 텍스트값을 얻을 수 있음
		System.out.println(session.getId()+"가 보낸 메시지: "+message.getPayload());
		
		// 메시지에서 정보 추출
		String msg = message.getPayload();
		if(!StringUtils.isNullOrEmpty(msg)) {
			String[] strs = msg.split(",");
			
			// 메시지가 유효하고 길이가 5(strs.length == 5)인 경우
			if(strs != null) {
				String cmd = strs[0];  // 명령어 유형
	            String caller = strs[1];  // 댓글 작성자
	            String receiver = strs[2];  // 게시글 작성자
	            String receiverEmail = strs[3];  // 게시글 작성자의 이메일
	            String seq = strs[4];  // 게시글 번호
	            
	            // 작성자가 로그인 중인 경우
	            WebSocketSession boardWriterSession = userSessionMap.get(receiver);
	            
	            // cmd = reply : 댓글인 경우
	            if("reply".equals(cmd) && boardWriterSession != null) {
	            	TextMessage tmpMsg = new TextMessage(caller + "님이 " + 
                            "<a type='external' href='/mentor/menteeboard/menteeboardView?seq="+seq+"&pg=1'>" 
	            			+ seq + "</a> 번 게시글에 댓글을 남겼습니다.");
	            	boardWriterSession.sendMessage(tmpMsg);
	            
	            // cmd = message : 쪽지를 보낸 경우
	            } else if("message".equals(cmd) && boardWriterSession != null) {
	                TextMessage tmpMsg = new TextMessage(caller + "님이 " +
                            "<a type='external' href='/mentor/essayboard/essayboardView?pg=1&seq="+seq+"&mentors="+ receiver +"'>" 
	                		+ receiver  + "</a>님에게 쪽지를 보냈습니다.");
	                boardWriterSession.sendMessage(tmpMsg);	            	
	            }
			}
			
			// 공고 지원자인경우
	        if(strs != null && strs.length == 5) {
	            String cmd = strs[0];
	            String mentee_name = strs[1];
	            String mentor_email = strs[2];
	            String meetingboard_seq = strs[3];
	            String participation_seq = strs[4];
	            
	            // 모임 작성자가 로그인 중인 경우
	            WebSocketSession mentorSession = userSessionMap.get(mentor_email);
	            if(cmd.equals("apply") && mentorSession != null) {
	                TextMessage tmpMsg = new TextMessage(
	                        mentee_name + "님이 공고에 지원했습니다. " 
	                        +"<a type='external' href='/mentor/participation/participationView?mseq="+ meetingboard_seq +"&pseq="+ participation_seq +"'>신청서 보기</a>");
	                mentorSession.sendMessage(tmpMsg);
	            }
	        }			
		}
		
		
	}
}
