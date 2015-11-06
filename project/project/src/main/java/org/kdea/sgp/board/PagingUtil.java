package org.kdea.sgp.board;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class PagingUtil {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	private boolean DEBUG = true;
	private boolean leftMore;
	private boolean rightMore;
	private int pg = 1;  //현재 페이지
	private int totalPages;
	private static int rowsPerPage = 4;  // 한 화면당 출력할 행수
	private static int numsPerPage = 2;
	private int totalRows;
	
	public NaviVO navi(int page, int totalRows) {
		this.pg = page;
		this.totalRows = totalRows;
		NaviVO nvo = getNavVO();  // 이용자가 리스트를 보기만하면 네비게이션VO도 따라가게 하고 jsp에 보이게 한다.
		return nvo;
	}
	
	private NaviVO getNavVO() {  // 이용자가 리스트를 보고 싶어할때 이 메소드가 호출 되게 해서 jsp로 넘어가게 한다. 
		NaviVO nav = new NaviVO();
		nav.setCurrPage(pg);
		nav.setLinks(getNavLinks(pg, rowsPerPage, numsPerPage));
		nav.setTotalPages(totalPages);
		nav.setLeftMore(leftMore);
		nav.setRightMore(rightMore);
		return nav;
	}
	
	private int[] getNavLinks(int page, int rowsPerPage, int numsPerPage) {
		System.out.printf("page=%d, RPP=%d, NPP=%d \n",page, rowsPerPage, numsPerPage);
        
        totalPages = (totalRows-1)/rowsPerPage+1;
        //System.out.printf("%d행씩 총페이지 수:%d \n", rowsPerPage, totalPages);
         
        int tmp = (page-1)/numsPerPage+1; // 몇번째 링크그룹에 속하는가?
        //System.out.printf("%d번째 링크 그룹",tmp);
        int end = tmp*numsPerPage;
        int start = (tmp-1)*numsPerPage+1;
         
        if(start==1) leftMore = false; // << 왼쪽 이동 출력여부
        else leftMore = true;
        if(end>=totalPages) {         // >> 오른쪽 이동 출력여부 // 끝 번호가 총페이지 수를 초과해서는 안되기때문에 
            end = totalPages;  // end가 totalPages를 넘어서면 안되기때문에 이렇게 해줌
            rightMore = false;
        }else rightMore = true;
        //System.out.printf("START:%d~END:%d \n",start, end);
         
        int[] links = new int[end-start+1];  // 링크의 숫자를 담는다
        for(int num=start,i=0;num<=end;num++,i++) {
            links[i] = num;
        }/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        return links;
    }
}
