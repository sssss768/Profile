package com.stu.service;

import com.stu.entity.Student;

import java.util.List;
import java.util.Map;

public interface StudentService {
    boolean insertStudent(Student student);
    boolean updateStudent(Student student);
    boolean deleteStudentById(int id);
    Student findStudentById(int id);
    List<Student> findAllStudents();
    List<Map<String, Object>> findAllStudentsMap();
    Student findStudentByUsername(String username);
}