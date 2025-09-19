package com.stu.dao.impl;

import com.stu.dao.GradesDao;
import com.stu.entity.Course;
import com.stu.entity.Grades;
import com.stu.utils.JdbcUtils;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GradesDaoImpl implements GradesDao {
    private JdbcUtils jdbcUtils ;
    public GradesDaoImpl(){
        jdbcUtils = new JdbcUtils();
        jdbcUtils.getConnection();
    }

    @Override
    public boolean insertGrades(Grades grades) {
        String sql = "INSERT INTO grades (username, course, grades) VALUES (?,?,?)";
        List<Object> params = new ArrayList<>();
        params.add(grades.getUsername());
        params.add(grades.getCourse());
        params.add(grades.getGrades());
        try {
            return jdbcUtils.updateByPreparedStatement(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateGrades(Grades grades) {
        String sql = "UPDATE grades SET username =?, course =?, grades = ? WHERE id =?";
        List<Object> params = new ArrayList<>();
        params.add(grades.getUsername());
        params.add(grades.getCourse());
        params.add(grades.getGrades());
        params.add(grades.getId());

        try {
            return jdbcUtils.updateByPreparedStatement(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteGradesById(int id) {
        String sql = "DELETE FROM grades WHERE id =?";
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
    public Grades findGradesById(int id) {
        String sql = "SELECT * FROM grades WHERE id =?";
        List<Object> params = new ArrayList<>();
        params.add(id);
        try {
            return jdbcUtils.findSimpleRefResult(sql, params, Grades.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Grades> findAllGrades() {
        String sql = "SELECT * FROM grades";
        try {
            return jdbcUtils.findMoreRefResult(sql, null, Grades.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> findAllGradesMap() {
        String sql = "SELECT * FROM grades";
        try {
            return jdbcUtils.findModeResult(sql, null);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Grades> findGrades(List<Course> courses, String username) throws Exception {
        List<Grades> grades  = new ArrayList<>();
        for (Course course : courses) {
            System.out.println(course.toString());
            Grades gradesInfo;
            String sql = "SELECT * FROM grades WHERE username = ? and course = ?";
            List<Object> params = new ArrayList<>();

            params.add(username);
            params.add(course.getCourse());
            gradesInfo = jdbcUtils.findSimpleRefResult(sql, params, Grades.class);
            if(gradesInfo==null){
                continue;
            }
            grades.add(gradesInfo);
            System.out.println(gradesInfo.toString());
        }
        return grades;

    }

    @Override
    public boolean deleteGradesByCourseAndUserName(String course) {
        String sql = "DELETE FROM grades WHERE course = ?";
        List<Object> params = new ArrayList<>();

        params.add(course);
        try {
            return jdbcUtils.updateByPreparedStatement(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Grades> findGradesByUsername(String selectedStudentNumber) {
        String sql = "SELECT * FROM grades WHERE username =?";
        List<Object> params = new ArrayList<>();
        params.add(selectedStudentNumber);
        try {
            return jdbcUtils.findMoreRefResult(sql, params, Grades.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}