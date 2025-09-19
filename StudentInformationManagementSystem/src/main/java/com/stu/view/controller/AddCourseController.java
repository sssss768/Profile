package com.stu.view.controller;

import com.stu.entity.Course;
import com.stu.service.CourseService;
import com.stu.service.impl.CourseServiceImpl;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;

public class AddCourseController {

    private CourseService courseService = new CourseServiceImpl();

    @FXML
    private TextField courseNameField;
    @FXML
    private TextField teacherField;
    @FXML
    private TextField creditField;
    @FXML
    private TextField termField;

    @FXML
    void addCourseButtonAction() {
        try {
            // Get the course information
            String courseName = courseNameField.getText();
            String teacher = teacherField.getText();
            int credit = Integer.parseInt(creditField.getText());
            String term = termField.getText();
            if (courseName.isEmpty() || teacher.isEmpty() || creditField.getText().isEmpty() || term.isEmpty()) {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Error");
                alert.setHeaderText(null);
                alert.setContentText("All fields are required.");
                alert.showAndWait();
                return;
            }

            // Create a course adn add info
            Course course = new Course();
            course.setCourse(courseName);
            course.setTeacher(teacher);
            course.setCredit(credit);
            course.setTerm(term);
            boolean inserted = courseService.insertCourse(course);
            if (inserted) {
                Alert alert = new Alert(Alert.AlertType.INFORMATION);
                alert.setTitle("Success");
                alert.setHeaderText(null);
                alert.setContentText("Course added successfully.");
                alert.showAndWait();
            } else {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Error");
                alert.setHeaderText(null);
                alert.setContentText("Failed to add course.");
                alert.showAndWait();
            }
        } catch (NumberFormatException e) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Invalid credit value. Credit should be a number.");
            alert.showAndWait();
        }
    }
}