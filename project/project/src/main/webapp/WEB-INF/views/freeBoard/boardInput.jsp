<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<tiles:insertDefinition name="mainTemplate">
<tiles:putAttribute name="title">홈</tiles:putAttribute>
    <tiles:putAttribute name="body">
<%-- 파일을 보낼려면 method="post" enctype="multipart/form-data" 반드시 필요/ 서블렛에서 form데이터 처리 부분 좀 다름--%>
<form id="uploadForm" action="input" method="post">
	<input type="hidden" name="ref" value="${vo.ref}">
	<input type="hidden" name="author" value="${sessionScope.id}">
	<table>
		<tr>
			<td>제목</td><td><input type="text" name="title" value="업로드 테스트"></td>
		</tr>
		<tr>
			<td>작성자</td><td>${sessionScope.id}</td>
		</tr>
		<tr>
			<td>내용</td><td><textArea name="contents" cols="50" row="3">업로드 테스트 입니다.</textArea></td>
		</tr>
		<tr>
			<td colspan="2"><button type="submit" id="btn">글저장</td>
		</tr>
	</table>
</form>
</tiles:putAttribute>
</tiles:insertDefinition>