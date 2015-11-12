<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>thirdMix(ver.jquery4.1)</title>
<!-- 폭발 로직 변경 및 정리  setinterval 과 clearInterval 사용     폭발 끝나면 그냥 다 멈춘다-->
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(jqueryOk);
	function jqueryOk() {
		var ctx = document.getElementById("canvas").getContext("2d"),

		canvasTemp = document.createElement("canvas"), scrollImg = new Image(), tempContext = canvasTemp.getContext("2d"), imgWidth = 0, imgHeight = 0, imageData = {}, canvasWidth = 352, canvasHeight = 1600, scrollVal = 0, speed = 2;
		/* 위쪽은 선생님 코드의 변수 선언, 그림을 그려주는 개체가 둘 필요하기때문에(그림의 처음과 끝을 이어 붙여야 하므로) 두 객체를 선언한다. 아래쪽 캔버스 템프는 조금 간략화된 클래스 선언으로 해당 객체에 상기와 같은 속성을 집어 넣어 준것이다 */

		scrollImg.src = "<c:url value="../resources/img/SpaceBackGround.jpg"/>";
		scrollImg.onload = loadImage;
		/*  배경 이미지 로드 선언 스크롤링 변수는 위쪽 변수 선언때 캔버스 템프 안에 들어가 있다 */

		var playerUnit = {};
		var keyPressOn = {};//pressed - true
		var spaceShipSprit;
		var canvasBuffer;
		/*  참조 블로그의 기체 움직임 변수들 각각 플레이어 유닛,버튼 입력 감지,기체 그림용,캔버스 객체의 펜을 담기위한 변수다(캔버스 객체는 실체 게임코드시 위쪽 코드와 일원화 시킬수 있다. 현재로선 기능 가동을 우선하여 객체를 하나 더 만들어둔 셈) */

		var enemyBalls;
		var gameEnd = false;
		var timeCheckLevel1 = 0;
		/* 위에서 부터 적 탄환 객체, 게임종료트리거용 객체, 시간이 지나가는것을 체크하는 객체 */

		/* 내가 추가한 곳   */
		var playerBulletimg;
		var playerBullet;
		var playerBulletMax = 100;/* 최대 탄환갯수  100개넘어가면 안쾌적함*/
		var playerBulletcnt = 0;
		var spacekey = false;

		var itemimg;
		var item;
		var itemMax = 5;
		var item_twoweapon = 2; //탄환 공격 범위를 늘려주는 아이템임
		/* 내가 추가한 끝   */
		
		var explosion; //폭발 이미지 변수 저장할때 씀
		var explosiontimer;
		var explosionimg;

		/* 1.아래쪽부터 돌아가는 로드 이미지는 게임에 시동을 거는 역할을 한다. */
		function loadImage() {
			imgWidth = scrollImg.width, imgHeight = scrollImg.height;
			canvasTemp.width = imgWidth;
			canvasTemp.height = imgHeight;
			/* 사용된 이미지의 폭과 너비를 저장하고 그림용 펜의 역할을 수행하는 캔버스 템프에도 담아둔다  */

			tempContext.drawImage(scrollImg, 0, 0, imgWidth, imgHeight);
			imageData = tempContext.getImageData(0, 0, imgWidth, imgHeight);
			/* 그림을 그리고 현재 그림의 테이터를 담아둔다 */

			canvasBuffer = document.createElement("canvas");
			/*    캔버스 버퍼 객체에 펜을 담는다 */
			playerUnit = {
				x : canvas.width / 2 - 18,
				y : canvas.height / 2 - 18,
				width : 36,
				height : 36,
				speed : 3
			};
			/* 중요!! 플레이어 유닛 선언으로 자바 스크립트의 클래스(객체) 선언의 표준으로 삼을 만 하다 저장하고 싶은 값은 클래스 내부의 변수, 펑션을 담는다면 메소드가 된다 */
			document.addEventListener("keydown", getKeyDown, false);
			document.addEventListener("keyup", getKeyUp, false);
			setImage();
			/*   창 자체에 이벤트 리스너를 설정하고 이미지를 불러와 기체 그림에 집어 넣는다 */
			enemyBalls = new Array();
			//createEnemyBalls(30);
			createEnemyBalls(10);
			/*  탄환 객체 선언 특정 개체를 배열로 만들고  */

			/* 내가 추가한 곳   */
			playerBullet = new Array();
			createplayerBullet(playerBulletMax);

			item = new Array();
			createitem(itemMax);
			/* 내가 추가한 곳   */

			render();
			/* 조건이 맞을 때까지 루프를 돌도록 설정된 게임 펑션을 돌린다. */
		}

		/* 2.기체이미지를 가져오는 펑션 */
		function setImage() {
			spaceShipSprit = new Image();
			spaceShipSprit.src = "<c:url value="../resources/img/samplespaceships.png"/>";
			playerBulletimg = new Image();
			playerBulletimg.src = "<c:url value="../resources/img/laserGreen11.png"/>";
			itemimg = new Image();
			itemimg.src = "<c:url value="../resources/img/laserGreen14.png"/>";
			explosionimg = new Image();
			explosionimg.src = "<c:url value="../resources/img/explosion-sprite-sheet.png"/>";
		}

		/* 3.탄환객체를 만드는 펑션 */
		function createEnemyBalls(iCount) {
			for (var i = 0; i < iCount; i++) {
				var startX = Math.floor(Math.random() * (canvas.width - 1)) + 1;
				var startY = 0;
				/* 탄환의 시작 위치 설정 */

				var startPos = Math.floor(Math.random() * 2)
				if (startPos == 1)
					startX = 0;
				else if (startPos == 2)
					startX = canvas.width;
				/*  탄환객체의 시작 시점을 각 캔버스의 끝으로 지정하기위한 부분 현재 위에서 아래로 내려오기만 하는 형태에선 필요없지만 후에 탄환 위치 조정에 쓸만할거 같기에 살려둠	 */

				var startAngle = Math.floor((Math.random() * 60) + 60);
				var startSpeed = Math.floor(Math.random() * (2)) + 2;
				/* 탄환의 방향,속도 설정 */

				var startColor;
				if (startSpeed == 2)
					startColor = "#ffffff";
				else
					startColor = "#00ff00";
				/*  속도에 따라 색을 다르게 설정한다 */

				var enemy = {
					x : startX,
					y : startY,
					color : startColor,
					radius : 4,
					speed : startSpeed,
					angle : startAngle,
					radians : Math.PI / 180
				};
				/* 탄환 객체를 만들어 지금까지 생성한 값을 집어 넣는다 */

				enemyBalls.push(enemy);
				/* 탄환 배열에 집어 넣는다. 이 펑션으로 확실해지는 것은 화면내에 물체 하나를 추가 할때마다 다수의 값을 가진(용량이 제법 되는)객체가 만들어져야 한다는것, 패턴 가짓수 만들기에는 주의가 필요하다 */
			}
		}

		/* 4.두종류의 키값모두 하나의 키캆으로 받기 위한 펑션들, 이 펑션들이 있는한 두키는 하나의 키값을 공유한다. */
		function getKeyDown(event) {
			var keyValue;
			if (event == null) {
				return;
			} else {
				keyValue = event.keyCode;
				event.preventDefault();
			}
			if (keyValue == "87")
				keyValue = "38"; //up
			else if (keyValue == "83")
				keyValue = "40"; //down
			else if (keyValue == "65")
				keyValue = "37"; //left
			else if (keyValue == "68")
				keyValue = "39"; //right
			keyPressOn[keyValue] = true;
			/* 내가 추가한 곳   */
			if (keyValue == "32") {
				//불렛 발사 펑션 호출  누르는 동안 하고 싶으면 위에 함수에 집어 넣으면 됨 
				spacekey = true;
			}
			/* 내가 추가한 곳   */
		}

		function getKeyUp(event) {
			var keyValue;
			if (event == null) {
				keyValue = window.event.keyCode;
				window.event.preventDefault();
			} else {
				keyValue = event.keyCode;
				event.preventDefault();
			}
			if (keyValue == "87")
				keyValue = "38"; //up
			else if (keyValue == "83")
				keyValue = "40"; //down
			else if (keyValue == "65")
				keyValue = "37"; //left
			else if (keyValue == "68")
				keyValue = "39"; //right
			keyPressOn[keyValue] = false;
			if (keyValue == "32") {
				//불렛 발사 펑션 호출  누르는 동안 하고 싶으면 위에 함수에 집어 넣으면 됨 
				spacekey = false;

			}
		}

		/* 5. 입력된 키값이 지정해둔 키와 일치할 경우 플레이어 유닛의 정보를 갱신시키는 펑션 */
		function calcKeyInnput() {
			if (keyPressOn["38"] && playerUnit.y >= -playerUnit.height / 2)
				playerUnit.y -= playerUnit.speed; //up
			if (keyPressOn["40"] && playerUnit.y <= canvas.height - playerUnit.height / 2)
				playerUnit.y += playerUnit.speed; //down
			if (keyPressOn["37"] && playerUnit.x >= -playerUnit.width / 2)
				playerUnit.x -= playerUnit.speed; //left
			if (keyPressOn["39"] && playerUnit.x <= canvas.width - playerUnit.width / 2)
				playerUnit.x += playerUnit.speed; //right

		}

		/* 6. 유닛의 과 탄환간의 거리를 재어 피격판정을내는 펑션, 피격의 경우 게임을 정지 시키기 위한 값을 돌려주고 그렇지 않을 경우 계속시킨다 */
		function checkHitPlayer() {
			var rtnVal = false;
			for (var i = 0; i < enemyBalls.length; i++) {
				var distanceX = (playerUnit.x + playerUnit.width / 2) - enemyBalls[i].x;
				var distanceY = (playerUnit.y + playerUnit.height / 2) - enemyBalls[i].y;
				var distance = distanceX * distanceX + distanceY * distanceY;

				if (distance <= (enemyBalls[i].radius + (playerUnit.width / 2 - 5)) * (enemyBalls[i].radius + (playerUnit.height / 2 - 5))) {
					rtnVal = true;
					break;
				}
			}

			return rtnVal;
		}

		/* 7.탄환의 위치를 조정하는 평션 */
		function calcEnemy() {
			if (timeCheckLevel1 > 600) {
				/* 내가 추가한 곳   */
				var itemcode = Math.floor(Math.random() * itemMax);

				useplayeritem(itemcode);
				/* 내가 추가한 곳  끝  */
				createEnemyBalls(2);
				timeCheckLevel1 = 0;
			}
			timeCheckLevel1++;
			/* 위쪽은일정 시간이 지날때마다 탄환 갯수를 추가하는 부분 */

			for (var i = 0; i < enemyBalls.length; i++) {
				enemyBalls[i].radians = enemyBalls[i].angle * Math.PI / 180;
				enemyBalls[i].x += Math.cos(enemyBalls[i].radians) * enemyBalls[i].speed;
				enemyBalls[i].y += Math.sin(enemyBalls[i].radians) * enemyBalls[i].speed;

				if (enemyBalls[i].x > canvas.width || enemyBalls[i].x < 0) {
					enemyBalls[i].angle = Math.floor((Math.random() * 60) + 60);
					enemyBalls[i].y = 0;
				} else if (enemyBalls[i].y > canvas.height || enemyBalls[i].y < 0) {
					enemyBalls[i].angle = Math.floor((Math.random() * 60) + 60);
					/*  enemyBalls[i].angle = 360 - enemyBalls[i].angle; */
					enemyBalls[i].y = 0;
				}
			}
			/*   해당탄환이 원래 가지고 있는속도, 현재위치, 방향값을 이용하여 다음위치를 산출하여 적용한다. */
		}

		/*   8.게임 루프 펑션 */
		function render() {

			useplayerBullet();
			calcitem();
			calcKeyInnput();
			calcEnemy();
			calcBullet();
			/* 키값을 받아 플레이어 기체 위치를 변경하고 다음으로 적 기체 위치를 변경한다 */

			ctx.clearRect(0, 0, canvasWidth, canvasHeight);
			/*  캔버스를 한번 지운다 */

			if (scrollVal >= canvasHeight - speed) {
				scrollVal = 0;
			}
			/* 혹시 스크롤 한바퀴 다돌아 간경우 스크롤을 초기화한다 */

			scrollVal += speed;
			/* 지정된 속도를 기준으로 스크롤의 값이 늘어난다(그리는 위치가 변경된다) */

			// This is the bread and butter, you have to make sure the imagedata isnt larger than the canvas your putting image data to.
			//back buffer에 그려진 배경이미지의 끝부분(아래쪽)을 복사해서 Canvas의 앞부분(위쪽)에 붙여 넣는다
			imageData = tempContext.getImageData(0, canvasHeight - scrollVal, canvasWidth, canvasHeight);
			ctx.putImageData(imageData, 0, 0, 0, 0, canvasWidth, imgHeight);

			//back buffer에 그려진 배경이미지의 시작부분(위쪽)을 복사해서 Canavas의 뒷부분(아래쪽)에 붙여 넣는다
			imageData = tempContext.getImageData(0, 0, canvasWidth, canvasHeight - scrollVal);
			ctx.putImageData(imageData, 0, scrollVal, 0, 0, canvasWidth, imgHeight);
			/* 배경 스크롤을 그려주는 부분 */

			/* 내가 추가한 곳   */
			for (var i = 0; i < playerBullet.length; i++) {
				ctx.drawImage(playerBulletimg, //Source Image
				0, 0, //X, Y Position on spaceShipSprit
				9, 54, //Cut Size from spaceShipSprit
				playerBullet[i].x, playerBullet[i].y, //View Position
				5, 20 //View Size
				);
				ctx.drawImage(canvasBuffer, 0, 0);
			}
			/* 내가 추가한 곳   끝*/

			ctx.drawImage(spaceShipSprit, //Source Image
			405, 180, //X, Y Position on spaceShipSprit
			playerUnit.width, playerUnit.height, //Cut Size from spaceShipSprit
			playerUnit.x, playerUnit.y, //View Position
			playerUnit.width, playerUnit.height //View Size
			);
			ctx.drawImage(canvasBuffer, 0, 0);
			/* 플레이어 기체를 그려준다 */

			for (var i = 0; i < enemyBalls.length; i++) {
				ctx.fillStyle = enemyBalls[i].color;
				ctx.beginPath();
				ctx.arc(enemyBalls[i].x, enemyBalls[i].y, enemyBalls[i].radius, 0, Math.PI * 2, true)
				ctx.closePath();
				ctx.fill();
			}
			/*  탄환(적기체)를 그려준다 */

			/* 내가 추가한 곳   */
			for (var i = 0; i < item.length; i++) {
				switch (i) {
				case 0:
					item[i].color = '#ff0000';
					break;
				case 1:
					item[i].color = '#ffff00';
					break;
				case 2:
					item[i].color = '#ff00ff';
					break;
				case 3:
					item[i].color = '#00ffff';
					break;
				default:
					break;
				}
				ctx.fillStyle = item[i].color;
				ctx.fillRect(item[i].x, item[i].y, item[i].width, item[i].height);
			}

			checkHitBullet();
			checkHititem();
			/* 내가 추가한 곳   끝*/

			gameEnd = checkHitPlayer();
			/*  피격판정을 실시한다 */
			if(gameEnd){
				explosion ={
						x : 0,
						y : 0,
						w :64,
						h :64,
						idx : 0,
						frame_cnt:25
				}
				explosiontimer = setInterval(function(){playerExplosion();},50);
			}
			if (!gameEnd) {

				setTimeout(function() {
					render();
				}, 10);
			}
			/*  판정에의해 게임 종료 혹은 속행을 판단하고 루프를 다시 돌릴 것인지를 결정한다. 이 과정은 10 밀리세컨드의 인터벌을 둔다 */
		}

		/* 내가 추가한 곳   */
		/* 첫 공들 설정*/
		function createplayerBullet(iCount) {
			for (var i = 0; i < iCount; i++) {

				var bullet = {
					x : 600,
					y : 600,
					color : "#00ffff",
					radius : 4, /*원의 크기*/
					speed : 0,
					angle : 4,
					radians : 0,
					use : false
				};
				/* 탄환 객체를 만들어 지금까지 생성한 값을 집어 넣는다 */

				playerBullet.push(bullet);
				/* 탄환 배열에 집어 넣는다. 이 펑션으로 확실해지는 것은 화면내에 물체 하나를 추가 할때마다 다수의 값을 가진(용량이 제법 되는)객체가 만들어져야 한다는것, 패턴 가짓수 만들기에는 주의가 필요하다 */
			}
		}
		/* 공을 사용할때*/
		function useplayerBullet() {
			
				if (spacekey) {

					if (playerBulletcnt > (playerBulletMax - 1)) {
						playerBulletcnt = 0;
					}

					var width = playerUnit.width / item_twoweapon;

					for (var i = 1; i < item_twoweapon; i++) {

						playerBullet[playerBulletcnt].x = playerUnit.x + (width * i) - 2;
						playerBullet[playerBulletcnt].y = playerUnit.y + playerUnit.height / 2;
						playerBullet[playerBulletcnt].speed = 3;
						playerBullet[playerBulletcnt].use = true;
						playerBulletcnt++;
						if (playerBulletcnt > (playerBulletMax - 1)) {
							playerBulletcnt = 0;
						}
					}
				}

			

		}
		/* 움직이는 공 설정*/
		function calcBullet() {

			for (var i = 0; i < playerBullet.length; i++) {
				if (playerBullet[i].use) {/* 사용하는 공만 움직임 */
					playerBullet[i].y -= playerBullet[i].speed;

					if (playerBullet[i].x > canvas.width || playerBullet[i].x < 0) {
						nouseplayerBullet(i);
					}
					if (playerBullet[i].y > canvas.height || playerBullet[i].y < 0) {
						nouseplayerBullet(i);
					}
				}
			} /*   해당탄환이 원래 가지고 있는속도, 현재위치, 방향값을 이용하여 다음위치를 산출하여 적용한다. */

		}
		/* 사용하지 않는 공으로 변경 */
		function nouseplayerBullet(i) {
			playerBullet[i].x = 600;
			playerBullet[i].y = 600;
			playerBullet[i].speed = 0;/* 0으로 해서 보이지 않는공은 아무것도 안함 */
			playerBullet[i].use = false;
		}
		/* 플레이어 탄환과 ball 충돌 확인*/
		function checkHitBullet() {

			for (var i = 0; i < playerBullet.length; i++) {
				if (playerBullet[i].use) {/* 사용하는 공만 충돌판정 확인함 */

					for (var j = 0; j < enemyBalls.length; j++) {
						var distanceX = playerBullet[i].x - enemyBalls[j].x;
						var distanceY = playerBullet[i].y - enemyBalls[j].y;
						var distance = distanceX * distanceX + distanceY * distanceY;

						if (distance <= (enemyBalls[j].radius + 15 * enemyBalls[j].radius + 15)) {
							nouseplayerBullet(i);
							enemyBalls[j].x = 600;
							enemyBalls[j].y = 600;
							enemyBalls[j].speed = 0;

							createEnemyBalls(1);
							break;
						}
					}

				}
			}

		}

		/* 아이템 */
		function createitem(imax) {
			for (var i = 0; i < imax; i++) {

				var newitem = {
					itemcode : i,
					x : 600,
					y : 600,
					color : "#ffffff",
					width : 30,
					height : 30,
					xspeed : 0,
					yspeed : 0,
					angle : 0,
					radius : 4,
					radians : Math.PI / 180,
					use : false
				};
				/* 아이템 객체를 만들어 지금까지 생성한 값을 집어 넣는다 */

				item.push(newitem);
				/* 아이템 배열에 집어 넣는다. 이 펑션으로 확실해지는 것은 화면내에 물체 하나를 추가 할때마다 다수의 값을 가진(용량이 제법 되는)객체가 만들어져야 한다는것, 패턴 가짓수 만들기에는 주의가 필요하다 */
			}

		}
		/* 아이템을 활성화될때*/
		function useplayeritem(i) {

			item[i].x = Math.floor(Math.random() * (canvas.width - 1)) + 1;
			item[i].y = 0;
			item[i].xspeed = 3;
			item[i].yspeed = 3;
			item[i].angle = Math.floor((Math.random() * 60) + 60);
			item[i].use = true;

		}

		function calcitem() {
			for (var i = 0; i < item.length; i++) {
				if (item[i].use) {
					item[i].radians = item[i].angle * Math.PI / 180;
					item[i].x += Math.cos(item[i].radians) * item[i].xspeed;
					item[i].y += Math.sin(item[i].radians) * item[i].yspeed;

					if (item[i].x > canvas.width - 30 || item[i].x < 5) {
						item[i].xspeed *= -1;
					} else if (item[i].y > canvas.height || item[i].y < 0) {
						nouseplayeritem(i);
					}

					if (item[i].x > canvas.width - 30) {
						item[i].x = canvas.width - 30;
					} else if (item[i].x < 5) {
						item[i].x = 5;
					}
				}
			}
			/*   해당탄환이 원래 가지고 있는속도, 현재위치, 방향값을 이용하여 다음위치를 산출하여 적용한다. */
		}
		/*아이템 충돌확인 */
		function checkHititem() {

			for (var i = 0; i < item.length; i++) {
				if (item[i].use) {/* 사용하는 공만 충돌판정 확인함 */

					var distanceX = (playerUnit.x + playerUnit.width / 2) - (item[i].x + item[i].width / 2);
					var distanceY = (playerUnit.y + playerUnit.height / 2) - (item[i].y + item[i].height / 2);
					var distance = distanceX * distanceX + distanceY * distanceY;

					if (distance <= (item[i].width / 2 + (playerUnit.width / 2 - 10)) * (item[i].height / 2 + (playerUnit.height / 2 - 10))) {
						nouseplayeritem(i); /*아이템 초기화 */

						if (item_twoweapon < 4) {
							item_twoweapon += 1;
							setTimeout(function() {
								item_twoweapon -= 1;

							}, 30000)
						}
					}

				}
			}

		}
		/*아이템 초기화 */
		function nouseplayeritem(i) {
			item[i].x = 600;
			item[i].y = 600;
			item[i].xspeed = 0;
			item[i].yspeed = 0;
			item[i].angle = 0;
			item[i].use = false;

		}
		function playerExplosion(){
			
			calcitem();
			calcEnemy();
			calcBullet();
			/* 키값을 받아 플레이어 기체 위치를 변경하고 다음으로 적 기체 위치를 변경한다 */

			ctx.clearRect(0, 0, canvasWidth, canvasHeight);
			/*  캔버스를 한번 지운다 */

			if (scrollVal >= canvasHeight - speed) {
				scrollVal = 0;
			}
			/* 혹시 스크롤 한바퀴 다돌아 간경우 스크롤을 초기화한다 */

			scrollVal += speed;
			/* 지정된 속도를 기준으로 스크롤의 값이 늘어난다(그리는 위치가 변경된다) */

			// This is the bread and butter, you have to make sure the imagedata isnt larger than the canvas your putting image data to.
			//back buffer에 그려진 배경이미지의 끝부분(아래쪽)을 복사해서 Canvas의 앞부분(위쪽)에 붙여 넣는다
			imageData = tempContext.getImageData(0, canvasHeight - scrollVal, canvasWidth, canvasHeight);
			ctx.putImageData(imageData, 0, 0, 0, 0, canvasWidth, imgHeight);

			//back buffer에 그려진 배경이미지의 시작부분(위쪽)을 복사해서 Canavas의 뒷부분(아래쪽)에 붙여 넣는다
			imageData = tempContext.getImageData(0, 0, canvasWidth, canvasHeight - scrollVal);
			ctx.putImageData(imageData, 0, scrollVal, 0, 0, canvasWidth, imgHeight);
			/* 배경 스크롤을 그려주는 부분 */

			/* 내가 추가한 곳   */
			for (var i = 0; i < playerBullet.length; i++) {
				ctx.drawImage(playerBulletimg, //Source Image
				0, 0, //X, Y Position on spaceShipSprit
				9, 54, //Cut Size from spaceShipSprit
				playerBullet[i].x, playerBullet[i].y, //View Position
				5, 20 //View Size
				);
				ctx.drawImage(canvasBuffer, 0, 0);
			}
			/* 내가 추가한 곳   끝*/

			for (var i = 0; i < enemyBalls.length; i++) {
				ctx.fillStyle = enemyBalls[i].color;
				ctx.beginPath();
				ctx.arc(enemyBalls[i].x, enemyBalls[i].y, enemyBalls[i].radius, 0, Math.PI * 2, true)
				ctx.closePath();
				ctx.fill();
			}
			/*  탄환(적기체)를 그려준다 */

			for (var i = 0; i < item.length; i++) {
				switch (i) {
				case 0:
					item[i].color = '#ff0000';
					break;
				case 1:
					item[i].color = '#ffff00';
					break;
				case 2:
					item[i].color = '#ff00ff';
					break;
				case 3:
					item[i].color = '#00ffff';
					break;
				default:
					break;
				}
				ctx.fillStyle = item[i].color;
				ctx.fillRect(item[i].x, item[i].y, item[i].width, item[i].height);
			}
			checkHitBullet();
			/*  폭발을 그려준다 */
			ctx.drawImage(explosionimg,explosion.x,explosion.y,explosion.w,explosion.h,playerUnit.x, playerUnit.y,64,64);
			explosion.x += explosion.w;
			explosion.idx++;
			if(explosion.idx % 5==0) {
				explosion.x = 0;
				explosion.y += explosion.h;
			}

			if(explosion.idx>explosion.frame_cnt) clearInterval(explosiontimer);
		}
		

	}
</script>
</head>
<body>
	<canvas id="canvas" width="352" height="500"></canvas>
</body>
</html>