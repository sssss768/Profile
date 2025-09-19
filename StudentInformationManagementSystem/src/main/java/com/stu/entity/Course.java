package com.stu.entity;

public class Course {
    private int id;
    private String course;
    private String teacher;
    private int credit;
    private String term;

    public Course() {
    }

    public Course(int id, String course, String teacher, int credit, String term) {
        this.id = id;
        this.course = course;
        this.teacher = teacher;
        this.credit = credit;
        this.term = term;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getTeacher() {
        return teacher;
    }

    public void setTeacher(String teacher) {
        this.teacher = teacher;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    @Override
    public String toString() {
        return "Course{" +
                "id=" + id +
                ", course='" + course + '\'' +
                ", teacher='" + teacher + '\'' +
                ", credit=" + credit +
                ", term='" + term + '\'' +
                '}';
    }
}