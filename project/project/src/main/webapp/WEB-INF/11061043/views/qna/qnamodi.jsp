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
			url : "qnamodi",
			dataType : "json",
			data :   $('form').eq(0).serialize()
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
                            <li><a href="home">Home</a>
                            </li>
                            <li>Questions and answers</li>
                        </ul>

                    </div>
                </div>
            </div>
        </div>
<!-- 서브페이지 배너 끝 -->
  <h5>글 수정</h5>  
 <div>
		<form>
			<table>
				<tr>
					<td>글번호 :</td>
					<td><input type="text" name="num" value="${post.num}" readonly="readonly"></td>
				</tr> 
				<tr>
					<td>글제목 :</td>
					<td><input type="text" name="title" value="${post.title}"></td>
				
				</tr>
				<tr>
					<td>작성자 :</td>
					<td><input type="text"name="author" value="${post.author}"></td>
				</tr>
				<tr>
					<td>내용 :</td>
					<td><textarea name="contents">${post.contents}</textarea></td>
				</tr>

				<tr>
					<td></td>
					<td><button type="button" name="submit">수정하기</button></td>
				</tr>
				<tr>
					<td colspan="2"><a href="qna?pnum=1"><Button type="button">글목록</Button></a></td>
				</tr>
			</table>
		</form>
	</div>

    </tiles:putAttribute>
</tiles:insertDefinition>