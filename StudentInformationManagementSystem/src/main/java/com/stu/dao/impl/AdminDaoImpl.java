package com.stu.dao.impl;

import com.stu.dao.AdminDao;
import com.stu.entity.Admin;
import com.stu.utils.JdbcUtils;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminDaoImpl implements AdminDao {
    private JdbcUtils jdbcUtils;
    public AdminDaoImpl(){
         jdbcUtils= new JdbcUtils();
         jdbcUtils.getConnection();
    }

    @Override
    public boolean insertAdmin(Admin admin) {
        String sql = "INSERT INTO admin (username, password, name, phone) VALUES (?,?,?,?)";
        List<Object> params = new ArrayList<>();
        params.add(admin.getUsername());
        params.add(admin.getPassword());
        params.add(admin.getName());
        params.add(admin.getPhone());
        try {
            return jdbcUtils.updateByPreparedStatement(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateAdmin(Admin admin) {
        String sql = "UPDATE admin SET username =?, password =?, name =?, phone =? WHERE id =?";
        List<Object> params = new ArrayList<>();
        params.add(admin.getUsername());
        params.add(admin.getPassword());
        params.add(admin.getName());
        params.add(admin.getPhone());
        params.add(admin.getId());
        try {
            return jdbcUtils.updateByPreparedStatement(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteAdminById(int id) {
        String sql = "DELETE FROM admin WHERE id =?";
        List<Object> params = new ArrayList<>();
        params.add(id);
        try {
            return jdbcUtils.updateByPreparedStatement(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Admin findAdminById(int id) {
        String sql = "SELECT * FROM admin WHERE id =?";
        List<Object> params = new ArrayList<>();
        params.add(id);
        try {
            return jdbcUtils.findSimpleRefResult(sql, params, Admin.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Admin> findAllAdmins() {
        String sql = "SELECT * FROM admin";
        try {
            return jdbcUtils.findMoreRefResult(sql, null, Admin.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Map<String, Object>> findAllAdminsMap() {
        String sql = "SELECT * FROM admin";
        try {
            return jdbcUtils.findModeResult(sql, null);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Admin findAdminByUsername(String username) {
        String sql = "SELECT * FROM admin WHERE username = ?";
        List<Object> params = new ArrayList<>();
        params.add(username);
        try {
            return jdbcUtils.findSimpleRefResult(sql, params, Admin.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}