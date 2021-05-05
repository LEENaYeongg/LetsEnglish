package model;

import java.util.Date;

//Bean Å¬·¡½º
public class Board {
   private int num;
   private String id;
   private String pass;
   private String title;
   private String content;
   private String file1;
   private Date regdate;
   private int bttype;
   private int btype;
   private int readcnt;
   private int grp;
   private int grplevel;
   private int grpstep;
   
public int getNum() {
	return num;
}
public void setNum(int num) {
	this.num = num;
}
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public String getPass() {
	return pass;
}
public void setPass(String pass) {
	this.pass = pass;
}
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public String getFile1() {
	return file1;
}
public void setFile1(String file1) {
	this.file1 = file1;
}
public Date getRegdate() {
	return regdate;
}
public void setRegdate(Date regdate) {
	this.regdate = regdate;
}
public int getBttype() {
	return bttype;
}
public void setBttype(int bttype) {
	this.bttype = bttype;
}
public int getBtype() {
	return btype;
}
public void setBtype(int btype) {
	this.btype = btype;
}
public int getReadcnt() {
	return readcnt;
}
public void setReadcnt(int readcnt) {
	this.readcnt = readcnt;
}
public int getGrp() {
	return grp;
}
public void setGrp(int grp) {
	this.grp = grp;
}
public int getGrplevel() {
	return grplevel;
}
public void setGrplevel(int grplevel) {
	this.grplevel = grplevel;
}
public int getGrpstep() {
	return grpstep;
}
public void setGrpstep(int grpstep) {
	this.grpstep = grpstep;
}
@Override
public String toString() {
	return "Board [num=" + num + ", id=" + id + ", pass=" + pass + ", title=" + title + ", content=" + content
			+ ", file1=" + file1 + ", regdate=" + regdate + ", bttype=" + bttype + ", btype=" + btype + ", readcnt="
			+ readcnt + ", grp=" + grp + ", grplevel=" + grplevel + ", grpstep=" + grpstep + "]";
}
}