package dao;

import java.util.List;

import util.DaoHelper;
import vo.Course;
import vo.Dept;
import vo.Professor;

public class CourseDao {
	
	private static CourseDao instance = new CourseDao();
	
	private CourseDao() {}
	
	public static CourseDao getInstance() {
		return instance;
	}
	
	public List<Course> getAllCourses() {
		return DaoHelper.selectList("courseDao.getAllCourses", rs -> {
			Course course = new Course();
			course.setNo(rs.getInt("course_no"));
			course.setName(rs.getString("course_name"));
			course.setType(rs.getString("course_type"));
			course.setScore(rs.getInt("course_score"));
			course.setQuota(rs.getInt("course_quota"));
			course.setReqCnt(rs.getInt("course_req_cnt"));
			course.setDescription(rs.getString("course_description"));
			course.setCreateDate(rs.getDate("course_create_date"));
			course.setUpdateDate(rs.getDate("course_update_date"));
			Dept dept = new Dept();
			dept.setName(rs.getString("dept_name"));
			dept.setNo(rs.getInt("dept_no"));
			Professor professor = new Professor();
			professor.setId(rs.getString("professor_id"));
			professor.setName(rs.getString("professor_name"));
			course.setDept(dept);
			course.setProfessor(professor);
			
			return course;
		});
	}
	
	public List<Course> getCourses(String id) {
		return DaoHelper.selectList("courseDao.getCourses", rs -> {
			Course course = new Course();
			course.setNo(rs.getInt("course_no"));
			course.setName(rs.getString("course_name"));
			course.setType(rs.getString("course_type"));
			course.setScore(rs.getInt("course_score"));
			course.setQuota(rs.getInt("course_quota"));
			course.setReqCnt(rs.getInt("course_req_cnt"));
			course.setDescription(rs.getString("course_description"));
			course.setCreateDate(rs.getDate("course_create_date"));
			course.setUpdateDate(rs.getDate("course_update_date"));
			Dept dept = new Dept();
			dept.setNo(rs.getInt("dept_no"));
			dept.setName(rs.getString("dept_name"));
			Professor professor = new Professor(rs.getString("professor_id"));
			course.setDept(dept);
			course.setProfessor(professor);
			
			return course;
		}, id);
	}
	
	public void insertCourse(Course course) {
		DaoHelper.update("courseDao.insertCourse", course.getName(),
				course.getType(), course.getScore(), course.getQuota(),
				course.getReqCnt(), course.getDescription(), course.getDept().getNo(),
				course.getProfessor().getId());
	}
	
	public void updateCourse(Course course) {
		DaoHelper.update("courseDao.updateCourse", course.getName(),
				course.getQuota(), course.getDescription(), course.getNo());
	}
	
	public Course getCourseByNo(int no) {
		return DaoHelper.selectOne("courseDao.getCourseByNo", rs -> {
			Course course = new Course();
			course.setNo(rs.getInt("course_no"));
			course.setName(rs.getString("course_name"));
			course.setType(rs.getString("course_type"));
			course.setScore(rs.getInt("course_score"));
			course.setQuota(rs.getInt("course_quota"));
			course.setReqCnt(rs.getInt("course_req_cnt"));
			course.setDescription(rs.getString("course_description"));
			course.setCreateDate(rs.getDate("course_create_date"));
			course.setUpdateDate(rs.getDate("course_update_date"));
			
			Dept dept = new Dept();
			dept.setName(rs.getString("dept_name"));
			dept.setNo(rs.getInt("dept_no"));
			course.setDept(dept);
			
			Professor professor = new Professor();
			professor.setId(rs.getString("professor_id"));
			professor.setName(rs.getString("professor_name"));
			course.setProfessor(professor);
			
			return course;
		}, no);
	}
	
	public Course getCourseByName(String name) {
		return DaoHelper.selectOne("courseDao.getCourseByName", rs -> {
			Course course = new Course();
			course.setNo(rs.getInt("course_no"));
			course.setName(rs.getString("course_name"));
			course.setType(rs.getString("course_type"));
			course.setScore(rs.getInt("course_score"));
			course.setQuota(rs.getInt("course_quota"));
			course.setReqCnt(rs.getInt("course_req_cnt"));
			course.setDescription(rs.getString("course_description"));
			course.setCreateDate(rs.getDate("course_create_date"));
			course.setUpdateDate(rs.getDate("course_update_date"));
			Dept dept = new Dept(rs.getInt("dept_no"));
			Professor professor = new Professor(rs.getString("professor_id"));
			course.setDept(dept);
			course.setProfessor(professor);
			
			return course;
		}, name);
	}

}
