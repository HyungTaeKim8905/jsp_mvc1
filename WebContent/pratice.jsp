<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="jquery-3.5.1.min.js"></script>
<script>
		//************************날짜 계산************************
		var d = new Date();
		var yy = String(d.getFullYear());	//2020
		var mm = String(d.getMonth() + 1);	//11	// 0부터 시작이기 때문에 +1 해줌
		var dd = String(d.getDate() - 1);	//15	// 해당일은 정보 조회가 안되기때문에 전날 데이터를 불러오기 위해 -1 해줌
		var today = Number(yy.concat(mm, dd));		// 년, 월, 일을 문자열로 합치고 숫자형으로 바꿈		today변수를 url뒤 파라미터로 붙여준다.
		
		$(document).ready(function()	{
			$.ajax({																																		
				url:" http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=85e9e2c651b6647b5c00cc8dd87a03d4&targetDt="+today,
				type:"get",
				success:function(data){
					var output = "";
					for(var i = 0; i < data.boxOfficeResult.dailyBoxOfficeList.length; i++){
						output += "<tr>";
							output += 		"<td>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["rank"] +"위</td>";			//영화 순위
							output += 		"<td>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["movieNm"] +"</td>";		//영화 제목
							output += 		"<td>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["openDt"] +"</td>";		//영화 개봉일
							output +=		"<td>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["salesAcc"] +"</td>";		//누적 매출액
							output += 		"<td>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["audiAcc"] +"</td>";		//누적 관객수
						output += "</tr>";
					}
					$("#tbody").html(output);
				}
			})
		})
	</script>
</head>
<body>
	<table border="1" width="1000">
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
</body>
</html>