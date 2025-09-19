package com.stu.view.controller;

import com.stu.entity.Student;
import com.stu.service.StudentService;
import com.stu.service.impl.StudentServiceImpl;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;

public class UpdateStudent {

    private StudentService studentService = new StudentServiceImpl();

    @FXML
    private TextField nameField;
    @FXML
    private TextField ageField;
    @FXML
    private TextField sexField;
    @FXML
    private TextField phoneField;
    @FXML
    private TextField addressField;
    @FXML
    private TextField usernameField;
    @FXML
    private TextField passwordField;
    @FXML
    private TextField inClassField;

    public void initialize(Student studentToEdit) {
        // Echo student information
        nameField.setText(studentToEdit.getName());
        ageField.setText(String.valueOf(studentToEdit.getAge()));
        sexField.setText(studentToEdit.getSex());
        phoneField.setText(studentToEdit.getPhone());
        addressField.setText(studentToEdit.getAddress());
        usernameField.setText(studentToEdit.getUsername());
        passwordField.setText(studentToEdit.getPassword());
        inClassField.setText(studentToEdit.getIn_class());
    }

    @FXML
    void saveChangesAction() {
        try {
            String id = usernameField.getText();
            Student student = studentService.findStudentByUsername(id);
            if (student!= null) {
                if (nameField.getText().isEmpty() || ageField.getText().isEmpty() || sexField.getText().isEmpty() ||
                        phoneField.getText().isEmpty() || addressField.getText().isEmpty() || usernameField.getText().isEmpty() ||
                        passwordField.getText().isEmpty() || inClassField.getText().isEmpty()) {
                    Alert alert = new Alert(Alert.AlertType.ERROR);
                    alert.setTitle("Error");
                    alert.setHeaderText(null);
                    alert.setContentText("All fields are required.");
                    alert.showAndWait();
                    return;
                }

                // Format request as same as it in AddStudentController
                String phoneRegex = "^1[3-9]\\d{9}$";
                if (!phoneField.getText().matches(phoneRegex)) {
                    Alert alert = new Alert(Alert.AlertType.ERROR);
                    alert.setTitle("Error");
                    alert.setHeaderText(null);
                    alert.setContentText("Invalid phone number format.");
                    alert.showAndWait();
                    return;
                }

                // same
                int age = Integer.parseInt(ageField.getText());
                if (age < 0 || age > 100) {
                    Alert alert = new Alert(Alert.AlertType.ERROR);
                    alert.setTitle("Error");
                    alert.setHeaderText(null);
                    alert.setContentText("Age must be between 0 and 100.");
                    alert.showAndWait();
                    return;
                }

                // same
                String sex = sexField.getText();
                if (!"male".equals(sex) &&!"female".equals(sex)) {
                    Alert alert = new Alert(Alert.AlertType.ERROR);
                    alert.setTitle("Error");
                    alert.setHeaderText(null);
                    alert.setContentText("Sex must be either 'male' or 'female'.");
                    alert.showAndWait();
                    return;
                }

                student.setName(nameField.getText());
                student.setAge(age);
                student.setSex(sexField.getText());
                student.setPhone(phoneField.getText());
                student.setAddress(addressField.getText());
                student.setUsername(usernameField.getText());
                student.setPassword(passwordField.getText());
                student.setIn_class(inClassField.getText());

                boolean updated = studentService.updateStudent(student);
                if (updated) {
                    Alert alert = new Alert(Alert.AlertType.INFORMATION);
                    alert.setTitle("Success");
                    alert.setHeaderText(null);
                    alert.setContentText("Student information updated successfully.");
                    alert.showAndWait();
                } else {
                    Alert alert = new Alert(Alert.AlertType.ERROR);
                    alert.setTitle("Error");
                    alert.setHeaderText(null);
                    alert.setContentText("Failed to update student information.");
                    alert.showAndWait();
                }
            } else {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Error");
                alert.setHeaderText(null);
                alert.setContentText("Student not found.");
                alert.showAndWait();
            }
        } catch (NumberFormatException e) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Invalid student ID format.");
            alert.showAndWait();
        }
    }
}