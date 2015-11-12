<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	var x = 5;
	var y = 5;
	var xdelta =7;
	var ydelta =7;

	window.addEventListener('load', function() { // 로드가 된 다음에 이벤트를 실행한다
	
		
		timer = setInterval(moveone, 50);
		
		
	});
	
	function moveone() {
		
		var canvas1 = document.querySelector("#canvas1");
		var ctx = canvas1.getContext("2d");
		
		ctx.clearRect(0, 0, canvas1.width, canvas1.height);

		ctx.fillStyle = '#000000';
		ctx.fillRect(x+= xdelta, y+=ydelta, 30, 30);
		

		if (x>canvas1.width-30 || x<5){ xdelta*=-1;} 

		if(y>canvas1.height-15 || y<5){ydelta*=-1;}
		
		
		if (x>canvas1.width-30){ x=canvas1.width-30;} 
		if (x<5){ x=12;} 

		if(y>canvas1.height-15){y=canvas1.height-15;}
		if(y<5){y=5;}
	
	}
</script>
</head>
<body>
	<canvas id="canvas1" width="352" height="500" style="border: 1px solid #000000"></canvas>
</body>
</html>