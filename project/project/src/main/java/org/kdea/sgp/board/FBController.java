package org.kdea.sgp.board;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("FB")
public class FBController {
	
	@Autowired 
	private FBService service; 
	private String searchChoice;
	private String key;
	
	@RequestMapping("inputForm")
	public String getInputForm(@ModelAttribute("vo") BoardVO vo, HttpServletRequest request) {
		
		return "freeBoard/boardInput";
	}
	
	@RequestMapping(value="input", method=RequestMethod.POST)
	public String setInsert(BoardVO vo) {
		service.setInput(vo);
		return "redirect:/FB/list";
	}
	
	@RequestMapping("list")
	public String getList(Model model, @ModelAttribute("vo") BoardVO vo, HttpServletRequest request) {
		model.addAttribute("list", service.getList(vo.getPage()));
		model.addAttribute("nvo", service.getNavi());
		return "freeBoard/boardList";
	}
	
	@RequestMapping("info")
	public String getInfo(Model model, @RequestParam int num, HttpServletRequest request) {
		BoardVO vo = service.getInfo(num);
		model.addAttribute("info", vo);
		model.addAttribute("reList", service.getReList(num));
		return "freeBoard/boardInfo";
	} 
	
	@RequestMapping("editForm")
	public String getEditForm(Model model, @RequestParam int num, HttpServletRequest request) {

		model.addAttribute("info", service.getInfo(num));
		return "freeBoard/boardEdit";
	}
	
	@RequestMapping("update")
	@ResponseBody
	public String setUpdate(@ModelAttribute BoardVO vo) {
		boolean ok = service.setUpdate(vo);
		String json = "{\"ok\":" + ok + "}";
		return json;
	}
	
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	@ResponseBody
	public BoardVO setDelete(BoardVO vo, HttpSession session) {
		String checkAuthor = (String)session.getAttribute("id");
		if(checkAuthor.equals(vo.getCheckAuthor())) {
			vo.setOk(service.setDelete(vo.getNum()));
			return vo;
		}
		else {
			vo.setOk(false);
			return vo;
		}
	}
	
	@RequestMapping("search")
	 public String search(Model model, @RequestParam String searchChoice, @RequestParam String key, @ModelAttribute("vo") BoardVO vo,HttpServletRequest request) {
		this.searchChoice = searchChoice;
		this.key = key;
		model.addAttribute("list", service.getSearch(this.searchChoice, this.key, vo.getPage()));
		model.addAttribute("nvo", service.getSearchNavi(this.searchChoice, this.key));
		return "freeBoard/boardSearch";
	 }
	
	@RequestMapping("searchNavi")
	 public String search(Model model, @ModelAttribute("vo") BoardVO vo, HttpServletRequest request) {

		model.addAttribute("list", service.getSearch(searchChoice, key, vo.getPage()));
		model.addAttribute("nvo", service.getSearchNavi(searchChoice, key));
		return "freeBoard/boardSearch";
	}
	
	@RequestMapping("replyInput")//´ñ±Û¾²±â
	@ResponseBody
	public ReplyVO setReplyInput(Model model, ReplyVO vo) {
		System.out.println(vo.getReContents());
		vo = service.setReplyInput(vo);
		return vo;
	}
	
	@RequestMapping("replyDelete")
	@ResponseBody
	public ReplyVO setReplyDelete(HttpSession session, ReplyVO vo) {
		String author = service.getReAuthor(vo.getReNum());
		String checkAuthor = (String)session.getAttribute("id");
		if(checkAuthor.equals(author)) {
			vo.setOk(service.setReplyDelete(vo));
			return vo;
		}
		else {
			vo.setOk(false);
			return vo;
		}
	}
}
