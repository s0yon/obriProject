package music.model;

import java.util.Date;
import lombok.Data;

@Data
public class msgVO {
	private int msgNo;
	private String userId;
	private String recvId;
	private String msgText;
	private int readSt;
	private int sendSt;
	private int msgCheck;
	private Date msgDate;
	private String msgDelYn;
}
