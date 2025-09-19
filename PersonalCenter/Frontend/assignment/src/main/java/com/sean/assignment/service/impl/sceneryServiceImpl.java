package com.sean.assignment.service.impl;

import com.sean.assignment.mapper.sceneryMapper;
import com.sean.assignment.pojo.Scenery;
import com.sean.assignment.service.sceneryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class sceneryServiceImpl implements sceneryService {

    @Autowired
    private sceneryMapper sceneryMapper;

    @Override
    public void add(Scenery scenery) {
        sceneryMapper.insert(scenery);
    }

    @Override
    public List<Scenery> list(String email, String name) {
        return sceneryMapper.list(email, name);
    }

    @Override
    public void delete(String email, String name) {
        sceneryMapper.delete(email, name);
    }

    @Override
    public void update(Scenery scenery) {
        sceneryMapper.update(scenery);
    }

    @Override
    public boolean hasScenery(Scenery scenery) {
        return sceneryMapper.hasScenery(scenery);
    }
}
