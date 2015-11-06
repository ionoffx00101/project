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
    <tiles:putAttribute name="title">자주 묻는 질문</tiles:putAttribute>
    <tiles:putAttribute name="body">
<!-- 서브페이지 배너 -->
 <div id="heading-breadcrumbs">
            <div class="container">
                <div class="row">
                    <div class="col-md-7">
                        <h1>FAQ</h1>
                    </div>
                    <div class="col-md-5">
                        <ul class="breadcrumb">
                            <li><a href="../temp/home">Home</a>
                            </li>
                            <li>Frequently asked questions</li>
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
                                <h2>FAQ</h2>
                            </div>


                            <div class="panel-group" id="accordion">

                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">

						<a data-toggle="collapse" data-parent="#accordion" href="#faq1">

						    1. 게임실행에 문제가 생겼나요

						</a>

					    </h4>
                                    </div>
                                    <div id="faq1" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <p>방법은 세개 있습니다</p>
                                            <ul>
                                                <li>게임 재실행</li>
                                                <li>컴퓨터 재부팅</li>
                                                <li>컴퓨터 새로사기</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.panel -->

                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">

						<a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">

						    2. 게시판 이용중 문의사항

						</a>

					    </h4>
                                    </div>
                                    <div id="collapseTwo" class="panel-collapse collapse">
                                        <div class="panel-body">
                                        게시판을 사용하지 않으면 됩니다
                                        </div>
                                    </div>
                                </div>
                                <!-- /.panel -->


                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">

						<a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">

						    3. 세번째 질문

						</a>

					    </h4>
                                    </div>
                                    <div id="collapseThree" class="panel-collapse collapse">
                                        <div class="panel-body">
                                           공룡이 다시 태어났다!
                                        </div>
                                    </div>
                                </div>
                                <!-- /.panel -->

                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">

						<a data-toggle="collapse" data-parent="#accordion" href="#faq4">

						    4. 네번째 궁금한거

						</a>

					    </h4>
                                    </div>
                                    <div id="faq4" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            난 궁금한게 없어
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.panel -->

                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">

						<a data-toggle="collapse" data-parent="#accordion" href="#faq5">

						    5. 다섯번째까지는 보여줘야할거같아

						</a>

					    </h4>
                                    </div>
                                    <div id="faq5" class="panel-collapse collapse">
                                        <div class="panel-body">
                                           남는 자원 좀 있나요?
                                           
                                        </div>
                                    </div>
                                </div>
                                <!-- /.panel -->

                            </div>
                            <!-- /.panel-group -->

                            <p class="text-muted">여전히 문제가 있다면 <a href="qna?pnum=1">Q&A</a>에 글을 남기면 도와드리겠습니다</p>
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