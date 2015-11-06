package org.kdea.sgp.mainpage;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("MainpageService")
public class MainpageService {

	HttpServletRequest request;
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public void requestsc(HttpServletRequest request) {
		this.request=request;
		
	}
	
	public boolean logingo(LoginVO lvo) {
		MainpageDAO mdao = sqlSessionTemplate.getMapper(MainpageDAO.class);
		boolean ok = mdao.logingo(lvo)>0?true:false;
		if(ok){
			request.getSession().setAttribute("loginOk", lvo.getId());
		}
		return ok;
	}

	public boolean getTemp(LoginVO lvo) {
		MainpageDAO mdao = sqlSessionTemplate.getMapper(MainpageDAO.class);
		boolean ok = mdao.getTemp(lvo)>0?true:false;
		System.out.println("템프 결과값:"+ok);
		return ok;
	}


}
