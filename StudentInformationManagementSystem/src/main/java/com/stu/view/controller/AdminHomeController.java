package com.stu.view.controller;

import com.stu.entity.Admin;
import com.stu.entity.Course;
import com.stu.entity.Grades;
import com.stu.entity.Student;
import com.stu.service.AdminService;
import com.stu.service.CourseService;
import com.stu.service.GradesService;
import com.stu.service.StudentService;
import com.stu.service.impl.AdminServiceImpl;
import com.stu.service.impl.CourseServiceImpl;
import com.stu.service.impl.GradesServiceImpl;
import com.stu.service.impl.StudentServiceImpl;
import com.stu.utils.AdminThreadLocalUtil;
import com.stu.utils.FxUtils;
import com.stu.view.controller.UpdateStudent;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;

import java.io.IOException;
import java.util.List;
import java.util.regex.Pattern;

public class AdminHomeController {

    private StudentService studentService = new StudentServiceImpl();
    private AdminService adminService = new AdminServiceImpl();
    private CourseService courseService = new CourseServiceImpl();
    private GradesService gradeService = new GradesServiceImpl();
    @FXML
    private ChoiceBox<String> courseChoiceBox;
    @FXML
    private ChoiceBox<String> studentNumberChoiceBox;
    @FXML
    private TableView<Course> courseList;
    @FXML
    private TableView<Student> studentList;
    @FXML
    private TableView<Grades> gradesList;
    @FXML
    private TabPane tabPane;
    @FXML
    private TextField name;
    @FXML
    private TextField phone;
    @FXML
    private ChoiceBox<String> usernameChoiceBox;

    private boolean flag1 = true;
    private boolean flag2 = true;
    private boolean flag3 = true;

    @FXML
    void initialize() {
        Admin admin = AdminThreadLocalUtil.get();
        name.setText(admin.getName());
        phone.setText(admin.getPhone());
        tabPane.getSelectionModel().selectedItemProperty().addListener(new ChangeListener<Tab>() {
            @Override
            public void changed(ObservableValue<? extends Tab> observable, Tab oldValue, Tab newValue) {
                if (newValue.getText().equals("StudentManage")) {
                    if(flag1){
                        initStudentTable();
                        flag1 =false;
                    }

                } else if (newValue.getText().equals("CourseManage")) {
                    if(flag2){
                        initCourseTable();
                        flag2 = false;
                    }

                } else if (newValue.getText().equals("GradesManage")) {
                    if(flag3){
                        initGradesTable();
                        flag3 = false;
                    }

                }
            }
        });
    }

    private void initStudentTable() {
        TableColumn<Student, Integer> idColumn = new TableColumn<>("Id");
        idColumn.setCellValueFactory(new PropertyValueFactory<>("id"));
        TableColumn<Student, String> nameColumn = new TableColumn<>("Name");
        nameColumn.setCellValueFactory(new PropertyValueFactory<>("name"));
        TableColumn<Student, Integer> ageColumn = new TableColumn<>("Age");
        ageColumn.setCellValueFactory(new PropertyValueFactory<>("age"));
        TableColumn<Student, String> sexColumn = new TableColumn<>("Sex");
        sexColumn.setCellValueFactory(new PropertyValueFactory<>("sex"));
        TableColumn<Student, String> phoneColumn = new TableColumn<>("Phone");
        phoneColumn.setCellValueFactory(new PropertyValueFactory<>("phone"));
        TableColumn<Student, String> addressColumn = new TableColumn<>("Address");
        addressColumn.setCellValueFactory(new PropertyValueFactory<>("address"));
        TableColumn<Student, String> usernameColumn = new TableColumn<>("Username");
        usernameColumn.setCellValueFactory(new PropertyValueFactory<>("username"));
        TableColumn<Student, String> inClassColumn = new TableColumn<>("In Class");
        inClassColumn.setCellValueFactory(new PropertyValueFactory<>("in_class"));

        studentList.getColumns().addAll(idColumn, nameColumn, ageColumn, sexColumn, phoneColumn, addressColumn, usernameColumn, inClassColumn);

        // Load student information
        List<Student> allStudents = studentService.findAllStudents();
        ObservableList<Student> observableStudents = FXCollections.observableArrayList(allStudents);
        studentList.setItems(observableStudents);

        refreshUsernameChoiceBox(allStudents);
    }

