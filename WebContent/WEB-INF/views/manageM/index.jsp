<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/taglibs.jsp"%>

<!DOCTYPE html>
<html lang="kn">

<head>
<meta charset="UTF-8">
<title>공과금 전체</title> 
</head>

<!--  차트 -->
<%-- <script src="${contextPath}/resources/css/chart/highcharts.js"></script> --%>
<!-- chart.js  -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
 <script type="text/javascript" src="${contextPath}/resources/js/loginchk.js"></script>
<!-- ------------------------- header ---------------------------- -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>

	<!-- 차트 -->
	<jsp:include page="/WEB-INF/views/common/chart.jsp"/>
<link rel="stylesheet" href="${contextPath}/resources/css/common.css">	
<body>

<script type="text/javascript">

// 수정 버튼을 눌렀을 때, 입력폼으로 전환
function up(index){
	
	if($("#upbtn").val() == "등록"){
		if(confirm("등록하시겠습니까?")){
			
			/* 그냥 form 액션
			if(index == 0)var frm = document.forms[0];
			if(index == 1)var frm = document.forms[1];
			
					frm.action = 'updateMAll.do';
					frm.target = "frmSys";
					frm.meth  class='boder-black'od = 'post';
					frm.submit();
					
					
					$(".nomalFrom").css("display", "inline");
					$(".upFrom").css("display", "none");
					$("#upbtn").val("수정");
					
					reload();
			 form 액션 종료 */
			 
			 // 음 필요없을지도?
			$.ajax({
				type : "post",
				dataType : "text", 
				 async : false,
				url : "updateMAll.do",
				data : {
					yyyy: $("input:hidden[name='yyyy']").val(), 
					mm: $("input:hidden[name='mm']").val(), 
					mode: $("input:hidden[name='mode']").val(), 
					uId: $("input:hidden[name='uId']").val(), 
					idx: $("input:hidden[name='idx']").val(), 
					gasM: $("input[name='gasM']").val(), 
					elM: $("input[name='elM']").val(), 
					wtM: $("input[name='wtM']").val(), 
					itM: $("input[name='itM']").val(), 
					maM: $("input[name='maM']").val(), 
				},
				success : function(result){
					alert("등록완료");
					reload();
				},
				error : function(result){
					errMsg(result);
				}
			});
			 
		}
		return;
	}
	$(".nomalFrom").css("display", "none");
	$(".upFrom").css("display", "inline");
	
	$("#upbtn").val("등록");
	
}

function reload() { (location || window.location || document.location).reload(); }




$(document).ready(function() {
	
	// 전월, 전전월 데이터 없을 때 0으로 채워주기
list =['가스','전기', '수도','인터넷', '관리비'];

// 전월, 당월
chart1("column", '전월 vs 당월','(전월) ${arrViewPast[0].yyyy}년도 ${arrViewPast[0].mm}월 | (당월) ${arrViewPast[1].yyyy}년도 ${arrViewPast[1].mm}월 ', list); // ${arrViewPast}
//차트타입, 타이틀, 서브타이들, x축 컬럼명
	
//3개월
chart3("column", '최근 3개월', "${arrViewPast3[2].yyyy}년도 ${arrViewPast3[2].mm}월 ~ ${arrViewPast3[0].yyyy}년도 ${arrViewPast3[0].mm}월",list); // ${arrViewPast3}
//차트타입, 타이틀, x축 컬럼명

var cList = ["line","line","line", "line", "line"]; 
var  rList = ["가스", "전기", "수도", "인터넷", "관리비"]; 
// 1년
chart12('최근 12개월','${my:NVL(arrViewPast12[0].yyyy, 0)}년도 ${my:NVL(arrViewPast12[0].mm, 0)}월 ~${arrViewPast12[12].yyyy}년도 ${arrViewPast12[12].mm}월  ',cList, rList );
//타이틀, 서브타이들,  type 배열 리스트, x컬럼 데이터
// 반복횟수는 컨트롤러에서 세팅
// ${arrViewPast12}


	
});

