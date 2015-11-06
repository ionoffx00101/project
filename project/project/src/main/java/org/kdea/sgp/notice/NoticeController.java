package org.kdea.sgp.notice;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("notice")
public class NoticeController {

	@Autowired
	private NBservice nbs;

	@Autowired
	private PagingUtil pu;
	
	String catego;
	String title;
	String author;

	@RequestMapping("/nologin")
	public String login() {

		return "noticeboard/loginForm";
	}

	@RequestMapping(value = "logingo", method = RequestMethod.POST)
	@ResponseBody
	public String logingo(BoardLoginVO bvo, HttpServletRequest request) {
		System.out.println("확인:" + bvo.getEname());
		nbs.requestSc(request);

		return "{\"ok\":" + nbs.getlogin(bvo) + "}";
	}

	@RequestMapping("/list")
	public String getList(Model model) {
		int page = 1;
		model.addAttribute("list", nbs.getlist(page));
		model.addAttribute("nvo", pu.getNav(page));

		return "noticeboard/nbList";
	}

	@RequestMapping("/nvi")
	public String getNavi(Model model, @RequestParam int page) {
		System.out.println("페이지: "+page);
		model.addAttribute("nvo", pu.getNav(page));
		model.addAttribute("list", nbs.getlist(page));

		return "noticeboard/nbList";
	}

	@RequestMapping("/write")
	public String write() {

		return "noticeboard/nbInputForm";
	}

	@RequestMapping(value = "/writeRegi", method = RequestMethod.POST)
	@ResponseBody
	public String writeRegi(BoardVO bvo, Model model) {
		System.out.println("확인:" + bvo.getAuthor());
		bvo.setWdate(new java.sql.Date(new Date().getTime()));
		model.addAttribute("date", bvo.getWdate());
		
		return "{\"infosource\":" + nbs.writeRegi(bvo) + "}";
	}

	@RequestMapping("/info")
	public String info(Model model, @RequestParam int infosc){
		System.out.println("info 소스 :"+infosc);
		model.addAttribute("list",nbs.getInfo(infosc));
		
		
		return "noticeboard/nbInfo";
	}
	
	@RequestMapping("/edit")
	public String edit(@RequestParam int editsc, Model model){
		model.addAttribute("list",nbs.geteditsc(editsc));
		
	return "noticeboard/nbEdit";	
	}
	
	@RequestMapping(value="/editgo",method=RequestMethod.POST)
	@ResponseBody
	public String editgo(BoardVO bvo){
		
		
		return "{\"ok\":"+nbs.editgo(bvo)+"}";
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	@ResponseBody
	public String delete(BoardVO bvo){
		
	return "{\"ok\":"+nbs.deletego(bvo.getNum())+"}";
	}
	
	@RequestMapping("/search")
	public String getSearch(Model model, @RequestParam String catego, String Ssc){
		int page = 1;
		   if(catego.equals("제목")){
			   System.out.println("제목검색");
			   SearchVO svo = new SearchVO();
				svo.setPage(page);
				svo.setTitle(Ssc);
				this.catego=catego;
				this.title=Ssc;
			   model.addAttribute("list",nbs.getSearch(svo));
			   model.addAttribute("nvo",pu.TgetNav(svo)); 
			   System.out.println("검색완료");
			   
			   return "noticeboard/nbSearch";
		   }else{
			  System.out.println("작성자검색");
			  SearchVO svo = new SearchVO();
			  svo.setPage(page);
			  svo.setAuthor(Ssc);
			  this.catego=catego;
			  this.author=Ssc;
			  model.addAttribute("list",nbs.getauthorSearch(svo));
			  model.addAttribute("nvo",pu.AgetNav(svo));
			  
			  return "noticeboard/nbSearch";
		   }
		
	}
	@RequestMapping("/searchnav")
	public String getNavi2(Model model, @RequestParam int page){

		SearchVO svo = new SearchVO();
		svo.setPage(page);
		svo.setAuthor(author);
		svo.setTitle(title);
		model.addAttribute("list",nbs.getnvSearch(svo,catego));
		model.addAttribute("nvo", pu.getnebiNav(svo,catego));
		
		return "noticeboard/nbSearch";
	}
	
}
