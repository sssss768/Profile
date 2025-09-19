package com.stu.entity.fx;

import javafx.beans.property.*;

public class GradesFx {
    private IntegerProperty id;
    private StringProperty username;
    private StringProperty course;
    private DoubleProperty grades;

    public GradesFx() {
    }

    public double getGrades() {
        return grades.get();
    }

    public DoubleProperty gradesProperty() {
        return grades;
    }

    public void setGrades(double grades) {
        this.grades.set(grades);
    }

    public GradesFx(Integer id, String username, String course, Double grades) {
        this.id = new SimpleIntegerProperty(id);
        this.username = new SimpleStringProperty(username);
        this.course = new SimpleStringProperty(course);
        this.grades = new SimpleDoubleProperty(grades);
    }

    public int getId() {
        return id.get();
    }

    public IntegerProperty idProperty() {
        return id;
    }

    public void setId(int id) {
        this.id.set(id);
    }

    public String getUsername() {
        return username.get();
    }

    public StringProperty usernameProperty() {
        return username;
    }

    public void setUsername(String username) {
        this.username.set(username);
    }

    public String getCourse() {
        return course.get();
    }

    public StringProperty courseProperty() {
        return course;
    }

    public void setCourse(String course) {
        this.course.set(course);
    }

    @Override
    public String toString() {
        return "GradesFx{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", course='" + course + '\'' +
                '}';
    }
}