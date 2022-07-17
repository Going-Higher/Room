package kr.co.room.dao;

import java.util.List;

import kr.co.room.model.Room;
import kr.co.room.pager.Pager;

public interface RoomDao {

	List<Room> list(Pager pager);

	void add(Room item);

	Room item(int roomid);

	void update(Room item);

	void delete(int roomid);
	
	int total(Pager pager);

}
