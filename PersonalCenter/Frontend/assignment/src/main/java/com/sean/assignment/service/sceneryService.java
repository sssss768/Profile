package com.sean.assignment.service;

import com.sean.assignment.pojo.Culture;
import com.sean.assignment.pojo.Food;
import com.sean.assignment.pojo.Scenery;

import java.util.List;

public interface sceneryService {
    void add(Scenery scenery);

    List<Scenery> list(String email,String name);

    void delete(String email, String name);

    void update(Scenery scenery);

    boolean hasScenery(Scenery scenery);
}
