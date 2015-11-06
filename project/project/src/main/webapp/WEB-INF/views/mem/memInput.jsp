<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<script>
	var check = false;
</script>
<c:choose>
	<c:when test="${check==null}"></c:when>
	<c:when test="${check==true}">
		<script>
			check = true;
		</script>
	</c:when>
	<c:when test="${check==false}">
		<script>
			alert('인증에 실패하였습니다 다시한번 시도해주세요');
		</script>
	</c:when>
	<c:when test="${check==null}"></c:when>
</c:choose>

<script type="text/javascript"
	src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	var re_id = /^(?=.*[a-zA-Z])(?=.*[0-9]).{7,20}$/; // 아이디 검사식
	var re_pw = /^(?=.*[a-zA-Z])(?=.*[0-9]).{5,20}$/; // 비밀번호 검사식
	var re_mail = /^([\w\.-]+)@([a-z\d\.-]+)\.([a-z\.]{2,6})$/; //
	var pwdCheck = false;
	var idCheck = false;
	var nickCheck = false;
	
	$(jqueryOk);
	function jqueryOk() {
		$('#check').click(function() {
			if (re_mail.test($('input[name=email]').val()) == true) {

				$.ajax({
					type : "post",
					url : "send",
					dataType : "json",
					data : {
						"email" : $('input[name=email]').val()
					},
					success : function(json) {
						if (json.ok) {
							alert('메일전송에 성공했습니다. 메일을 통해 인증을 확인해주세요');
						} else
							alert('전송 실패');
					},
					error : function(err) {
						alert("에러");
					}
				});
			} else {
				alert('사용가능한 이메일이 아닙니다');
			}

		});
  
		$('#idCheck').click(function() {
			alert("중복검사 버튼");
		if(re_id.test($("#id").val())==true){
			$.ajax({
				type : "post",
				url : "idCheck",
				dataType : "json",
				data : {
					"id" : $('#id').val()
				},
				success : function(json) {
					if (json.ok) {
						idCheck = true;
						alert('사용가능한 ID입니다');
					} else
						alert('중복된 ID입니다');
				},
				error : function(err) {
					alert("에러");
				}
			});
		   }else{
			   alert('사용가능한 ID가 아닙니다'); 
		   }
		});
		$('#nickCheck').click(function() {
			$.ajax({
				type : "post",
				url : "nickCheck",
				dataType : "json",
				data : {
					"nick" : $('input[name=nick]').val()
				},
				success : function(json) {
					if (json.ok) {
						nickCheck = true;
						alert('사용가능한 닉네임입니다');
					} else
						alert('중복된 닉네임입니다');
				},
				error : function(err) {
					alert("에러");
				}
			});

		});

		$('#id').on('keyup', function() {
			idCheck = false;
		});
		$('#nick').on('keyup', function() {
			nickCheck = false;
		});

		$('#regist').click(
				function() {
					if (check && idCheck && pwdCheck && nickCheck
							&& $('input[name=name]').val() != '') {
						$.ajax({
							type : "post",
							url : "regist",
							dataType : "json",
							data : $('#meminfo').serialize(),
							success : function(json) {
								if (json.ok) {
									alert('등록에 성공했습니다');
									location.href="../mainpage/main"
									
								} else
									alert('등록 실패');
							},
							error : function(err) {
								alert("에러");
							}
						});
					} else {
						if (!check) {
							alert('이메일 인증 이후에 등록하실수 있습니다 ');
						} else if (!idCheck) {
							alert('id중복 검사를 해주셔야 합니다 ');
						} else if (!nickCheck) {
							alert('닉네임중복 검사를 해주셔야 합니다 ');
						} else if (!pwdCheck) {
							alert('패스워드 유효성 검사를 해주시기 바랍니다 ');
						}
					}

				});

		if (!check) {
			$('.afterCheck').attr("readonly", "readonly");
			$('.afterCheck').click(function() {
				alert('인증 이후에 사용 가능하십니다');

			});
		}
		if (check) {
			$('input[name=email]').attr("readonly", "readonly");
		}

		$('#pwd')
				.on(
						'keyup',
						function() {
							if (re_pw.test($('#pwd').val()) != true) {
								$('#pwdTest').empty();
								$('#pwdTest').css('color', 'red');
								$('#pwdTest')
										.text(
												'비밀번호는 영문자와 숫자의 혼합구성으로 5자 이상 20자 이하로 입력해 주셔야 합니다');
							} else {
								$('#pwdTest').empty();
								$('#pwdTest').css('color', 'black');
								$('#pwdTest').text('사용가능한 패스워드 입니다');
							}

						});

		$('#pwdCheck').on('keyup', function() {
			if ($('#pwd').val() != $('#pwdCheck').val()) {
				pwdCheck = false;
				$('#checkTest').empty();
				$('#checkTest').css('color', 'red');
				$('#checkTest').append('입력한 패스워드와 일치하지않습니다.');
			} else if ($('#pwd').val() == $('#pwdCheck').val()) {
				pwdCheck = true;
				$('#checkTest').empty();
				$('#checkTest').css('color', 'black');
				$('#checkTest').append('입력하신 패스워드와 일치합니다');
			}

		})
		
		$("#loginButton").click(function(){
			$.ajax({
				type : "post",
				url : "../mainpage/logingo",
				dataType : "json",
				data : {"id":$("#loginid").val(),"pwd":$("#loginpwd").val()},
				success : function(ok) {
					if (ok.ok) {
						alert('로그인에 성공했습니다');
						location.href="../mainpage/main"
					} else
						alert('로그인에 실패했습니다.');
				},
				error : function(err) {
					alert("에러");
				}
			});
			
		});

	}
