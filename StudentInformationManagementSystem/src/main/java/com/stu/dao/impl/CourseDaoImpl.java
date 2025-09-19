package com.stu.dao.impl;

import com.stu.dao.CourseDao;
import com.stu.entity.Course;
import com.stu.utils.JdbcUtils;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CourseDaoImpl implements CourseDao {
    private JdbcUtils jdbcUtils ;
    public CourseDaoImpl(){
       jdbcUtils = new JdbcUtils();
       jdbcUtils.getConnection();
    }

    @Override
    public boolean insertCourse(Course course) {
        String sql = "INSERT INTO course (course, teacher, credit, term) VALUES (?,?,?,?)";
        List<Object> params = new ArrayList<>();
        params.add(course.getCourse());
        params.add(course.getTeacher());
        params.add(course.getCredit());
        params.add(course.getTerm());
        try {
            return jdbcUtils.updateByPreparedStatement(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateCourse(Course course) {
        String sql = "UPDATE course SET course =?, teacher =?, credit =?, term =? WHERE id =?";
        List<Object> params = new ArrayList<>();
        params.add(course.getCourse());
        params.add(course.getTeacher());
        params.add(course.getCredit());
        params.add(course.getTerm());
        params.add(course.getId());
        try {
            return jdbcUtils.updateByPreparedStatement(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteCourseById(int id) {
        String sql = "DELETE FROM course WHERE id =?";
        List<Object> params = new ArrayList<>();
        params.add(id);
        try {
            return jdbcUtils.updateByPreparedStatement(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Course findCourseById(int id) {
        String sql = "SELECT * FROM course WHERE id =?";
        List<Object> params = new ArrayList<>();
        params.add(id);
        try {
            return jdbcUtils.findSimpleRefResult(sql, params, Course.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Course> findAllCourses() {
        String sql = "SELECT * FROM course";
        try {
            return jdbcUtils.findMoreRefResult(sql, null, Course.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> findAllCoursesMap() {
        String sql = "SELECT * FROM course";
        try {
            return jdbcUtils.findModeResult(sql, null);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Course> findCourseByTerm(String term) {
        String sql = "SELECT * FROM course where term = ?";
        List<Object> params = new ArrayList<>();
        params.add(term);
        try {
            return jdbcUtils.findMoreRefResult(sql, params, Course.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Course findCourseByName(String selectedCourseName) {
        String sql = "SELECT * FROM course WHERE course = ?";
        List<Object> params = new ArrayList<>();
        params.add(selectedCourseName);
        try {
            return jdbcUtils.findSimpleRefResult(sql, params, Course.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}