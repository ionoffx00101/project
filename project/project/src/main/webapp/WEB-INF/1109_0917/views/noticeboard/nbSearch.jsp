<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
 
a:link {text-decoration: none; color: black;}
a:visited {text-decoration: none; color: black;}
a:active {text-decoration: none; color: black;}
a:hover {text-decoration: none; color: blue; font-weight: bold;}
body {
	text-align: center;
}
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


<script type="text/javascript" src="<c:url value="/resources/jquery-2.1.4.min.js"/>"></script>
<script type="text/javascript">
$(start);
function start(){
	$("#btn1").click(function(){
		location.href="sbinput";
	});
	
	$("#btn2").click(function(){
		
		location.href="search?catego="+$("#combo").val()+"&Ssc="+$("#search").val();
	});
	
	$("#search").on("keydown",function(evt){
		if(evt.keyCode==13){
			
			location.href="search?catego="+$("#combo").val()+"&Ssc="+$("#search").val();
		}
		
	});
	
};
</script>

<tiles:insertDefinition name="mainTemplate">
<tiles:putAttribute name="title">홈</tiles:putAttribute>
<tiles:putAttribute name="body">
    <!-- 서브페이지 배너 -->
 <div id="heading-breadcrumbs">
            <div class="container">
                <div class="row">
                    <div class="col-md-7">
                        <h1>공　지　게　시　판</h1>
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
<h2>검 색 리 스 트</h2>
<table>
    <tr>
        <td class="cols">글번호</td>
        <td class="colss">제목</td>
        <td class="cols">작성자</td>
        <td class="cols">작성일</td>
        <td class="cols">조회수</td>
    </tr>
<c:forEach var="board" items="${list}">
<tr>
<td>${board.num}.　</td>
<td><a href="info?infosc=${board.num}">${board.title }　</a>　</td>
<td>${board.author }　</td>
<td>${board.wdate} </td>
<td>${board.hitcnt }</td>
</tr>
</c:forEach>
</table><br>
<c:choose>
    <c:when test="${loginOk =='KING'}">
       <button type="button" id="btn1">글　쓰　기</button>
    </c:when>
</c:choose>
<select id="combo">
<option>제목</option>
<option>작성자</option>
</select>　
<input type="text" id="search" name="search">　
<button type="button" id="btn2">검색</button><br>


<c:choose>
	<c:when test="${nvo.leftMore}">
		<a href="searchnav?page=${nvo.links[0]-1}"> [<<] </a>
	</c:when>
</c:choose>


<c:forEach var="s" items="${nvo.links}">

<c:choose>
	<c:when test="${nvo.currPage == s}">
		[<span style='color:red;font-size:1.5em;'>${s}</span>]
	</c:when>
<c:otherwise>
	<a href="searchnav?page=${s}">[${s}]</a> 
</c:otherwise>
</c:choose>

</c:forEach>


<c:choose>

	<c:when test="${nvo.rightMore}">
	<a href="searchnav?page=${nvo.links[1]+1}"> [>>] </a>
	</c:when>

</c:choose>




</tiles:putAttribute>
</tiles:insertDefinition>