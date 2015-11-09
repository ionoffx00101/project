<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
$(start);
function start(){	 

	
	$("#btn1").click(function(){
		$.ajax({
	         url : "idsearchget",
		     type : "post",
		     dataType : "json",
		     data : {"nick":$("#nicksc").val(),"email":$("#emailsc").val()},
		     success : function(ok) {
			   if (ok.ok) {
				  alert("ID 전체가 확인 가능한 메일을 보내드렸습니다.");	
				      location.href="idsearchget2?nick="+$("#nicksc").val()+"&email="+$("#emailsc").val();
			      }
			   else if(!ok.ok){
				  alert("닉네임 확인 혹은 email 확인에 실패하였습니다. 정확한 정보를 입력해주세요.");
			      }
		      },
		      error : function(err) {
			    alert("닉네임 확인 혹은 email 확인에 실패하였습니다. 정확한 정보를 입력해주세요.");
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
                        <h1>ID　찾기</h1>
                    </div>
                    <div class="col-md-5">
                        <ul class="breadcrumb">

                            <li><a href="../mainpage/main">Home</a>
                            </li>
                            <li>ID　찾기</li>
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
                                <h3 class="text-uppercase">ID 찾기</h3>
                            </div>

                            <form>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="nick">Nick　Name</label>
                                            <input type="text" class="form-control" id="nicksc">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="email">E-mail　주소</label>
                                            <input type="text" class="form-control" id="emailsc">
                                        </div>
                                    </div>
                                </div>
                                <!-- /.row -->
                                <div class="text-center">
                                    <button type="button" class="btn btn-template-main" id="btn1"><i class="fa fa-save"></i>확　인</button>
                                </div>
                            </form>

                        </div>
                    </div>
                 </div>
             </div>
         </div>
</tiles:putAttribute>
</tiles:insertDefinition>