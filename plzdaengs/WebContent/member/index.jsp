<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/template/default_link.jsp" %>
<% 
String user = (String)request.getSession().getAttribute("userInfo");
%>

<script type="text/javascript">
$(function() {
	$("#loginbtn").click(loginModalShow);
	$("#loginmodal .modal-success").click(login);
	
	$(".modal-cancel").click(function() {
		var name = $(this).attr("name");
		$("#"+name).modal("hide");
	});
	
	$("#loginalert button").click(loginAlertBtnClick);
	
	/* $("#myBtn3").click(function(){
	    $("#myModal3").modal({backdrop: "static"});
	  }); */
	<%
	if(user != null ){
		//프로필 변경
		//메인페이지 변경
	%>
	loginProcess();
	<%
	}
	%>
});
function loginAlertBtnClick() {
	$("#loginalert").modal("hide");
	return false;
}

function loginProcess() {
	$("#profile").css("background-image", "url('/plzdaengs/template/img/profile.jpg')");
}
function loginModalShow() {
	$("#loginmodal").modal("show");
}

function login(){
	var id = $("#loginmodal input[name=id]").val();
	var password = $("#loginmodal input[name=password]").val();
	
	var idPattern = /^[A-Za-z]{1}[A-Za-z0-9]{3,10}$/;
	
	//로그인 실패를 위해 ajax
	$.ajax({
		url : "/plzdaengs/member"
		, method : "post"
		, data : $("#loginmodal form").serialize()
		, success : function(result){
			if(result.trim() != "success"){
				$("#loginalert p").html(result);
				$("#loginalert").modal({backdrop: "static"});
			}
			
			location.href = "/plzdaengs/member/index.jsp";
		}
	});
	//
	
}
</script>
<style type="text/css">
#loginmodal .modal-lg{
	width: 50%;
}
#loginmodal .modal-content{
	border-radius: 5%;
}
#loginmodal .form-cotrol-label{
	font-size: 1.2rem;
}

#loginmodal .form-group input{
	height: 3rem;
	font-size: 1.2rem;
}
#loginmodal .btn-group button{
	height: 3rem
}
#loginmodal h5{
	font-size: 1.7rem;	
}