</script>
   <tiles:insertDefinition name="mainTemplate">
   <tiles:putAttribute name="title">홈</tiles:putAttribute>
	<tiles:putAttribute name="body">

        <!-- *** LOGIN MODAL END *** -->

        <div id="heading-breadcrumbs">
            <div class="container">
                <div class="row">
                    <div class="col-md-7">
                        <h1>New account / Sign in</h1>
                    </div>
                    <div class="col-md-5">
                        <ul class="breadcrumb">
                            <li><a href="../mainpage/main">Home</a>
                            </li>
                            <li>New account / Sign in</li>
                        </ul>

                    </div>
                </div>
            </div>
        </div>

        <div id="content">
            <div class="container">

                <div class="row">
                    <div class="col-md-6">
                        <div class="box">
                            <h2 class="text-uppercase">New account</h2>

                            <p class="lead">Not our registered customer yet?</p>
                            <p>With registration with us new world of fashion, fantastic discounts and much more opens to you! The whole process will not take you more than a minute!</p>
                            <p class="text-muted">If you have any questions, please feel free to <a href="contact.html">contact us</a>, our customer service center is working for you 24/7.</p>

                            <hr>

                            <form id="meminfo">
                                <div class="form-group">
                                    <label for="name-login">Email</label><br>
                                    <input type="text" class="form-control" name="email"  style="width:400px; height:35px; float: left;" value="${email}">　
                                    <button type="button" class="btn btn-template-main" id="check"><i class="fa fa-user-md"></i>인　증</button>
                                </div>
                                <div class="form-group">
                                    <label for="email-login">이　름</label>
                                    <input type="text" class="form-control" id="name" name="name" style="width:400px; height:35px; ">
                                </div>
                                <div class="form-group">
                                    <label for="psword-login">닉네임</label><br>
                                    <input type="text" class="form-control" id="nick" style="width:400px; height:35px; float: left;" name="nick">　
                                    <button type="button" class="btn btn-template-main" id="nickCheck"><i class="fa fa-user-md"></i>인　증</button>
                                </div>
                                
                                <div class="form-group">
                                    <label for="password-login">ID</label><br>
                                    <input type="text" class="form-control" id="id" style="width:400px; height:35px; float: left;" name="id">　
                                    <button type="button" class="btn btn-template-main" id="idCheck"><i class="fa fa-user-md"></i>인　증</button>
                                </div>
                                
                                <div class="form-group">
                                    <label for="password-login">Password</label>
                                    <input type="password" class="form-control" id="pwd" style="width:400px; height:35px;" name="pwd">
                                </div>
                                
                                <div id="pwdTest"></div>
                                                                
                                <div class="form-group">
                                    <label for="password-login">Password　Check</label>
                                    <input type="password" class="form-control" id="pwdCheck" style="width:400px; height:35px;" name="pwdCheck">
                                </div>
                                
                                <div id="checkTest"></div>
                                
                                <div class="text-center">
                                    <button type="button" class="btn btn-template-main" id="regist"><i class="fa fa-user-md"></i> Register</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="box">
                            <h2 class="text-uppercase">Login</h2>

                            <p class="lead">Already our customer?</p>
                            <p class="text-muted">Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean
                                ultricies mi vitae est. Mauris placerat eleifend leo.</p>

                            <hr>

                            <form id="loginform">
                                <div class="form-group">
                                    <label for="email">ID</label>
                                    <input type="text" class="form-control" name="id" id="loginid" placeholder="ID">
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" name="pwd" id="loginpwd" placeholder="Password">
                                </div>
                                <div class="text-center">
                                    <button type="button" class="btn btn-template-main" id="loginButton"><i class="fa fa-sign-in"></i> Log in</button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>
                <!-- /.row -->

            </div>
            <!-- /.container -->
        </div>
        <!-- /#content -->

	</tiles:putAttribute>
</tiles:insertDefinition>