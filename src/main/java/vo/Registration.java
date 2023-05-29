package vo;

import java.sql.Date;

public class Registration {

	private int no;
	private Course course;
	private Student student;
	private String status;
	private Date updateDate;
	private Date createDate;
	private int rownum;
	
	public Registration() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}

	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	public int getRownum() {
		return rownum;
	}
	
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
}
