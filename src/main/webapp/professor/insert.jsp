<%@page import="dao.ProfessorDao"%>
<%@page import="vo.Dept"%>
<%@page import="vo.Professor"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 교수로 회원가입 시킨다.
	// 요청 파라미터 조회
	String position = request.getParameter("position");
	int deptNo = Integer.parseInt(request.getParameter("deptNo"));
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	
	// 업무로직 수행
	// 교수 정보 저장
	Professor professor = new Professor();
	professor.setId(id);
	professor.setPassword(password);
	professor.setName(name);
	professor.setPosition(position);
	professor.setDept(new Dept(deptNo));
	
	// 아이디 중복 체크
	ProfessorDao professorDao =  new ProfessorDao();
	if (professorDao.getProfessorById(id) != null) {
		response.sendRedirect("form.jsp?err=id");
		return;
	}
	// 교수 정보 데이터베이스 저장
	professorDao.insertProfessor(professor);
	
	// 재요청 URL 응답
	response.sendRedirect("../home.jsp");
%>