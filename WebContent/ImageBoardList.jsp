<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="Header.jsp" %>
	<style>

		img {
			width:200px;
			height:280px;
		}
		
		content {
			font-size:7px;
		}
		
		.h1 {
			width:340px;
			position:absolute;
			left: 70px;
			top:145px;
		}
		
		.h2 {
			width:340px;
			position:absolute;
			left: 900px;
			top:145px;
		}
		
		
		.ImageSearch {
			position:absolute;
			top:150px;
			left:670px;
		}
		
		.a1 {
				position:absolute;
				left:1205px;
				top:170px;
		}
		
		.IMGInsert {
			border:none;
			cursor:pointer;
			position:absolute;
			left:1090px;
			top:950px;
		}
		
		.picturediv {
			width:1040px;
			height:750px;
			position:absolute;
			left:30px;
			top:200px;
			
		}
	
		.div1 {
			color:gray;
			position:absolute;
			left:1030px;
		}
		
		.MovieRanking {
			width:700px;
			height:630px;
			position:relative;
			left:900px;
			top:128px;
		}
		
		
	</style>
	<script src="jquery-3.5.1.min.js"></script>
	<script>
	//************************날짜 계산************************
	var d = new Date();
	var yy = String(d.getFullYear());	//2020
	var mm = String(d.getMonth() + 1);	//11	// 0부터 시작이기 때문에 +1 해줌
	var dd = String(d.getDate() - 1);	//15	// 해당일은 정보 조회가 안되기때문에 전날 데이터를 불러오기 위해 -1 해줌
	var today = Number(yy.concat(mm, dd));		// 년, 월, 일을 문자열로 합치고 숫자형으로 바꿈		today변수를 url뒤 파라미터로 붙여준다.
	
		$.ajax({																								
			url:" http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=85e9e2c651b6647b5c00cc8dd87a03d4&targetDt="+today,
			type:"get",
			success:function(data){
				var output = "";
				var output1 = "";
				for(var i = 0; i < data.boxOfficeResult.dailyBoxOfficeList.length; i++){
					output += "<tr>";
					if(i % 2 == 0)	{
						output += 		"<td style='background-color:#AAA'>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["rank"] +"위</td>";			//영화 순위
						output += 		"<td style='background-color:#AAA'>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["movieNm"] +"</td>";			//영화 제목
						output += 		"<td style='background-color:#AAA'>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["openDt"] +"</td>";			//영화 개봉일
						output +=		"<td style='background-color:#AAA'>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["salesAcc"] +"</td>";		//누적 매출액
						output += 		"<td style='background-color:#AAA'>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["audiAcc"] +"</td>";			//누적 관객수
					} else	{
						output += 		"<td>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["rank"] +"위</td>";			//영화 순위
						output += 		"<td>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["movieNm"] +"</td>";		//영화 제목
						output += 		"<td>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["openDt"] +"</td>";		//영화 개봉일
						output +=		"<td>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["salesAcc"] +"</td>";		//누적 매출액
						output += 		"<td>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["audiAcc"] +"</td>";		//누적 관객수
					}
					output += "</tr>";
					if(i <= 7)	{
					output1 +=  "<li style='float:left; width:200; margin-right:5px;'>";
					output1 +=  "<img src='" + i + ".jpg'>";
					output1 +=  "<div>";
					output1 += 	"<h5 style='font-size:medium; margin-top:0px; margin-bottom:0px; width:200px'>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["movieNm"] +"</h5>";		//영화 제목
					output1 += 	"<h5 style='font-size:medium; margin-top:0px; margin-bottom:0px;'>일일 관객수 : "+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["audiCnt"] +"</h5>";		//영화 제목
					output1 +=  "</div>";
					output1 +=  "</li>";
					}
				}
				$("#tbody").html(output);
				$("#gogo").append(output1);
			}
		});
	</script>
</head>
<body>
	<h1 class="h1">현재 개봉작</h1>
	<!-- ******************** 영화코드 영화순위 영화제목을 나타내는 부분 ***********************-->
	<h1 class="h2">실시간 박스오피스</h1>
	<table class="MovieRanking">
	<thead>
		<tr>
			<th>순위</th>
			<th>영화 제목</th>
			<th>영화 개봉일</th>
			<th>누적 매출액</th>
			<th>누적 관객수</th>
		</tr>
	</thead>
	<tbody id="tbody">
	
	</tbody>
</table>
		<!-- 사진 정렬 -->
		<div class="picturediv" style="list-style:none;">
			<ul style="list-style:none; margin-top:0px; margin-bottom:0px;" id="gogo">
				
			</ul>
		</div>
</body>
</html>
<%@ include file="Footer.jsp" %>