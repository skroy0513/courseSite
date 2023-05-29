<%@page import="vo.Course"%>
<%@page import="dao.CourseDao"%>
<%@page import="vo.Registration"%>
<%@page import="dao.RegistrationDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 과정 재신청을 처리하세요.
	// 요청 파라미터 조회
	String loginId = (String) session.getAttribute("loginId");
	String loginType = (String) session.getAttribute("loginType");
	String err = request.getParameter("err");
	if (loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("수강신청취소", "utf-8"));
		return;
	}
	
	int no = Integer.parseInt(request.getParameter("regNo"));
	// 업무로직 수행
	// 수강정보 불러오기
	RegistrationDao regDao = new RegistrationDao();
	Registration savedReg = regDao.getRegByNo(no);
	savedReg.setStatus("신청완료");
	regDao.updateRegByNo(savedReg);
	// 신청자수 변경
	CourseDao courseDao = new CourseDao();
 	Course savedCourse = courseDao.getCourseByNo(savedReg.getCourse().getNo());
 	courseDao.updateCourse(savedCourse);
	
	// 재요청 URL응답
	response.sendRedirect("course-registration-list.jsp");
%>