package com.stu.utils;

import com.stu.entity.Student;

public class UserThreadLocalUtil {

    private static final ThreadLocal<Student> userThreadLocal = new ThreadLocal<>();

    public static void set(Student user) {
        userThreadLocal.set(user);
    }

    public static Student get() {
        return userThreadLocal.get();
    }

    public static void remove() {
        userThreadLocal.remove();
    }
}