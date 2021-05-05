package model;

import java.util.Date;

public class Score {
	private int no;
	private String id;
	private Date tdate;
	private int score;
	private int ttype;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getTdate() {
		return tdate;
	}
	public void setTdate(Date tdate) {
		this.tdate = tdate;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public int getTtype() {
		return ttype;
	}
	public void setTtype(int ttype) {
		this.ttype = ttype;
	}
	@Override
	public String toString() {
		return "Score [no=" + no + ", id=" + id + ", tdate=" + tdate + ", score=" + score + ", ttype=" + ttype + "]";
	}
}
