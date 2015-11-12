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
	var rnum = "${rnum}";
	var memCnt = 0;
	var master;
	var visiter = "";
	var ready = false;
	$(function() {
		if(rnum==null||rnum==""){
			alert("방을 선택하지 않고 입장할수는 없습니다.");
			location.href="roomList";
		}
		//var ws = new WebSocket("ws://localhost:8888/MavenWeb/wsinit");
		var ws = new WebSocket(
				"ws://192.168.8.28:8888/Test/game?position=room&nick=" + nick
						+ "&rnum=" + rnum);
		ws.onopen = function() {
			$('#chatStatus').text('Info: connection opened.');

			$('input[name=chatInput]').on('keydown', function(evt) {
				if (evt.keyCode == 13) {
					var msg = {
						position : "room",
						cmd : "chat",
						nick : nick,
						contents : $('input[name=chatInput]').val()
					};
					ws.send(JSON.stringify(msg));
					$('input[name=chatInput]').val('');
				}
			});
			var msg = {
				position : "room",
				cmd : "roomData",
			};
			ws.send(JSON.stringify(msg));
		};
		ws.onmessage = function(event) {
			var ob = eval("(" + event.data + ")");
			if (ob.cmd == "chat") {
				$('textarea').eq(0).prepend(ob.nick + ":" + ob.contents + '\n');
			}
			else if (ob.cmd == 'memList') {
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

				$("td[class=memlist]").on("click", function() {
					visiter = $(this).text();
					alert(visiter);
				});

			}
			else if (ob.cmd == 'roomUpdate') {

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

				$("td[class=memlist]").on("click", function() {
					visiter = $(this).text();
					alert(visiter);
				});

				$('#roomMember').empty();
				var list = ob.roomMembers;
				master = ob.master;
				memCnt = ob.memCnt;
				for (var i = 0; i < list.length; i++) {
					$('#roomMember').append(
							"<tr><td class=roomMember>" + list[i]
									+ "</td></tr>");
				}

			}
			else if (ob.cmd == 'kickout') {
				alert('추방당하셨습니다');
				location.href = "roomList";
			}
			else if (ob.cmd == 'ready') {
				if(ready){
					ready=false;
				}else{
					ready=true;
				}
				alert(ready);
			}
			else if (ob.cmd == 'start') {
				location.href="gameStart?gnum="+ob.gnum;
			}
		};
		ws.onclose = function(event) {
			$('#chatStatus').text('Info: connection closed.');
		};
		$('#kickout').click(function() {
			if (master == nick && memCnt == 2) {
				for (var i = 0; i < 2; i++) {
					if ($('td[class=roomMember]').eq(i).text() != master) {
						var msg = {
							position : "room",
							cmd : "kickout",
							nick : $('td[class=roomMember]').eq(i).text()
						};
						ws.send(JSON.stringify(msg));
					}
				}
			}
		});
		$('#invite').click(function() {
			if (memCnt < 2) {
				if (visiter != "") {
					var msg = {
						position : "room",
						cmd : "invite",
						nick : nick,
						receiver : visiter,
						rnum : rnum
					};
					ws.send(JSON.stringify(msg));
				}
			}
		});

		$('#start').click(function() {
			if (master == nick && ready==true) {
				var msg = {
					position : "room",
					cmd : "start",
					rnum : rnum
				};
				ws.send(JSON.stringify(msg));
			}
		});
		$('#ready').click(function() {
			if (master != nick) {
				var msg = {
					position : "room",
					cmd : "ready",
					rnum : rnum
				};
				ws.send(JSON.stringify(msg));
			}
		});

		$('#return').click(function() {
			location.href = "roomList";
		});

	});
</script>
</head>
<body>
	접속자 명단
	<table id="memList"></table>
	참가자
	<table id="roomMember"></table>
	<p>
	<div id='chatStatus'></div>
	<textarea name="chatMsg" rows="5" cols="40"></textarea>
	<p>
		메시지 입력 : <input type="text" name="chatInput">
		<button id="kickout">추방</button>
		<button id="start">시작</button>
		<button id="ready">레디</button>
		<button id="invite">초대</button>
		<button id="return">돌아가기</button>
</body>
</html>