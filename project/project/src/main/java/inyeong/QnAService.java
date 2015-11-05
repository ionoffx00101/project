package inyeong;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("qnasvc")
public class QnAService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public QnABoardVO getPost(HttpServletRequest request) {
		int num = Integer.parseInt(request.getParameter("num"));

		QnADAO dao = sqlSessionTemplate.getMapper(QnADAO.class);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		dao.getPostDAO(map);
		List<QnABoardVO> list = (List<QnABoardVO>) map.get("key");
		return list.get(0);
	}
	
	public List<QnAReplyVO> getPostReply(HttpServletRequest request) {
		int num = Integer.parseInt(request.getParameter("num"));
		
		QnADAO dao = sqlSessionTemplate.getMapper(QnADAO.class);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		dao.getpostreply(map);
		List<QnAReplyVO> list = (List<QnAReplyVO>) map.get("key");

		return list;
	}

	public boolean modipost(QnABoardVO vo) {
		QnADAO dao = sqlSessionTemplate.getMapper(QnADAO.class);
		int rows = dao.update(vo);
		
		boolean check = rows>0 ? true : false; 
		return check;
	}

	public int newpost(QnABoardVO vo) {
		QnADAO dao = sqlSessionTemplate.getMapper(QnADAO.class);
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("title", vo.getTitle());
		map.put("author", vo.getAuthor());
		map.put("contents", vo.getContents());
		map.put("ref", vo.getRef());
		dao.newpostpro(map);
		String snum = (String) map.get("num");
		int num = Integer.parseInt(snum);
		
		
		
		return num;
		/*
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		dao.newpostmap(map);
		List<QnABoardVO> list = (List<QnABoardVO>) map.get("key");
		
		int rows = list.get(0).getNum();
		System.out.println(rows);
		//int rows = dao.newpostdao(vo);
		//글번호가 있으면 0보다 크겠
		boolean check = rows>0 ? true : false;
		return check;*/
		//return true;
	}

	public boolean delpost(HttpServletRequest request) {
		int num = Integer.parseInt(request.getParameter("num"));
		boolean check=false;
		QnADAO dao = sqlSessionTemplate.getMapper(QnADAO.class);
		int rows = dao.momcheck(num);
		boolean momnono = rows>0 ? true : false;
		
		if(!momnono){
			int row=dao.delete(num);
			check = row>0 ? true : false;
		}
		
		return check;
	}

	public List<QnABoardVO> svcsearch(String word, String cate, int pnum) {
		QnADAO dao = sqlSessionTemplate.getMapper(QnADAO.class);
		
		List<QnABoardVO> list = new ArrayList();
		
		if(cate.equals("글제목")){
			QnABoardVO vo = new QnABoardVO();
			vo.setTitle(word);
			vo.setPage(pnum);
			list = dao.search(vo);
			//list = dao.searcha(word,pg);
		}
		else if(cate.equals("글쓴이")){
			QnABoardVO vo = new QnABoardVO();
			vo.setAuthor(word);
			System.out.println(word+"word");
			System.out.println(vo.getAuthor()+"get");
			vo.setPage(pnum);
			list = dao.searcha(vo);
			//list = dao.searcha(word,pg);
		}
		else{
			//svc.svclist(pnum);
		}
		//없으면 전체리스트
		
		return list;
	}

}
