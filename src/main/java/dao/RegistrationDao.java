package dao;

import java.util.List;

import util.DaoHelper;
import vo.Course;
import vo.Dept;
import vo.Professor;
import vo.Registration;
import vo.Student;

public class RegistrationDao {

	public void insertReg(Registration reg) {
		DaoHelper.update("regDao.insertReg", reg.getCourse().getNo(),
				reg.getStudent().getId());
	}
	
	public List<Registration> getRegsById(String id) {
		return DaoHelper.selectList("regDao.getRegsById", rs -> {
			Registration reg = new Registration();
			reg.setNo(rs.getInt("reg_no"));
			reg.setStatus(rs.getString("reg_status"));
			
			Course course = new Course();
			
			Professor professor = new Professor();
			professor.setName(rs.getString("professor_name"));
			
			Dept dept = new Dept();
			dept.setName(rs.getString("dept_name"));
			
			course.setNo(rs.getInt("course_no"));
			course.setName(rs.getString("course_name"));
			course.setDept(dept);
			course.setProfessor(professor);
			reg.setCourse(course);

			return reg;
		}, id);
	}
	
	public Registration getRegById(String id) {
		return DaoHelper.selectOne("regDao.getRegById", rs -> {
			Registration reg = new Registration();
			reg.setNo(rs.getInt("reg_no"));
			reg.setCourse(new Course(rs.getInt("course_no")));
			reg.setStudent(new Student(rs.getString("student_id")));
			reg.setStatus(rs.getString("reg_status"));
			reg.setUpdateDate(rs.getDate("reg_update_date"));
			reg.setCreateDate(rs.getDate("reg_create_date"));

			return reg;	
		}, id);
	}
	
	public List<Registration> getRegByCourseNo(int courseNo) {
		return DaoHelper.selectList("regDao.getRegByCourseNo", rs -> {
			Registration reg = new Registration();
			reg.setRownum(rs.getInt("rownum"));
			Student student = new Student();
			student.setId(rs.getString("student_id"));
			student.setName(rs.getString("student_name"));
			student.setGrade(rs.getInt("student_grade"));
			Dept dept = new Dept();
			dept.setName(rs.getString("dept_name"));
			student.setDept(dept);
			
			reg.setStudent(student);
			
			return reg;
		}, courseNo, courseNo);
	}
	
	public Registration getRegByNo(int no) {
		return DaoHelper.selectOne("regDao.getRegByNo", rs -> {
			Registration reg = new Registration();
			reg.setNo(rs.getInt("reg_no"));
			reg.setCourse(new Course(rs.getInt("course_no")));
			reg.setStudent(new Student(rs.getString("student_id")));
			reg.setStatus(rs.getString("reg_status"));
			reg.setUpdateDate(rs.getDate("reg_update_date"));
			reg.setCreateDate(rs.getDate("reg_create_date"));
			
			return reg;
		}, no);
	}
	
	public void updateRegByNo(Registration reg) {
		DaoHelper.update("regDao.updateRegByNo", reg.getStatus(), reg.getNo());
	}
}
