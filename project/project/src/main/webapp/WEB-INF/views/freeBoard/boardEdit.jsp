<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<tiles:insertDefinition name="mainTemplate">
<tiles:putAttribute name="title">홈</tiles:putAttribute>
    <tiles:putAttribute name="body">
<script type="text/javascript">
$(jqueryOk);
function jqueryOk() {
	$('#btn').click(function(evt) {
		if(confirm('정말로 수정하시겠습니까?')) {
			
			var serializeData = $('#form').serialize();
			$.ajax({
				type:'post',
				url:'update',
				data:serializeData,
				dataType:'json',
				success:function(json) {
					if(json.ok) {
						alert('수정에 성공');
						location.href='info?num=' + ${info.num};
					} else {
						alert('수정에 실패');
					}
				}
			});
		}
	});
}
</script>
<h2>사원정보 수정 페이지</h2>
<form id="form">  
<input type="hidden" name="num" value="${info.num}">
<table>
	<tr>
		<td>등록번호:</td><td>${info.num}</td>
	</tr>
	<tr>
		<td>글쓴이:</td><td>${info.author}</td>
	</tr>
	<tr>
		<td>제목:</td><td><input type="text" name="title" value="${info.title}"></td>
	</tr>
	<tr>
		<td>내용:</td><td><textarea name="contents">${info.contents}</textarea></td>
	</tr>
	<tr><td><button type="button" id="btn">변경사항 적용</button></td></tr>
</table>
</form>
<a href="list">목록으로</a>  
</tiles:putAttribute>
</tiles:insertDefinition>