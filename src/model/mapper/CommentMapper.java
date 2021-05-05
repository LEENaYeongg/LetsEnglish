package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import model.Comment;

public interface CommentMapper {

	@Select("SELECT ifnull(MAX(no),0) FROM comment")
	   int maxno();
	
	@Insert( "insert into comment" 
	         + " (no,id,content,rdate,btype,num)"
	         + " values (#{no},#{id},#{content},now(),#{btype},#{num})")
	   void insert(Comment comment);
	
	@Select({"<script>",
		"select * from comment",
		"<if test='num != null and btype != null'>where num=#{num} and btype=#{btype}</if>",
		"<if test='num == null and btype != null'> where btype=#{btype}</if>",
		 "<if test='no != null'>order by no desc </if>",
		"</script>"})
	List<Comment> select(Map<String, Object> map);
	
}
