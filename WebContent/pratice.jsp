<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="jquery-3.5.1.min.js"></script>
<script>
		//************************��¥ ���************************
		var d = new Date();
		var yy = String(d.getFullYear());	//2020
		var mm = String(d.getMonth() + 1);	//11	// 0���� �����̱� ������ +1 ����
		var dd = String(d.getDate() - 1);	//15	// �ش����� ���� ��ȸ�� �ȵǱ⶧���� ���� �����͸� �ҷ����� ���� -1 ����
		var today = Number(yy.concat(mm, dd));		// ��, ��, ���� ���ڿ��� ��ġ�� ���������� �ٲ�		today������ url�� �Ķ���ͷ� �ٿ��ش�.
		
		$(document).ready(function()	{
			$.ajax({																																		
				url:" http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=85e9e2c651b6647b5c00cc8dd87a03d4&targetDt="+today,
				type:"get",
				success:function(data){
					var output = "";
					for(var i = 0; i < data.boxOfficeResult.dailyBoxOfficeList.length; i++){
						output += "<tr>";
							output += 		"<td>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["rank"] +"��</td>";			//��ȭ ����
							output += 		"<td>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["movieNm"] +"</td>";		//��ȭ ����
							output += 		"<td>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["openDt"] +"</td>";		//��ȭ ������
							output +=		"<td>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["salesAcc"] +"</td>";		//���� �����
							output += 		"<td>"+ data["boxOfficeResult"]["dailyBoxOfficeList"][i]["audiAcc"] +"</td>";		//���� ������
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
				<th>����</th>
				<th>��ȭ ����</th>
				<th>��ȭ ������</th>
				<th>���� �����</th>
				<th>���� ������</th>
			</tr>
		</thead>
		<tbody id="tbody">
			
		</tbody>
	</table>
</body>
</html>