<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ include file="include/header.jsp" %>


<style type="text/css">
	
	.idOkay{
		display: none;
	}

	.idExist{
		display: none;
	}
	
	.lessThanWord{
		display: none;
	}
	
	.overThanWords{
		display: none
	}
	
	.signUpFormWrapper{
		margin-top: 100px;
		display: flex;
		justify-content: center;
	}
	
	#signUpForm{
		text-align: center;
	    width: 70%;
	    display: flex;
	    flex-direction: column;
	}
</style>

		<div class="board_write_wrapper">		
			<div class="signUpFormWrapper">
				<form id="signUpForm" action="/insertUser" method="post">
				
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					
					<div class="inputIdBoxing">
						<div>
							<input id="idInput" type="text" name="userid" placeholder="ID" autofocus="autofocus" oninput="checkingId()">
						</div>
						<div class="idOkay">사용 가능한 아이디입니다.</div>
						<div class="idExist">이미 사용중인 아이디입니다.</div>
						<div class="lessThanWord">최소 5글자 이상 입력하세요.</div>
						<div class="overThanWords">최대 10글자 이하만 입력가능합니다.</div>
					</div>
					
					<div>
						<input id="pwInput" type="password" name="userpw" placeholder="password" oninput="checkPw()" required="required">
					</div>
					<div>
						<input id="pwDoubleChecking" type="password" name="userpw" placeholder="confirm password" oninput="checkPw()" required="required">
					</div>
					<div>
						<input type="text" name="userName" placeholder="name" required="required">
					</div>
					
					<div>
						<button id="signUpBTN" type="submit" disabled="disabled">가입</button>
						<button type="button">취소</button>
					</div>					
					
				</form>
			</div>
		</div> <!-- board_write_wrapper -->
	
	
		
		
	</div> <!-- wrapper -->
	
	
	<%@ include file="include/footer.jsp" %>
	
	<script type="text/javascript">
		
			
			function checkingId(){
							
				if($.trim($("#idInput").val()).length < 5){
					$(".idOkay").css("display", "none");
					$(".idExist").css("display", "none");
					$(".lessThanWord").css("display", "inline-block");
					$(".overThanWords").css("display", "none");
					$("#idInput").css("background-color", "#FFCECE");
					return false;
				}
				
				if($.trim($("#idInput").val()).length > 10){
					$(".idOkay").css("display", "none");
					$(".idExist").css("display", "none");
					$(".lessThanWord").css("display", "none");
					$(".overThanWords").css("display", "inline-block");
					$("#idInput").css("background-color", "#FFCECE");
					$("#idInput").val("");
					return false;
				}
				
				var idOkay = "";
				var pwOkay = "";
				var inputId = $("#idInput").val();
				
				var csrfHeaderName = "${_csrf.headerName}";
				var csrfTokenValue = "${_csrf.token}";	
				
				
				$.ajax({
					url: '/checkId',
					data:{userid: inputId},
					type: 'POST',
					dataType: 'JSON',
					beforeSend: function(xhr){
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					success:function(cnt){
						if(cnt == 0){  // 아이디 사용가능
							
							idOkay = 1;
						
							console.log("cnt:0 - 아이디 사용가능");							
							console.log("idokay: " + idOkay);

							
							if(idOkay == 1 && pwOkay == 1){
								console.log("id and pw are okay");
								$("#signUpBTN").css("disabled", false);
								signUpAble();
							}
							
							$(".idOkay").css("display", "inline-block");
							$(".idExist").css("display", "none");
							$(".lessThanWord").css("display", "none");
							$("#idInput").css("background-color", "#B0F6AC");
							
						}else if(cnt == 1){  // 아이디 중복
							
							console.log("cnt:1 - 아이디 중복");
							console.log("idokay: " + idOkay);
							
							$(".idOkay").css("display", "none");
							$(".idExist").css("display", "inline-block");
							$(".lessThanWord").css("display", "none");							
							$("#idInput").css("background-color", "#FFCECE");
							
						}else if(inputId == ""){
							
							$(".idOkay").attr("display", "none");
							$(".idExist").attr("display", "none");							
							$("#idInput").css("background-color", "white");
						}	
					}
				//	error:function(){
				//		alert("ERROR");
				//	}
					
				});
			} // checkingId end
			
			function checkPw(){
				
				var pwInput = $("#pwInput").val();	
				var pwRechecking = $("#pwDoubleChecking").val();
				
				if(pwInput != pwRechecking){
					
					pwOkay = 0;
					
					console.log("pwOkay: 0 - 패스워드 불일치");
					console.log("pwOkay: " + pwOkay);
					
					$("#pwInput").css("background-color", "#FFCECE");
					$("#pwDoubleChecking").css("background-color", "#FFCECE");
					
				}else if (pwInput == pwRechecking){
					
					pwOkay = 1;
					
					console.log("pwOkay: 1 - 패스워드 일치");
					console.log("pwOkay: " + pwOkay);
					
					$("#pwInput").css("background-color", "#B0F6AC");
					$("#pwDoubleChecking").css("background-color", "#B0F6AC");
					signUpAble();
				}
				
			} // checkPw end
			
			function signUpAble(){
				
				$("#signUpBTN").prop("disabled", false);
				
			} // signUpAble end
			
	
	</script>
	
	
</body>
</html>

					
						
						
						
				

	