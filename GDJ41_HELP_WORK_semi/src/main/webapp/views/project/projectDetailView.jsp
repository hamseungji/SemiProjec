<%@page import="java.util.Arrays"%>
<%@page import="com.help.project.model.vo.ProMemberJoinMember"%>
<%@page import="java.util.List"%>
<%@page import="com.help.project.model.vo.Project"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<%
	Project p = (Project)request.getAttribute("projectInfo");
	List<ProMemberJoinMember> pMember = (List)request.getAttribute("ProMemberJoinMember");
	
	String[] memberName = new String[pMember.size()];
	
	for(int i =0; i<pMember.size();i++){
		String temp = (String)pMember.get(i).getMemberName();
		memberName[i] = temp;
	}
%>
<link rel ="stylesheet" href="<%=request.getContextPath()%>/css/projectDetailView.css" type="text/css">
<main>

<!-- 프로젝트정보 -->

<input type="hidden" id="memberId" value="<%=loginMember.getMemberId()%>">
<input type="hidden" id="projectNo" value="<%=p.getProjectNo()%>">

<!-- 일반게시글 작성 모달 -->
<button style="display:none;" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal1" id="insertNormal_">글작성</button>
<div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" onsubmit="return checkContent();">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">게시물 작성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <input class="form-control" type="text" placeholder="제목" aria-label="default input example" name="title">
      <span id="titleResult"></span>
        <textarea class="form-control" placeholder="내용을 입력하세요" id="normalContent" style="height: 200px; margin-top: 20px; margin-bottom:10px; resize:none"></textarea>
		  <div class="mb-3">
 		<label for="formFile" class="form-label"></label>
  		<input class="form-control" type="file" id="uploadNormal" name="upfile" multiple>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="close_content">닫기</button>
        <button type="button" class="btn btn-primary" id="normal_submit_Btn">등록</button>
      </div>
    </div>
  </div>
</div>

<!-- 업무게시글 작성 모달 -->
<button style="display:none;" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal2" id="insertWork_">글작성</button>

<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" onsubmit="return checkWorkContent();">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">업무 작성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <input class="form-control" type="text" placeholder="제목" aria-label="default input example" id="workTitle">
      <span id="work_titleResult"></span>
      <div id="work_Ing_container">
      	<span><i class="fas fa-history"></i></span>
      	<button type="button" class="btn btn-outline-primary">요청</button>
      	<button type="button" class="btn btn-outline-success">진행</button>
      	<button type="button" class="btn btn-outline-warning">피드백</button>
      	<button type="button" class="btn btn-outline-secondary">보류</button>
      	<button type="button" class="btn btn-outline-primary">완료</button>
      </div>
      <div id="work_addMember_container">
      	<span><i class="fas fa-user"></i></span>
      		<select class="form-select" id="work_addMember"></select>
      </div>
      <div id="workStart_container">
      	<span><i class="fas fa-calendar-plus"></i></span>
      	<input type="date" id="workStart">
      </div>
      <div id="workEnd_container">
      	<span><i class="fas fa-calendar-check"></i></span>
      	<input type="date" id="workEnd">
      </div>
      <div id="workRank_container">
     	 <span><i class="fas fa-flag"></i></span>
      	 <select class="form-select" id="workRank">
			  <option value="1" selected="selected">Open this select menu</option>
			  <option value="1">One</option>
			  <option value="2">Two</option>
			  <option value="3">Three</option>
		</select>
      </div>
      
        <textarea class="form-control" placeholder="내용을 입력하세요" id="workContent" style="height: 200px; margin-top: 20px; margin-bottom:10px; resize:none"></textarea>
		  <div class="mb-3">
 		<label for="formFile" class="form-label"></label>
  		<input class="form-control" type="file" id="uploadWorkfile_" name="uploadWorkfile" multiple>
		</div>
		<input type="hidden" id="memberId" value="admin">
		<input type="hidden" id="projectNo" value="3">
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="close_content">닫기</button>
        <button type="button" class="btn btn-primary" id="work_submit_Btn">등록</button>
      </div>
    </div>
  </div>