//총합 12개월 총 지출 금액 차트 (chart.js 썼는데 망함)
$(document).ready(function() {
	
	var context = document
    .getElementById('myChart')
    .getContext('2d');
	 var myChart = new Chart(context, {
         type: 'line', // 차트의 형태
         data: { // 차트에 들어갈 데이터
             labels: [
                 //x 축
             	<c:forEach items="${arrViewPast12}" var="v12">
             	'${v12.yyyy}/${v12.mm}',
             	</c:forEach>
             ],
             datasets: [
                 { //데이터
                     label: '가스', //차트 제목
                     fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                     data: [
                    		<c:forEach items="${arrViewPast12}" var="v12">
                         	${v12.gasM},
                         	</c:forEach>
                         	//x축 label에 대응되는 데이터 값
                     ],
                     backgroundColor: 
                         //색상
                          'rgba(255, 99, 132, 0.2)',
                     
                     borderColor: 
                         //경계선 색상
                            'rgba(255, 99, 132, 1)',
                     
                     borderWidth: 1 //경계선 굵기
                 },
                 { //데이터
                     label: '전기', //차트 제목
                     fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                     data: [
                    		<c:forEach items="${arrViewPast12}" var="v12">
                         	${v12.elM},
                         	</c:forEach>
                         	//x축 label에 대응되는 데이터 값
                     ],
                     backgroundColor: 
                         //색상
                         'rgba(54, 162, 235, 0.2)',
                     
                     borderColor: 
                         //경계선 색상
                              'rgba(54, 162, 235, 1)',
                     
                     borderWidth: 1 //경계선 굵기
                 },
                 { //데이터
                     label: '수도', //차트 제목
                     fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                     data: [
                    		<c:forEach items="${arrViewPast12}" var="v12">
                         	${v12.wtM},
                         	</c:forEach>
                         	//x축 label에 대응되는 데이터 값
                     ],
                     backgroundColor: 
                         //색상
                      'rgba(75, 192, 192, 0.2)',
                     
                     borderColor: 
                         //경계선 색상
                            'rgba(75, 192, 192, 1)',
                     
                     borderWidth: 1 //경계선 굵기
                 },
                 { //데이터
                     label: '인터넷', //차트 제목
                     fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                     data: [
                    		<c:forEach items="${arrViewPast12}" var="v12">
                         	${v12.itM},
                         	</c:forEach>
                         	//x축 label에 대응되는 데이터 값
                     ],
                     backgroundColor: 
                         //색상
                         	 'rgba(153, 102, 255, 0.2)',
                     
                     borderColor: 
                         //경계선 색상
                         	 'rgba(153, 102, 255, 1)',
                     
                     borderWidth: 1 //경계선 굵기
                 },
                 { //데이터
                     label: '관리', //차트 제목
                     fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                     data: [
                    		<c:forEach items="${arrViewPast12}" var="v12">
                         	${v12.maM},
                        	</c:forEach>
                         	//x축 label에 대응되는 데이터 값
                     ],
                     backgroundColor:                          //색상
                         	 'rgba(255, 159, 64, 0.2)',
                     
                     borderColor: 
                         //경계선 색상
                         'rgba(255, 159, 64, 1)',
                     
                     borderWidth: 1 //경계선 굵기
                 }
                 /* ,
                 {
                     label: 'test2',
                     fill: false,
                     data: [
                         8, 34, 12, 24
                     ],
                     backgroundColor: 'rgb(157, 109, 12)',
                     borderColor: 'rgb(157, 109, 12)'
                 } */
             ]
         },
         options: {
             scales: {
            	  yAxes: [{
                      display: true,
                    
                      scaleLabel: {
                          display: true
                      }
                  }]
             },
             title: { display: true, text: '최근 1년 공과금 비교' },
           tootip : {
        		enabled : true,
        		mode : 'dataset',
        		position : 'cursor',
        		intersect : false
           },
             hover: { mode: 'dataset', intersect: false }
         }
     });
});


		
	  

function show(){
	if(	$("#passY").text() == "접기"){
	$("#passYT").css("display","none");
	$("#passY").text(">> 작년에는 얼마 썼을까?");
	$(".savingDiv").css("display","inline");
	}else{
	$("#passYT").css("display","table");
	$("#passY").text("접기");
	$('.savingDiv').css("display","none");
	}
}

</script>

