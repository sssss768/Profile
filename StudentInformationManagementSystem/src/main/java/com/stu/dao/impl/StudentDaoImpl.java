package com.stu.dao.impl;

import com.stu.dao.StudentDao;
import com.stu.entity.Student;
import com.stu.utils.JdbcUtils;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StudentDaoImpl implements StudentDao {
    private JdbcUtils jdbcUtils;
    public StudentDaoImpl(){
        jdbcUtils = new JdbcUtils();
        jdbcUtils.getConnection();
    }

    @Override
    public boolean insertStudent(Student student) {
        String sql = "INSERT INTO student (username, password, sex, age, phone, address, name, in_class) VALUES (?,?,?,?,?,?,?,?)";
        List<Object> params = new ArrayList<>();
        params.add(student.getUsername());
        params.add(student.getPassword());
        params.add(student.getSex());
        params.add(student.getAge());
        params.add(student.getPhone());
        params.add(student.getAddress());
        params.add(student.getName());
        params.add(student.getIn_class());
        try {
            return jdbcUtils.updateByPreparedStatement(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateStudent(Student student) {
        String sql = "UPDATE student SET username =?, password =?, sex =?, age =?, phone =?, address =?, name =?, in_class =? WHERE id =?";
        List<Object> params = new ArrayList<>();
        params.add(student.getUsername());
        params.add(student.getPassword());
        params.add(student.getSex());
        params.add(student.getAge());
        params.add(student.getPhone());
        params.add(student.getAddress());
        params.add(student.getName());
        params.add(student.getIn_class());
        params.add(student.getId());
        try {
            return jdbcUtils.updateByPreparedStatement(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteStudentById(int id) {
        String sql = "DELETE FROM student WHERE id =?";
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
    public Student findStudentById(int id) {
        String sql = "SELECT * FROM student WHERE id =?";
        List<Object> params = new ArrayList<>();
        params.add(id);
        try {
            return jdbcUtils.findSimpleRefResult(sql, params, Student.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Student> findAllStudents() {
        String sql = "SELECT * FROM student";
        try {
            return jdbcUtils.findMoreRefResult(sql, null, Student.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> findAllStudentsMap() {
        String sql = "SELECT * FROM student";
        try {
            return jdbcUtils.findModeResult(sql, null);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Student findStudentByUsername(String username) {
        String sql = "SELECT * FROM student WHERE username =?";
        List<Object> params = new ArrayList<>();
        params.add(username);
        try {
            return jdbcUtils.findSimpleRefResult(sql, params, Student.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}