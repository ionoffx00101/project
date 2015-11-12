package org.kdea.sgp.game;

import java.util.Enumeration;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

public class GameInterceptor extends HttpSessionHandshakeInterceptor {

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {

		System.out.println("Before Handshake");

		ServletServerHttpRequest ssreq = (ServletServerHttpRequest) request;
		System.out.println("URI:" + request.getURI());

		HttpServletRequest req = ssreq.getServletRequest();
		System.out.println("param, id:" + req.getParameter("nick"));

		// 인터 셉터는 처음 페이지에 입장했을때만 실행된다.
		// 인터셉터를 통해서 집어넣어야 할 것은 어느곳에서 온 명령인지, 보낸 사람은 누구인지가 필수로 들어간다.
		String position = req.getParameter("position");
		String usrNick = req.getParameter("nick");

		attributes.put("usrNick", usrNick);
		attributes.put("position", position);
		
		// 하단 변수는 위치정보에 의해 2차적으로 들어가는 변수다
		int rnum;
		int gnum;

		// 입장한 페이지가 '방'일 경우 서버측에서 전송된 '방'의 번호를 같이 전송해줘야한다.(어느 맵에 세션을 집어넣을지를 결정해야 하기 때문)
		if (position.equals("room")) {
			rnum = Integer.parseInt(req.getParameter("rnum"));
			attributes.put("rnum", rnum);
		}
		else if (position.equals("game")) {
			rnum = Integer.parseInt(req.getParameter("rnum"));
			attributes.put("rnum", rnum);
			gnum = Integer.parseInt(req.getParameter("gnum"));
			attributes.put("gnum", gnum);
		}

		

		return super.beforeHandshake(request, response, wsHandler, attributes);
	}

	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception ex) {
		System.out.println("After Handshake");

		super.afterHandshake(request, response, wsHandler, ex);
	}

}