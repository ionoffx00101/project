package org.kdea.sgp.board;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FBService {

	private int page;
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public void setInput(BoardVO vo) {
		FBDAO dao = sqlSessionTemplate.getMapper(FBDAO.class);
        dao.setInput(vo);
	}

	public List<BoardVO> getList(int page) {
		FBDAO dao = sqlSessionTemplate.getMapper(FBDAO.class);
		this.page = page;
		if(page == 0) {
			page = 1;
		}
		List<BoardVO> list = dao.getList(page);
		
		return list;
	}
	
	public NaviVO getNavi() {
		FBDAO dao = sqlSessionTemplate.getMapper(FBDAO.class);
		int totalRows = dao.getTotalCount();
		PagingUtil util = new PagingUtil();
		return util.navi(page, totalRows);
	}
	
	public BoardVO getInfo(int num) {
		FBDAO dao = sqlSessionTemplate.getMapper(FBDAO.class);
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("num", num);
		dao.getInfo(map);
		List<BoardVO> list = (List<BoardVO>)map.get("key");
		return list.get(0);
	}
	
	public boolean setUpdate(BoardVO vo) {
		FBDAO dao = sqlSessionTemplate.getMapper(FBDAO.class);
		int row = dao.setUpdate(vo);
		return row > 0 ? true : false;
	}

	public boolean setDelete(int num) {
		FBDAO dao = sqlSessionTemplate.getMapper(FBDAO.class);
		Integer findSrefRow = dao.getFindSref(num);
		boolean delete = false;
		boolean ok = false;
		if(findSrefRow == null) {
			delete = true;
		}
		if(delete) {
			dao.setDelete(num);
			ok = true;
		}
		return ok;
	}

	public List<BoardVO> getSearch(String searchChoice, String key, int page) {
		FBDAO dao = sqlSessionTemplate.getMapper(FBDAO.class);
		this.page = page;
		if(page == 0) {
			page = 1;
		}
		BoardVO vo = new BoardVO();
		vo.setPage(page);
		if(searchChoice.equals("제목으로 검색")) {
			vo.setTitle(key);
			return dao.getSearchStitle(vo);
		} else {
			vo.setAuthor(key);
			return dao.getSearchSauthor(vo);
		}
	}

	public NaviVO getSearchNavi(String searchChoice, String key) {
		FBDAO dao = sqlSessionTemplate.getMapper(FBDAO.class);
		int totalRows = 0;
		PagingUtil util = new PagingUtil();
		if(searchChoice.equals("제목으로 검색")) {
			totalRows = dao.getTotalCountStitle(key);
			return util.navi(page, totalRows);
		} else {
			totalRows = dao.getTotalCountSauthor(key);
			return util.navi(page, totalRows);
		}
	}

	public ReplyVO setReplyInput(ReplyVO vo) {
		FBDAO dao = sqlSessionTemplate.getMapper(FBDAO.class);
		int row = dao.setReplyInput(vo);
		boolean ok = row > 0 ? true : false;
		vo.setOk(ok);
		return vo;
	}

	public List<ReplyVO> getReList(int num) {
		FBDAO dao = sqlSessionTemplate.getMapper(FBDAO.class);
		List<ReplyVO> list = dao.getReList(num);
		return list;
	}

	public boolean setReplyDelete(ReplyVO vo) {
		FBDAO dao = sqlSessionTemplate.getMapper(FBDAO.class);
		Integer findReRefRow = dao.getFindReRef(vo.getReNum());
		boolean delete = false;
		boolean ok = false;
		if(findReRefRow == null) {
			delete = true;
		}
		if(delete) {
			dao.setReplyDelete(vo.getReNum());
			ok = true;
		}
		return ok;
	}

	public String getReAuthor(int reNum) {
		FBDAO dao = sqlSessionTemplate.getMapper(FBDAO.class);
		String author = dao.getReAuthor(reNum);
		return author;
	}
}

