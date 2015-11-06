package org.kdea.sgp.mainpage;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/mainpage")
public class MainpageController {

	@Autowired
	private MainpageService ms;
	
	@RequestMapping("/main")
	public String maingo(){
		return "mainpage/home";
	}
	
	@RequestMapping(value="/logingo", method=RequestMethod.POST)
	@ResponseBody
	public String logingo(LoginVO lvo, HttpServletRequest request){
		System.out.println("로그인 소스:"+lvo.getId());	
		ms.requestsc(request);	
		
		return "{\"ok\":"+ms.logingo(lvo)+",\"temp\":"+ms.getTemp(lvo)+"}";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request){
		System.out.println("삭제전"+(String)request.getSession().getAttribute("loginOk"));
		request.getSession().removeAttribute("loginOk");
		System.out.println("결과"+(String)request.getSession().getAttribute("loginOk"));
		return "mainpage/home";
	}
}