</div>


<div id="title-container">
	<div id="pro-bookmark-star"><i class="fas fa-star"></i></div>
	<div id="project-title"><span><%=p.getProName() %></span></div>
</div>
<div id="menu-container">
	<ul class="nav">
		<li class="nav-item"><a class="nav-link active" aria-current="page" href="#">홈</a></li>
		<li class="nav-item"><a class="nav-link" href="#">업무</a></li>
		<li class="nav-item"><a class="nav-link" href="#">파일</a></li>
		<%if(loginMember.getMemberId().equals(p.getMemberId())){ %> <!-- 현재 로그인된 멤버와, 프로젝트 생성자 아이디가 같으면 초대 버튼 활성화 -->
		<li class="nav-item"><a class="nav-link" href="#">초대</a></li>
		<%} %>
	</ul>
</div>
	<hr style="margin-top: 5px;">
<div id="pro_container">
	<div id="inputContent_container">
		<div id="input-group">
			<div id="insertNormal"><a href="#"><span><i class="fas fa-edit"></i></span>&nbsp;글</a></div>
			<div id="insertWork"><a href="#"><span><i class="fas fa-list"></i></span>&nbsp;업무</a></div>
			<div id="insertSche"><a href="#"><span><i class="far fa-calendar"></i></span>&nbsp;일정</a></div>
			<div id="insertTodo"><a href="#"><span><i class="fas fa-check-square"></i></span>&nbsp;할일</a></div>
		</div>
	</div>
	<div id="content_section"></div>
</div>

</main>
<script>
	/* 1.일반 게시글 작성 로직 */
	$("#insertNormal").click(e=>{
		$("#insertNormal_").click();
		
	});
	
	const checkContent=()=>{
		let title = $("input[name=title]").val();
		if(title.trim().length == 0){
			$("input[name=title]").focus();
			$("#titleResult").text("제목을 입력하세요").css("color","red");
			return false;
		}
	}
	
	$("#normal_submit_Btn").click(e=>{
	
		const frm = new FormData();
		const fileInput = $("input[name=upfile]");
		for(let i=0; i<fileInput[0].files.length;i++){
			frm.append("upfile"+i,fileInput[0].files[i]);
			
		}
		frm.append("title", $("input[name=title]").val());
		frm.append("content", $("#normalContent").val());
		frm.append("memberId",$("#memberId").val());
		frm.append("projectNo", $("#projectNo").val());
	
		
		$.ajax({
			url : "<%=request.getContextPath()%>/project/insertNormalContent.do",
			type:"post",
			data:frm,
			processData:false,
			contentType:false,
			success:data=>{
				$("#close_content").click();
			},
			error:(a)=>{
				alert("실팽");
			}
			
		});
		
	});
	
	/* 2.업무 게시글 작성 로직 */
	
	
	$("#insertWork").click(e=>{
		$("#insertWork_").click();	
	});
	
	const checkWorkContent=()=>{
		let worktitle = $("#workTitle").val();
		if(title.trim().length == 0){
			$("#workTitle").focus();
			$("#work_titleResult").text("제목을 입력하세요").css("color","red");
			return false;
		}
	}
	
	//해당 프로젝트 참여자 리스트 .. 업무 작성시
	
		
		const select = $("#work_addMember");
		
			
		let memberName = new Array();
		memberName = "<%=Arrays.toString(memberName)%>";
		memberName = memberName.substring(1,memberName.length-1);
		memberName = memberName.split(",");
		
		
			for(let i=0; i<memberName.length;i++){
				const option = $("<option>");
				option.val(memberName[i].trim()).text(memberName[i].trim());
				select.append(option);
			}
	
	
 	/* $("#work_submit_Btn").click(e=>{
		
		let workTitle = $("#workTitle").val();
		let workIng= 
		let workAddMember=
		let workStart=
		let workEnd=
		let workRank=
		let workContent=
		
	}); */
	

</script>

<%@ include file="/views/common/footer.jsp"%>