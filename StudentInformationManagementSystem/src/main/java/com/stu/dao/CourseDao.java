package com.stu.dao;

import com.stu.entity.Course;

import java.util.List;
import java.util.Map;

public interface CourseDao {
    boolean insertCourse(Course course);
    boolean updateCourse(Course course);
    boolean deleteCourseById(int id);
    Course findCourseById(int id);
    List<Course> findCourseByTerm(String term);
    List<Course> findAllCourses();
    List<Map<String, Object>> findAllCoursesMap();
    Course findCourseByName(String selectedCourseName);
}