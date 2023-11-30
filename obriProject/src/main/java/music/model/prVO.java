package music.model;

import java.util.Date;

import lombok.Data;

@Data
public class prVO {
	private int prNo;	
	private String userId;
	private String prSub;
	private String prText;
	private int prRcount;
	private String prMajor;
	private String prLoc;
	private String prCareer;
	private String prVideo;
	private String prFile;	
	private String prHash;
	private Date prDate;
	private Date prUpdate;
	private Character prDelYn;
	
	// page
	private int startRow;
	private int endRow;
	
	// search && keyword
	private String search;
	private String keyword;
	
	// order
	private String sortOrder;
	
	
}
