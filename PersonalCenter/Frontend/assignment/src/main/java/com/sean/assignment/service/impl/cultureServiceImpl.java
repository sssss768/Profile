package com.sean.assignment.service.impl;

import com.sean.assignment.mapper.cultureMapper;
import com.sean.assignment.mapper.foodMapper;
import com.sean.assignment.mapper.userMapper;
import com.sean.assignment.pojo.Culture;
import com.sean.assignment.pojo.Food;
import com.sean.assignment.service.cultureService;
import com.sean.assignment.service.foodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class cultureServiceImpl implements cultureService {

    @Autowired
    private cultureMapper cultureMapper;

    @Override
    public void add(Culture culture) {
       cultureMapper.insert(culture);
    }

    @Override
    public List<Culture> list(String email, String name) {
        return cultureMapper.list(email, name);
    }

    @Override
    public void delete(String email, String name) {
        cultureMapper.delete(email, name);
    }

    @Override
    public void update(Culture culture) {
        cultureMapper.update(culture);
    }

    @Override
    public boolean hasCulture(Culture culture) {
        return cultureMapper.hasCulture(culture);
    }
}
