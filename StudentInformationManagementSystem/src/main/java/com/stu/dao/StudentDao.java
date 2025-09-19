package com.stu.dao;

import com.stu.entity.Student;

import java.util.List;
import java.util.Map;

public interface StudentDao {
    boolean insertStudent(Student student);
    boolean updateStudent(Student student);
    boolean deleteStudentById(int id);
    Student findStudentById(int id);
    List<Student> findAllStudents();
    List<Map<String, Object>> findAllStudentsMap();
    Student findStudentByUsername(String username);
}