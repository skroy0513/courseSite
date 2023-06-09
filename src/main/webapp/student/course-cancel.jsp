<%@page import="vo.Course"%>
<%@page import="dao.CourseDao"%>
<%@page import="vo.Registration"%>
<%@page import="dao.RegistrationDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 수강취소 처리를 한다.
	// 요청 파라미터 조회
	String loginId = (String) session.getAttribute("loginId");
	String loginType = (String) session.getAttribute("loginType");
	String err = request.getParameter("err");
	if (loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("수강신청취소", "utf-8"));
		return;
	}
	if (!"STUDENT".equals(loginType)) {
		response.sendRedirect("../home.jps?err=dedy&job=" + URLEncoder.encode("수강신청취소", "utf-8"));
		return;
	}
	
	int no = Integer.parseInt(request.getParameter("regNo"));
	// 업무로직 수행
	// 수강정보 불러오기
	RegistrationDao regDao = new RegistrationDao();
	Registration savedReg = regDao.getRegByNo(no);
	// 수강취소하기
	savedReg.setStatus("수강취소");
	regDao.updateRegByNo(savedReg);
	// 신청자수 업데이트
	CourseDao courseDao = CourseDao.getInstance();
 	Course savedCourse = courseDao.getCourseByNo(savedReg.getCourse().getNo());
 	courseDao.updateCourse(savedCourse);
	
	
	// 재요청 URL응답
	response.sendRedirect("course-registration-list.jsp");
%>