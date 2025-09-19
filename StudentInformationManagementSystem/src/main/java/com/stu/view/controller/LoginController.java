package com.stu.view.controller;

import com.stu.entity.Admin;
import com.stu.entity.Student;
import com.stu.service.AdminService;
import com.stu.service.StudentService;
import com.stu.service.impl.AdminServiceImpl;
import com.stu.service.impl.StudentServiceImpl;
import com.stu.utils.AdminThreadLocalUtil;
import com.stu.utils.FxUtils;
import com.stu.utils.UserThreadLocalUtil;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.CheckBox;
import javafx.scene.control.TextField;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

import java.io.IOException;

public class LoginController {

    private AdminService adminService = new AdminServiceImpl();
    private StudentService studentService = new StudentServiceImpl();

    @FXML
    private CheckBox adminRadio;

    @FXML
    private AnchorPane loginPane;

    @FXML
    private TextField passwordText;

    @FXML
    private CheckBox userRadio;

    @FXML
    private TextField usernameText;

    @FXML
    void backAction(ActionEvent event) {
        toNewScene("/com/stu/view/controller/fxml/Menu.fxml");
    }

    @FXML
    void loginAction(ActionEvent event) {
        String username = usernameText.getText();
        String password = passwordText.getText();
        //Select Administrators
        if(adminRadio.isSelected()){
            Admin adminByUsername = adminService.findAdminByUsername(username);
            if(adminByUsername!=null){
                if(adminByUsername.getPassword().equals(password)){
                    AdminThreadLocalUtil.set(adminByUsername);
                    FxUtils.showAlert(Alert.AlertType.INFORMATION,"login success","teacher login success");
                    toNewScene("/com/stu/view/controller/fxml/AdminHome.fxml");


                }
            }else {
                FxUtils.showAlert(Alert.AlertType.ERROR,"Admin UserName or Password Error!","username or password is not right,please try again");
            }


        }
        if(userRadio.isSelected()){

            Student studentByUsername = studentService.findStudentByUsername(username);
            if(studentByUsername!=null){
                if(studentByUsername.getPassword().equals(password)){
                    UserThreadLocalUtil.set(studentByUsername);
                    FxUtils.showAlert(Alert.AlertType.INFORMATION,"login success","student login success");
                    toNewScene("/com/stu/view/controller/fxml/UserHome.fxml");

                }
            }else {
                FxUtils.showAlert(Alert.AlertType.ERROR,"Student UserName or Password Error!","username or password is not right,please try again");
            }

        }
        if(!adminRadio.isSelected() && !userRadio.isSelected()){

            FxUtils.showAlert(Alert.AlertType.WARNING,"Choose error!","please choose your role");
        }

    }

    @FXML
    void selectAdminRadio(ActionEvent event) {

    }

    @FXML
    void selectUserAction(ActionEvent event) {



    }

    private void toNewScene(String fxmlUrl){
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource(fxmlUrl));
            Parent root = loader.load();
            Scene newScene = new Scene(root);
            Stage currentStage = (Stage)loginPane.getScene().getWindow();
            Stage newStage = new Stage();
            newStage.setScene(newScene);
            newStage.show();
            currentStage.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    // Listen for changes in the selected status of the two CheckBoxes to ensure single selection
    public void initialize() {
        adminRadio.selectedProperty().addListener((observable, oldValue, newValue) -> {
            if (newValue) {
                userRadio.setSelected(false);
            }
        });

        userRadio.selectedProperty().addListener((observable, oldValue, newValue) -> {
            if (newValue) {
                adminRadio.setSelected(false);
            }
        });
    }
}
