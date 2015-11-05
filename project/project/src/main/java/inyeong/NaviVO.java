package inyeong;

public class NaviVO {
	
	private int currPage;
	private int[] links;
	private boolean leftMore, rightMore;
	private int tatalPages;
	private int linknum;
	
	public int getTatalPages() {
		return tatalPages;
	}
	public void setTatalPages(int tatalPages) {
		this.tatalPages = tatalPages;
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
	public int getLinknum() {
		return linknum;
	}
	public void setLinknum(int linknum) {
		this.linknum = linknum;
	}
	
}

