package org.kdea.sgp.board;

import java.sql.Date;

public class ReplyVO {
	
	private int reNum;		
	private String reAuthor; 	
	private String reContents;
	private int reRef;
	private Date reDate;
	private int bNum;
	
	private boolean ok;		//등록결과
	private String checkAuthor;	//비교할 이름
	
	
	public int getReNum() {
		return reNum;
	}
	public void setReNum(int reNum) {
		this.reNum = reNum;
	}
	public String getReAuthor() {
		return reAuthor;
	}
	public void setReAuthor(String reAuthor) {
		this.reAuthor = reAuthor;
	}
	public String getReContents() {
		return reContents;
	}
	public void setReContents(String reContents) {
		this.reContents = reContents;
	}
	public int getReRef() {
		return reRef;
	}
	public void setReRef(int reRef) {
		this.reRef = reRef;
	}
	public Date getReDate() {
		return reDate;
	}
	public void setReDate(Date reDate) {
		this.reDate = reDate;
	}
	public int getbNum() {
		return bNum;
	}
	public void setbNum(int bNum) {
		this.bNum = bNum;
	}
	public boolean isOk() {
		return ok;
	}
	public void setOk(boolean ok) {
		this.ok = ok;
	}
	public String getCheckAuthor() {
		return checkAuthor;
	}
	public void setCheckAuthor(String checkAuthor) {
		this.checkAuthor = checkAuthor;
	}
}
