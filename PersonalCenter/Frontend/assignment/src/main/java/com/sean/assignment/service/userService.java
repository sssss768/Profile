package com.sean.assignment.service;

import com.sean.assignment.pojo.PageBean;
import com.sean.assignment.pojo.User;

import java.util.List;

public interface userService {

    // 查询所有用户信息
    List<User> list();

    //删除用户
    void delete(List<String> id);

    void add(User user);

    void update(User user);

    PageBean page(Integer page, Integer pageSize, String email);

    User query(String name);

    User login(User user);


}
