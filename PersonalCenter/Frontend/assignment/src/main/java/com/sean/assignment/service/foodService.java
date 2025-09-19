package com.sean.assignment.service;

import com.sean.assignment.pojo.Food;

import java.util.List;

public interface foodService {
    void add(Food food);

    List<Food> list(String email,String name);

    void delete(String email, String name);

    void update(Food food);

    boolean hasFood(Food food);
}
