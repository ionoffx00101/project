package org.kdea.sgp.game;

import java.io.IOException;
import java.security.Key;
import java.util.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class GameHandler extends TextWebSocketHandler {
	private static Map<String, WebSocketSession> sessionMap = new HashMap<String, WebSocketSession>();

	private static Map<Integer, Map> listMemberMap = new HashMap<Integer, Map>();

	private static Map<Integer, Map> listDataMap = new HashMap<Integer, Map>();

	private static Map<Integer, Map> gameMembersMap = new HashMap<Integer, Map>();

	private static Map<Integer, Map> gameDataMap = new HashMap<Integer, Map>();

	private int rnum = 1;
	private int gnum = 1;

	// 웹소켓 서버측에 텍스트 메시지가 접수되면 호출되는 메소드
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		// 클라이언트에서 올라온 메시지를 문자열로 바꾼다
		String payloadMessage = (String) message.getPayload();

		// 통신은 모조리 제이슨 문자열을 통해 하게 된다(서버에 핸들러는 1개만 있는게 안정적이기에 다종 다양한 명령을 받기 위해서는
		// 제이슨문자열이 필수가 된다) 그렇기에 웹소켓이 통신을 받게 되면 제이슨 파서를 호출한다.
		JSONParser jsonParser = new JSONParser();

		try {
			// 제이슨 파서를 통해 문자열을 제이슨 오브젝트로 만든다.
			JSONObject jsonObj = (JSONObject) jsonParser.parse(payloadMessage);

			// 오브젝트 내의 조건을 단계별로 검증함으로서 명령을 구분하게된다. 우선순위는 얼마나 많은 종류의 페이지에서 쓰는가를
			// 기준으로 한다. 그런 의미에서 가장 중요한것은 어느 종류의 페이지에서 명령이 왔는가하는것 즉 위치를 알아보는 것이
			// 된다.
			// 그런 의미에서 맨먼저 '위치' 정보를 먼저 받는다(서로 공톨되는 명령이라고 해도 안쓰는 페이지가 있으면 검증을 위해
			// 헛도는 로직이 생긴다. 로직구성은 코드 절약보단 로직 필연성을 우선했다.)
			String position = (String) jsonObj.get("position");

			try {
				// 보내진 페이지가 '방 목록'인경우 불러와지는 명령들
				if (position.equals("roomList")) {
					// 위치가 '목록'인것을 확인한 뒤에 '명령'을 검사한다.
					String cmd = (String) jsonObj.get("cmd");
					// 명령이 채팅인경우 현재 목록 페이지에 접속되어 있는 전원(세션 맵에 담긴 세션들 전부)에게 메시지를
					// 전달한다
					if (cmd.equals("chat")) {

						Iterator<String> sessionkeys = sessionMap.keySet().iterator();
						while (sessionkeys.hasNext()) {
							String key = sessionkeys.next();
							sessionMap.get(key).sendMessage(new TextMessage(payloadMessage));
						}

					}
					// 명령이 '방 만들기'인경우
					else if (cmd.equals("roomCreate")) {
						// 방 이름과 방을 만든 사람의 이름을 받아낸다
						String nick = (String) jsonObj.get("nick");
						String roomName = (String) jsonObj.get("roomName");

						// 방정보용 맵으로 사용할 맵을 만든다.
						Map<String, String> roomDataMap = new HashMap<String, String>();

						// 정보맵에 각종 정보를 집어 넣는다
						roomDataMap.put("master", nick);
						roomDataMap.put("roomName", roomName);
						roomDataMap.put("memCnt", "0");
						roomDataMap.put("roomCondition", "ready");

						// 방멤버의 세션을 담을 맴을 만들 맴을 만들고 해당맵을 담는 용도의 리스트에 저장한다.
						// 그 이후 동인한 키를 이용해서 위쪽에서 만든 정보용 맵을 담는다.(방의 정보와 세션이 저장되는
						// 2종류의 맵이 생긴다.)
						listMemberMap.put(rnum, new HashMap<String, WebSocketSession>());
						listDataMap.put(rnum, roomDataMap);

						// 요청자에게 반환할 제이슨 오브젝트를 만들고 방이 만들어졌으니 입장하라는 명령과 방의 번호를
						// 담는다.
						JSONObject reTurnJson = new JSONObject();
						reTurnJson.put("cmd", "enter");
						reTurnJson.put("rnum", rnum);

						// 제이슨 오브젝트를 문자열로 만든다.
						String sJson = reTurnJson.toJSONString();

						// 방 작성자에게 명령을 돌려보낸다
						sessionMap.get(nick).sendMessage(new TextMessage(sJson));

						// 방 정보의 고유성을 위하여 키값을 하나 올려둔다
						rnum += 1;

					}
					if (cmd.equals("enterCheck")) {
						String nick = (String) jsonObj.get("nick");
						int roomNum = Integer.parseInt((String) jsonObj.get("rnum"));
						Map<String, String> roomDataMap = listDataMap.get(roomNum);
						int memCnt = Integer.parseInt(roomDataMap.get("memCnt"));
						String roomCondition = roomDataMap.get("roomCondition");

						JSONObject reTurnJson = new JSONObject();
						if (memCnt < 2 && roomCondition.equals("ready")) {

							reTurnJson.put("cmd", "enter");
							reTurnJson.put("rnum", roomNum);

							// 방 작성자에게 명령을 돌려보낸다

						} else {

							reTurnJson.put("cmd", "enterFalse");

							// 제이슨 오브젝트를 문자열로 만든다.

						}
						// 방 작성자에게 명령을 돌려보낸다
						String sJson = reTurnJson.toJSONString();
						sessionMap.get(nick).sendMessage(new TextMessage(sJson));
					}
				} // 위치가 방에서 온 명령인경우 (현재 채팅기능만 담겨있어서 따로 명령을 인식하지 않는다. 명령 구분은 후에
					// 반드시 들어가는 기능이기에 재갱신 예정)
				else if (position.equals("room")) {

					String cmd = (String) jsonObj.get("cmd");
					if (cmd.equals("chat")) {
						Map<String, Object> map = session.getAttributes();
						int rnum = (Integer) map.get("rnum");
						Map<String, WebSocketSession> roomMemberMap = listMemberMap.get(rnum);

						Iterator<String> keys = roomMemberMap.keySet().iterator();
						while (keys.hasNext()) {
							String key = keys.next();
							roomMemberMap.get(key).sendMessage(new TextMessage(payloadMessage));
						}
					} else if (cmd.equals("invite")) {
						String receiver = (String) jsonObj.get("receiver");
						sessionMap.get(receiver).sendMessage(new TextMessage(payloadMessage));
						;
					} else if (cmd.equals("kickout")) {
						String nick = (String) jsonObj.get("nick");
						Map<String, Object> map = session.getAttributes();
						int rnum = (Integer) map.get("rnum");
						Map<String, WebSocketSession> roomMemberMap = listMemberMap.get(rnum);

						roomMemberMap.get(nick).sendMessage(new TextMessage(payloadMessage));
					} else if (cmd.equals("ready")) {
						Map<String, Object> map = session.getAttributes();
						int rnum = (Integer) map.get("rnum");
						Map<String, WebSocketSession> roomMemberMap = listMemberMap.get(rnum);
						Iterator<String> roomMemberKeys = roomMemberMap.keySet().iterator();
						while (roomMemberKeys.hasNext()) {
							String key = roomMemberKeys.next();
							roomMemberMap.get(key).sendMessage(new TextMessage(payloadMessage));
							System.out.println(key + "에게 전송 완료");
						}
					} else if (cmd.equals("start")) {
						Map<String, Object> map = session.getAttributes();
						int rnum = (Integer) map.get("rnum");

						Map<String, String> gameData = new HashMap<String, String>();
						gameData.put("gameCondition", "game");
						gameData.put("memCnt", "0");

						gameMembersMap.put(gnum, new HashMap<String, WebSocketSession>());
						gameDataMap.put(gnum, gameData);

						Map<String, String> roomDataMap = listDataMap.get(rnum);
						String roomCondition = "game";
						roomDataMap.put("roomCondition", roomCondition);

						JSONObject startCmd = new JSONObject();
						startCmd.put("cmd", "start");
						startCmd.put("gnum", gnum);
						

						String sJson = startCmd.toJSONString();

						Map<String, WebSocketSession> roomMemberMap = listMemberMap.get(rnum);
						Iterator<String> roomMemberKeys = roomMemberMap.keySet().iterator();
						while (roomMemberKeys.hasNext()) {
							String key = roomMemberKeys.next();
							roomMemberMap.get(key).sendMessage(new TextMessage(sJson));
							System.out.println(key + "에게 전송 완료");
						}
						gnum += 1;
						roomListupdate();
					}
				} else if (position.equals("game")) {
					String cmd = (String) jsonObj.get("cmd");
					if (cmd.equals("end")) {
						Map<String, Object> map = session.getAttributes();
						int gnum = (Integer) map.get("gnum");
						Map<String, WebSocketSession> gameMember = gameMembersMap.get(gnum);
						Iterator<String> Keys = gameMember.keySet().iterator();
						while (Keys.hasNext()) {
							String key = Keys.next();
							gameMember.get(key).sendMessage(new TextMessage(payloadMessage));
							System.out.println(key + "에게 전송 완료");
						}
					}
					if (cmd.equals("playing")) {
						Map<String, Object> map = session.getAttributes();
						int gnum = (Integer) map.get("gnum");
						String nick = (String) map.get("nick"); // 닉이 같을때 보내지 않
						
						//System.out.println(payloadMessage);
						
						Map<String, WebSocketSession> gameMember = gameMembersMap.get(gnum);
						Iterator<String> Keys = gameMember.keySet().iterator();
						while (Keys.hasNext()) {
							String key = Keys.next();
							if(!key.equals(nick)){
								gameMember.get(key).sendMessage(new TextMessage(payloadMessage));
							}
						}
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}

		} catch (ParseException e) {
			e.printStackTrace();
		}

	}

	// 웹소켓 서버에 클라이언트가 접속하면 호출되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		super.afterConnectionEstablished(session);

		// 처음 접속 했을때 필수적으로 받아야하는 것은 어느 페이지에서 접속했는가와 접속자명이므로 두 값을 받아낸다(어느 맵에 세션과
		// 닉네임을 저장할지를 알기 위해 필요하다)
		Map<String, Object> map = session.getAttributes();
		String nick = (String) map.get("usrNick");
		String position = (String) map.get("position");

		// 페이지가 '방 목록'인 경우
		if (position.equals("roomList")) {
			// 세션맵에 닉네임을 키로 세션을 저장한다
			sessionMap.put(nick, session);

			// 접속자에게 방목록의 정보를 전송하기 위해 제이슨 오브젝트와 배열을 준비한다.
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("cmd", "roomList");
			JSONArray jsonArr = new JSONArray();

			// 방목록을 만들기 위해 방정보맵 목록의 키값을 받아낸다
			Iterator<Integer> keys = listDataMap.keySet().iterator();
			while (keys.hasNext()) {
				int key = keys.next();

				// 리스트에 담을 제이슨 오브젝트를 만든다. 그리고 방정보맵의 키값이 방의 번호이므로 바로 오브젝트에 담는다
				JSONObject listData = new JSONObject();
				listData.put("rnum", key);

				// 방정보맵 목록에서 방정보 맵을 키값을 이용해 가져오고 그 안에서 각종 정보를 뽑아내어 제이슨 오브젝트에 담는다
				Map<String, String> roomDataMap = listDataMap.get(key);
				String roomName = roomDataMap.get("roomName");
				listData.put("roomName", roomName);

				// 완성된 제이슨 오브젝트를 배열에 담는다
				jsonArr.add(listData);
			}

			// 반환용 제이슨 오브젝트에 완성된 배열을 담고 문자열로 만든다
			jsonObj.put("list", jsonArr);
			String sJson = jsonObj.toJSONString();

			// 방목록에 입장한 유저에게 보내준다.
			sessionMap.get(nick).sendMessage(new TextMessage(sJson));

			memListupdate();

		}

		// 페이지가 '방'인 경우
		else if (position.equals("room")) {

			// 파라미터로 인터셉터에서 받아낸 방 숫자을 뽑아내고 해당 방 숫자를 키로 하는 방 을 불러내어 닉네임과 세션을
			// 담는다(아래쪽은 리스트 갱신 기능이나 이또한 조건에 의해 실행 여부가 결정될 예정이므로 후일 기재한다)
			int rnum = (Integer) map.get("rnum");
			Map<String, WebSocketSession> roomMemberMap = listMemberMap.get(rnum);
			roomMemberMap.put(nick, session);
			System.out.println("방 입장 완료");
			Map<String, String> roomDataMap = listDataMap.get(rnum);
			int memCnt = Integer.parseInt(roomDataMap.get("memCnt")) + 1;
			roomDataMap.put("memCnt", Integer.toString(memCnt));
			System.out.println("방 인원수 조정:" + memCnt);
			if (memCnt > 1) {
				String roomCondition = "ready";
				roomDataMap.put("roomCondition", roomCondition);
			}
			roomUpdate(roomMemberMap, roomDataMap);
			// 방 내부 인원에게 방 정보를 전송한다.
			JSONObject roomData = new JSONObject();
			roomData.put("cmd", "roomUpdate");

			JSONArray roomMembers = new JSONArray();
			Iterator<String> roomMemNames = roomMemberMap.keySet().iterator();
			while (roomMemNames.hasNext()) {
				String key = roomMemNames.next();
				roomMembers.add(key);
			}
			roomData.put("roomMembers", roomMembers);

			JSONArray memList = new JSONArray();
			Iterator<String> members = sessionMap.keySet().iterator();
			while (members.hasNext()) {
				String member = members.next();
				memList.add(member);
			}
			roomData.put("list", memList);
			roomData.put("master", roomDataMap.get("master"));
			roomData.put("memCnt", roomDataMap.get("memCnt"));

			String sJson = roomData.toJSONString();

			Iterator<String> roomMemberKeys = roomMemberMap.keySet().iterator();
			while (roomMemberKeys.hasNext()) {
				String key = roomMemberKeys.next();
				roomMemberMap.get(key).sendMessage(new TextMessage(sJson));
				System.out.println(key + "에게 전송 완료");
			}
			System.out.println("방 업데이트 완료");
			roomListupdate();
		}
		//페이지가 '게임'인경우
		else if (position.equals("game")) {

			// 파라미터로 인터셉터에서 받아낸 방 숫자을 뽑아내고 해당 방 숫자를 키로 하는 방 을 불러내어 닉네임과 세션을
			// 담는다(아래쪽은 리스트 갱신 기능이나 이또한 조건에 의해 실행 여부가 결정될 예정이므로 후일 기재한다)
			int gnum = (Integer) map.get("gnum");
			Map<String, WebSocketSession> gameMember = gameMembersMap.get(gnum);
			gameMember.put(nick, session);
			System.out.println("방 입장 완료");
			Map<String, String> gameData = gameDataMap.get(gnum);
			int memCnt = Integer.parseInt(gameData.get("memCnt")) + 1;
			gameData.put("memCnt", Integer.toString(memCnt));
			System.out.println("게임 인원수 조정:" + memCnt);
			if (memCnt == 2) {
				JSONObject startCmd = new JSONObject();
				startCmd.put("cmd", "start");

				String sJson = startCmd.toJSONString();

				Iterator<String> Keys = gameMember.keySet().iterator();
				while (Keys.hasNext()) {
					String key = Keys.next();
					gameMember.get(key).sendMessage(new TextMessage(sJson));
				}
				System.out.println("방 업데이트 완료");
				
			}
			
			roomListupdate();
		}
		
		System.out.println("클라이언트 접속됨");

	}

	// 클라이언트가 접속을 종료하면 호출되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		super.afterConnectionClosed(session, status);

		// 접속 종료시 유저의 닉네임을 받는다
		Map<String, Object> map = session.getAttributes();
		String nick = (String) map.get("usrNick");

		// 닉네임을 가지고 세션맵을 튀져 해당 유저가 존재할 시에 유저를 지운다.
		Iterator<String> listkeys = sessionMap.keySet().iterator();
		while (listkeys.hasNext()) {
			String key = listkeys.next();
			if (key.equals(nick)) {
				sessionMap.remove(nick);
				System.out.println(nick + "룸 리스트 접속종료");
				memListupdate();
			}

		}

		// 다음으로 방에 소속된 유져의 세션을 뒤지게 되나 약간의 단계를 필요로 한다. 일단 방 목록 역할을 하는 리스트 멤버 맵의
		// 키를 가져온다
		Iterator<Integer> roomkeys = listMemberMap.keySet().iterator();
		while (roomkeys.hasNext()) {
			// 키값을 사용해서 리스트 멤버맵 내부의 각 방의 닉네임과 세션이 담긴 맵을 불러낸다.
			int key = roomkeys.next();
			Map<String, WebSocketSession> roomMemberMap = listMemberMap.get(key);

			// 해당맵을 뒤져 일치하는 닉네임이 있을 경우 해당 세션을 삭제한다.(후일 조건에 따른 맵자체 삭제도 생성 예정)
			Iterator<String> roomkeys2 = roomMemberMap.keySet().iterator();
			while (roomkeys2.hasNext()) {
				String key2 = roomkeys2.next();
				if (key2.equals(nick)) {
					roomMemberMap.remove(nick);
					System.out.println(nick + "룸  접속종료");

					// 접속 종료시 방의 정보내의 인원수를 내린다.
					Map<String, String> roomDataMap = listDataMap.get(key);
					int memCnt = Integer.parseInt(roomDataMap.get("memCnt")) - 1;
					System.out.println("현재 방 인원수" + memCnt);
					roomDataMap.put("memCnt", Integer.toString(memCnt));

					// 만약 방의 인원수가 0이라면 방의 상태를 체크하여 일반 대기중일시 방을 지운다.
					if (memCnt == 0) {
						if (roomDataMap.get("roomCondition").equals("ready")) {
							listDataMap.remove(key);
							listMemberMap.remove(key);

							roomListupdate();

						}
					} else {
						String master = roomDataMap.get("master");
						if (nick.equals(master)) {
							Iterator<String> remainMember = roomMemberMap.keySet().iterator();
							if (remainMember.hasNext()) {
								String nextMaster = remainMember.next();
								roomDataMap.put("master", nextMaster);
							}
						}
						roomUpdate(roomMemberMap, roomDataMap);
					}

				}

			}

		}
		
		
		//
		Iterator<Integer> gamekeys = gameMembersMap.keySet().iterator();
		while (gamekeys.hasNext()) {
			// 키값을 사용해서 리스트 멤버맵 내부의 각 방의 닉네임과 세션이 담긴 맵을 불러낸다.
			int key = gamekeys.next();
			Map<String, WebSocketSession> gameMember = gameMembersMap.get(key);

			// 해당맵을 뒤져 일치하는 닉네임이 있을 경우 해당 세션을 삭제한다.(후일 조건에 따른 맵자체 삭제도 생성 예정)
			Iterator<String> gamekeys2 = gameMember.keySet().iterator();
			while (gamekeys2.hasNext()) {
				String key2 = gamekeys2.next();
				if (key2.equals(nick)) {
					gameMember.remove(nick);
					System.out.println(nick + " 게임  접속종료");

					// 접속 종료시 방의 정보내의 인원수를 내린다.
					Map<String, String> gameData = gameDataMap.get(key);
					int memCnt = Integer.parseInt(gameData.get("memCnt")) - 1;
					System.out.println("현재 게임 잔존수" + memCnt);
					gameData.put("memCnt", Integer.toString(memCnt));

					// 만약 방의 인원수가 0이라면 방의 상태를 체크하여 일반 대기중일시 방을 지운다.
					if (memCnt == 0) {
							gameDataMap.remove(key);
							gameMembersMap.remove(key);
							System.out.println("게임 삭제");
					} 
				}

			}

		}

		System.out.println("클라이언트 접속해제");
	}

	// 메시지 전송시나 접속해제시 오류가 발생할 때 호출되는 메소드
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		super.handleTransportError(session, exception);
		System.out.println("전송오류 발생");
	}

	public void roomListupdate() throws Exception {
		// 접속자에게 방목록의 정보를 전송하기 위해 제이슨 오브젝트와 배열을 준비한다.
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("cmd", "roomList");
		JSONArray jsonArr = new JSONArray();

		// 방목록을 만들기 위해 방정보맵 목록의 키값을 받아낸다
		Iterator<Integer> keys = listDataMap.keySet().iterator();
		while (keys.hasNext()) {
			int listkey = keys.next();

			// 리스트에 담을 제이슨 오브젝트를 만든다. 그리고 방정보맵의 키값이 방의 번호이므로
			// 바로 오브젝트에 담는다
			JSONObject listData = new JSONObject();
			listData.put("rnum", listkey);

			// 방정보맵 목록에서 방정보 맵을 키값을 이용해 가져오고 그 안에서 각종 정보를
			// 뽑아내어 제이슨 오브젝트에 담는다
			Map<String, String> DataMap = listDataMap.get(listkey);
			String roomName = DataMap.get("roomName");
			listData.put("roomName", roomName);

			// 완성된 제이슨 오브젝트를 배열에 담는다
			jsonArr.add(listData);
		}

		// 반환용 제이슨 오브젝트에 완성된 배열을 담고 문자열로 만든다
		jsonObj.put("list", jsonArr);
		String sJson = jsonObj.toJSONString();

		Iterator<String> sessionkeys = sessionMap.keySet().iterator();
		while (sessionkeys.hasNext()) {
			String sessionkey = sessionkeys.next();
			sessionMap.get(sessionkey).sendMessage(new TextMessage(sJson));
		}
	}

	public void memListupdate() throws Exception {
		// 현재 이용중인 이용자에게 갱신된 리스트 전송
		JSONObject jsonMem = new JSONObject();
		jsonMem.put("cmd", "memList");
		JSONArray memList = new JSONArray();

		Iterator<String> members = sessionMap.keySet().iterator();

		while (members.hasNext()) {
			String member = members.next();
			memList.add(member);
		}
		jsonMem.put("list", memList);

		String sJson = jsonMem.toJSONString();

		Iterator<String> sessionkeys = sessionMap.keySet().iterator();
		while (sessionkeys.hasNext()) {
			String sessionkey = sessionkeys.next();
			sessionMap.get(sessionkey).sendMessage(new TextMessage(sJson));
		}

		Iterator<Integer> roomkeys = listMemberMap.keySet().iterator();
		while (roomkeys.hasNext()) {
			// 키값을 사용해서 리스트 멤버맵 내부의 각 방의 닉네임과 세션이 담긴 맵을 불러낸다.
			Map<String, WebSocketSession> roomMemberMap = listMemberMap.get(roomkeys.next());

			Iterator<String> roomkeys2 = roomMemberMap.keySet().iterator();
			while (roomkeys2.hasNext()) {
				String key2 = roomkeys2.next();
				System.out.println(sJson);
				roomMemberMap.get(key2).sendMessage(new TextMessage(sJson));
			}

		}
	}

	private void roomUpdate(Map<String, WebSocketSession> roomMemberMap, Map<String, String> roomDataMap)
			throws Exception {

		// 방 내부 인원에게 방 정보를 전송한다.
		JSONObject roomData = new JSONObject();
		roomData.put("cmd", "roomUpdate");

		JSONArray roomMembers = new JSONArray();
		Iterator<String> roomMemNames = roomMemberMap.keySet().iterator();
		while (roomMemNames.hasNext()) {
			String key = roomMemNames.next();
			roomMembers.add(key);
		}
		roomData.put("roomMembers", roomMembers);

		JSONArray memList = new JSONArray();
		Iterator<String> members = sessionMap.keySet().iterator();
		while (members.hasNext()) {
			String member = members.next();
			memList.add(member);
		}
		roomData.put("list", memList);
		roomData.put("master", roomDataMap.get("master"));
		roomData.put("memCnt", roomDataMap.get("memCnt"));

		String sJson = roomData.toJSONString();

		Iterator<String> roomMemberKeys = roomMemberMap.keySet().iterator();
		while (roomMemberKeys.hasNext()) {
			String key = roomMemberKeys.next();
			roomMemberMap.get(key).sendMessage(new TextMessage(sJson));
			System.out.println(key + "에게 전송 완료");
		}
		System.out.println("방 업데이트 완료");

	}
}