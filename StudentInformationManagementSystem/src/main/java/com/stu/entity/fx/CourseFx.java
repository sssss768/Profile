package com.stu.entity.fx;

import javafx.beans.property.IntegerProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;

public class CourseFx {
    private IntegerProperty id;
    private StringProperty course;
    private StringProperty teacher;
    private IntegerProperty credit;
    private StringProperty term;

    public CourseFx() {
    }

    public CourseFx(Integer id, String course, String teacher, Integer credit, String term) {
        this.id = new SimpleIntegerProperty(id);
        this.course = new SimpleStringProperty(course);
        this.teacher = new SimpleStringProperty(teacher);
        this.credit = new SimpleIntegerProperty(credit);
        this.term = new SimpleStringProperty(term);
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

    public String getCourse() {
        return course.get();
    }

    public StringProperty courseProperty() {
        return course;
    }

    public void setCourse(String course) {
        this.course.set(course);
    }

    public String getTeacher() {
        return teacher.get();
    }

    public StringProperty teacherProperty() {
        return teacher;
    }

    public void setTeacher(String teacher) {
        this.teacher.set(teacher);
    }

    public int getCredit() {
        return credit.get();
    }

    public IntegerProperty creditProperty() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit.set(credit);
    }

    public String getTerm() {
        return term.get();
    }

    public StringProperty termProperty() {
        return term;
    }

    public void setTerm(String term) {
        this.term.set(term);
    }

    @Override
    public String toString() {
        return "CourseFx{" +
                "id=" + id +
                ", course='" + course + '\'' +
                ", teacher='" + teacher + '\'' +
                ", credit=" + credit +
                ", term='" + term + '\'' +
                '}';
    }
}