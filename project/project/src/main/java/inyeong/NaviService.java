package inyeong;

import java.util.HashMap;
import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("navisvc")
public class NaviService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate; 
	
	
	private boolean leftMore, rightMore;
	
	int pg;
	int totalPg;
	int rowsPerPage = 5;
	int numsPerPage = 3;


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

	public List<QnABoardVO> svclist(int pnum) {
		QnADAO dao = sqlSessionTemplate.getMapper(QnADAO.class);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("num", pnum);
		dao.getPagelist(map);
		List<QnABoardVO> list = (List<QnABoardVO>) map.get("key");
		
		return list;
	}
	public NaviVO getNaviVO(int pnum) {
		
		pg =pnum;
		NaviVO nav = new NaviVO();
		nav.setCurrPage(pg);
		nav.setLinks(getNavlinks(pg, rowsPerPage, numsPerPage));
		nav.setLeftMore(leftMore);
		nav.setRightMore(rightMore);
		nav.setTatalPages(totalPg);
		System.out.println(nav.getLinks().length+"link");
		return nav;
	}
	
	public int[] getNavlinks(int page, int rowsPerPage, int numsPerPage) {
		QnADAO dao = sqlSessionTemplate.getMapper(QnADAO.class);
		int totalPages = (dao.getTotalRows() - 1) / rowsPerPage + 1;
		
		totalPg = totalPages;

		int tmp = (page - 1) / numsPerPage + 1;
		
		int end = tmp * numsPerPage;
	
		int start = (tmp - 1) * numsPerPage + 1;
		
		if (start == 1)
			leftMore = false;
		
		else
			leftMore = true;
		
		if (end >= totalPages) {
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

	public NaviVO getsearchNaviVO(int pnum, String cate, String word) {
		pg =pnum;
		NaviVO nav = new NaviVO();
		nav.setCurrPage(pg);// 현재 페이지
		
		nav.setLinks(getsearchNavlinks(pg, rowsPerPage, numsPerPage,cate,word));// 현재 페이지가 속한
		
		nav.setLeftMore(leftMore);// 왼쪽 이동 작성여부
		nav.setRightMore(rightMore);// 오른쪽 이동 작성여부
		nav.setTatalPages(totalPg);
		System.out.println(nav.getLinks().length+"link");
		return nav;
	}
	
	public int[] getsearchNavlinks(int page, int rowsPerPage, int numsPerPage,String cate, String word) {
		QnADAO dao = sqlSessionTemplate.getMapper(QnADAO.class);
		int totalPages =0;
		if(cate.equals("글제목")){
			totalPages = (dao.getsearchTotalRows(word) - 1) / rowsPerPage + 1;
		}
		else if(cate.equals("글쓴이")){
			totalPages = (dao.getsearchaTotalRows(word) - 1) / rowsPerPage + 1;
		}
		// 로우넘의 최대 숫자(총 로우넘 갯수와 동일)에 1을 빼서 한페이지당 행수로 나누고 1을 더하면 총 페이지 수가 나온다(한
		// 페이지에 들어가는 행을 구하는 식과 연관성있음)
		totalPg = totalPages;

		int tmp = (page - 1) / numsPerPage + 1;
		// 현 페이지가 속하는 페이지 집단군의 산출(어느 행이 어느 페이지에 들어가는 가를 산출하는 식과 동일)
		int end = tmp * numsPerPage;
		// 페이지 집단군과 페이지 집단군별 최대 행수를 곱하면 그 페이지 집단군의 최대 숫자가 나온다.
		int start = (tmp - 1) * numsPerPage + 1;
		// 해당 페이지 집단군 바로 전 페단군의 최대 숫자에 1을 더하면 현재 페이지 집단군의 최소 숫자가 나온다
		if (start == 1)
			leftMore = false;
		// 혹시 그 최소 숫자가 1일 경우 왼쪽(<<) 링크를 출력하지 않도록 출력시 확인하는 boolean 갚을 false로 준다
		else
			leftMore = true;
		// 아닐 경우(1보다 클경우) 왼쪽 링크 출력시 확인하는 boolean 값을 true로 준다
		if (end >= totalPages) {
			end = totalPages;
			rightMore = false;
			// 혹시 최대 숫자가 총 페이지 숫자보다 크거나 같을 경우 오른쪽(>>) 링크를 출력하지 않도록 출력시 확인하는
			// boolean 값을 false로 준다
		} else
			rightMore = true;
		// 아닐경우(현 페이지 집단의 최대수보다 총 페이지 숫자가 클경우) 오른족 링크 출력시 확인하는 boolean 값을 true로
		// 준다
		int[] links = new int[end - start + 1];
		// 페이지 넘버들이 담긴 배열을 만든다. 그 크기는 최대 숫자-최소숫자+1로 하며 그 이유는 최대 숫자와 최소 숫자의 차이가
		// 일정하다고 할수 없기 때문

		// 예) 5페이지 씩 출력하는 페이지 링크 집단의 페이지수가 총 13 페이지일 경우 1,2번째 링크군의 최소 최대 차는 4이지만
		// 3번째
		// 링크 군의 최대, 최소차이는 2 가된다
		for (int num = start, i = 0; num <= end; num++, i++) {
			links[i] = num;
		}
		// 루프를 통해 배열에 시작 넘버부터 마지막 넘버까지 집어 넣는다.
		return links;
	}

}
