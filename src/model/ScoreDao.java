package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.mapper.ScoreMapper;

public class ScoreDao {
	private Class<ScoreMapper> cls = ScoreMapper.class;
	private Map<String, Object> map = new HashMap<>();

	public int maxno() {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).maxno();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}
	
	public int insert(Score score) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).insert(score);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}

	public int scoreCount(String column, String find, String id) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			map.clear();
			map.put("id", id);
			if (column != null) {
				String[] cols = column.split(",");
				switch (cols.length) {
				case 3: map.put("col3", cols[2]);
				case 2: map.put("col2", cols[1]);
				case 1: map.put("col1", cols[0]);
					break;
				}
				map.put("find", find);
			}
			return session.getMapper(cls).scorecount(map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}

	

	public Score selectOne(String id) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			map.clear();
			map.put("id", id);
			return session.getMapper(cls).select(map).get(0);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return null;
	}

	public int update(Score score) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).update(score);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}

	public int delete(String id) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			return session.getMapper(cls).delete(id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return 0;
	}


	public List<Map<String, Object>> boardgraph() {
		SqlSession session = MyBatisConnection.getConnection();
		List<Map<String, Object>> list = null;
		try {
			list = session.getMapper(cls).graph();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return list;
	}

	public List<Score> slist(int pageNum, int limit, String column, String find, String id) {
		SqlSession session = MyBatisConnection.getConnection();
		try {
			map.clear();
			map.put("start", (pageNum - 1) * limit);
			map.put("limit", limit);
			map.put("id", id);
			if (column != null) {
				String[] cols = column.split(",");
				switch (cols.length) {
				case 3: map.put("col3", cols[2]);
				case 2: map.put("col2", cols[1]);
				case 1: map.put("col1", cols[0]);
				}
				 map.put("find",find);
			}
			return session.getMapper(cls).select(map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MyBatisConnection.close(session);
		}
		return null;
	}

}
