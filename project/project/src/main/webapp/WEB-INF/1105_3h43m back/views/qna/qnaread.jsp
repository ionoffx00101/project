<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%--defaultTemplate를 적용할 때 템플릿의 title, body 영역은 여기에서 오버라이드한다 --%>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
$(jqueryOk);
function jqueryOk() {
	$('button[name=delete]').on('click', function(evt){
		  evt.preventDefault();
		  var idx = $(this).attr('data-idx');
          if(confirm("정말삭제하시겠습니까")){ 	        	  	
        	  		  $.ajax({
        	  			type : "post",
        	  			url : "qnadel",
        	  			dataType : "json",
        	  			data :   {"num":idx}
        	  			,
        	  			success : function(json) {
        	  				if (json.check) {
        	  					alert("삭제성공");
        	  					//location.href="<c:url value="/board/list?pnum=1"/>";
        	  					/* location.href="http://192.168.8.55:8500/CoffeeWeb/temp/qna?pnum=1"; */
        	  					location.href="../temp/qna?pnum=1";
        	  				} else{
        	  					alert("답글이 있으면 삭제할 수 없습니다.");
        	  				}
        	  			},
        	  			error : function(err) {
        	  				alert("에러 : 다시 시도해주세요");
        	  			}

        	  		}); 
          }
            
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
<h5>글상세보기</h5>
글번호 : ${post.num} <br>
글제목 : ${post.title} <br>
글쓴이 : ${post.author} <br>
작성일 : ${post.wdate} <br>
글내용 : ${post.contents} <br>
<br>
<br>
댓글<br>
<c:forEach var="re" items="${replylist}">
${re.renum} ${re.reauthor} ${re.contents} ${re.redate} <button>댓글달기</button><br> 
</c:forEach>
<p>
<a href="qnarepost?refnum=${post.num}&reftitle=${post.title}"><button>답글쓰기</button></a>
<a href="qnamodi?num=${post.num}"><button>수정</button></a>
<button type="button" name="delete"  data-idx="${post.num}">삭제</button>
<a href="qna?pnum=1"><Button>글목록</Button></a>

    </tiles:putAttribute>
</tiles:insertDefinition>