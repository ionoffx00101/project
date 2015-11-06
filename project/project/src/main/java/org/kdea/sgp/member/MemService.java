package org.kdea.sgp.member;

import java.util.List;
import java.util.Random;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service("MemService")
public class MemService {
	
	@Autowired
	protected JavaMailSender  mailSender;

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public boolean editPWcheck(String pw) {
		MemDAO mdao = sqlSessionTemplate.getMapper(MemDAO.class);
		System.out.println("비번소스:"+pw);
		System.out.println("비번확인결과0.5:"+mdao.ETpwCheck(pw));
		boolean ok = mdao.ETpwCheck(pw)>0?true:false;
		System.out.println("비번확인결과:"+ok);
		return ok;
	}

	public boolean editIDcheck(String id) {
		MemDAO mdao = sqlSessionTemplate.getMapper(MemDAO.class);
		boolean ok = mdao.ETidCheck(id)>0?true:false;
		System.out.println("아이디확인결과:"+ok);
		return ok;
	}
	
	public boolean updatePW(BoardVO bvo) {
		MemDAO mdao = sqlSessionTemplate.getMapper(MemDAO.class);
		boolean ok = mdao.ETpwUpdate(bvo)>0?true:false;
		System.out.println("업데이트 확인결과 : "+ok);
		return ok;
	}

	public boolean editNickcheck(String nicksc) {
		MemDAO mdao = sqlSessionTemplate.getMapper(MemDAO.class);
		boolean ok = mdao.ETnickCheck(nicksc)>0?false:true;
		System.out.println("중복확인 결과:"+ok);
		return ok;
	}

	public boolean newNickRegi(BoardVO bvo) {
		MemDAO mdao = sqlSessionTemplate.getMapper(MemDAO.class);
		boolean ok = mdao.ETnewNickRegi(bvo)>0?true:false;
		return ok;
	}

	public boolean emailEdit(BoardVO bvo) {
		MemDAO mdao = sqlSessionTemplate.getMapper(MemDAO.class);
		boolean ok = mdao.ETemailEdit(bvo)>0?true:false;
		return ok;
	}

	public boolean idsearchCheck(BoardVO bvo) {
		MemDAO mdao = sqlSessionTemplate.getMapper(MemDAO.class);
		boolean ok = mdao.ETidsearchCheck(bvo)>0?true:false;
		return ok;
	}

	public boolean sendMail(BoardVO bvo) {
		MemDAO mdao = sqlSessionTemplate.getMapper(MemDAO.class);
		try{
		        MimeMessage msg = mailSender.createMimeMessage();
		     	msg.setFrom("syasyapeu@naver.com"); 
		        msg.setSubject("안녕하세요 XX사이트의 고객님의 ID 찾기 결과입니다.");
		        
		        msg.setContent("찾으시는 아이디는 "+mdao.SCidsc(bvo)+"입니다.", "text/html; charset=utf-8");
		        msg.setRecipient(RecipientType.TO , new InternetAddress(bvo.getEmail()));
		         
		        mailSender.send(msg);
		        return true;
	        }catch(Exception ex) {
	        	ex.printStackTrace();
	        }
	        return false;
	}

	public String IdSearchResult(BoardVO bvo) {
		MemDAO mdao = sqlSessionTemplate.getMapper(MemDAO.class);
		
		return mdao.SCidsc(bvo);
	}

	public boolean sendTempMail(BoardVO bvo) {
		MemDAO mdao = sqlSessionTemplate.getMapper(MemDAO.class);
		bvo.setNum(mdao.SCpwsc(bvo));
	      Random randomMaking = new Random();
	      int i = 1;
	       String randomPwdCheakingResult = "";
	      while (i < 10) {
	       int randomMakingNumber = randomMaking.nextInt(25) + 65;
	       char randomMakingNumberChange = (char) randomMakingNumber;
	       randomPwdCheakingResult += randomMakingNumberChange;
	       i++;
	      }
	      bvo.setPw(randomPwdCheakingResult);
	      bvo.setTemp(1);
	      mdao.setTempPw(bvo);
		    try{
		        MimeMessage msg = mailSender.createMimeMessage();
		     	msg.setFrom("syasyapeu@naver.com"); 
		        msg.setSubject("안녕하세요 XX사이트의 고객님의 임시비밀번호입니다..");
		        
		        msg.setContent("임시비밀번호는 "+randomPwdCheakingResult+"입니다.", "text/html; charset=utf-8");
		        msg.setRecipient(RecipientType.TO , new InternetAddress(bvo.getEmail()));
		         
		        mailSender.send(msg);
		        return true;
	        }catch(Exception ex) {
	        	ex.printStackTrace();
	        }
	        return false;
		
	}
	
	//=====================================================================================================
    public boolean sendMail(EmailVO email) throws Exception {
        try{
	        MimeMessage msg = mailSender.createMimeMessage();
	     	msg.setFrom("someone@paran.com"); 
	        msg.setSubject(email.getSubject());
	        msg.setContent(email.getContent(), "text/html; charset=utf-8");
	        
	        msg.setRecipient(RecipientType.TO , new InternetAddress(email.getReceiver()));
	         
	        mailSender.send(msg);
	        return true;
        }catch(Exception ex) {
        	ex.printStackTrace();
        }
        return false;
    }

	public boolean nickCheck(String nick) {
		MemDAO dao = sqlSessionTemplate.getMapper(MemDAO.class);
		int result= dao.nickCheck(nick);
		if(result==0){
			return true;
		}
		return false;
	}

	public boolean idCheck(String id) {
		MemDAO dao = sqlSessionTemplate.getMapper(MemDAO.class);
		int result= dao.idCheck(id);
		System.out.println("중복검사 결과 소스:"+result);
		if(result==0){
			return true;
		}
		return false;
	}

	public boolean regist(MemberVO member) {
		MemDAO dao = sqlSessionTemplate.getMapper(MemDAO.class);
		int result1=dao.memregist(member);
		int mnum=dao.getMnum(member.getId());
		member.setMnum(mnum);
		
		int result2=dao.pwregist(member);
		
		if(result2>0&&result1>0){
			return true;
		}
		
		return false;
	}
	


}
