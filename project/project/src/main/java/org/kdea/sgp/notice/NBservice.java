package org.kdea.sgp.notice;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("NBservice")
public class NBservice {

	HttpServletRequest request;

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	public void requestSc(HttpServletRequest request) {
		this.request = request;

	}

	public boolean getlogin(BoardLoginVO bvo) {
		NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
		boolean ok = nbd.NBgetlogin(bvo)>0?true:false;
		if(ok){
			request.getSession().setAttribute("loginOk", bvo.getEname());
		}
		
		return ok;
	}

	public List<BoardVO> getlist(int page) {
		NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
		
		
		return nbd.NBgetList(page);
	}

/*	public boolean writeRegi(BoardVO bvo) {
		NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
		System.out.println("확인2:"+bvo.getContents());
		System.out.println("확인3:"+bvo.getWdate());
		boolean ok = nbd.NBwriteRegi(bvo)>0?true:false;
		
		return ok;
	}*/
	
	public int writeRegi(BoardVO bvo){
		NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("title", bvo.getTitle());
		map.put("contents", bvo.getContents());
		map.put("author",bvo.getAuthor());
		map.put("wdate", bvo.getWdate());
		map.put("hitcnt", bvo.getHitcnt());
		map.put("n_num",null);
		nbd.getNBnum(map);
	    int infonum = (Integer)map.get("key1");
	    
	    return infonum;    
	}

	public List<BoardVO> getInfo(int infosc) {
		NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("infosc", infosc);
		nbd.NBgetinfo(map);
		List<BoardVO> list = (List<BoardVO>)map.get("nbKey");
		
		return list;
	}

	public BoardVO geteditsc(int editsc) {
		NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
        
		return nbd.NBgeteditSc(editsc);
	}

	public boolean editgo(BoardVO bvo) {
		NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
		boolean ok = nbd.NBeditgo(bvo)>0?true:false;
		
		return ok;
	}

	public boolean deletego(int deletesc) {
		NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
		boolean ok = nbd.NBdeletego(deletesc)>0?true:false;
		
		return ok;
	}

	public List<BoardVO> getSearch(SearchVO svo) {
		NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
		
		return nbd.NBsearchlist(svo);
	}

	public List<BoardVO> getauthorSearch(SearchVO svo) {
		NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
		
		return nbd.NBauthorsearchlist(svo);
	}

	public List<BoardVO> getnvSearch(SearchVO svo, String catego) {
		NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
        if(catego.equals("제목")){
        	return nbd.NBsearchlist(svo);
        }else{
        return nbd.NBauthorsearchlist(svo);	
        }
		
	}

}
