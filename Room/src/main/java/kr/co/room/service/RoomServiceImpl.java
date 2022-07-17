package kr.co.room.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.room.dao.RoomDao;
import kr.co.room.model.Room;
import kr.co.room.pager.Pager;

@Service
public class RoomServiceImpl implements RoomService {
	
	@Autowired
	RoomDao dao;

	@Override
	public List<Room> list(Pager pager) {	
		int total = dao.total(pager);
		
		pager.setTotal(total);
		
		return dao.list(pager);
	}

	@Override
	public void add(Room item) {
		dao.add(item);		
	}

	@Override
	public Room item(int roomid) {		
		return dao.item(roomid);
	}

	@Override
	public void update(Room item) {
		dao.update(item);		
	}

	@Override
	public void delete(int roomid) {
		dao.delete(roomid);		
	}

}
