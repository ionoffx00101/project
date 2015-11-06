package org.kdea.sgp.board;

import java.util.*;

public interface FBDAO {

	public List<BoardVO> getList(int page);
	public int getTotalCount();
	public int setInput(BoardVO vo);
	public void getInfo(Map<String,Object>map);
	public int setUpdate(BoardVO vo);
	public int setDelete(int num);
	public List<BoardVO> getSearchStitle(BoardVO vo);
	public List<BoardVO> getSearchSauthor(BoardVO vo);
	public int getTotalCountStitle(String title);
	public int getTotalCountSauthor(String author);
	public Integer getFindSref(int num); // int형은 null값을 못받으므로 Integer형으로 받는다.
	public int setReplyInput(ReplyVO vo);
	public List<ReplyVO> getReList(int num);
	public int setReplyDelete(int num);
	public String getReAuthor(int reNum);
	public Integer getFindReRef(int reNum);
}
