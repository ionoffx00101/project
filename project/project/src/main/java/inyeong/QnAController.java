package inyeong;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("temp")
public class QnAController {

	@Autowired
	public QnAService qnasvc;
	
	@Autowired
	public NaviService navisvc;
	
	@RequestMapping(value="home", method=RequestMethod.GET)
    public String homelnk(Model model,HttpServletRequest request) {
		
		return "qna/home";
    }
	
	
	@RequestMapping(value="qna", method=RequestMethod.GET)
    public String qnalnk(Model model,HttpServletRequest request,@RequestParam int pnum) {
		
		List<QnABoardVO> list = navisvc.svclist(pnum);
		NaviVO navi = navisvc.getNaviVO(pnum);
		navi.setLinknum(navi.getLinks().length);
		model.addAttribute("list", list);
		model.addAttribute("navi", navi);
		model.addAttribute("search", false);
        //return "qna/qnalist";
		return "qna/qnalist";
    }
	
	@RequestMapping(value="faq", method=RequestMethod.GET)
    public String faqlnk(Model model,HttpServletRequest request) {
    
        return "qna/faq";
    }
	
	@RequestMapping(value="qnapost", method=RequestMethod.GET)
    public String qnapostlnk(Model model,HttpServletRequest request,QnABoardVO vo) {
		model.addAttribute("QnABoardVO", vo);

        return "qna/qnapost";
    }
	
	@RequestMapping(value="qnarepost", method=RequestMethod.GET)
    public String qnarepostlnk(Model model,HttpServletRequest request,@RequestParam int refnum,@RequestParam String reftitle) {

		model.addAttribute("ref", refnum);
		model.addAttribute("title", "re:"+reftitle);

        return "qna/qnapost";
    }
	
	@RequestMapping(value="qnapost", method=RequestMethod.POST)
	@ResponseBody
    public String qnapostfn(QnABoardVO vo) {

		int num =qnasvc.newpost(vo);//boardsvc.inputpost(vo);
		boolean check = num>0 ? true : false;

    	return "{\"check\":"+check+",\"num\":"+num+"}";
    }
	
	@RequestMapping(value="qnaread", method=RequestMethod.GET)
    public String qnareadlnk(Model model,HttpServletRequest request) {
		model.addAttribute("post",qnasvc.getPost(request));
		model.addAttribute("replylist",qnasvc.getPostReply(request));
        return "qna/qnaread";
    }
	
	@RequestMapping(value="qnamodi", method=RequestMethod.GET)
    public String qnamodilnk(Model model,HttpServletRequest request) {
		model.addAttribute("post",qnasvc.getPost(request));
        return "qna/qnamodi";
    }
	
	@RequestMapping(value="qnamodi", method=RequestMethod.POST)
	@ResponseBody
    public String qnamodifn(Model model,QnABoardVO vo,HttpServletRequest request) {
    
		boolean postcheck=qnasvc.modipost(vo);//boardsvc.inputpost(vo);
    	return "{\"check\":"+postcheck+",\"num\":"+vo.getNum()+"}";
    	
    }
	
	@RequestMapping(value="qnadel", method=RequestMethod.POST)
	@ResponseBody
    public String qnadelfn(Model model,HttpServletRequest request) {
		
		boolean postcheck=qnasvc.delpost(request);//boardsvc.inputpost(vo);
    	return "{\"check\":"+postcheck+"}";

    }
	
	@RequestMapping(value="search", method=RequestMethod.GET)
	public String search(Model model, QnABoardVO vo,HttpServletRequest request,@RequestParam("word") String word,@RequestParam("cate") String cate,@RequestParam("pnum") int pnum) {

		
		List<QnABoardVO> list = qnasvc.svcsearch(word,cate,pnum);

		NaviVO navi = navisvc.getsearchNaviVO(pnum,cate,word);

		navi.setLinknum(navi.getLinks().length);
		
		model.addAttribute("list",list);
		model.addAttribute("navi", navi);
		model.addAttribute("word", word);
		model.addAttribute("cate", cate);
		model.addAttribute("search", true);
    	return "qna/qnalist";
	}
	
	@RequestMapping(value="gameinfo", method=RequestMethod.GET)
    public String gameinfolnk(Model model,HttpServletRequest request) {
		
        return "gameinfo/gameinfo";
    }
	@RequestMapping(value="gamecont", method=RequestMethod.GET)
    public String gamecontlnk(Model model,HttpServletRequest request) {
		
        return "gameinfo/gamecont";
    }
}