<main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section id="breadcrumbs" class="breadcrumbs">
      <div class="container">

        <ol>
          <li><a href="index.html">공과금</a></li>
          <li>전체</li>
        </ol>
        <h2>전체</h2>

      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Portfolio Details Section ======= -->
    <section id="portfolio-details" class="portfolio-details">
      <div class="container">

        <div class="">

          <div class="">
          
          <div>
					<select id='yyyyC' name='yyyyC'>
					<option>년도</option>
					<option value="2022" <c:if test='${arrViewNow[0].yyyy eq "2022"}'>selected="selected"</c:if>>2022</option>
					<option value="2021" <c:if test='${arrViewNow[0].yyyy eq "2021"}'>selected="selected"</c:if>>2021</option>
					<option value="2020" <c:if test='${arrViewNow[0].yyyy eq "2020"}'>selected="selected"</c:if>>2020</option>
					<option value="2019" <c:if test='${arrViewNow[0].yyyy eq "2019"}'>selected="selected"</c:if>>2019</option>
					</select>
					
					<select id='mmC' name='mmC'>
					<option>월</option>
					<c:forEach var="i" begin="1" end="12" step="1">
					<option value="${i}"<c:if test='${arrViewNow[0].mm eq i}'>selected="selected"</c:if>>${i}</option>
					</c:forEach>
					</select>
					
					<button onclick="schGo();">검색</button>
					
					</div>
					
            <div class="portfolio-info">
              <div class="swiper-wrapper align-items-center">

					<%--이번달 요금 --%>
                <div class="swiper-slide">
                	<c:forEach var='arr' items='${arrViewNow}' varStatus="st">
                	<!-- !!이건 나중에 고지서 보고 컬럼 더 만들어야함 -->
                	 <span style="float: right;" ><a href="javascript:detail();" > >> 자세히 보러가기</a></span>
                	 <h3>${arr.yyyy}년도 ${arr.mm}월 공과금</h3>
				<form name="frmReg${st.index}"   class='boder-black' method="post">
				
				
				<c:set var='mode' value='u'/>
				<%--<c:if test="${arr.gasM == null && arr.elM == null && arr.wtM == null && arr.itM == null}"> --%>
				<c:if test="${arr.idx == null}"> 
				<c:set var='mode' value='i'/>
				</c:if>
				
                <input type="hidden" value="${arr.idx}" name='idx' id='idx'/>
                <input type="hidden" value="${mode}" name='mode' id='mode'/>
                <input type="hidden" value="${arr.yyyy}" name='yyyy' id='yyyy'/>
                <input type="hidden" value="${arr.mm}" name='mm' id='mm'/>
                <input type="hidden" value="${arr.uId}" name='uId' id='uId'/>
                	<table class='tb'>
                	<tbody>
					<tr>
						<th  class='boder-black'>가스비</th>
						<th  class='boder-black'>전기세</th>
						<th  class='boder-black'>수도세</th>
						<th  class='boder-black'>인터넷</th>
						<th  class='boder-black'>관리비</th>
					</tr>
					<tr>
						<th  class='boder-black'>
						<c:choose>
						<c:when test="${arr.gasM ne null}">
						<span class='nomalFrom'><fmt:formatNumber value="${arr.gasM}" type="number"/>원</span>
						<span class='upFrom' style="display: none;"><input  class='manageI' type="text" name='gasM' value="${arr.gasM}"/>원</span>
						</c:when>
						<c:otherwise>
						<span class='nomalFrom'><fmt:formatNumber value="0" type="number"/>원</span>
						<span class='upFrom' style="display: none;" ><input  class='manageI' type="text" name='gasM' value="0"/>원</span>
						</c:otherwise>
						</c:choose>
						</th>
						
						<th  class='boder-black'>
						<c:choose>
						<c:when  test="${arr.elM ne null}">
						<span class='nomalFrom'><fmt:formatNumber value="${arr.elM}" type="number"/>원</span>
						<span class='upFrom' style="display: none;"><input  class='manageI' type="text" name="elM" value="${arr.elM}"/>원</span>
						</c:when>
						<c:otherwise>
						<span class='nomalFrom'><fmt:formatNumber value="0" type="number"/>원</span>
						<span class='upFrom' style="display: none;"><input  class='manageI' type="text" name="elM" value="0"/>원</span>
						</c:otherwise>
						</c:choose>
						</th>
						
						<th  class='boder-black'>
						<c:choose>
						<c:when  test="${arr.wtM ne null}">
						<span class='nomalFrom'><fmt:formatNumber value="${arr.wtM}" type="number"/>원</span>
						<span class='upFrom' style="display: none;"><input  class='manageI' type="text" name="wtM" value="${arr.wtM}""/>원</span>
						</c:when>
						<c:otherwise>
						<span class='nomalFrom'><fmt:formatNumber value="0" type="number"/>원</span>
						<span class='upFrom' style="display: none;" ><input  class='manageI' type="text" name="wtM" value="0"/>원</span>
						</c:otherwise>
						</c:choose>
						</th>
						
						<th  class='boder-black'>
						<c:choose>
						<c:when test="${arr.itM ne null}">
						<span class='nomalFrom'><fmt:formatNumber value="${arr.itM}" type="number"/>원</span>
						<span class='upFrom' style="display: none;"><input  class='manageI' type="text" name="itM"  value="${arr.itM}"/>원</span>
						</c:when>
						<c:otherwise>
						<span class='nomalFrom'><fmt:formatNumber value="0" type="number"/>원</span>
						<span class='upFrom' style="display: none;"><input  class='manageI' type="text" name="itM" value="0"/>원</span>
						</c:otherwise>
						</c:choose>
						</th>
						
						<th  class='boder-black'>
						<c:choose>
						<c:when test="${arr.maM ne null}">
						<span class='nomalFrom'><fmt:formatNumber value="${arr.maM}" type="number"/>원</span>
						<span class='upFrom' style="display: none;"><input  class='manageI' type="text" name="maM"  value="${arr.maM}"/>원</span>
						</c:when>
						<c:otherwise>
						<span class='nomalFrom'><fmt:formatNumber value="0" type="number"/>원</span>
						<span class='upFrom' style="display: none;"><input  class='manageI' type="text" name="maM" value="0"/>원</span>
						</c:otherwise>
						</c:choose>
						</th>
					</tr>
					<tr>
					<th colspan="5">
						<c:set var='avgNow' value="${(arr.gasM+arr.elM+arr.wtM+arr.itM+arr.maM)}" ></c:set>
					총 지출 : <fmt:formatNumber value="${avgNow}" type="number"/>원
					</th>
					</tr>
                	</tbody>
                	</table>
                		<input id='upbtn' class='btn_brown' type="button" onclick="up(${st.index});" value="수정"/> 
