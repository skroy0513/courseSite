<%@page import="java.util.List"%>
<%@page import="dao.CourseDao"%>
<%@page import="vo.Student"%>
<%@page import="vo.Course"%>
<%@page import="vo.Registration"%>
<%@page import="dao.RegistrationDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 과정 신청을 처리한다.
	// 요청 파라미터 조회
	String loginId = (String) session.getAttribute("loginId");
	String loginType = (String) session.getAttribute("loginType");
	int no = Integer.parseInt(request.getParameter("no"));
	
	// 업무로직 수행
	if (loginId == null) {
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("수강신청", "utf-8"));
		return;
	}
	if (!"STUDENT".equals(loginType)) {
		response.sendRedirect("../home.jps?err=dedy&job=" + URLEncoder.encode("수강신청", "utf-8"));
		return;
	}
	

	RegistrationDao regDao = new RegistrationDao();
	List<Registration> regList = regDao.getRegsById(loginId);
	CourseDao courseDao = CourseDao.getInstance();
	Course savedCourse = courseDao.getCourseByNo(no);
	
	Registration reg = new Registration();
	reg.setCourse(savedCourse);
	reg.setStudent(new Student(loginId));
	
	// 처음 등록하는 경우
	if (regList.size() == 0) {
		// 정원 초과 체크
		if (savedCourse.getQuota() <= savedCourse.getReqCnt()) {
			response.sendRedirect("course-registration-list.jsp?err=quota");
			return;
		}
		// 수강신청 정보 저장
		regDao.insertReg(reg);
		// 신청자수 업데이트
		courseDao.updateCourse(savedCourse);
		// 재요청 URL 응답
		response.sendRedirect("course-registration-list.jsp");
		return;
	}
	
	// 중복 수강 체크
 	for (Registration savedReg : regList) {
 		if (no == savedReg.getCourse().getNo()) {
 			response.sendRedirect("course-registration-list.jsp?err=req");
			return;
 		}
 	}
	// 정원 초과 체크
	if (savedCourse.getQuota() <= savedCourse.getReqCnt()) {
		response.sendRedirect("course-registration-list.jsp?err=quota");
		return;
	}
	// 수강신청 정보 저장
	regDao.insertReg(reg);
	// 신청자수 업데이트
	courseDao.updateCourse(savedCourse);
	
	// 재요청 URL 응답
	response.sendRedirect("course-registration-list.jsp");
%>