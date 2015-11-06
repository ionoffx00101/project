<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%--defaultTemplate를 적용할 때 템플릿의 title, body 영역은 여기에서 오버라이드한다 --%>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
$(jqueryOk);
function jqueryOk() {
	
	$("button[name=submit]").on("click",function (evt){
        evt.preventDefault();
		  $.ajax({
			type : "post",
			url : "../temp/qnamodi",
			dataType : "json",
			data :   $('#modiform').serialize()
			,
			success : function(json) {
				if (json.check) {
					alert("업데이트성공");
					/* location.href="http://192.168.8.55:8500/CoffeeWeb/temp/qnaread?num="+json.num+""; */
					location.href="../temp/qnaread?num="+json.num+"";
				} else{
					alert("업데이트실패");
				}
			},
			error : function(err) {
				alert("에러 : 다시 시도해주세요");
			}

		}); 
	});
}
</script>
<tiles:insertDefinition name="subTemplate">
    <tiles:putAttribute name="title">Q&A</tiles:putAttribute>
    <tiles:putAttribute name="body">
   <!-- 서브페이지 배너 -->
 <div id="heading-breadcrumbs">
            <div class="container">
                <div class="row">
                    <div class="col-md-7">
                        <h1>Q & A</h1>
                    </div>
                    <div class="col-md-5">
                        <ul class="breadcrumb">
                            <li><a href="../temp/home">Home</a>
                            </li>
                            <li>Questions and answers</li>
                        </ul>

                    </div>
                </div>
            </div>
        </div>
<!-- 서브페이지 배너 끝 -->

<div id="content">
            <div class="container">

                <div class="row">
                    <div class="col-md-12">
                        <div class="box">
                            
							<div class="heading">
                                <h2 >글수정</h2>
                            </div>
                            <hr>

                            <form id="modiform">
                            <input type="text" name="num" value="${post.num}" hidden="hidden"><!-- hidden="hidden" -->
                            <input type="text" name="author" value="${post.author}" hidden="hidden">
                                <div class="form-group">
                                    <label >글제목</label>
                                    <input type="text" class="form-control" name="title" value="${post.title}">
                                </div>
                                <div class="form-group">
                                    <label >내용</label>
                                    <textarea name="contents" class="form-control" rows="15">${post.contents}</textarea>
                                    <!-- <input type="text" class="form-control" id="email-login"> -->
                                </div>
                                <div class="text-center">
                                    <button type="button" class="btn btn-template-main" name="submit"> 수정하기</button>
                                    <a href="../temp/qna?pnum=1" ><button type="button"  class="btn btn-template-main">목록</button></a>
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