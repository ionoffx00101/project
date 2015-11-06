package org.kdea.sgp.member;

import java.util.List;

public interface MemDAO {

	public int ETpwCheck(String pw);

	public int ETidCheck(String id);

	public int ETpwUpdate(BoardVO bvo);

	public int ETnickCheck(String nicksc);

	public int ETnewNickRegi(BoardVO bvo);

	public int ETemailEdit(BoardVO bvo);

	public int ETidsearchCheck(BoardVO bvo);

	public String SCidsc(BoardVO bvo);

	public int SCpwsc(BoardVO bvo);

	public void setTempPw(BoardVO bvo);

	
	//============================================================
	
	public int memregist(MemberVO mem);

	public int pwregist(MemberVO mem);
	
	public int getMnum(String id);

	public int idCheck(String id);

	public int nickCheck(String nick);
}
