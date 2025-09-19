package com.stu.view.controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

import java.io.IOException;

public class MenuController {
    @FXML
    private AnchorPane bgPane;

    @FXML
    void loginAction(ActionEvent event) {
        toNewScene("/com/stu/view/controller/fxml/Login.fxml");
    }

    @FXML
    void registerAction(ActionEvent event) {
        toNewScene("/com/stu/view/controller/fxml/Register.fxml");
    }


    private void toNewScene(String fxmlUrl){
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource(fxmlUrl));
            Parent root = loader.load();
            Scene newScene = new Scene(root);
            Stage currentStage = (Stage)bgPane.getScene().getWindow();
            Stage newStage = new Stage();
            newStage.setScene(newScene);
            newStage.show();
            currentStage.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

}
