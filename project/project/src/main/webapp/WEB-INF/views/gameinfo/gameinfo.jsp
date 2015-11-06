<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%--defaultTemplate를 적용할 때 템플릿의 title, body 영역은 여기에서 오버라이드한다 --%>
<style type="text/css">
a:link {
	text-decoration: none;
	color: black;
}

a:visited {
	text-decoration: none;
	color: black;
}

a:active {
	text-decoration: none;
	color: black;
}

a:hover {
	text-decoration: none;
	color: blue;
	font-weight: bold;
}

</style>

<tiles:insertDefinition name="subTemplate">
    <tiles:putAttribute name="title">게임소개</tiles:putAttribute>
    <tiles:putAttribute name="body">
<!-- 서브페이지 배너 -->
 <div id="heading-breadcrumbs">
            <div class="container">
                <div class="row">
                    <div class="col-md-7">
                        <h1>game info</h1>
                    </div>
                    <div class="col-md-5">
                        <ul class="breadcrumb">
                            <li><a href="../temp/home">Home</a>
                            </li>
                            <li>game info</li>
                        </ul>

                    </div>
                </div>
            </div>
        </div>
<!-- 서브페이지 배너 끝 -->

<div id="content">
            <div class="container">
                <div class="row">
                    <!-- *** LEFT COLUMN ***
			 _________________________________________________________ -->

                    <div class="col-md-12 clearfix">
                        <section>

                            <div class="heading">
                                <h2>게임소개</h2>
                            </div>

                          <h4>게임소개</h4>

                  
                            <pre><Strong> 2인 멏티플레이가 가능한 종스크롤 슈팅게임</Strong><br> 아이템을 먹고 상대방을 더 빨리 패배시키세요</pre>

               
                        <Br>
                        
                        <h4>세계관</h4>

                        
                            <pre>지구가 멸망한 후 우주로 나간 세력들이 많아졌다 자원을 놓고 전쟁이 일어났다 </pre>

                   
                        <!-- /#post-content -->

                            
                        </section>

                    </div>
                    <!-- /.col-md-9 -->

    

                </div>
                <!-- /.row -->

            </div>
            <!-- /.container -->
        </div>
        <!-- /#content -->
    </tiles:putAttribute>
</tiles:insertDefinition>