    private void initCourseTable() {
        TableColumn<Course, Integer> courseIdColumn = new TableColumn<>("Id");
        courseIdColumn.setCellValueFactory(new PropertyValueFactory<>("id"));
        TableColumn<Course, String> courseNameColumn = new TableColumn<>("Course Name");
        courseNameColumn.setCellValueFactory(new PropertyValueFactory<>("course"));
        TableColumn<Course, String> teacherColumn = new TableColumn<>("Teacher");
        teacherColumn.setCellValueFactory(new PropertyValueFactory<>("teacher"));
        TableColumn<Course, Integer> creditColumn = new TableColumn<>("Credit");
        creditColumn.setCellValueFactory(new PropertyValueFactory<>("credit"));
        TableColumn<Course, String> termColumn = new TableColumn<>("Term");
        termColumn.setCellValueFactory(new PropertyValueFactory<>("term"));

        courseList.getColumns().addAll(courseIdColumn, courseNameColumn, teacherColumn, creditColumn, termColumn);

        // Load course information
        List<Course> allCourses = courseService.findAllCourses();
        ObservableList<Course> observableCourses = FXCollections.observableArrayList(allCourses);
        courseList.setItems(observableCourses);

        refreshCourseChoiceBox(allCourses);
    }

    private void initGradesTable() {
        TableColumn<Grades, Integer> gradesIdColumn = new TableColumn<>("Id");
        gradesIdColumn.setCellValueFactory(new PropertyValueFactory<>("id"));
        TableColumn<Grades, String> gradesUsernameColumn = new TableColumn<>("Username");
        gradesUsernameColumn.setCellValueFactory(new PropertyValueFactory<>("username"));
        TableColumn<Grades, String> gradesCourseColumn = new TableColumn<>("Course");
        gradesCourseColumn.setCellValueFactory(new PropertyValueFactory<>("course"));
        TableColumn<Grades, Double> gradesValueColumn = new TableColumn<>("Grades");
        gradesValueColumn.setCellValueFactory(new PropertyValueFactory<>("grades"));

        gradesList.getColumns().addAll(gradesIdColumn, gradesUsernameColumn, gradesCourseColumn, gradesValueColumn);

        // Load grade information
        List<Grades> allGrades = gradeService.findAllGrades();
        ObservableList<Grades> observableGrades = FXCollections.observableArrayList(allGrades);
        gradesList.setItems(observableGrades);

        List<Student> allStudents = studentService.findAllStudents();
        refreshStudentNumberChoiceBox(allStudents);
    }

    private void refreshUsernameChoiceBox(List<Student> students) {
        usernameChoiceBox.getItems().clear();
        if (students != null) {
            students.forEach(student -> {
                if (!usernameChoiceBox.getItems().contains(student.getUsername())) {
                    usernameChoiceBox.getItems().add(student.getUsername());
                }
            });
        }
    }

    private void refreshCourseChoiceBox(List<Course> courses) {
        courseChoiceBox.getItems().clear();
        if (courses != null) {
            courses.forEach(course -> {
                if (!courseChoiceBox.getItems().contains(course.getCourse())) {
                    courseChoiceBox.getItems().add(course.getCourse());
                }
            });
        }
    }

    private void refreshStudentNumberChoiceBox(List<Student> students) {
        studentNumberChoiceBox.getItems().clear();
        if (students != null) {
            students.forEach(student -> {
                if (!studentNumberChoiceBox.getItems().contains(student.getUsername())) {
                    studentNumberChoiceBox.getItems().add(student.getUsername());
                }
            });
        }
    }

    @FXML
    void logoutAction(ActionEvent event) {
        AdminThreadLocalUtil.remove();
        toNewScene("/com/stu/view/controller/fxml/Login.fxml");
    }

