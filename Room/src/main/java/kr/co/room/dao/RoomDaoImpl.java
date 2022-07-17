package kr.co.room.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.room.model.Room;
import kr.co.room.pager.Pager;

@Repository
public class RoomDaoImpl implements RoomDao {
	
	@Autowired
	SqlSession sql;

	@Override
	public void add(Room item) {
		sql.insert("room.add", item);
	}

	@Override
	public Room item(int roomid) {		
		return sql.selectOne("room.item", roomid);
	}

	@Override
	public void update(Room item) {
		sql.update("room.update", item);
	}

	@Override
	public void delete(int roomid) {
		sql.delete("room.delete", roomid);
	}

	@Override
	public List<Room> list(Pager pager) {
		return sql.selectList("room.list", pager);
	}

	@Override
	public int total(Pager pager) {
		return sql.selectOne("room.total", pager);
	}
	
}
