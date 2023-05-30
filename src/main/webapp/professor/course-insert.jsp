<%@page import="dao.CourseDao"%>
<%@page import="vo.Professor"%>
<%@page import="vo.Dept"%>
<%@page import="vo.Course"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 신규 개설과정을 등록시킨다.
	// 오류 파악
	String loginType = (String) session.getAttribute("loginType");
	String loginId = (String) session.getAttribute("loginId");
	
	if (loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("과정등록", "utf-8"));
		return;
	}
	if (!"PROFESSOR".equals(loginType)) {
		response.sendRedirect("../home.jsp?err=deny&job=" + URLEncoder.encode("과정등록", "utf-8"));
		return;
	}
	// 요청파라미터 조회
	String name = request.getParameter("name");
	String type = request.getParameter("type");
	int deptNo = Integer.parseInt(request.getParameter("deptNo"));
	int score = Integer.parseInt(request.getParameter("score"));
	int quota = Integer.parseInt(request.getParameter("quota"));
	String description = request.getParameter("description");
	
	// 업무로직수행
	CourseDao courseDao = CourseDao.getInstance();
	
	Course course = new Course();
	course.setName(name);
	course.setType(type);
	course.setScore(score);
	course.setQuota(quota);
	course.setReqCnt(0);
	course.setDescription(description);
	Dept dept = new Dept(deptNo);
	course.setDept(dept);
	Professor professor = new Professor(loginId);
	course.setProfessor(professor);
	
	if (courseDao.getCourseByName(name) != null) {
		response.sendRedirect("course-form.jsp?err=req");
		return;
	}
	courseDao.insertCourse(course);
	
	// 재요청 URL 응답
	response.sendRedirect("course-list.jsp");
%>