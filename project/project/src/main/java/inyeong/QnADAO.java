package inyeong;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface QnADAO {

	public void getPagelist(Map<String, Object> map);
	public int getTotalRows();
	public void getPostDAO(HashMap<String, Object> map);
	public int update(QnABoardVO vo);
	
	public int newpostdao(QnABoardVO vo);
	
	public int delete(int num);
	public int momcheck(int num);
	public void getpostreply(HashMap<String, Object> map);
	public int getsearchTotalRows(String title);
	public int getsearchaTotalRows(String author);
	public List<QnABoardVO> search(QnABoardVO vo);
	public List<QnABoardVO> searcha(QnABoardVO vo);
	
	//public void newpostmap(HashMap<String, Object> map);
	public void newpostpro(HashMap<String, Object> map);


}
