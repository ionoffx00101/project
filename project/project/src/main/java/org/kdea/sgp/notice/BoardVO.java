package org.kdea.sgp.notice;

import java.sql.Date;

public class BoardVO {
private int num;
private String title;
private String author;
private String contents;
private int hitcnt;
private Date wdate;
public int getNum() {
	return num;
}
public void setNum(int num) {
	this.num = num;
}
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}
public String getAuthor() {
	return author;
}
public void setAuthor(String author) {
	this.author = author;
}
public String getContents() {
	return contents;
}
public void setContents(String contents) {
	this.contents = contents;
}
public int getHitcnt() {
	return hitcnt;
}
public void setHitcnt(int hitcnt) {
	this.hitcnt = hitcnt;
}
public Date getWdate() {
	return wdate;
}
public void setWdate(Date wdate) {
	this.wdate = wdate;
}



}
