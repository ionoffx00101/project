<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%--defaultTemplate를 적용할 때 템플릿의 title, body 영역은 여기에서 오버라이드한다 --%>
<tiles:insertDefinition name="subTemplate">
    <tiles:putAttribute name="title">자주 묻는 질문</tiles:putAttribute>
    <tiles:putAttribute name="body">
    
     여기는 자주 묻는 질문

    </tiles:putAttribute>
</tiles:insertDefinition>