package org.kdea.sgp.notice;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service("pagingUtil")
public class PagingUtil {
	
	private boolean leftMore, rightMore;
	int pg;
	int rowsPerPage = 5; //한 화면당 출력할 행수
	int numsPerPage = 5; //한화면당 링크의 수 
	int totalPages;
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	

	public NaviVO getNav(int page) {
		
		pg= page;
		getTotalrow();
		NaviVO nav = getNaviVO();
		
		return nav;
	}
	
	public NaviVO TgetNav(SearchVO svo){
		NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
		pg= svo.getPage();
		System.out.println("제목:"+svo.getTitle());
		NaviVO nav = getNaviVO();
		totalPages = (nbd.NBgetTitleTotalRows(svo.getTitle()) - 1) / rowsPerPage + 1;
		return nav;
	}
	
	public NaviVO AgetNav(SearchVO svo){
		NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
		pg= svo.getPage();
		System.out.println("제목:"+svo.getTitle());
		NaviVO nav = getNaviVO();
		totalPages = (nbd.NBgetAuthorTotalRows(svo.getAuthor()) - 1) / rowsPerPage + 1;
		return nav;
	}

	public NaviVO getnebiNav(SearchVO svo, String cate) {
		
		if(cate.equals("제목")){
			NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
			pg= svo.getPage();
			System.out.println("제목:"+svo.getTitle());
			NaviVO nav = getNaviVO();
			totalPages = (nbd.NBgetTitleTotalRows(svo.getTitle()) - 1) / rowsPerPage + 1;
			return nav;
		}else{
			NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
			pg= svo.getPage();
			System.out.println("제목:"+svo.getTitle());
			NaviVO nav = getNaviVO();
			totalPages = (nbd.NBgetAuthorTotalRows(svo.getAuthor()) - 1) / rowsPerPage + 1;
			return nav;
			
		}
	}
	
	
	private NaviVO getNaviVO() {
		NaviVO nav = new NaviVO();
		nav.setCurrPage(pg);
		nav.setLinks(getNavlinks(pg, rowsPerPage, numsPerPage));
		nav.setLeftMore(leftMore);
		nav.setRightMore(rightMore);
		nav.setTotalpage(totalPages);
		return nav;
	}
	
	
	private void getTotalrow(){
		NoticeBoardDAO nbd = sqlSessionTemplate.getMapper(NoticeBoardDAO.class);
			
		totalPages = (nbd.NBgetTotalRows() - 1) / rowsPerPage + 1;
		
		
	}

	
	private int[] getNavlinks(int page, int rowsPerPage, int numsPerPage) {

		System.out.println("로우즈펄페이지:"+rowsPerPage);		
        System.out.println("토탈페이지:"+totalPages);

		int tmp = (page - 1) / numsPerPage + 1; // 몇번째 링크그룹에 속하는가?
		int end = tmp * numsPerPage;
		int start = (tmp - 1) * numsPerPage + 1;
		if (start == 1)
			leftMore = false; // << 왼쪽 이동 출력여부
		else
			leftMore = true;
		if (end >= totalPages) {  // >> 오른쪽 이동 출력여부
			end = totalPages;
			rightMore = false;
		} else
			rightMore = true;
		int[] links = new int[end - start + 1];
		for (int num = start, i = 0; num <= end; num++, i++) {
			links[i] = num;
		}
		return links; 
	}

}
