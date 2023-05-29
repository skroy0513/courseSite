<%@page import="vo.Professor"%>
<%@page import="dao.ProfessorDao"%>
<%@page import="vo.Student"%>
<%@page import="dao.StudentDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 로그인처리
	// 요청 파라미터 조회
	String type = request.getParameter("type");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	// 업무로직 수행
	// 학생일때
	if (type.equals("STUDENT")) {
		StudentDao studentDao = new StudentDao();
	  	Student student = studentDao.getStudentById(id);
	  	
		// 존재하지 않는 아이디
		if (student == null) {
			response.sendRedirect("loginform.jsp?err=id");
			return;
		}
		// 비밀번호가 일치하지 않음
		if (!password.equals(student.getPassword())) {
			response.sendRedirect("loginform.jsp?err=pwd");
			return;
		}
		
		session.setAttribute("loginId", student.getId());
		session.setAttribute("loginType", "STUDENT");
	}
	
	// 교수일때
	if (type.equals("PROFESSOR")) {
		ProfessorDao professorDao = new ProfessorDao();
		Professor professor = professorDao.getProfessorById(id);
		
		// 존재하지 않는 아이디
		if (professor == null) {
			response.sendRedirect("loginform.jsp?err=id");
			return;
		}
		// 비밀번호 불일치
		if (!password.equals(professor.getPassword())) {
			response.sendRedirect("loginform.jsp?err=pwd");
			return;
		}
		
		session.setAttribute("loginId", professor.getId());
		session.setAttribute("loginType", "PROFESSOR");
	}
	
	
	// 재요청 URL 응답
	response.sendRedirect("home.jsp");
%>