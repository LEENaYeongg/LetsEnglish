package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Score;

public interface ScoreMapper {
	
	@Insert("insert into score"
		    +" (no,id,tdate,score,ttype)"
		    +" value (#{no},#{id},#{tdate},#{score},#{ttype})")
	int insert(Score score);

	@Select("select ifnull(max(no),0) from score")
	int maxno();

	@Select({"<script>",
        "select * from score ",
        "<if test='no != null and id != null'> where no=#{no} and id=#{id}</if>",
        "<if test='no == null and id != null'> where id=#{id}</if>",
        "<if test='col1 != null'> and ${col1} like '%${find}%'</if>",
        "<if test='col2 != null'> or ${col2} like '%${find}%'</if>",
        "<if test='col3 != null'> or ${col3} like '%${find}%'</if>",
        "<if test='start != null'> order by tdate desc"
        + " limit #{start},#{limit}</if>",
        "</script>"})
  List<Score> select(Map<String, Object> map);

	@Update("update score set tdate=#{tdate}, score=#{score}, ttype=#{ttype} where id=#{id}")
	int update(Score s);

	@Delete("delete from score where id=#{value}")
	int delete(String id);

	@Select({"<script>",
		   "select count(*) from score where id=#{id}",
		   "<if test='col1 != null'> and ${col1} like '%${find}%'</if>",
		   "<if test='col2 != null'> or ${col2} like '%${find}%'</if>",
		   "<if test='col3 != null'> or ${col3} like '%${find}%'</if>",
		   "</script>"})
	int scorecount(Map<String, Object> map);
	
	@Select("select ttype, count(*) cnt from score group by ttype "
			+ "having count(*) > 0 order by cnt desc")
	List<Map<String, Object>> graph();

}
