package model;

import java.util.Date;

public class Comment {
private int no;
private String content;
private Date rdate;
private String id;
private int btype;
private int num;
public int getNo() {
	return no;
}
public void setNo(int no) {
	this.no = no;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public Date getRdate() {
	return rdate;
}
public void setRdate(Date rdate) {
	this.rdate = rdate;
}
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public int getBtype() {
	return btype;
}
public void setBtype(int btype) {
	this.btype = btype;
}
public int getNum() {
	return num;
}
public void setNum(int num) {
	this.num = num;
}
@Override
public String toString() {
	return "comment [no=" + no + ", content=" + content + ", rdate=" + rdate + ", id=" + id + ", btype=" + btype
			+ ", num=" + num + "]";
}


}
