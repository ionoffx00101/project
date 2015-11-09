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
    <tiles:putAttribute name="title">게임 조작법</tiles:putAttribute>
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
                                <h2>게임조작법</h2>
                            </div>

                          <p class="lead">우주선 게임은 키보드로 합니다</p>

                        <div id="post-content">
                            <p><strong>Pellentesque habitant morbi tristique</strong> senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas
                                semper. <em>Aenean ultricies mi vitae est.</em> Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, <code>commodo vitae</code>, ornare sit amet, wisi. Aenean
                                fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. <a href="#">Donec non enim</a> in turpis pulvinar facilisis. Ut felis.</p>

                            <p>
                                <img src="<c:url value="../resources/img/blog2.jpg"/>" class="img-responsive col-md-12 clearfix" alt="Example blog post alt">
                            </p>
                           <br>
                        </div>
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
        <br> <!-- 내용 차서 밑에 공간 생기면 이거 지워도 됨  사진 밑에 공간없어서 이렇게 함 -->
    </tiles:putAttribute>
</tiles:insertDefinition>