<%@page import="dao.RegistrationDao"%>
<%@page import="vo.Registration"%>
<%@page import="java.util.List"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	String loginType = (String) session.getAttribute("loginType");
	String err = request.getParameter("err");
	if (loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("수강신청현황", "utf-8"));
		return;
	}
	
	RegistrationDao regDao = new RegistrationDao();
	List<Registration> regList = regDao.getRegsById(loginId);
%>
<!doctype html>
<html lang="ko">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<style type="text/css">
	.btn.btn-xs {--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;}
</style>
</head>
<body>
<jsp:include page="../nav.jsp">
	<jsp:param name="menu" value="학생"/>
</jsp:include>
<div class="container">
	<div class="row mb-3">
    	<div class="col-12">
        	<h1 class="border bg-light fs-4 p-2">수강신청 현황</h1>
      	</div>
   	</div>
	<div class="row mb-3">
		<div class="col-12">
<%
	if ("req".equals(err)) {
%>
		<div class="alert alert-danger">
			<strong>수강신청 실패</strong> 이미 신청한 과정입니다.
		</div>
<%
	}
%>
<%
	if ("quota".equals(err)) {
%>
		<div class="alert alert-danger">
			<strong>수강신청 실패</strong> 정원이 초과되었습니다.
		</div>
<%
	}
%>
			<p>현재 수강신청 현황을 확인하세요</p>
			<table class="table">
				<thead>
					<tr class="table-dark">
						<th style="width: 10%;">신청번호</th>
						<th style="width: 10%;">과정번호</th>
						<th style="width: 20%;">과정명</th>
						<th style="width: 15%;">학과</th>
						<th style="width: 15%;">담당교수</th>
						<th style="width: 15%;">신청상태</th>
						<th style="width: 15%;"></th>
					</tr>
				</thead>
				<tbody>
<%
	if (regList.size() == 0) {
%>
					<tr class="align-middle">
						<td colspan="7">신청한 과정이 존재하지 않습니다. </td>
					</tr>

<%
	} else {
		for (Registration reg : regList) {
%>
					<tr class="align-middle">
						<td><%=reg.getNo() %></td>
						<td><%=reg.getCourse().getNo() %></td>
						<td><%=reg.getCourse().getName() %></td>
						<td><%=reg.getCourse().getDept().getName() %></td>
						<td><%=reg.getCourse().getProfessor().getName() %></td>
						<td><span class="badge text-bg-<%="신청완료".equals(reg.getStatus()) ? "success" : "secondary" %> %>success"><%=reg.getStatus() %></span></td>
						<td>
							<a href="course-detail.jsp?no=<%=reg.getCourse().getNo() %>" class="btn btn-outline-dark btn-xs">상세정보</a>
<%
			if ("신청완료".equals(reg.getStatus())) {
%>
							<a href="course-cancel.jsp?regNo=<%=reg.getNo() %>" class="btn btn-outline-danger btn-xs">수강취소</a>
<%
			} else if("수강취소".equals(reg.getStatus())) {
%>
							<a href="course-reapply.jsp?regNo=<%=reg.getNo() %>" class="btn btn-primary btn-xs">재신청</a>
<%	
			}
%>
						</td>
					</tr>
<%
		}
	}
%>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>