<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="my" uri="myFunc"%> 


<!DOCTYPE html>
<html lang="kn">

<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<!-- ------------------------- header ---------------------------- -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script type="text/javascript">

function loginGo(){
	$.ajax({
		type : "post",
		dataType : "text", 
		 async : false,
		url : "loginGo.do",
		data : {
			id: $("input:text[name='id']").val(), 
			inputPw: $("input:text[name='inputPw']").val(), 
		},
		success : function(result){
			alert("성공");
		},
		error : function(result){
			alert("실패");
		}
	});
}
</script>
<body>
<main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs">
      <div class="container">

        <ol>
          <li><a href="index.html">로그인</a></li>
          <li>로그인</li>
        </ol>
        <h2>로그인</h2>

      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Portfolio Details Section ======= -->
    <section id="portfolio-details" class="portfolio-details">
      <div class="container">

        <div class="">

          <div class="">
     
					
            <div class="portfolio-info">
              <div class="swiper-wrapper align-items-center">

					<%--로그인 --%>
                <div class="swiper-slide">
                <form name="frmReg" method="post" action="/loginGo.do">
                		<input type="text" id='id' name="id"/>
                		<br>
                		<input type="text" id='inputPw' name="inputPw"/>	
                		<br>
                		<a class="cta-btn2" href="#" onclick="loginGo();">로그인</a>
                		<a class="cta-btn2" href="join.do">회원가입</a>
                </form>
                </div>
              </div>
              
  </main><!-- End #main -->

</body>
<!-- ------------------------- header ---------------------------- -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</html>