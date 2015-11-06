<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<tiles:insertDefinition name="mainTemplate">
<tiles:putAttribute name="title">홈</tiles:putAttribute>
    <tiles:putAttribute name="body">
<script type="text/javascript">
$(jqueryOk);
function jqueryOk() {
	$('#btn').click(function() {
		location.href='search?searchChoice=' + $('#combo').val() + '&key=' + $('#key').val();
	});
	$('#key').keydown(function(evt) {
		if(evt.keyCode==13){
			location.href='search?searchChoice=' + $('#combo').val() + '&key=' + $('#key').val();
        }
	});
}
</script>
<table>
<tr>
	<td>번호</td><td>제목</td><td>글쓴이</td><td>첨부파일</td>
</tr>
<c:forEach var="s" items="${list}">
<tr>
	<td>${s.num}</td><td><a href="info?num=${s.num}">${s.title}</td>
	<td>${s.author}</td>
</tr>
</c:forEach>
</table>
<a href="inputForm">리스트 추가하기</a>
<form method="post" action="search">
<select name="searchChoice" id="combo">
	<option value="제목으로 검색" selected>제목으로 검색</option>
	<option value="작가로 검색">작가로 검색</option>
</select>
<input type="text" id="key" name="key">
<button type="button" id="btn">검색</button>
<br>
<c:choose>
	<c:when test="${nvo.leftMore}">
		<a href="list?page=${nvo.links[0]-1}"> [<<] </a>
	</c:when>
</c:choose>
<c:forEach var="s" items="${nvo.links}">
<c:choose>
	<c:when test="${nvo.currPage == s}">
		[<span style='color:red;font-size:1.5em;'>${s}</span>]
	</c:when>
<c:otherwise>
	<a href="list?page=${s}">[${s}]</a> 
</c:otherwise>
</c:choose>
</c:forEach>
<c:choose>
	<c:when test="${nvo.rightMore}">
	<a href="list?page=${nvo.links[1]+1}"> [>>] </a>
	</c:when>
</c:choose>
</form>
</tiles:putAttribute>
</tiles:insertDefinition>