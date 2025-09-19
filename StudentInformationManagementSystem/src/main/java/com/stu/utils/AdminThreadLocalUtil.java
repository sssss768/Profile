package com.stu.utils;

import com.stu.entity.Admin;

public class AdminThreadLocalUtil {

    private static final ThreadLocal<Admin> adminThreadLocal = new ThreadLocal<>();

    public static void set(Admin admin) {
        adminThreadLocal.set(admin);
    }

    public static Admin get() {
        return adminThreadLocal.get();
    }

    public static void remove() {
        adminThreadLocal.remove();
    }
}