</style>
</head>
<body>
<!-- navbar-->	
	<!-- 로그인 모달창 -->
	<div id="loginmodal" class="modal fade" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header text-center">
					<h5 class="modal-title" id="myModalLabel" style="margin-left: auto;">로그인</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<input type="hidden" name="act" value="login">
	            		<div class="form-group" align="right">
							<label for="">
							<input type="checkbox" class="form-control" name="idsave" value="idsave" >아이디저장</label>
						</div>
						<div class="form-group">
	                        <label class="form-control-label text-uppercase" >아이디</label>
	                        <input type="text" placeholder="아이디를 입력하세요" class="form-control" required="required" name="id">
	                      </div>
	                      <div class="form-group">       
	                        <label class="form-control-label text-uppercase">비밀번호</label>
	                        <input type="password" placeholder="" class="form-control" name="password" required>
	                      </div>
            		</form>
            		<div class="">
	            		<button class="btn btn-primary modal-success" name="loginmodal">로그인</button>
	            		<button class="btn btn-primary modal-cancel" name="loginmodal">취소</button>
	            	</div>
				</div>
			</div>
		</div>
		<!-- 로그인 시 뜨는 경고창 -->
		<div class="modal fade" id="loginalert" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">로그인 경고</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
						<p></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">확인</button>
					</div>
				</div>

			</div>
		</div>
	</div>
	<header class="header">
		<nav class="navbar navbar-expand-lg px-4 py-2 bg-white shadow">
			<a href="#" class="sidebar-toggler text-gray-500 mr-4 mr-lg-5 lead"><i
				class="fas fa-align-left"></i></a><a href="index.html"
				class="navbar-brand font-weight-bold text-uppercase"></a>
			<ul class="ml-auto d-flex align-items-center list-unstyled mb-0">
				<li class="nav-item">
					<form id="searchForm" class="ml-auto d-none d-lg-block">
						<div class="form-group position-relative mb-0">
							<button type="submit" style="top: -3px; left: 0;"
								class="position-absolute bg-white border-0 p-0">
								<i class="o-search-magnify-1 text-gray text-lg"></i>
							</button>
							<input type="search" placeholder="Search ..."
								class="form-control form-control-sm border-0 no-shadow pl-4">
						</div>
					</form>
				</li>
				<li class="nav-item dropdown mr-3"><a id="notifications"
					href="http://example.com" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false"
					class="nav-link dropdown-toggle text-gray-400 px-1"><i
						class="fa fa-bell"></i><span class="notification-icon"></span></a>
					<div aria-labelledby="notifications" class="dropdown-menu">
						<a href="#" class="dropdown-item">
							<div class="d-flex align-items-center">
								<div class="icon icon-sm bg-violet text-white">
									<i class="fab fa-twitter"></i>
								</div>
								<div class="text ml-2">
									<p class="mb-0">You have 2 followers</p>
								</div>
							</div>
						</a><a href="#" class="dropdown-item">
							<div class="d-flex align-items-center">
								<div class="icon icon-sm bg-green text-white">
									<i class="fas fa-envelope"></i>
								</div>
								<div class="text ml-2">
									<p class="mb-0">You have 6 new messages</p>
								</div>
							</div>
						</a><a href="#" class="dropdown-item">
							<div class="d-flex align-items-center">
								<div class="icon icon-sm bg-blue text-white">
									<i class="fas fa-upload"></i>
								</div>
								<div class="text ml-2">
									<p class="mb-0">Server rebooted</p>
								</div>
							</div>
						</a><a href="#" class="dropdown-item">
							<div class="d-flex align-items-center">
								<div class="icon icon-sm bg-violet text-white">
									<i class="fab fa-twitter"></i>
								</div>
								<div class="text ml-2">
									<p class="mb-0">You have 2 followers</p>
								</div>
							</div>
						</a>
						<div class="dropdown-divider"></div>
						<a href="#" class="dropdown-item text-center"><small
							class="font-weight-bold headings-font-family text-uppercase">View
								all notifications</small></a>
					</div></li>
				<li class="nav-item dropdown ml-auto"><a id="userInfo"
					href="http://example.com" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false"
					class="nav-link dropdown-toggle"><img src="/plzdaengs/template/img/avatar-6.jpg"
						alt="Jason Doe" style="max-width: 2.5rem;"
						class="img-fluid rounded-circle shadow"></a>
					<div aria-labelledby="userInfo" class="dropdown-menu">
						<a href="#" class="dropdown-item"><strong
							class="d-block text-uppercase headings-font-family">Mark
								Stephen</strong><small>Web Developer</small></a>
						<div class="dropdown-divider"></div>
						<a href="#" class="dropdown-item">Settings</a><a href="#"
							class="dropdown-item">Activity log </a>
						<div class="dropdown-divider"></div>
						<a href="/plzdaengs/login.html" class="dropdown-item">Logout</a>
					</div></li>
			</ul>
		</nav>
	</header>

	<div class="d-flex align-items-stretch" id ="document">
		<!-- 사이드 sidebar -->
		<%@ include file="/template/sidebar.jsp" %>
		<!-- 사이드 sidebar -->
		
		<div class="page-holder w-100 d-flex flex-wrap">
			<div class="container-fluid" id="contents">
				<!-- section 1 -->
				<section class="py-5" id="mainSection">
					<div class="w-100">
						<h1 class="text-main">댕댕이를 <span class="text-primary">부탁해~</span></h1>
						<div class="subheading">
							kitri 2nd Project 4조
						</div>
						<div class="login-icons">
							<button class="btn btn-primary" id="loginbtn">로그인</button>
							<button class="btn btn-primary" id="registerbtn">회원가입</button>
						</div>
					</div>
				</section>
				
				<!-- section 2 -->
				<section>
					<div class="row mb-4">
						<div class="col-lg-7 mb-4 mb-lg-0">
							<div class="card">
								<div class="card-header">
									<h2 class="h6 text-uppercase mb-0">Current server uptime</h2>
								</div>
								<div class="card-body">
									<p class="text-gray">Lorem ipsum dolor sit amet,
										consectetur adipisicing elit.</p>
									<div class="chart-holder">
										<canvas id="lineChart1" style="max-height: 14rem !important;"
											class="w-100"></canvas>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-5 mb-4 mb-lg-0 pl-lg-0">
							<div class="card mb-3">
								<div class="card-body">
									<div class="row align-items-center flex-row">
										<div class="col-lg-5">
											<h2 class="mb-0 d-flex align-items-center">
												<span>86.4</span><span
													class="dot bg-green d-inline-block ml-3"></span>
											</h2>
											<span class="text-muted text-uppercase small">Work
												hours</span>
											<hr>
											<small class="text-muted">Lorem ipsum dolor sit</small>
										</div>
										<div class="col-lg-7">
											<canvas id="pieChartHome1"></canvas>
										</div>
									</div>
								</div>
							</div>
							<div class="card">
								<div class="card-body">
									<div class="row align-items-center flex-row">
										<div class="col-lg-5">
											<h2 class="mb-0 d-flex align-items-center">
												<span>1.724</span><span
													class="dot bg-violet d-inline-block ml-3"></span>
											</h2>
											<span class="text-muted text-uppercase small">Server
												time</span>
											<hr>
											<small class="text-muted">Lorem ipsum dolor sit</small>
										</div>
										<div class="col-lg-7">
											<canvas id="pieChartHome2"></canvas>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-5 mb-4 mb-lg-0">
							<div class="card mb-3">
								<div class="card-body">
									<div class="row align-items-center mb-3 flex-row">
										<div class="col-lg-5">
											<h2 class="mb-0 d-flex align-items-center">
												<span>86%</span><span
													class="dot bg-violet d-inline-block ml-3"></span>
											</h2>
											<span class="text-muted text-uppercase small">Monthly
												Usage</span>
											<hr>
											<small class="text-muted">Lorem ipsum dolor sit</small>
										</div>
										<div class="col-lg-7">
											<canvas id="pieChartHome3"></canvas>
										</div>
									</div>
								</div>
							</div>
							<div class="card">
								<div class="card-body">
									<div class="row align-items-center flex-row">
										<div class="col-lg-5">
											<h2 class="mb-0 d-flex align-items-center">
												<span>$126,41</span><span
													class="dot bg-green d-inline-block ml-3"></span>
											</h2>
											<span class="text-muted text-uppercase small">All
												Income</span>
											<hr>
											<small class="text-muted">Lorem ipsum dolor sit</small>
										</div>
										<div class="col-lg-7">
											<canvas id="pieChartHome4"></canvas>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-7">
							<div class="card">
								<div class="card-header">
									<h2 class="h6 text-uppercase mb-0">Total Overdue</h2>
								</div>
								<div class="card-body">
									<p class="text-gray">Lorem ipsum dolor sit amet,
										consectetur adipisicing elit.</p>
									<div class="chart-holder">
										<canvas id="lineChart2" style="max-height: 14rem !important;"
											class="w-100"></canvas>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
			<%@ include file="/template/footer.jsp" %>
		</div>
	</div>
	<%@ include file="/template/default_js_link.jsp" %>
</body>
</html>