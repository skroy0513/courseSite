<%@page import="vo.Professor"%>
<%@page import="dao.ProfessorDao"%>
<%@page import="vo.Student"%>
<%@page import="dao.StudentDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String loginId = (String) session.getAttribute("loginId");
	String loginType = (String) session.getAttribute("loginType");
	
	
%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark mb-3">
	<div class="container">
    	<ul class="navbar-nav me-auto">
        	<li class="nav-item"><a class="nav-link " href="/app4/home.jsp">홈</a></li>
<%
	if (loginType == null || loginType.equals("STUDENT")) {
%>
			<li class="nav-item dropdown">
          		<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	학생
          		</a>
          		<ul class="dropdown-menu">
            		<li><a class="dropdown-item" href="/app4/student/course-list.jsp">모든 과정 조회</a></li>
            		<li><a class="dropdown-item" href="/app4/student/course-registration-list.jsp">신청현황 조회</a></li>
          		</ul>
        	</li>
<%
	} else if (loginType != null) {
		if (loginType.equals("PROFESSOR")) {
%>
			<li class="nav-item dropdown">
          		<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	교수
          		</a>
          		<ul class="dropdown-menu">
            		<li><a class="dropdown-item" href="/app4/professor/course-list.jsp">개설한 과정 조회</a></li>
            		<li><a class="dropdown-item" href="/app4/professor/course-form.jsp">과정 등록</a></li>
          		</ul>
        	</li>
<%
		}
	}
%>
      	</ul>
      	<ul class="navbar-nav">
<%
	if (loginId == null) {
%>
         	<li class="nav-item"><a class="nav-link " href="/app4/loginform.jsp">로그인</a></li>
			<li class="nav-item dropdown">
          		<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	사용자 등록
          		</a>
          		<ul class="dropdown-menu">
            		<li><a class="dropdown-item" href="/app4/student/form.jsp">학생</a></li>
            		<li><a class="dropdown-item" href="/app4/professor/form.jsp">교수</a></li>
          		</ul>
        	</li>
<%
	} else {
		if (loginType.equals("STUDENT")) {
			StudentDao studentDao = new StudentDao();
			Student student = studentDao.getStudentById(loginId);
%>
			<li class="nav-item"><a class="nav-link disabled text-light">"<%=student.getName() %>" 학생 님 환영합니다.</a></li>
<%
		} else if (loginType.equals("PROFESSOR")) {
		ProfessorDao professorDao = new ProfessorDao();
		Professor professor = professorDao.getProfessorById(loginId);
%>
			<li class="nav-item"><a class="nav-link disabled text-light">"<%=professor.getName() %>" 교수 님 환영합니다.</a></li>
<%
		}
%>
         	<li class="nav-item"><a class="nav-link " href="/app4/logout.jsp">로그아웃</a></li>
<%
	}
%>
      	</ul>
   	</div>
</nav>