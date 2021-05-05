package model;

public class Calendar {
	private int num;
	private String calyear;
	private String calmonth;
	private String calday;
	private String calcontents;
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getCalyear() {
		return calyear;
	}
	public void setCalyear(String calyear) {
		this.calyear = calyear;
	}
	public String getCalmonth() {
		return calmonth;
	}
	public void setCalmonth(String calmonth) {
		this.calmonth = calmonth;
	}
	public String getCalday() {
		return calday;
	}
	public void setCalday(String calday) {
		this.calday = calday;
	}
	public String getCalcontents() {
		return calcontents;
	}
	public void setCalcontents(String calcontents) {
		this.calcontents = calcontents;
	}
	@Override
	public String toString() {
		return "Calendar [num=" + num + ", calyear=" + calyear + ", calmonth=" + calmonth + ", calday=" + calday
				+ ", calcontents=" + calcontents + "]";
	}
	
	
}
