package org.kdea.sgp.notice;

public class NaviVO {
private int currPage;
private int[] links;
private boolean leftMore;
private boolean rightMore;
private int totalpage;


public int getTotalpage() {
	return totalpage;
}
public void setTotalpage(int totalpage) {
	this.totalpage = totalpage;
}
public int getCurrPage() {
	return currPage;
}
public void setCurrPage(int currPage) {
	this.currPage = currPage;
}
public int[] getLinks() {
	return links;
}
public void setLinks(int[] links) {
	this.links = links;
}
public boolean isLeftMore() {
	return leftMore;
}
public void setLeftMore(boolean leftMore) {
	this.leftMore = leftMore;
}
public boolean isRightMore() {
	return rightMore;
}
public void setRightMore(boolean rightMore) {
	this.rightMore = rightMore;
}


}
