<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
#table{border: 1px solid;}
/*  #newnick{
  -webkit-box-shadow: none;
  box-shadow: none;
  border-radius: 0;
  width: 408.75px;
  height: 34px;
  
}
#newnick:focus{
  border-color: #38a7bb;
  outline: 0;
  -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(56, 167, 187, 0.6);
  box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(56, 167, 187, 0.6);
}  */
</style>
<script type="text/javascript" src="<c:url value="/resources/jquery-2.1.4.min.js"/>"></script>
<script type="text/javascript">
$(start);
function start(){
	
	var nicksource = null;
	var nickduplebutton = false;
	var re_mail = /^([\w\.-]+)@([a-z\d\.-]+)\.([a-z\.]{2,6})$/; 
	var re_pw = /^(?=.*[a-zA-Z])(?=.*[0-9]).{5,20}$/; // 비밀번호 검사식
	
	

         $("#btn1").click(function(){
        	 if(re_pw.test($("#newpw").val())==true){
        	 alert("버튼반응");
        	 if($("#newpw").val()==$("#pwcheck").val()){
        		 
             alert("버튼반응2");
    	       $.ajax({
    		     url : "pwEdit",
   			     type : "post",
   			     dataType : "json",
   			     data : {"pw":$("#oldpw").val(),"newpw":$("#newpw").val(), "id":$("#idsource").val()},
   			     success : function(ok) {
   				   if (ok.ok) {
   					  alert("등록에 성공하였습니다.");
   					
   					location.href="editpage";
   					
   				      }
   				   else if(!ok.ok){
   					  alert("현재 비밀번호가 옳바르지 않습니다.");
   				      }
   			      },
   			      error : function(err) {
   				    alert("에러"+err);
   			      } 		   
    	       });
          }
   	 }else{
   		 alert("특수문자나 스페이스바는 이용하실 수 없습니다.");
   	 }	 
   });
        
         setInterval(function(){
        	 if($("#newpw").val()!=$("#pwcheck").val()){
            	 $("#errpw").text("동일한 비밀번호가 아닙니다.");
             }
         }, 0.01);
        	 
         setInterval(function(){
        	 if($("#newpw").val()==$("#pwcheck").val()){
            	 $("#errpw").text("동일한 비밀번호입니다.");
             }
         }, 0.01);
         
         
/*   ====================================================================  */
	
    
		$("#btn2").click(function(){
			 $.ajax({
    		     url : "nickcheck",
   			     type : "post",
   			     dataType : "json",
   			     data : {"nick":$("#newnick").val()},
   			     success : function(ok) {
   				   if (ok.ok) {
   					  alert("사용할 수 있는 닉네임입니다.");	
   					nicksource=$("#newnick").val();
                    nickduplebutton=true;
   				      }
   				   else if(!ok.ok){
   					  alert("중복 된 닉네임입니다.");
   				      }
   			      },
   			      error : function(err) {
   				    alert("에러"+err);
   			      } 		   
    	       });
		});
    	
		$("#btn3").click(function(){
			alert("올라간 nick:"+nicksource);
			if(nicksource==$("#newnick").val() && nickduplebutton==true){
				
				 $.ajax({
	    		     url : "nickRegi",
	   			     type : "post",
	   			     dataType : "json",
	   			     data : {"nick":$("#newnick").val(), "id":$("#idsource").val()},
	   			     success : function(ok) {
	   				   if (ok.ok) {
	   					  alert("닉네임이 수정되었습니다.");	
	   					  location.href="editpage";
	 
	   				      }
	   				   else if(!ok.ok){
	   					  alert("닉네임의 수정에 실패하였습니다.");
	   				      }
	   			      },
	   			      error : function(err) {
	   				    alert("에러"+err);
	   			      } 		   
	    	       });
			}else{
				alert("다시 중복검사를 실행해 주세요.");
			}
		});
		
		$("#newnick").on('keyup', function(){
			nickduplebutton=false;
		});
    	
	


    	$("#btn4").click(function(){
				 $.ajax({
	    		     url : "emailEdit",
	   			     type : "post",
	   			     dataType : "json",
	   			     data : {"email":$("#newemail").val(), "id":$("#idsource").val()},
	   			     success : function(ok) {
	   				   if (ok.ok) {
	   					  alert("Email이 수정되었습니다.");	
	   					  location.href="editpage";
	 
	   				      }
	   				   else if(!ok.ok){
	   					  alert("Email의 수정에 실패하였습니다.");
	   				      }
	   			      },
	   			      error : function(err) {
	   				    alert("에러"+err);
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
                        <h1>회원정보 변경페이지</h1>
                        <input type="hidden" value="${loginOk}" id="idsource">
                    </div>
                    <div class="col-md-5">
                        <ul class="breadcrumb">

                            <li><a href="../mainpage/main">Home</a>
                            </li>
                            <li>회원정보 변경페이지</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

     <div id="content" class="clearfix">

            <div class="container">

                <div class="row">

                    <!-- *** LEFT COLUMN ***
			 _________________________________________________________ -->

                    <div class="col-md-9 clearfix" id="customer-account">

                        <p class="lead">Change your personal details or your password here.</p>
                        <p class="text-muted">Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>

                        <div class="box">

                            <div class="heading">
                                <h3 class="text-uppercase">Password 변경</h3>
                            </div>

                            <form>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="password_old">Old password</label>
                                            <input type="password" class="form-control" id="oldpw">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="password_1">New password</label>
                                            <input type="password" class="form-control" id="newpw">
                                            <div id="errpw"></div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="password_2">Retype new password</label>
                                            <input type="password" class="form-control" id="pwcheck">
                                        </div>
                                    </div>
                                </div>
                                <!-- /.row -->
                                <div class="text-center">
                                    <button type="button" class="btn btn-template-main" id="btn1"><i class="fa fa-save"></i> Save new password</button>
                                </div>
                            </form>

                        </div>
                        
                          <div class="box">

                            <div class="heading">
                                <h3 class="text-uppercase">New NickName</h3>
                            </div>

                            <form>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="password_old">New Nickname</label><br>
                                            <input type="text" class="form-control" id="newnick"><br>
                                            <button type="button" class="btn btn-template-main" id="btn2">중복　확인</button>                       
                                        </div>
                                    </div>
                                </div>

                                <!-- /.row -->
                                <div class="text-center">
                                    <button type="button" class="btn btn-template-main" id="btn3"><i class="fa fa-save"></i> Save new NickName</button>
                                </div>
                            </form>

                        </div>
                        
                          <div class="box">

                            <div class="heading">
                                <h3 class="text-uppercase">E-mail 변경</h3>
                            </div>

                            <form>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="password_old">New E-mail</label>
                                            <input type="text" class="form-control" id="newemail">
                                        </div>
                                    </div>
                                </div>
                                <!-- /.row -->
                                <div class="text-center">
                                    <button type="button" class="btn btn-template-main" id="btn4"><i class="fa fa-save"></i> Save new E-mail</button>
                                </div>
                            </form>

                        </div>

                    </div>
                 </div>
                 </div>
                 </div>   
</tiles:putAttribute>
</tiles:insertDefinition>