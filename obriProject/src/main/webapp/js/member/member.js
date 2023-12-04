var checkid = 'n';

// 가입 필수 입력 항목 검사
function check(){

	$("#idGuide").hide();
	$("#pwGuide").hide();
	$("#nameGuide").hide();
	$("#phoneGuide").hide();
	$("#emailGuide").hide();

	var mempw=$("#userPw").val();

	 if($.trim($("#userId").val())==""){
		var newtext='<font color="red">아이디를 입력해주세요.</font>';
		$("#idGuide").text('');
		$("#idGuide").show();
		$("#idGuide").append(newtext);
		$("#userId").val("").focus();
		return false;
	 }
	 
	 if($.trim($("#userPw").val())==""){
		var newtext='<font color="red">비밀번호를 입력해주세요.</font>';
		$("#pwGuide").text('');
		$("#pwGuide").show();
		$("#pwGuide").append(newtext);
		$("#userPw").val("").focus();
		return false;
	 }
	 if($.trim($("#userName").val())==""){
		var newtext='<font color="red">이름을 입력해주세요.</font>';
		$("#nameGuide").text('');
		$("#nameGuide").show();
		$("#nameGuide").append(newtext);
		$("#userName").val("").focus();
		return false;
	 }
	 if($.trim($("#userPhone").val())==""){
		var newtext='<font color="red">휴대폰번호를 입력해주세요.</font>';
		$("#phoneGuide").text('');
		$("#phoneGuide").show();
		$("#phoneGuide").append(newtext);
		$("#userPhone").val("").focus();
		 return false;
	 }
	 if($.trim($("#userEmail").val())==""){
		var newtext='<font color="red">이메일을 입력해주세요.</font>';
		$("#emailGuide").text('');
		$("#emailGuide").show();
		$("#emailGuide").append(newtext);
		$("#userEmail").val("").focus();
		return false;
	 }
	if($.trim($("#userPw").val()).length < 6){
		var newtext='<font color="red">비밀번호는 6~12자의 값이어야 합니다.</font>';
		$("#pwGuide").text('');
		$("#pwGuide").show();
		$("#pwGuide").append(newtext);
		$("#userPw").focus();
		return false;
	}
	if(!(validateUserPw(mempw))){
		var newtext='<font color="red">비밀번호는 영대소문자, 숫자만 가능합니다.</font>';
		$("#pwGuide").text('');
		$("#pwGuide").show();
		$("#pwGuide").append(newtext);
		$("#userPw").focus();
		return false;
	}
	if(checkid == 'n'){
		var newtext='<font color="red">아이디 중복확인을 해주세요.</font>';
		$("#idGuide").text('');
		$("#idGuide").show();
		$("#idGuide").append(newtext);
		$("#userId").focus();
		return false;
	}
};

// 입력 비밀번호 유효성 검사 : 영대소문자, 숫자
function validateUserPw(mempw){
  var pattern= new RegExp(/^[A-Za-z0-9]+$/);
  return pattern.test(mempw);
};

// 아이디 중복 확인
function checkId(){
	$("#idGuide").hide();
	var memid=$("#userId").val();
	
	// 1. 길이 검사
	if($.trim($("#userId").val()).length < 6){
		var newtext='<font color="red">아이디는 6~12자의 값이어야 합니다.</font>';
		$("#idGuide").text('');
		$("#idGuide").show();
		$("#idGuide").append(newtext);
		$("#userId").focus();
		return false;
	}
	
	// 2. 유효성 검사
	if(!(validateUserId(memid))){
		var newtext='<font color="red">아이디는 영소문자, 숫자만 가능합니다.</font>';
		$("#idGuide").text('');
		$("#idGuide").show();
		$("#idGuide").append(newtext);
		$("#userId").focus();
		return false;
	}
	
	// 3. 중복 검사
    $.ajax({
        type: "POST", 
        url: "checkMemId.do",
        data: {"memid":memid}, 
        success: function(data) {
      	  if(data == 1){	// 중복
      		var newtext='<font color="red">사용 중인 아이디입니다.</font>';
      		$("#idGuide").text('');
        	$("#idGuide").show();
        	$("#idGuide").append(newtext);
          	$("#userId").focus();
          	return false;
	      }else{	// 사용가능
      		var newtext='<font color="blue">사용 가능한 아이디입니다.</font>';
      		$("#idGuide").text('');
      		$("#idGuide").show();
      		$("#idGuide").append(newtext);
      		$("#userPw").focus();	// 다음으로 이동
      		
      		checkid = 'y';
      	  }  	    	  
        }
        ,
    	error:function(e){
    		alert("data error"+e);
    	}
    });
};

// 입력 아이디 유효성 검사 : 영소문자, 숫자
function validateUserId(memid){
  var pattern= new RegExp(/^[a-z0-9]+$/); 
  return pattern.test(memid);
};