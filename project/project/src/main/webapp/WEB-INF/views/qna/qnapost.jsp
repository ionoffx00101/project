<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%--defaultTemplate를 적용할 때 템플릿의 title, body 영역은 여기에서 오버라이드한다 --%>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

$(jqueryOk);
function jqueryOk() {
	$('button[name=submit]').on('click', function(evt){
		  evt.preventDefault();
		 if($('input[name=title]').val() == ''){
				 $('input[name=title]').val($('input[name=title]').attr('placeholder'));
			 } 
		  if($('input[name=ref]').val() == ''){
				 $('input[name=ref]').val(0);
			 }
        	  		  $.ajax({
        	  			type : "post",
        	  			url : "qnapost",
        	  			dataType : "json",
        	  			data :   $('form').eq(0).serialize()
        	  			,
        	  			success : function(json) {
        	  				if (json.check) {
        	  					alert("저장성공");
        	  					//location.href="<c:url value="/board/list?pnum=1"/>";
        	  					/* location.href="http://192.168.8.55:8500/SpringWeb/temp/qna?pnum=1"; */
        	  					location.href="../temp/qnaread?num="+json.num+"";
        	  					
        	  					/* location.href="../temp/qnaread?num=1"; */
        	  				} else{
        	  					alert("저장실패");
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
<h5>글쓰기</h5>
<div>
<form>
<table>

<tr>
<td>글제목 :</td>
<td><input type="text" name="title" placeholder="${title}"></td>
</tr>
<tr>
<td>글쓴이 :</td>
<td><input type="text"name="author" ></td>
</tr>
<tr>
<td>내용 :</td>
<td><textarea name="contents" ></textarea></td>
</tr>

<tr>
<td><input type="text" name="ref" value="${ref}" hidden="hidden"></td>
<td><button type="button" name="submit">등록하기</button>
<button type="reset">초기화</button></td>
</tr>
<tr>

<td colspan="2"><a href="qna?pnum=1"><button type="button">리스트보기</button></a></td>
</tr>
</table>
</form>
</div>

    </tiles:putAttribute>
</tiles:insertDefinition>