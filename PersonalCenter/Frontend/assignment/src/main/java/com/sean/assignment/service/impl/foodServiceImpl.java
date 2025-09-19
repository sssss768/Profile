package com.sean.assignment.service.impl;

import com.sean.assignment.mapper.foodMapper;
import com.sean.assignment.mapper.userMapper;
import com.sean.assignment.pojo.Food;
import com.sean.assignment.service.foodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class foodServiceImpl implements foodService {

    @Autowired
    private foodMapper foodMapper;

    @Override
    public void add(Food food) {
        foodMapper.insert(food);
    }

    @Override
    public List<Food> list(String email,String name) {
      return foodMapper.list(email,name);
    }

    @Override
    public void delete(String email, String name) {
        foodMapper.delete(email,name);
    }

    @Override
    public void update(Food food) {
        foodMapper.update(food);
    }

    @Override
    public boolean hasFood(Food food) {
        return foodMapper.hasFood(food);
    }
}
