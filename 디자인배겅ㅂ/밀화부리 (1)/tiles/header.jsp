<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<div class="header">
	<div class="container">
		<div class="logo">
			<a href="index.html"><img src="/SimpleWeb/resources/images/logo.png" alt=""></a>
		</div>
		<span class="menu"></span>
		<div class="navigation">
			<ul class="navig cl-effect-3" >
				<li><a href="index.html">Home</a></li>
				<li><a href="games.html">Games</a></li>
				<li><a href="blog.html">Blog</a></li>
				<li><a href="features.html">Features</a></li>
				<li><a href="contact.html">Contact</a></li>
			</ul>
			<script>
				$( "span.menu" ).click(function() {
				  $( ".navigation" ).slideToggle( "slow", function() {
				    // Animation complete.
				  });
				});
			</script>
			<div class="clearfix"></div>
		</div>
		<div class="clearfix"></div>
	</div>
</div>