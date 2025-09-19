package com.stu.view.controller;

import com.stu.entity.Grades;
import com.stu.service.GradesService;
import com.stu.service.impl.GradesServiceImpl;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;

public class AddGradesController {

    private GradesService gradesService = new GradesServiceImpl();

    @FXML
    private TextField usernameField;
    @FXML
    private TextField courseField;
    @FXML
    private TextField gradeField;

    @FXML
    void addGradeButtonAction() {
        try {
            // Get the grade informationr
            String username = usernameField.getText();
            String course = courseField.getText();
            double gradeValue = Double.parseDouble(gradeField.getText());
            if (username.isEmpty() || course.isEmpty() || gradeField.getText().isEmpty()) {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Error");
                alert.setHeaderText(null);
                alert.setContentText("All fields are required.");
                alert.showAndWait();
                return;
            }

            // Create a grade list and add info
            Grades grade = new Grades();
            grade.setUsername(username);
            grade.setCourse(course);
            grade.setGrades(gradeValue);
            boolean inserted = gradesService.insertGrades(grade);
            if (inserted) {
                Alert alert = new Alert(Alert.AlertType.INFORMATION);
                alert.setTitle("Success");
                alert.setHeaderText(null);
                alert.setContentText("Grade added successfully.");
                alert.showAndWait();
            } else {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Error");
                alert.setHeaderText(null);
                alert.setContentText("Failed to add grade.");
                alert.showAndWait();
            }
        } catch (NumberFormatException e) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Invalid grade value. Grade should be a number.");
            alert.showAndWait();
        }
    }
}