function e_check(){
	
	 if($("#jobFin").is(":checked")){
        $("#jobFin").val('Y');
     }else{
        $("#jobFin").val('N');
     }	
     
     if($("#fin").val() == 'Y'){
     	alert("더 이상 수정할수 없습니다.");
     	return false;
     }     
     
	if($("#jobSpace").val() == ""){
		alert("인원수를 입력하세요.");
		$("#jobSpace").focus();
		return false;
	}
	if($("#jobEndDate2").val() == ""){
		alert("모집 마감일을 입력하세요.");
		$("#jobEndDate").focus();
		return false;
	}
	if($("#jobConcert2").val() == ""){
		alert("공연일을 입력하세요.");
		$("#jobConcert").focus();
		return false;
	}
	if($("#jobAddress").val() == ""){
		alert("주소를 입력하세요.");
		$("#jobAddress").focus();
		return false;
	}
	if($(":radio[name='jobCd']").is(":checked") == false){
		alert("분류를 선택해주세요.");
		return false;	
	}
	if($("#jobSub").val() == ""){
		alert("제목을 입력하세요.");
		$("#jobSubject").focus();
		return false;
	}
	
	if($("#jobSub").val().length > 100) {
		alert("제목을 100자 이내로만 입력가능합니다.");
		$("#jobSub").focus();
		return false;
	}
	
	if($("#jobText").val() == ""){
		alert("내용을 입력하세요.");
		$("#jobText").focus();	
		return false;
	}
	
	if($("#jobText").val().length > 4000) {
		alert("내용을 4000자 이내로만 입력가능합니다.");
		$("#jobSub").focus();
		return false;
	}

}	