package com.stu.entity;

public class Grades {
    private int id;
    private String username;
    private String course;
    private Double grades;

    public Grades() {
    }

    public Grades(int id, String username, String course,Double grades) {
        this.id = id;
        this.username = username;
        this.course = course;
        this.grades = grades;
    }

    public Double getGrades() {
        return grades;
    }

    public void setGrades(Double grades) {
        this.grades = grades;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    @Override
    public String toString() {
        return "Grades{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", course='" + course + '\'' +
                '}';
    }
}