package com.stu.service.impl;

import com.stu.dao.GradesDao;
import com.stu.dao.impl.GradesDaoImpl;
import com.stu.entity.Course;
import com.stu.entity.Grades;
import com.stu.service.GradesService;

import java.util.List;
import java.util.Map;

public class GradesServiceImpl implements GradesService {
    private GradesDao gradesDao = new GradesDaoImpl();

    @Override
    public boolean insertGrades(Grades grades) {
        return gradesDao.insertGrades(grades);
    }

    @Override
    public boolean updateGrades(Grades grades) {
        return gradesDao.updateGrades(grades);
    }

    @Override
    public boolean deleteGradesById(int id) {
        return gradesDao.deleteGradesById(id);
    }

    @Override
    public Grades findGradesById(int id) {
        return gradesDao.findGradesById(id);
    }

    @Override
    public List<Grades> findAllGrades() {
        return gradesDao.findAllGrades();
    }

    @Override
    public List<Map<String, Object>> findAllGradesMap() {
        return gradesDao.findAllGradesMap();
    }

    @Override
    public List<Grades> getGradesList(List<Course> courses, String username) throws Exception {
        return gradesDao.findGrades(courses,username);
    }

    @Override
    public boolean deleteGradesByCourseAndUserName(String course) {
        return gradesDao.deleteGradesByCourseAndUserName(course);
    }

    @Override
    public List<Grades> findGradesByUsername(String selectedStudentNumber) {
        return gradesDao.findGradesByUsername(selectedStudentNumber);
    }
}