package com.sean.assignment.service;

import com.sean.assignment.pojo.Culture;
import com.sean.assignment.pojo.Food;

import java.util.List;

public interface cultureService {
    void add(Culture culture);

    List<Culture> list(String email,String name);

    void delete(String email, String name);

    void update(Culture culture);

    boolean hasCulture(Culture culture);
}
