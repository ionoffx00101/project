package org.kdea.sgp.notice;

import java.util.HashMap;
import java.util.List;

public interface NoticeBoardDAO {

	public int NBgetlogin(BoardLoginVO bvo);

	public List<BoardVO> NBgetList(int page);

	public int NBgetTotalRows();

	/*public int NBwriteRegi(BoardVO bvo);*/

	public List<BoardVO> NBgetinfo(HashMap<String, Object> map);

	public BoardVO NBgeteditSc(int editsc);

	public int NBeditgo(BoardVO bvo);

	public int NBdeletego(int deletesc);

	public List<BoardVO> NBsearchlist(SearchVO svo);

	public int NBgetTitleTotalRows(String title);

	public List<BoardVO> NBauthorsearchlist(SearchVO svo);

	public int NBgetAuthorTotalRows(String author);

	public void getNBnum(HashMap<String, Object> map);

	

}
