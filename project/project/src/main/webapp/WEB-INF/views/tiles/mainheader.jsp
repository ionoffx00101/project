<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
$(start);
function start(){
	
	$("#loginbutton").click(function(){
		$.ajax({
			url : "../mainpage/logingo",
			type : "post",
			dataType : "json",
			data : $("#loginform").eq(0).serialize(),
			success : function(ok) {
				if (ok.ok) {
					if(ok.temp){
						alert("임시비밀번호로 로그인하셨습니다. 비밀번호를 변경해 주세요.")
					}
					alert("로그인에 성공하였습니다.");	
					
					location.href="../mainpage/main";
					
				}
				else if(!ok.ok){
					alert("로그인에 실패하였습니다.");
				}
			},
			error : function(err) {
				alert("에러"+err);
			}
			
		});	
	});
}

</script>
<div id="all">
	<!-- div all  -->
	<header>
		<!-- *** TOP ***__________________________________ -->
		<div id="top">
			<div class="container">
				<div class="row">
					<div class="col-xs-5 contact">
						<p class="hidden-sm hidden-xs">Contact us on ToboWorld</p>
						<p class="hidden-md hidden-lg">
							<a href="#" data-animate-hover="pulse"><i class="fa fa-phone"></i></a>
							<a href="#" data-animate-hover="pulse"><i
								class="fa fa-envelope"></i></a>
						</p>
					</div>
					<div class="col-xs-7">
						<div class="social">
							<a href="#" class="external facebook" data-animate-hover="pulse"><i
								class="fa fa-facebook"></i></a> <a href="#" class="external gplus"
								data-animate-hover="pulse"><i class="fa fa-google-plus"></i></a>
							<a href="#" class="external twitter" data-animate-hover="pulse"><i
								class="fa fa-twitter"></i></a> <a href="#" class="email"
								data-animate-hover="pulse"><i class="fa fa-envelope"></i></a>
						</div>
						
						<c:choose>
						   <c:when test='${loginOk == null}'>
						<div class="login">
							<a href="#" data-toggle="modal" data-target="#login-modal"><i
								class="fa fa-sign-in"></i> <span
								class="hidden-xs text-uppercase">Sign in</span></a> <a
								href="../mem/input"><i class="fa fa-user"></i> <span
								class="hidden-xs text-uppercase">Sign up</span></a>
							<a href="../mem/searchID">아이디</a>/<a href="../mem/searchPW">PW 찾기</a>
						</div>
						    </c:when>
						    <c:otherwise>
						    <a href="../mainpage/logout">Logout</a>　<a href="../mem/editpage">회원변경　페이지</a>
						    </c:otherwise>
						</c:choose>	
					</div>
				</div>
			</div>
		</div>
		<!-- *** TOP END *** -->
		<!-- *** NAVBAR *** _________________________________________________________ -->
		<div class="navbar-affixed-top" data-spy="affix" data-offset-top="200">
			<div class="navbar navbar-default yamm" role="navigation" id="navbar">
				<div class="container">
					<div class="navbar-header">
						<a class="navbar-brand home" href="../temp/home"> <img
							src="<c:url value="../resources/img/logo.png"/>"
							alt="Universal logo" class="hidden-xs hidden-sm"> <img
							src="<c:url value="../resources/img/logo-small.png"/>"
							alt="Universal logo" class="visible-xs visible-sm"><span
							class="sr-only">go to homepage</span>
						</a>
						<div class="navbar-buttons">
							<button type="button" class="navbar-toggle btn-template-main"
								data-toggle="collapse" data-target="#navigation">
								<span class="sr-only">Toggle navigation</span> <i
									class="fa fa-align-justify"></i>
							</button>
						</div>
					</div>
					<!--/.navbar-header -->
					<div class="navbar-collapse collapse" id="navigation">
						<ul class="nav navbar-nav navbar-right">
							<li>
								<!-- class="dropdown active" --> <a href="../temp/home">Home</a>
							</li>
							<li class="dropdown"><a href="javascript: void(0)"
								class="dropdown-toggle" data-toggle="dropdown">게임소개<b
									class="caret"></b></a>
								<ul class="dropdown-menu">
									<li><a href="../temp/gameinfo">게임소개</a></li>
									<li><a href="../temp/gamecont">조작법</a></li>
								</ul></li>
							<li class="dropdown"><a href="../notice/list">공지게시판 </a></li>
							<li class="dropdown"><a href="../FB/list">자유게시판 </a></li>
							<li class="dropdown"><a href="#">이미지게시판 </a></li>
							<li class="dropdown"><a href="javascript: void(0)"
								class="dropdown-toggle" data-toggle="dropdown">질문 <b
									class="caret"></b></a>
								<ul class="dropdown-menu">
									<li><a href="../temp/faq">자주묻는질문</a></li>
									<li><a href="../temp/qna?pnum=1">Q&A</a></li>
								</ul></li>
						</ul>
					</div>
					<!--/.nav-collapse -->
					<div class="collapse clearfix" id="search">
						<form class="navbar-form" role="search">
							<div class="input-group">
								<input type="text" class="form-control" placeholder="Search">
								<span class="input-group-btn">
									<button type="submit" class="btn btn-template-main">
										<i class="fa fa-search"></i>
									</button>
								</span>
							</div>
						</form>
					</div>
					<!--/.nav-collapse -->
				</div>
			</div>
			<!-- /#navbar -->
		</div>
		<!-- *** NAVBAR END *** -->
	</header>
	<!-- *** LOGIN MODAL ***
	
_________________________________________________________ -->

	<div class="modal fade" id="login-modal" tabindex="-1" role="dialog"
		aria-labelledby="Login" aria-hidden="true">
		<div class="modal-dialog modal-sm">

			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="Login">Customer login</h4>
				</div>
				<div class="modal-body">
					<form action="customer-orders.html" method="post">
						<div class="form-group">
							<input type="text" class="form-control" id="email_modal"
								placeholder="email">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" id="password_modal"
								placeholder="password">
						</div>
						<p class="text-center">
							<button class="btn btn-template-main">
								<i class="fa fa-sign-in"></i> Log in
							</button>
						</p>
					</form>

					<p class="text-center text-muted">회원이 아니신가요?</p>
					<p class="text-center text-muted">
						<a href="customer-register.html"><strong>지금 가입하세요</strong></a>!<br>전세계
						사람들과 우주선게임을 하세요
					</p>
				</div>
			</div>
		</div>
	</div>
	<!-- *** LOGIN MODAL END *** -->
</div>
<!-- div all end -->