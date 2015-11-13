<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Websocket Client</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	var nick = "${nick}";
	$(function() {
		var roomSelect = false;
		var roomnum;

		//var ws = new WebSocket("ws://localhost:8888/MavenWeb/wsinit");
		var ws = new WebSocket(
				"ws://192.168.8.55:8500/project/game?position=roomList&nick="
						+ nick);
		ws.onopen = function() {
			$('#chatStatus').text('Info: connection opened.');

			$('input[name=chatInput]').on('keydown', function(evt) {
				if (evt.keyCode == 13) {
					var msg = {
						position : "roomList",
						cmd : "chat",
						nick : nick,
						contents : $('input[name=chatInput]').val()
					};
					ws.send(JSON.stringify(msg));
					$('input[name=chatInput]').val('');
				}
			});
		};
		ws.onmessage = function(event) {
			var ob = eval("(" + event.data + ")");
			if (ob.cmd == "chat") {
				$('textarea').eq(0).prepend(ob.nick + ":" + ob.contents + '\n');
			}
			if (ob.cmd == 'roomList') {

				$('#roomList').empty();
				var list = ob.list;

				for (var i = 0; i < list.length; i++) {

					$('#roomList')
							.append(
									"<tr><td id='"+i+"'}'>"
											+ list[i].rnum
											+ "</td><td class='roomTitle' data-idx="+i+">"
											+ list[i].roomName + "</td></tr>");

				}
				$("td[class=roomTitle]").mouseover(function() {
					$(this).css("color", "red");
					$(this).css("font-size", "1.1em");
				});
				$("td[class=roomTitle]").mouseout(function() {
					$(this).css("color", "black");
					$(this).css("font-size", "1em");
				});

				$("td[class=roomTitle]").on("click", function() {

					var idx = $(this).attr('data-idx');
					var num = $('#' + idx).text();

					if (!roomSelect || roomnum != num) {
						roomSelect = true;
						roomnum = num;
					} else {

						var msg = {
							position : "roomList",
							cmd : "enterCheck",
							nick : nick,
							rnum : num
						};

						ws.send(JSON.stringify(msg));
					}
				});

			}
			if (ob.cmd == 'memList') {

				$('#memList').empty();
				var list = ob.list;

				for (var i = 0; i < list.length; i++) {
					$('#memList').append(
							"<tr><td class=memlist>" + list[i] + "</td></tr>");

				}
				$("td[class=memlist]").mouseover(function() {
					$(this).css("color", "red");
					$(this).css("font-size", "1.1em");
				});
				$("td[class=memlist]").mouseout(function() {
					$(this).css("color", "black");
					$(this).css("font-size", "1em");
				});

				$("td[class=memList]").on("click", function() {
				});

			}
			if (ob.cmd == 'enter') {
				location.href = "roomIn?rnum=" + ob.rnum;
			}
			if (ob.cmd == 'enterFalse') {
				alert('입장할수 없는 방입니다');
			}
			if (ob.cmd == 'invite') {
				if(confirm(ob.nick+"님이 초대하셨습니다 응하시겠습니까?")){
					var msg = {
							position : "roomList",
							cmd : "enterCheck",
							nick : nick,
							rnum : ob.rnum
						};
						ws.send(JSON.stringify(msg));
				}

			}

		};
		ws.onclose = function(event) {
			$('#chatStatus').text('Info: connection closed.');
		};

		//방 입장용 이벤트 리스너
		$('#enter').click(function() {

			if (roomSelect) {
				var msg = {
					position : "roomList",
					cmd : "enterCheck",
					nick : nick,
					rnum : roomnum
				};
				ws.send(JSON.stringify(msg));
			}else{
				alert('입장하고 싶은 방을 골라주세요');			}
			
		});
		//방 만들기 버튼 이벤트 리스너
		$('#roomCreate').click(function() {
			//시용자에게서 프롬프트로 방의 이름을 받고 제이슨 문자열을 만들어 서버로 전송한다
			var roomName = prompt("방 이름을 입력해 주세요", "");
			if (roomName == null || roomName == '') {
				return;
			}
			var msg = {
				position : "roomList",
				cmd : "roomCreate",
				nick : nick,
				roomName : roomName
			};
			ws.send(JSON.stringify(msg));
		});

	});
</script>
</head>
<body>
	<!-- 방목록 -->
	방 목록
	<table id="roomList"></table>
	<!--접속자 명단 -->
	접속자 명단
	<table id="memList"></table>
	<p>
		<!-- 현재 접속상태 표시(철거 예정) -->
	<div id='chatStatus'></div>
	<!-- 채팅 메시지 출력창 -->
	<textarea name="chatMsg" rows="5" cols="40"></textarea>
	<p>
		<!--채팅 메시지 입력창 -->
		메시지 입력 : <input type="text" name="chatInput">
	<p>
		<button id="enter">입장</button>
		<button id="roomCreate">방만들기</button>
</body>
</html>