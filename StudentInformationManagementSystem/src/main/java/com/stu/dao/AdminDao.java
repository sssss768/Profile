package com.stu.dao;

import com.stu.entity.Admin;

import java.util.List;
import java.util.Map;

public interface AdminDao {
    boolean insertAdmin(Admin admin);
    boolean updateAdmin(Admin admin);
    boolean deleteAdminById(int id);
    Admin findAdminById(int id);
    List<Admin> findAllAdmins();
    List<Map<String, Object>> findAllAdminsMap();
    Admin findAdminByUsername(String username);
}