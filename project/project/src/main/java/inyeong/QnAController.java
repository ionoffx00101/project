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
		request.getSession().setAttribute("loginOk", "KING");
		request.getSession().setAttribute("ok", true); // 임시
		request.getSession().setAttribute("id", "tempid"); 
		request.getSession().setAttribute("nick", "닉네임");
		
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
		
		model.addAttribute("nick", (String)request.getSession().getAttribute("nick")); // 닉을 받아서  넣는다
		model.addAttribute("QnABoardVO", vo);

        return "qna/qnapost";
    }
	
	@RequestMapping(value="qnarepost", method=RequestMethod.GET)
    public String qnarepostlnk(Model model,HttpServletRequest request,@RequestParam int refnum,@RequestParam String reftitle) {
		
		String id =(String)request.getSession().getAttribute("nick");
		
		if(!id.equals("닉네임")){                   // 닉네임 자리에 운영자 닉네임이 들어가면 됨 지금은 임시로 만들어 둔것이다.
			return "redirect:/temp/qnaread?num="+refnum;
		}
		
		model.addAttribute("nick", id); // 닉을 받아서  넣는다
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
		
		/*비밀 글 기능 컬럼을 만들고 그 값이 true 일경우 위에 get post에서 그 게 뭔 값인지 받아올수 있을것이다 vo부터 테이블 수정까지 다해야한다 
		받아오면 이프문사용해서 비밀글이면 세션에 담긴 로그인 아이디가 뭔지 받아서 vo안에 있는 아이디값이랑 비교한다 맞아야지만 post 글로 보내준다
		아니면 리스트에 남아있는다.*/
		
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
  
		String id =(String)request.getSession().getAttribute("nick");
		
		if(!id.equals(vo.getAuthor())){                   // 닉네임 자리에 운영자 닉네임이 들어가면 됨 지금은 임시로 만들어 둔것이다.
			return "redirect:/temp/qnaread?num="+vo.getNum();
		}
		
		boolean postcheck=qnasvc.modipost(vo);//boardsvc.inputpost(vo);
		
    	return "{\"check\":"+postcheck+",\"num\":"+vo.getNum()+"}";
    	
    }
	
	@RequestMapping(value="qnadel", method=RequestMethod.POST)
	@ResponseBody
    public String qnadelfn(Model model,HttpServletRequest request,QnABoardVO vo) {
		
		System.out.println(vo.getAuthor()+"asd");
		
		boolean postcheck=qnasvc.delpost(request);//boardsvc.inputpost(vo);
    	
	/*	String id =(String)request.getSession().getAttribute("nick");
		
		if(!id.equals(vo.getAuthor())){                   // 닉네임 자리에 운영자 닉네임이 들어가면 됨 지금은 임시로 만들어 둔것이다.
			return "redirect:/temp/qnaread?num="+vo.getNum();
		}*/
		
		
		
		
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
	
	@RequestMapping(value="tempgame13", method=RequestMethod.GET)
    public String tempgame14lnk(Model model,HttpServletRequest request) {
		
        return "game/thirdMix(ver.jquery6.2)";
    }
}
