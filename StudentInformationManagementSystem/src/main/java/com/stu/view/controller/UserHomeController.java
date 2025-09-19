package com.stu.view.controller;

import com.stu.entity.Course;
import com.stu.entity.Grades;
import com.stu.entity.Student;
import com.stu.entity.fx.CourseFx;
import com.stu.entity.fx.GradesFx;
import com.stu.service.CourseService;
import com.stu.service.GradesService;
import com.stu.service.StudentService;
import com.stu.service.impl.CourseServiceImpl;
import com.stu.service.impl.GradesServiceImpl;
import com.stu.service.impl.StudentServiceImpl;
import com.stu.utils.FxUtils;
import com.stu.utils.UserThreadLocalUtil;
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
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class UserHomeController {

    private StudentService studentService = new StudentServiceImpl();
    private CourseService courseService = new CourseServiceImpl();
    private GradesService gradesService = new GradesServiceImpl();

    @FXML
    private TextField address;
    @FXML
    private TextField age;
    @FXML
    private TextField classes;
    @FXML
    private TableView<?> courseList;
    @FXML
    private TableView<CourseFx> coursesList;
    @FXML
    private TableView<GradesFx> gradesList;
    @FXML
    private ChoiceBox<String> termChoiceBox;
    @FXML
    private ChoiceBox<String> termChoiceBox3;
    @FXML
    private TextField name;
    @FXML
    private TextField phone;
    @FXML
    private TextField sex;
    @FXML
    private TabPane tabPane;

    @FXML
    void initialize() {
        // Initialize student information
        Student student = UserThreadLocalUtil.get();
        name.setText(student.getName());
        age.setText(String.valueOf(student.getAge()));
        sex.setText(student.getSex());
        phone.setText(student.getPhone());
        classes.setText(student.getIn_class());
        address.setText(student.getAddress());

        tabPane.getSelectionModel().selectedItemProperty().addListener(new ChangeListener<Tab>() {
            @Override
            public void changed(ObservableValue<? extends Tab> observable, Tab oldValue, Tab newValue) {
                if (newValue.getText().equals("GradesInfo")) {
                    loadTermsForChoiceBox(termChoiceBox);
                }
                if (newValue.getText().equals("CourseInfo")) {
                    loadTermsForChoiceBox(termChoiceBox3);
                }
            }
        });
    }

    private void loadTermsForChoiceBox(ChoiceBox<String> choiceBox) {
        List<Course> allCourses = courseService.findAllCourses();
        Set<String> termsSet = new HashSet<>();
        if (allCourses!= null) {
            for (Course course : allCourses) {
                termsSet.add(course.getTerm());
            }
        }
        ObservableList<String> termsList = FXCollections.observableArrayList(termsSet);
        choiceBox.getItems().clear();
        choiceBox.getItems().addAll(termsList);
    }

    @FXML
    void editStuAction(ActionEvent event) {
        String nickname = name.getText();
        int stuAge = Integer.parseInt(age.getText());
        String stuSex = sex.getText();
        String stuPhone = phone.getText();
        String stuAddress = address.getText();
        String stuClasses = classes.getText();
        Student student = new Student();
        student.setId(UserThreadLocalUtil.get().getId());
        student.setUsername(UserThreadLocalUtil.get().getUsername());
        student.setPassword(UserThreadLocalUtil.get().getPassword());
        student.setAddress(stuAddress);
        student.setSex(stuSex);
        student.setName(nickname);
        student.setAge(stuAge);
        student.setPhone(stuPhone);
        student.setIn_class(stuClasses);
        if (stuAge < 0 || stuAge > 100) {
            FxUtils.showAlert(Alert.AlertType.ERROR, "age error", "age is must in 0-100");
            return;
        }
        if (!stuSex.equals("male") &&!stuSex.equals("female")) {
            FxUtils.showAlert(Alert.AlertType.ERROR, "sex error", "sex must be male or female");
            return;
        }
        boolean updateStudent = studentService.updateStudent(student);
        if (updateStudent) {
            FxUtils.showAlert(Alert.AlertType.INFORMATION, "update success", "something wrong");
            name.setText(student.getName());
            age.setText(String.valueOf(student.getAge()));
            sex.setText(student.getSex());
            phone.setText(student.getPhone());
            classes.setText(student.getIn_class());
            address.setText(student.getAddress());
            UserThreadLocalUtil.set(student);
        } else {
            FxUtils.showAlert(Alert.AlertType.ERROR, "error", "Something wrong");
        }
    }

    @FXML
    void exportAction(ActionEvent event) throws Exception {
        try {
            String term = termChoiceBox.getSelectionModel().getSelectedItem();
            if (term == null) {
                FxUtils.showAlert(Alert.AlertType.ERROR, "error", "Please select a term.");
                return;
            }

            List<Course> courses = courseService.getCourses(term);
            if (courses == null) {
                FxUtils.showAlert(Alert.AlertType.ERROR, "error", "No course information found.");
                return;
            }

            List<Grades> grades = gradesService.getGradesList(courses, UserThreadLocalUtil.get().getUsername());
            if (grades == null || grades.isEmpty()) {
                FxUtils.showAlert(Alert.AlertType.ERROR, "error", "There is no grade data available for export.");
                return;
            }

            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Grade Sheet");

            Row headerRow = sheet.createRow(0);
            CellStyle headerStyle = workbook.createCellStyle();
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerStyle.setFont(headerFont);

            org.apache.poi.ss.usermodel.Cell idCell = headerRow.createCell(0);
            idCell.setCellValue("Id");
            idCell.setCellStyle(headerStyle);

            org.apache.poi.ss.usermodel.Cell numberCell = headerRow.createCell(1);
            numberCell.setCellValue("Student Number");
            numberCell.setCellStyle(headerStyle);

            org.apache.poi.ss.usermodel.Cell courseCell = headerRow.createCell(2);
            courseCell.setCellValue("Course");
            courseCell.setCellStyle(headerStyle);

            org.apache.poi.ss.usermodel.Cell gradesCell = headerRow.createCell(3);
            gradesCell.setCellValue("Grades");
            gradesCell.setCellStyle(headerStyle);

            // Fill data rows
            int rowNum = 1;
            for (Grades grade : grades) {
                Row dataRow = sheet.createRow(rowNum++);
                org.apache.poi.ss.usermodel.Cell idDataCell = dataRow.createCell(0);
                idDataCell.setCellValue(grade.getId());

                org.apache.poi.ss.usermodel.Cell numberDataCell = dataRow.createCell(1);
                numberDataCell.setCellValue(grade.getUsername());

                org.apache.poi.ss.usermodel.Cell courseDataCell = dataRow.createCell(2);
                courseDataCell.setCellValue(grade.getCourse());

                org.apache.poi.ss.usermodel.Cell gradesDataCell = dataRow.createCell(3);
                gradesDataCell.setCellValue(grade.getGrades());
            }

            // Let the user select the save path
            javafx.stage.FileChooser fileChooser = new javafx.stage.FileChooser();
            fileChooser.setTitle("Save Grade Sheet");
            fileChooser.getExtensionFilters().add(new javafx.stage.FileChooser.ExtensionFilter("Excel file", "*.xlsx"));
            File selectedFile = fileChooser.showSaveDialog(null);

            if (selectedFile!= null) {
                try (FileOutputStream fos = new FileOutputStream(selectedFile)) {
                    workbook.write(fos);
                    FxUtils.showAlert(Alert.AlertType.INFORMATION, "Success", "The grade sheet has been successfully exported.");
                }
            } else {
                FxUtils.showAlert(Alert.AlertType.WARNING, "Path not selected", "No save path was selected. Export operation canceled.");
            }

        } catch (IOException e) {
            FxUtils.showAlert(Alert.AlertType.ERROR, "Error", "An error occurred while exporting the grade sheet: " + e.getMessage());
        }
    }

    @FXML
    void queryCourseAction(ActionEvent event) {
        coursesList.getColumns().clear();
        coursesList.getItems().clear();
        String term = termChoiceBox3.getSelectionModel().getSelectedItem();
        System.out.println(term);
        if (term == null) {
            FxUtils.showAlert(Alert.AlertType.ERROR, "error", "server error");
        }

        List<Course> courses = courseService.getCourses(term);
        List<CourseFx> courseFxes = new ArrayList<>();
        for (Course cours : courses) {
            CourseFx courseFx = new CourseFx(cours.getId(), cours.getCourse(), cours.getTeacher(), cours.getCredit(), cours.getTerm());
            courseFxes.add(courseFx);
        }
        ObservableList<CourseFx> courseObservableList = FXCollections.observableArrayList(courseFxes);
        coursesList.setItems(courseObservableList);
        // Set up
        TableColumn<CourseFx, Integer> IdColumn = new TableColumn<>("Id");
        IdColumn.setCellValueFactory(new PropertyValueFactory<>("id"));
        TableColumn<CourseFx, String> courseColumn = new TableColumn<>("Course");
        courseColumn.setCellValueFactory(new PropertyValueFactory<>("course"));

        TableColumn<CourseFx, String> teacherColumn = new TableColumn<>("Teacher");
        teacherColumn.setCellValueFactory(new PropertyValueFactory<>("teacher"));

        TableColumn<CourseFx, Integer> creditColumn = new TableColumn<>("Credit");
        creditColumn.setCellValueFactory(new PropertyValueFactory<>("credit"));
        TableColumn<CourseFx, String> termColumn = new TableColumn<>("Term");
        termColumn.setCellValueFactory(new PropertyValueFactory<>("term"));
        coursesList.getColumns().addAll(IdColumn, courseColumn, teacherColumn, creditColumn, termColumn);
    }

    @FXML
    void queryGradesAction(ActionEvent event) throws Exception {
        String term = termChoiceBox.getSelectionModel().getSelectedItem();
        if (term == null) {
            FxUtils.showAlert(Alert.AlertType.ERROR, "error", "server error");
        }
        System.out.println(term);
        List<Course> courses = courseService.getCourses(term);
        if (courses!= null) {
            List<Grades> grades = gradesService.getGradesList(courses, UserThreadLocalUtil.get().getUsername());

            gradesList.getItems().clear();
            gradesList.getColumns().clear();
            List<GradesFx> gradesFxes = new ArrayList<>();

            for (Grades grade : grades) {
                System.out.println(grade==null);
                System.out.println(grade.toString());
                GradesFx gradesFx = new GradesFx(grade.getId(), grade.getCourse(), grade.getUsername(), grade.getGrades());
                gradesFxes.add(gradesFx);
            }

            ObservableList<GradesFx> gradesObservableList = FXCollections.observableArrayList(gradesFxes);

            gradesList.setItems(gradesObservableList);

            // Set up
            TableColumn<GradesFx, Integer> gradesIdColumn = new TableColumn<>("Id");
            gradesIdColumn.setCellValueFactory(new PropertyValueFactory<>("id"));

            TableColumn<GradesFx, String> numberColumn = new TableColumn<>("StudentNumber");
            numberColumn.setCellValueFactory(new PropertyValueFactory<>("username"));

            TableColumn<GradesFx, String> courseColumn = new TableColumn<>("Course");
            courseColumn.setCellValueFactory(new PropertyValueFactory<>("course"));

            TableColumn<GradesFx, Double> gradesColumn = new TableColumn<>("Grades");
            gradesColumn.setCellValueFactory(new PropertyValueFactory<>("grades"));
            gradesList.getColumns().addAll(gradesIdColumn, numberColumn, courseColumn, gradesColumn);
        } else {
            FxUtils.showAlert(Alert.AlertType.ERROR, "error", "no course");
        }
    }

    @FXML
    void logoutAction(ActionEvent event) {
        UserThreadLocalUtil.remove();
        toNewScene("/com/stu/view/controller/fxml/Login.fxml");
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