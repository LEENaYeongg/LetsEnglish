package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.mapper.CommentMapper;

public class CommentDao {
private Class<CommentMapper> cls = CommentMapper.class;
private Map<String, Object> map = new HashMap<>();

public int maxno() {
    SqlSession session= MyBatisConnection.getConnection();
    try {
       return session.getMapper(cls).maxno();
    }catch(Exception e) {
       e.printStackTrace();
    }finally {
       MyBatisConnection.close(session);
    }
    return 0;
 }

public boolean insert(Comment c) {
	SqlSession session= MyBatisConnection.getConnection();
    try {
       session.getMapper(cls).insert(c);
       return true;
    }catch (Exception e) {
       e.printStackTrace();
    }finally {
       MyBatisConnection.close(session);
    }
    return false;
 }
public List<Comment> comment(int num,int btype){
	SqlSession session = MyBatisConnection.getConnection();
	try {
		map.clear();
		map.put("btype",btype);
		map.put("num", num);
		return session.getMapper(cls).select(map);
	}catch(Exception e) {
		e.printStackTrace();
	}finally {
		MyBatisConnection.close(session);
	}
	return null;
}
}
