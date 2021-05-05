package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Board;

public interface BoardMapper {
   
   @Select("SELECT ifnull(MAX(num),0) FROM board")
   int maxnum();

   
   @Insert( "insert into board" 
         + " (num,id,pass,title,bttype,btype,content,file1,regdate,"
         + " readcnt,grp,grplevel,grpstep)" 
         + " value (#{num},#{id},#{pass},#{title},#{bttype},#{btype},"
         + " #{content},#{file1},now(),0,#{grp},#{grplevel},#{grpstep})")
   void insert(Board board);

   @Select({"<script>",
   "select count(*) from board where btype=#{btype}",
   "<if test='col1 != null'> and ${col1} like '%${find}%'</if>",
   "<if test='col2 != null'> or ${col2} like '%${find}%'</if>",
   "<if test='col3 != null'> or ${col3} like '%${find}%'</if>",
   "</script>"})
   int boardcount(Map<String,Object>map);

   @Select({"<script>",
         "select * from board ",
         "<if test='num == null'>where btype=#{btype}</if>",
         "<if test='num != null'>where num=#{num}</if>",
         "<if test='col1 != null'> and ${col1} like '%${find}%'</if>",
         "<if test='col2 != null'> or ${col2} like '%${find}%'</if>",
         "<if test='col3 != null'> or ${col3} like '%${find}%'</if>",
         "<if test='start != null'>order by grp desc, grpstep "
         + "limit #{start},#{limit}</if>",
         "</script>"})
   List<Board> select(Map<String, Object> map);

   @Update("update board set readcnt = readcnt + 1 "
         + " where num = #{value}")
   void readcntAdd(int num);
   
   @Update("update board set grpstep = grpstep +1"
          + " where grp =#{grp} and grpstep > #{grpstep}")
   void grpStepAdd(@Param("grp")int grp, @Param("grpstep")int grpstep);
   
   @Update("update board set id=#{id}, bttype=#{bttype}, btype=#{btype}, title=#{title},"
         + "content=#{content},file1=#{file1} where num=#{num}")
   void update(Board board);

   @Delete("delete from board where num = #{value}")
   int delete(int num);
   
}