package com.stu.service.impl;

import com.stu.dao.AdminDao;
import com.stu.dao.impl.AdminDaoImpl;
import com.stu.entity.Admin;
import com.stu.service.AdminService;

import java.util.List;
import java.util.Map;

public class AdminServiceImpl implements AdminService {
    private AdminDao adminDao = new AdminDaoImpl();

    @Override
    public boolean insertAdmin(Admin admin) {
        return adminDao.insertAdmin(admin);
    }

    @Override
    public boolean updateAdmin(Admin admin) {
        return adminDao.updateAdmin(admin);
    }

    @Override
    public boolean deleteAdminById(int id) {
        return adminDao.deleteAdminById(id);
    }

    @Override
    public Admin findAdminById(int id) {
        return adminDao.findAdminById(id);
    }

    @Override
    public List<Admin> findAllAdmins() {
        return adminDao.findAllAdmins();
    }

    @Override
    public List<Map<String, Object>> findAllAdminsMap() {
        return adminDao.findAllAdminsMap();
    }

    @Override
    public Admin findAdminByUsername(String username) {
        return adminDao.findAdminByUsername(username);
    }
}