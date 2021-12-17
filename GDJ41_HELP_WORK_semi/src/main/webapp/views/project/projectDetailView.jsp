<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<link rel ="stylesheet" href="<%=request.getContextPath()%>/css/projectDetailView.css" type="text/css">
<main>


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
		<input type="hidden" id="memberId" value="admin">
		<input type="hidden" id="projectNo" value="1">
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="close_content">닫기</button>
        <button type="button" class="btn btn-primary" id="nomarl_submit_Btn">등록</button>
      </div>
    </div>
  </div>
</div>



<div id="title-container">
	<div id="pro-bookmark-star"><i class="fas fa-star"></i></div>
	<div id="project-title"><span>프로젝트명</span></div>
</div>
<div id="menu-container">
	<ul class="nav">
		<li class="nav-item"><a class="nav-link active" aria-current="page" href="#">홈</a></li>
		<li class="nav-item"><a class="nav-link" href="#">업무</a></li>
		<li class="nav-item"><a class="nav-link" href="#">파일</a></li>
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
	
	$("#nomarl_submit_Btn").click(e=>{
	
		
		let title = $("input[name=title]").val();
		let content = $("#normalContent").val();
		let memberId = $("#memberId").val();
		let projectNo = $("#projectNo").val();
		const frm = new FormData();
		const fileInput = $("input[name=upfile]");
		for(let i=0; i<fileInput[0].files.length;i++){
			frm.append("upfile"+i,fileInut[0].files[i]);
		}
		
		
		$.ajax({
			url : "<%=request.getContextPath()%>/project/insertNormalContent.do",
			method :"post",
			data: {"title":title,"content":content,"memberId":memberId,"projectNo":projectNo},
			success : data =>{
				$("#close_content").click();
			},
			error: (a)=>{
				alert(data);
				$("#close_content").click();
			}
			
		});
		
		$.ajax({
			url : "<%=request.getContextPath()%>/project/insertNormalContentFile.do",
			type:"post",
			processData:false,
			contentType:false,
			success:data=>{
				alert(data);
			},
			error:(a)=>{
				alert(data);
			}
			
		});
		
	});
	

</script>

<%@ include file="/views/common/footer.jsp"%>