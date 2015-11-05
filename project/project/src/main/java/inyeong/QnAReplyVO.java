package inyeong;

public class QnAReplyVO {
  
	private int	renum ;
	private String reauthor ;
	private String contents;
	private int reref ;
	private java.sql.Date redate ;
	private int num ;
	
	public int getRenum() {
		return renum;
	}
	public void setRenum(int renum) {
		this.renum = renum;
	}
	public String getReauthor() {
		return reauthor;
	}
	public void setReauthor(String reauthor) {
		this.reauthor = reauthor;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getReref() {
		return reref;
	}
	public void setReref(int reref) {
		this.reref = reref;
	}
	public java.sql.Date getRedate() {
		return redate;
	}
	public void setRedate(java.sql.Date redate) {
		this.redate = redate;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	
	
}
