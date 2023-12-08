package music.model;

public class commLikeVO {

	private String commLikeNo;		
	private int commno;				// 필요 foreign
	private String commLike;
	private String userId;			// 필요 primary
	
	public String getCommLikeNo() {
		return commLikeNo;
	}
	public void setCommLikeNo(String commLikeNo) {
		this.commLikeNo = commLikeNo;
	}
	public int getCommno() {
		return commno;
	}
	public void setCommno(int commno) {
		this.commno = commno;
	}
	public String getCommLike() {
		return commLike;
	}
	public void setCommLike(String commLike) {
		this.commLike = commLike;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
	
}
	
	