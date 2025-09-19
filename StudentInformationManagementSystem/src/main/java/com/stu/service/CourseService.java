package com.stu.service;

import com.stu.entity.Course;

import java.util.List;
import java.util.Map;

public interface CourseService {
    boolean insertCourse(Course course);
    boolean updateCourse(Course course);
    boolean deleteCourseById(int id);
    Course findCourseById(int id);
    List<Course> findAllCourses();
    List<Map<String, Object>> findAllCoursesMap();
    List<Course> getCourses(String term);

    Course findCourseByName(String selectedCourseName);
}