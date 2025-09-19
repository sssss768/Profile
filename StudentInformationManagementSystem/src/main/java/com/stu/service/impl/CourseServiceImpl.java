package com.stu.service.impl;

import com.stu.dao.CourseDao;
import com.stu.dao.impl.CourseDaoImpl;
import com.stu.entity.Course;
import com.stu.service.CourseService;

import java.util.List;
import java.util.Map;

public class CourseServiceImpl implements CourseService {
    private CourseDao courseDao = new CourseDaoImpl();

    @Override
    public boolean insertCourse(Course course) {
        return courseDao.insertCourse(course);
    }

    @Override
    public boolean updateCourse(Course course) {
        return courseDao.updateCourse(course);
    }

    @Override
    public boolean deleteCourseById(int id) {
        return courseDao.deleteCourseById(id);
    }

    @Override
    public Course findCourseById(int id) {
        return courseDao.findCourseById(id);
    }

    @Override
    public List<Course> findAllCourses() {
        return courseDao.findAllCourses();
    }

    @Override
    public List<Map<String, Object>> findAllCoursesMap() {
        return courseDao.findAllCoursesMap();
    }

    @Override
    public List<Course> getCourses(String term) {
        return courseDao.findCourseByTerm(term);
    }

    @Override
    public Course findCourseByName(String selectedCourseName) {
        return courseDao.findCourseByName(selectedCourseName);
    }
}