</form>
<iframe id="frmSys" name="frmSys" allowTransparency="true" width="0" height="0" scrolling="no" frameborder="0"></iframe>
                		</c:forEach>
                		
                </div>
              </div>
              
              <br><br>
              <div class="swiper-slide">
               <h3>이번달엔 얼마나 줄였을까? </h3>
      		<table class="tb">
      		<tbody>
      			<tr>
      			<th  class='boder-black'>년/월</th>
      			<th  class='boder-black'>가스</th>
      			<th  class='boder-black'>전기</th>
      			<th  class='boder-black'>수도</th>
      			<th  class='boder-black'>인터넷</th>
      			<th  class='boder-black'>관리비</th>
      			</tr>
		      <c:forEach var='arrC' items='${arrViewPast}' varStatus="st">
      			<tr>
      			<th  class='boder-black'>${arrC.yyyy}년 ${arrC.mm}월</th>
      			
      			<th  class='boder-black'>
      			<span class='nomalFrom'><fmt:formatNumber value="${arrC.gasM}" type="number"/>원
      			</span>
      			</th>
      			
      			<th  class='boder-black'>
      			<span class='nomalFrom'><fmt:formatNumber value="${arrC.elM}" type="number"/>원
      			</span>
      			</th>
      			
      			<th  class='boder-black'>
      			<span class='nomalFrom'><fmt:formatNumber value="${arrC.wtM}" type="number"/>원
      			</span>
      			</th>
      			
      			<th  class='boder-black'>
      			<span class='nomalFrom'><fmt:formatNumber value="${arrC.itM}" type="number"/>원
      			</span>
      			</th>      			
      			
      			<th  class='boder-black'>
      			<span class='nomalFrom'><fmt:formatNumber value="${arrC.maM}" type="number"/>원
      			</span>
      			</th>      			
      			</tr>		
      			</c:forEach>
      			
      			<c:set var='gas' value='${arrViewPast[1].gasM - arrViewPast[0].gasM}'/>
      			<c:set var='el' value='${arrViewPast[1].elM - arrViewPast[0].elM}' />
      			<c:set var='wt' value='${arrViewPast[1].wtM - arrViewPast[0].wtM}'/>
      			<c:set var='it' value='${arrViewPast[1].itM - arrViewPast[0].itM}' />
      			<c:set var='ma' value='${arrViewPast[1].maM - arrViewPast[0].maM}' />
      		
      			
      			<tr>
      				<th>개별 총</th>
      				<th class='boder-black'><fmt:formatNumber value="${gas}" type="number"/>원</th>
      				<th class='boder-black'><fmt:formatNumber value="${el}" type="number"/>원</th>
      				<th class='boder-black'><fmt:formatNumber value="${wt}" type="number"/>원</th>
      				<th class='boder-black'><fmt:formatNumber value="${it}" type="number"/>원</th>
      				<th class='boder-black'><fmt:formatNumber value="${ma}" type="number"/>원</th>
      			</tr>	    
      		</tbody>
     		</table>
     		
     		<br>
     		<a id='passY' href='javascript:show();' >>> 작년에는 얼마 썼을까?</a>
     		<table class="tb disNone" id = 'passYT' style="display: none;">
      		<tbody>
      			<tr>
      			<th  class='boder-black'>년/월</th>
      			<th  class='boder-black'>가스</th>
      			<th  class='boder-black'>전기</th>
      			<th  class='boder-black'>수도</th>
      			<th  class='boder-black'>인터넷</th>
      			<th  class='boder-black'>관리비</th>
      			</tr>
		      <c:forEach var='arr4' items='${arrViewPast4}' varStatus="st">
      			<tr>
      			<th  class='boder-black'>${arr4.yyyy}년 ${arr4.mm}월</th>
      			
      			<th  class='boder-black'>
      			<span class='nomalFrom'><fmt:formatNumber value="${arr4.gasM}" type="number"/>원
      			</span>
      			</th>
      			
      			<th  class='boder-black'>
      			<span class='nomalFrom'><fmt:formatNumber value="${arr4.elM}" type="number"/>원
      			</span>
      			</th>
      			
      			<th  class='boder-black'>
      			<span class='nomalFrom'><fmt:formatNumber value="${arr4.wtM}" type="number"/>원
      			</span>
      			</th>
      			
      			<th  class='boder-black'>
      			<span class='nomalFrom'><fmt:formatNumber value="${arr4.itM}" type="number"/>원
      			</span>
      			</th>    
      			
      			<th  class='boder-black'>
      			<span class='nomalFrom'><fmt:formatNumber value="${arr4.maM}" type="number"/>원
      			</span>
      			</th>     			
      			</tr>	
      			</c:forEach>
      			
      			<c:set var='gas2' value='${arrViewPast4[1].gasM - arrViewPast4[0].gasM}'/>
      			<c:set var='el2' value='${arrViewPast4[1].elM - arrViewPast4[0].elM}' />
      			<c:set var='wt2' value='${arrViewPast4[1].wtM - arrViewPast4[0].wtM}'/>
      			<c:set var='it2' value='${arrViewPast4[1].itM - arrViewPast4[0].itM}' />
      			<c:set var='ma2' value='${arrViewPast4[1].maM - arrViewPast4[0].maM}' />
      		
      			
      			<tr>
      				<th>개별 총</th>
      				<th class='boder-black'><fmt:formatNumber value="${gas2}" type="number"/>원</th>
      				<th class='boder-black'><fmt:formatNumber value="${el2}" type="number"/>원</th>
      				<th class='boder-black'><fmt:formatNumber value="${wt2}" type="number"/>원</th>
      				<th class='boder-black'><fmt:formatNumber value="${it2}" type="number"/>원</th>
      				<th class='boder-black'><fmt:formatNumber value="${ma2}" type="number"/>원</th>
      			</tr>	    
      		</tbody>
     		</table>
     		
     		<br>
     		
     		<c:set var='avg' value="${(gas+el+wt+it+ma)}" ></c:set>
     		
     		     		
			<c:choose>
			<c:when test="${avg >= 0}">
			<div style="text-align: center;" class='savingDiv'>
			<h4>
			<img alt="" src="${contextPath}/resources/img/feeling/good1.png" style="width: 34%">
			이번달엔<fmt:formatNumber value="${avg}" type="number"/>원 절약했어!</h4>
			</div>
			
			</c:when>
			<c:when test="${avg < 0}">
     		<c:set var='avg2' value="${(gas+el+wt+it)* -1}" ></c:set>
     		
			<div style="text-align: center;" class='savingDiv'>
			<h4>
			<img alt="" src="${contextPath}/resources/img/feeling/bad.png" style="width: 34%">
			<fmt:formatNumber value="${avg2}" type="number"/>원 더 사용했어..</h4>
			</div>
			</c:when>
			</c:choose>
			
      		
      		<br>
      		<hr>
      		<br>
      		
      		<h3>한눈에 보는 내 공과금</h3>
      		<br>
      		<!-- 전원 당월 막대그래프 비교 -->
      		<figure class="highcharts-figure">
		    <div id="container1"></div>
		    <p class="highcharts-description">
		      
		    </p>
			</figure>
			
			<br><br>
      		
      		
      		<!-- 3개월간 총 지출 금액 차트 -->
      		<figure class="highcharts-figure">
		    <div id="container3"></div>
		    <p class="highcharts-description">
		        
		    </p>
			</figure>
			
				<!-- 6개월간 총 지출 금액 차트 -->
      		<figure class="highcharts-figure">
		    <div id="container6"></div>
		    <p class="highcharts-description">
		        
		    </p>
			</figure>
			
      		
      		<%-- 
      		<!-- 1년간 총 지출 금액 차트 --> <!-- 여기부터 -->
      		<div style="width: 100%; ">
				<!--차트가 그려질 부분-->
				<canvas id="myChart" ></canvas>
			</div>
			 --%> 
			<br><br>
			
			
		<!-- 1년간 총 지출 금액 차트 --> <!-- 여기부터 -->
      		<figure class="highcharts-figure">
		    <div id="container12"></div>
		    <p class="highcharts-description">
		        
		    </p>
			</figure>

			
              </div>
            </div>
          </div>
          <script>
      	// 검색 버튼
      	function schGo(){
      		
      		location.href='index.do?yyyy='+ $("select[name=yyyyC]").val() + '&mm=' + $("select[name=mmC]").val() + '&uId=' + $("input:hidden[name='uId']").val(); 
      		
      	}
      	
      	// 자세히 보기
      	function detail(){
      		
      		location.href='detailView.do?yyyy='+ $("select[name=yyyyC]").val() + '&mm=' + $("select[name=mmC]").val() ; 
      	}
          </script>
<%-- 
          <div class="col-lg-4">
            <div class="portfolio-info">
              <h3>Project information</h3>
              <ul>
                <li><strong>Category</strong>: Web design</li>
                <li><strong>Client</strong>: ASU Company</li>
                <li><strong>Project date</strong>: 01 March, 2020</li>
                <li><strong>Project URL</strong>: <a href="#">www.example.com</a></li>
              </ul>
            </div>
            <div class="portfolio-description">
              <h2>th  class='boder-black'is is an example of portfolio detail</h2>
              <p>
                Autem ipsum nam porro corporis rerum. Quis eos dolorem eos itaque inventore commodi labore quia quia. Exercitationem repudiandae officiis neque suscipit non officia eaque itaque enim. Voluptatem officia accusantium nesciunt est omnis tempora consectetur dignissimos. Sequi nulla at esse enim cum deserunt eius.
              </p>
            </div>
          </div>

        </div>

      </div>
    </section><!-- End Portfolio Details Section -->
--%>
  </main><!-- End #main -->

</body>
<!-- ------------------------- header ---------------------------- -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</html>