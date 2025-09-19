package com.stu.view.controller;

import com.stu.entity.Student;
import com.stu.service.StudentService;
import com.stu.service.impl.StudentServiceImpl;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.io.IOException;
import java.util.regex.Pattern;

public class AddStudentController {
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

    public void addStudentAction() {
        // Check if the required fields are empty
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

        // Name regexe judgement, assuming that only letters, kanji, and spaces are allowed, with lengths between 2 and 20
        String nameRegex = "^[a-zA-Z\\u4e00-\u9fa5 ]{2,20}$";
        if (!Pattern.matches(nameRegex, nameField.getText())) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Invalid name format.");
            alert.showAndWait();
            return;
        }

        // Mobile phone number format verification (We set China moblie +86 11)
        String phoneRegex = "^1[3-9]\\d{9}$";
        if (!Pattern.matches(phoneRegex, phoneField.getText())) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Invalid phone number format.");
            alert.showAndWait();
            return;
        }

        // Check if the age is numeric and between 0 - 100
        try {
            int age = Integer.parseInt(ageField.getText());
            if (age < 0 || age > 100) {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Error");
                alert.setHeaderText(null);
                alert.setContentText("Age must be between 0 and 100.");
                alert.showAndWait();
                return;
            }
        } catch (NumberFormatException e) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Invalid age format.");
            alert.showAndWait();
            return;
        }

        // The sex can be only male or female
        String sex = sexField.getText();
        if (!"male".equals(sex) &&!"female".equals(sex)) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Sex must be either 'male' or 'female'.");
            alert.showAndWait();
            return;
        }

        // Check if the username already exists
        String username = usernameField.getText();
        if (studentService.findStudentByUsername(username)!= null) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Username already exists.");
            alert.showAndWait();
            return;
        }

        Student student = new Student();
        student.setName(nameField.getText());
        student.setAge(Integer.parseInt(ageField.getText()));
        student.setSex(sexField.getText());
        student.setPhone(phoneField.getText());
        student.setAddress(addressField.getText());
        student.setUsername(usernameField.getText());
        student.setPassword(passwordField.getText());
        student.setIn_class(inClassField.getText());

        boolean added = studentService.insertStudent(student);
        if (added) {
            Alert alert = new Alert(Alert.AlertType.INFORMATION);
            alert.setTitle("Success");
            alert.setHeaderText(null);
            alert.setContentText("Student added successfully!");
            alert.showAndWait();
        } else {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Failed to add student.");
            alert.showAndWait();
        }
    }
    @FXML
    void backAction(ActionEvent event) {
      toNewScene("/com/stu/view/controller/fxml/AdminHome.fxml");
    }
    private void toNewScene(String fxmlUrl){
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource(fxmlUrl));
            Parent root = loader.load();
            Scene newScene = new Scene(root);
            Stage currentStage = (Stage)nameField.getScene().getWindow();
            Stage newStage = new Stage();
            newStage.setScene(newScene);
            newStage.show();
            currentStage.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
