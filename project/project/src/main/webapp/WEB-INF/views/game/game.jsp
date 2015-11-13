<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Websocket Client</title>
<style type="text/css">
canvas { border: 1px solid #555555;}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	var nick = "${nick}";
	var rnum = "${rnum}";
	var gnum = "${gnum}";
		
	$(function() {
		//var ws = new WebSocket("ws://localhost:8888/MavenWeb/wsinit");
		var ws = new WebSocket(
				"ws://192.168.8.55:8500/project/game?position=game&nick=" + nick
						+ "&gnum=" + gnum + "&rnum=" + rnum);
		ws.onopen = function() {

		};
		ws.onmessage = function(event) {
			var ob = eval("(" + event.data + ")");
			if (ob.cmd == "start") {
				gameStart();
			}
			if (ob.cmd == 'end') {
				alert('게임이 종료 되었습니다');
				location.href = "roomIn?rnum=" + rnum;
			}
		};
		ws.onclose = function(event) {
		};

		$('#end').click(function() {
			var msg = {
				position : "game",
				cmd : "end",
				gnum : gnum
			};
			ws.send(JSON.stringify(msg));

		});
		

	});
</script>
</head>
<body>
	<canvas id="1p" width="600" height="850"></canvas>
	<canvas id="2p" width="600" height="850"></canvas>
	<p>
		<button id="end">게임끝</button>
</body>
</html>