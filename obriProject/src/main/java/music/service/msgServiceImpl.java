package music.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import music.dao.msgDao;
import music.model.msgVO;

@Service
public class msgServiceImpl implements msgService{

	@Autowired
	private msgDao dao;
	
	public int insertMsg(msgVO msg) {
		return dao.insertMsg(msg);
	}
	
}
