<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="Header.jsp" %>
<script src="jquery-3.5.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
	<script>
		function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	            }
	        }).open();
	    }
			function idcheck()	{// 아이디 중복확인 버튼을 눌렀을때 실행되는 함수 
				 var id = document.board.id.value;
				 location.href="idcheck.jsp?id=" + id;
			}
			
			function chkPW(){
				var pw = $("#password").val();	
				var num = pw.search(/[0-9]/g);	//전체에서  0~9사이에 아무 숫자 '하나'  찾음 만약 1234가 입력되면 pw에는 1234가 저장되는지
				var eng = pw.search(/[a-z]/ig); 
				var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
				if(pw.length < 8 || pw.length > 20){
					alert("8자리 ~ 20자리 이내로 입력해주세요.");
					return false;
				}else if(pw.search(/\s/) != -1){
					alert("비밀번호는 공백 없이 입력해주세요.");
					return false;
				}else if(num < 0 || eng < 0 || spe < 0 ){
					alert("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
					return false;
				}else {
					//console.log("통과"); 
					return true;
				}
			}
			
// sample6_postcode  sample6_address  sample6_detailAddress  sample6_extraAddress
			/*
			function SumAddress()	{
						var postcode = $("#sample6_postcode").val();
						var address = $("#sample6_address").val();
						var detailAddress = $("#sample6_detailAddress").val();
						var extraAddress = $("#sample6_extraAddress").val();			//각각의 주소값을 각각의 변수에 저장
						var result = postcode.concat(" ", address," ", detailAddress," ", extraAddress);
						return result;
					}
			document.getElementById("address").value = SumAddress();
			*/
			$(document).ready(function(){      // blur() 요소에서 포커스를 잃을 경우에 발생하는 이벤트 이다
				$("#password").blur(function(){
					if($(this).val()!=""){
						var result = chkPW();		// result값이 true면 blur 실행
					}
				});
				$("form").submit(function(){		// true면 전송이 되고 false면 전송 안되고?
					if($("#id").val() == ""){		// || $("#id").val().trim().length == 0 공백을 썻을때도 alert를 띄우고 싶은데 이게 맞는지
						alert("아이디를 입력하세요.");
						$("#id").focus();
						return false;
					}else if($("#password").val() == ""){
						alert("비밀번호를 입력하세요.");
						$("#password").focus();
						return false;
					}else if($("#passwordRe").val() == ""){
						alert("비밀번호 확인을 입력하세요.");
						$("#passwordRe").focus();
						return false;
					}else if($("#passwordRe").val() != $("#password").val()){
						alert("비밀번호가 일치하지 않습니다.");
						$("#passwordRe").focus();
						return false;
					}else if($("#name").val() == ""){
						alert("이름을 입력하세요.");
						$("#name").focus();
						return false;
					}else if($("#email").val() == ""){
						alert("이메일을 입력하세요.");
						$("#email").focus();
						return false;
					}else if($("#phone2 ").val() == ""){
						alert("전화번호를 입력하세요.");
						$("#phone2").focus();
						return false;
					}else{
						var postcode = $("#sample6_postcode").val();
						var address = $("#sample6_address").val();
						var detailAddress = $("#sample6_detailAddress").val();
						var extraAddress = $("#sample6_extraAddress").val();			//각각의 주소값을 각각의 변수에 저장
						var result = postcode.concat(" ", address," ", detailAddress," ", extraAddress);
						$("#address").val(result);
						//---------------------------------
						var phone1 = $("#phone1").val();
						var phone2 = $("#phone2").val();
						var phone3 = $("#phone3").val();
						var result1 = phone1.concat("-", phone2,"-", phone3);
						$("#phone").val(result1);
						return true;				
					}
				});
			});
		</script>
		<style>
			button {
				background-color: #e3f2fd!important;
			}
			
			input:button {
				background-color: #e3f2fd!important;
			}
		</style>
</head>
<body>
	<section>
			<article>
				<form id="board" name="board" action="joinok.jsp" method="post">
					<fieldset>
						<div id="form">
							<h3>
								아이디 <span>*</span><br> 					<!--  onclick="idcheck()" -->
								<input type="text" name="id" id="id"> <input type="button" onclick="idcheck()" value="아이디 중복확인" style="background-color: #e3f2fd!important;">
							</h3>
							<h3>
								비밀번호 <span>*</span><br> 
								<input type="password" name="password" id="password">
							</h3>
							<h3>
								비밀번호 확인 <span>*</span><br> 
								<input type="password" name="passwordRe" id="passwordRe">
							</h3>
							<h3>
								이름 <span>*</span><br> 
								<input type="text" name="name" id="name">
							</h3>
							<h3>
								생년월일<br> 
								<input type="date" name="birth" id="birth" value="1990-01-01">
							</h3>
							<h3>성별</h3>
							<div id="radio_g">
								<input type="radio" name="gender" id="gender" value="M">남자
								<input type="radio" name="gender" id="gender" value="F">여자
							</div>
							<h3>
								이메일 <span>*</span><br> 
								<input type="email" name="email" id="email">
							</h3>				
							<h3>주소 <span>*</span><br>
								<input type="text" id="sample6_postcode" placeholder="우편번호">
								<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" style="background-color: #e3f2fd!important;"><br>
								<input type="text" id="sample6_address" placeholder="주소"><br>
								<input type="text" id="sample6_detailAddress" placeholder="상세주소">
								<input type="text" id="sample6_extraAddress" placeholder="참고항목">
								<input type="hidden" id="address" name="address" value="">
							</h3>
							</h3>
							<h3>전화번호 <span>*</span></h3>
							<div class="phone_d">
								<select name="phone1" id="phone1">	<!--  input hidden  -->
									<option value="010" selected>010</option>
									<option value="011">011</option>
									<option value="016">016</option>
								</select> 
								<input type="text" name="phone2" id="phone2" size="5" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">-<input type="text" name="phone3" id="phone3" size="5" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"></h3>
								<input type="hidden" id="phone" name="phone" value="">
							</div>
						</div>
					</fieldset>
					<br>
					<button type="submit" id="join">가입하기</button>
				</form>
				<br>
			</article>
		</section>
</body>