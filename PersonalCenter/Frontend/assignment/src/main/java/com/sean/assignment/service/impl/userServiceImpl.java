package com.sean.assignment.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sean.assignment.mapper.userMapper;
import com.sean.assignment.pojo.PageBean;
import com.sean.assignment.pojo.User;
import com.sean.assignment.service.userService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class userServiceImpl implements userService {

    @Autowired
    private userMapper userMapper;

    @Override
    public List<User> list() {
        return userMapper.list(null);
    }

    @Override
    public void delete(List<String> ids) {
        userMapper.delete(ids);
    }

    @Override
    public void add(User user) {
        userMapper.insert(user);
    }

    @Override
    public void update(User user) {
        userMapper.update(user);
    }

    @Override
    public PageBean page(Integer page, Integer pageSize, String email) {
        PageHelper.startPage(page, pageSize);
        Page<User> p = (Page<User>) userMapper.list(email);
        PageBean pageBean = new PageBean(p.getTotal(), p.getResult());
        return pageBean;
    }

    @Override
    public User query(String name) {
        return userMapper.getByName(name);
    }

    @Override
    public User login(User user) {
        return userMapper.getByEmail(user);
    }
}
