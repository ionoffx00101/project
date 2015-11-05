<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%--defaultTemplate를 적용할 때 템플릿의 title, body 영역은 여기에서 오버라이드한다 --%>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(function() {
		var cate;
		$('button[name=btn_search]').on(
				'click',
				function(evt) {

					var word = $('input[name=searchword]').val();
					cate = $('select[name=category]').val();
					if (word != null) {
						location.href = 'search?word=' + word + '&cate=' + cate
								+ '&pnum=1';
					}
				});
		$('input[name=searchword]').on(
				'keydown',
				function(evt) {

					var word = $('input[name=searchword]').val();
					cate = $('select[name=category]').val();

					if (evt.keyCode == 13) {
						if (word != null) {
							location.href = 'search?word=' + word + '&cate='
									+ cate + '&pnum=1';
						}
					}

				});
	});
</script>
<style type="text/css">

a:link {text-decoration: none; color: black;}
a:visited {text-decoration: none; color: black;}
a:active {text-decoration: none; color: black;}
a:hover {text-decoration: none; color: blue; font-weight: bold;}

table {
display: inline-block;
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;

}
table td.cols {
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;
}
table td {
    width: 250px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}
table td.colss {
    width: 550px;
        padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #369;
    border-bottom: 3px solid #036;
}
</style>

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

  <a href="qna?pnum=1"><h5>글목록</h5></a>
	<select name="category">
		<option>글제목</option>
		<option>글쓴이</option>
	</select>
	<input type="text" name="searchword">
	<button type="button" name="btn_search">검색</button>
	<br>
	<br>
	<br>
	<a href="qnapost"><button type="button">글쓰기</button></a>
	<br>
	<br>
	<table>
    <tr>
        <td class="cols">글번호</td>
        <td class="colss">제목</td>
        <td class="cols">작성자</td>
        <td class="cols">작성일</td>
        <td class="cols">조회수</td>
    </tr>
    <c:forEach var="b" items="${list}">
    <tr>
        <td>${b.num}</td>
        <td><a href="qnaread?num=${b.num}"> ${b.title} </a> </td>
        <td>${b.author}</td>
        <td> ${b.wdate}</td>
        <td> ${b.hitcnt}</td>
    </tr>
    </c:forEach>
</table>
	<p>
<c:choose>
    <c:when test="${search}">
			<c:choose>
				<c:when test="${navi.leftMore}">
					<a href="search?word=${word}&cate=${cate}&pnum=1"> [<<] </a>
					<%-- ${navi.links.length-1}${navi.links().length-1}--%>
				</c:when>
			</c:choose>
	</c:when>	


	<c:otherwise>
			<c:choose>
				<c:when test="${navi.leftMore}">
					<a href="qna?pnum=1"> [<<] </a>
				</c:when>
			</c:choose>
	</c:otherwise>

</c:choose>


		<!--  -->
		
		<c:choose>
    <c:when test="${search}">
    	<c:forEach var="board" items="${navi.links}">

			<c:choose>
				<c:when test="${navi.currPage==board}">
          [<span style='color: red; font-size: 1.5em;'>${board}</span>]
       </c:when>
				<c:when test="${navi.currPage!=board}">
        [ <a href="search?word=${word}&cate=${cate}&pnum=${board}">${board}</a>]
       </c:when>
			</c:choose>

		</c:forEach>
    </c:when>
    
    <c:otherwise>
		<c:forEach var="board" items="${navi.links}">

			<c:choose>
				<c:when test="${navi.currPage==board}">
          [<span style='color: red; font-size: 1.5em;'>${board}</span>]
       </c:when>
				<c:when test="${navi.currPage!=board}">
        [ <a href="qna?pnum=${board}">${board}</a>]
       </c:when>
			</c:choose>

		</c:forEach>
		</c:otherwise>

</c:choose>
		<!--  -->
		
		
		
<c:choose>
    <c:when test="${search}">	
		
			<c:choose>
				<c:when test="${navi.rightMore}">
					<a href="search?word=${word}&cate=${cate}&pnum=${navi.linknum}">
						[>>] </a>
					<%-- ${navi.links.length-1}${navi.links().length-1}--%>
				</c:when>
			</c:choose>
			
		</c:when>
		
		<c:otherwise>
			<c:choose>
				<c:when test="${navi.rightMore}">
					<a href="qna?pnum=${navi.linknum}"> [>>] </a>
					<%-- ${navi.links.length-1}${navi.links().length-1}--%>
				</c:when>
			</c:choose>
			</c:otherwise>

</c:choose>
		

    </tiles:putAttribute>
</tiles:insertDefinition>