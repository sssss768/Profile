package com.stu.service.impl;

import com.stu.dao.StudentDao;
import com.stu.dao.impl.StudentDaoImpl;
import com.stu.entity.Student;
import com.stu.service.StudentService;

import java.util.List;
import java.util.Map;

public class StudentServiceImpl implements StudentService {
    private StudentDao studentDao = new StudentDaoImpl();

    @Override
    public boolean insertStudent(Student student) {
        return studentDao.insertStudent(student);
    }

    @Override
    public boolean updateStudent(Student student) {
        return studentDao.updateStudent(student);
    }

    @Override
    public boolean deleteStudentById(int id) {
        return studentDao.deleteStudentById(id);
    }

    @Override
    public Student findStudentById(int id) {
        return studentDao.findStudentById(id);
    }

    @Override
    public List<Student> findAllStudents() {
        return studentDao.findAllStudents();
    }

    @Override
    public List<Map<String, Object>> findAllStudentsMap() {
        return studentDao.findAllStudentsMap();
    }

    @Override
    public Student findStudentByUsername(String username) {
        return studentDao.findStudentByUsername(username);
    }
}