    @FXML
    void addCourseAction(ActionEvent event) {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/com/stu/view/controller/fxml/addCourse.fxml"));
            Parent root = loader.load();
            Scene scene = new Scene(root);
            Stage stage = new Stage();
            stage.setScene(scene);
            stage.showAndWait();

            // Update the course list table and ChoiceBox
            List<Course> updatedCourses = courseService.findAllCourses();
            ObservableList<Course> updatedObservableCourses = FXCollections.observableArrayList(updatedCourses);
            courseList.setItems(updatedObservableCourses);
            refreshCourseChoiceBox(updatedCourses);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @FXML
    void addGradesAction(ActionEvent event) {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/com/stu/view/controller/fxml/addGrades.fxml"));
            Parent root = loader.load();
            Scene scene = new Scene(root);
            Stage stage = new Stage();
            stage.setScene(scene);
            stage.showAndWait();

            // Update the Grade List table and ChoiceBox
            List<Grades> updatedGrades = gradeService.findAllGrades();
            ObservableList<Grades> updatedObservableGrades = FXCollections.observableArrayList(updatedGrades);
            gradesList.setItems(updatedObservableGrades);
            List<Student> allStudents = studentService.findAllStudents();
            refreshStudentNumberChoiceBox(allStudents);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @FXML
    void addStuAction(ActionEvent event) {
        toNewScene("/com/stu/view/controller/fxml/addStudent.fxml");
    }

    @FXML
    void editStuAction(ActionEvent event) {
        String selectedUsername = usernameChoiceBox.getValue();
        if (selectedUsername != null) {
            Student studentToEdit = studentService.findStudentByUsername(selectedUsername);
            if (studentToEdit != null) {
                try {
                    FXMLLoader loader = new FXMLLoader(getClass().getResource("/com/stu/view/controller/fxml/updateStudent.fxml"));
                    Parent root = loader.load();
                    UpdateStudent updateStudentController = loader.getController();
                    updateStudentController.initialize(studentToEdit);
                    Scene scene = new Scene(root);
                    Stage stage = new Stage();
                    stage.setScene(scene);
                    stage.showAndWait();

                    // Update the student list form and ChoiceBox
                    List<Student> updatedStudents = studentService.findAllStudents();
                    ObservableList<Student> updatedObservableStudents = FXCollections.observableArrayList(updatedStudents);
                    studentList.setItems(updatedObservableStudents);
                    refreshUsernameChoiceBox(updatedStudents);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Error");
                alert.setHeaderText(null);
                alert.setContentText("Student not found.");
                alert.showAndWait();
            }
        } else {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Please select a student to edit.");
            alert.showAndWait();
        }
    }

    @FXML
    void queryCourseAction(ActionEvent event) {
        String selectedCourseName = courseChoiceBox.getValue();
        if (selectedCourseName != null) {
            Course course = courseService.findCourseByName(selectedCourseName);
            if (course != null) {
                // Display the queried course information
                ObservableList<Course> singleCourseList = FXCollections.observableArrayList(course);
                courseList.setItems(singleCourseList);
            } else {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Error");
                alert.setHeaderText(null);
                alert.setContentText("Course not found.");
                alert.showAndWait();
            }
        } else {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Please select a course.");
            alert.showAndWait();
        }
    }

    @FXML
    void queryGradesAction(ActionEvent event) {
        String selectedStudentNumber = studentNumberChoiceBox.getValue();
        if (selectedStudentNumber != null) {
            List<Grades> gradesForStudent = gradeService.findGradesByUsername(selectedStudentNumber);
            if (gradesForStudent != null && !gradesForStudent.isEmpty()) {
                ObservableList<Grades> singleStudentGradesList = FXCollections.observableArrayList(gradesForStudent);
                gradesList.setItems(singleStudentGradesList);
            } else {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Error");
                alert.setHeaderText(null);
                alert.setContentText("No grades found for the selected student.");
                alert.showAndWait();
            }
        } else {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Please select a student number.");
            alert.showAndWait();
        }
    }

    @FXML
    void queryStuAction(ActionEvent event) {
        String selectedUsername = usernameChoiceBox.getValue();
        if (selectedUsername != null) {
            Student student = studentService.findStudentByUsername(selectedUsername);
            if (student != null) {
                // Display the queried student information
                ObservableList<Student> singleStudentList = FXCollections.observableArrayList(student);
                studentList.setItems(singleStudentList);
            } else {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Error");
                alert.setHeaderText(null);
                alert.setContentText("Student not found.");
                alert.showAndWait();
            }
        } else {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Please select a username.");
            alert.showAndWait();
        }
    }

    @FXML
    void removeCourseAction(ActionEvent event) {
        String selectedCourseName = courseChoiceBox.getValue();
        if (selectedCourseName != null) {
            Course courseToRemove = courseService.findCourseByName(selectedCourseName);
            if (courseToRemove != null) {
                boolean deleted = courseService.deleteCourseById(courseToRemove.getId());
                if (deleted) {
                    // Deletes all the corresponding grade information
                    boolean gradesDeleted = gradeService.deleteGradesByCourseAndUserName(courseToRemove.getCourse());
                    if (gradesDeleted) {
                        Alert alert = new Alert(Alert.AlertType.INFORMATION);
                        alert.setTitle("Success");
                        alert.setHeaderText(null);
                        alert.setContentText("Course deleted successfully and corresponding grades removed.");
                        alert.showAndWait();

                        // Update the form and ChoiceBox
                        List<Course> updatedCourses = courseService.findAllCourses();
                        ObservableList<Course> updatedObservableCourses = FXCollections.observableArrayList(updatedCourses);
                        courseList.setItems(updatedObservableCourses);
                        refreshCourseChoiceBox(updatedCourses);
                    } else {
                        Alert alert = new Alert(Alert.AlertType.ERROR);
                        alert.setTitle("Error");
                        alert.setHeaderText(null);
                        alert.setContentText("Failed to remove corresponding grades.");
                        alert.showAndWait();
                    }
                } else {
                    Alert alert = new Alert(Alert.AlertType.ERROR);
                    alert.setTitle("Error");
                    alert.setHeaderText(null);
                    alert.setContentText("Failed to delete course.");
                    alert.showAndWait();
                }
            } else {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Error");
                alert.setHeaderText(null);
                alert.setContentText("Course not found.");
                alert.showAndWait();
            }
        } else {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Please select a course to delete.");
            alert.showAndWait();
        }
    }

    @FXML
    void removeGradesAction(ActionEvent event) {
        String selectedStudentNumber = studentNumberChoiceBox.getValue();
        if (selectedStudentNumber != null) {
            List<Grades> gradesToRemove = gradeService.findGradesByUsername(selectedStudentNumber);
            if (gradesToRemove != null && !gradesToRemove.isEmpty()) {
                for (Grades grade : gradesToRemove) {
                    boolean deleted = gradeService.deleteGradesById(grade.getId());
                    if (!deleted) {
                        Alert alert = new Alert(Alert.AlertType.ERROR);
                        alert.setTitle("Error");
                        alert.setHeaderText(null);
                        alert.setContentText("Failed to delete grade with id: " + grade.getId());
                        alert.showAndWait();
                        return;
                    }
                }
                Alert alert = new Alert(Alert.AlertType.INFORMATION);
                alert.setTitle("Success");
                alert.setHeaderText(null);
                alert.setContentText("Grades for student deleted successfully.");
                alert.showAndWait();

                // Update the Grade List table and ChoiceBox
                List<Grades> updatedGrades = gradeService.findAllGrades();
                ObservableList<Grades> updatedObservableGrades = FXCollections.observableArrayList(updatedGrades);
                gradesList.setItems(updatedObservableGrades);
                List<Student> allStudents = studentService.findAllStudents();
                refreshStudentNumberChoiceBox(allStudents);
            } else {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Error");
                alert.setHeaderText(null);
                alert.setContentText("No grades found for the selected student.");
                alert.showAndWait();
            }
        } else {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Please select a student number.");
            alert.showAndWait();
        }
    }

    @FXML
    void removeStuAction(ActionEvent event) {
        String selectedUsername = usernameChoiceBox.getValue();
        if (selectedUsername != null) {
            Student studentToRemove = studentService.findStudentByUsername(selectedUsername);
            if (studentToRemove != null) {
                boolean deleted = studentService.deleteStudentById(studentToRemove.getId());
                if (deleted) {
                    Alert alert = new Alert(Alert.AlertType.INFORMATION);
                    alert.setTitle("Success");
                    alert.setHeaderText(null);
                    alert.setContentText("Student deleted successfully.");
                    alert.showAndWait();

                    // Update the form and ChoiceBox
                    List<Student> updatedStudents = studentService.findAllStudents();
                    ObservableList<Student> updatedObservableStudents = FXCollections.observableArrayList(updatedStudents);
                    studentList.setItems(updatedObservableStudents);
                    refreshUsernameChoiceBox(updatedStudents);
                } else {
                    Alert alert = new Alert(Alert.AlertType.ERROR);
                    alert.setTitle("Error");
                    alert.setHeaderText(null);
                    alert.setContentText("Failed to delete student.");
                    alert.showAndWait();
                }
            } else {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Error");
                alert.setHeaderText(null);
                alert.setContentText("Student not found.");
                alert.showAndWait();
            }
        } else {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error");
            alert.setHeaderText(null);
            alert.setContentText("Please select a student to delete.");
            alert.showAndWait();
        }
    }

    @FXML
    void updateInfoAction(ActionEvent event) {
        Admin admin = AdminThreadLocalUtil.get();

        String adminName = name.getText();
        String adminPhone = phone.getText();

        // As same as student
        String nameRegex = "^[a-zA-Z\\u4e00-\u9fa5 ]{2,20}$";
        if (!Pattern.matches(nameRegex, adminName)) {
            FxUtils.showAlert(Alert.AlertType.ERROR, "error", "Invalid admin name.");
            return;
        }

        // what can I say, man
        String phoneRegex = "^1[3-9]\\d{9}$";
        if (!Pattern.matches(phoneRegex, adminPhone)) {
            FxUtils.showAlert(Alert.AlertType.ERROR, "error", "Invalid phone number.");
            return;
        }

        admin.setName(adminName);
        admin.setPhone(adminPhone);
        boolean b = adminService.updateAdmin(admin);
        if (b) {
            FxUtils.showAlert(Alert.AlertType.INFORMATION, "success", "update admininfo success!");
            AdminThreadLocalUtil.set(admin);
            name.setText(adminName);
            phone.setText(adminPhone);
        } else {
            FxUtils.showAlert(Alert.AlertType.ERROR, "error", "edit admininfo error");
        }
    }

    private void toNewScene(String fxmlUrl) {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource(fxmlUrl));
            Parent root = loader.load();
            Scene newScene = new Scene(root);
            Stage currentStage = (Stage) tabPane.getScene().getWindow();
            Stage newStage = new Stage();
            newStage.setScene(newScene);
            newStage.show();
            currentStage.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}