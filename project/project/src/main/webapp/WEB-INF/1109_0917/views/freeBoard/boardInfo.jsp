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
	$('#dBtn').click(function(evt) {
		if(confirm('정말로 삭제하시겠습니까?')) {
			$.ajax({
				type:'post',
				url:'delete',
				data:$('#form1').serialize(),
				dataType:'json',
				success:function(json) {
					if(json.ok) {
						alert('삭제에 성공');
						location.href='list';
					} else {
						alert('삭제에 실패');
					}
				}
			});
		}
	});
	$('#reBtn').click(function() {
		$.ajax({
			type : 'post',
			url : 'replyInput',
			dataType : 'json',
			data : $('#form2').serialize(),
			success : function(json) {
				console.log(json);
				if (json.ok) {
					location.href="info?num="+json.bNum;
				} else {
					alert("false");
				}
			},
			error : function(json) {
				alert("오류발생");
			}
		});
	});
	$("#table a.reDelete").each(function(i){
		 $(this).click(function(){
	 			$.ajax({
					type : 'post',
					url : 'replyDelete',
					dataType : 'json',
					data : {
						reNum:$('#num'+i).val(),
						checkAuthor:$('#checkAuthor'+i).val(),
						bNum:$('#bNum').val()
					},
					success : function(json) {
						console.log(json);
						if (json.ok) {
							console.log(json.bNum);
							alert('삭제성공');
							location.href="info?num="+json.bNum;
						} else {
							alert("작성자만 삭제 가능합니다.");
						}
					},
					error : function(json) {
						alert("오류발생");
					}
				});
		 }); 
	});
	$("#table a.reReInput").each(function(i){
		$(this).click(function() {
			$('#tr'+i).append(
				'<input type="hidden" name="reRef" value="' + $('#num'+i).val() +  '">' +	
				'<tr>' +
					'<td>${sessionScope.id}</td><td colspan="2"><textarea name="reContents" cols="53" rows="2"></textarea></td>' +
					'<td><button type="button" class="reBtn">등록</button></td>' + 
				'</tr>'
			);
			$('.reBtn').each(function(i) {
				$(this).click(function(i) {
					$.ajax({
						type : 'post',
						url : 'replyInput',
						dataType : 'json',
						data : $('#form3').serialize(),
						success : function(json) {
							console.log(json);
							if (json.ok) {
								location.href="info?num="+json.bNum;
							} else {
								alert("false");
							}
						},
						error : function(json) {
							alert("오류발생");
						}
					});
				});
			});
		});
	});
}
</script>
<h2>상세 페이지</h2>
등록번호 ${info.num } <br>
제목 ${info.title } <br>
내용 ${info.contents } <br>
저자 ${info.author } <br>
날짜 ${info.wdate } <br>

<p>
<form id="form1">
<input type="hidden" name="num" value="${info.num}">
<input type="hidden" name="checkAuthor" value="${info.author}">
<button type="button" id="dBtn">삭제</button>
</form>
<br>
<form id="form2">
[댓글작성]
	<input type="hidden" name="reAuthor" value="${sessionScope.id}"> <!-- 현재 접속중인 아이디 -->
	<input type="hidden" name="bNum" value="${info.num}">		<!-- 현재 들어와있는 상세게시글 번호 -->
	<table>
		<tr><td>${sessionScope.id}</td> <td colspan="2"><textarea name="reContents" cols="53" rows="2"></textarea></td>
		<td><button type="button" id="reBtn">등록</button></td></tr>
	</table>
</form>

<br>
<form id="form3">
	<input type="hidden" name="reAuthor" value="${sessionScope.id}"> <!-- 현재 접속중인 아이디 -->
	<input type="hidden" name="bNum" id="bNum" value="${info.num}">
	<table id="table">
	<c:forEach var="reList" items="${reList}" varStatus="status">
		<input type="hidden" name="reNum" id="num${status.index}" value="${reList.reNum}">
		<input type="hidden" name="checkAuthor" id="checkAuthor${status.index}" value="${reList.reAuthor}" >
		<tr id="tr${status.index}">
			<th>${reList.reAuthor}</th><td>${reList.reContents}</td><td>${reList.reDate}</td> 
			<td>[<a href="#" class="reReInput">댓글 달기</a>]</td><td>[<a href="#" class="reDelete">삭제</a>]</td>		
		</tr>
	</c:forEach>
	</table>
</form>
<a href="editForm?num=${info.num}">수정하로 가기</a>
<a href="inputForm?ref=${info.num}">답글 쓰기</a>
<a href="list">목록으로</a>  
</tiles:putAttribute>
</tiles:insertDefinition>