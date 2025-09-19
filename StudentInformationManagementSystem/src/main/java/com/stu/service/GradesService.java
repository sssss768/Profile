package com.stu.service;

import com.stu.entity.Course;
import com.stu.entity.Grades;

import java.util.List;
import java.util.Map;

public interface GradesService {
    boolean insertGrades(Grades grades);
    boolean updateGrades(Grades grades);
    boolean deleteGradesById(int id);
    Grades findGradesById(int id);
    List<Grades> findAllGrades();
    List<Map<String, Object>> findAllGradesMap();
    List<Grades> getGradesList(List<Course> courses,String username) throws Exception;
    boolean deleteGradesByCourseAndUserName(String course);

    List<Grades> findGradesByUsername(String selectedStudentNumber);
}