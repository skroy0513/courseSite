<%@page import="vo.Dept"%>
<%@page import="dao.StudentDao"%>
<%@page import="vo.Student"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 학생으로 회원가입 시킨다.
	// 요청 파라미터 조회
	int grade = Integer.parseInt(request.getParameter("grade"));
	int deptNo = Integer.parseInt(request.getParameter("deptNo"));
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	
	// 업무로직수행
	// 학생정보 저장
	Student student = new Student();
	student.setId(id);
	student.setPassword(password);
	student.setName(name);
	student.setGrade(grade);
	student.setDept(new Dept(deptNo));
	
	// 학생 아이디 중복 체크
	StudentDao studentDao = new StudentDao();
	if (studentDao.getStudentById(id) != null) {
		response.sendRedirect("form.jsp?err=id");
		return;
	}
	
	// 학생 정보 데이터베이스 저장
	studentDao.insertStudent(student);
	
	// 재요청 URL 응답	
	response.sendRedirect("../home.jsp");
%>