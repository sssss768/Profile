package com.sean.assignment.controller;

import com.sean.assignment.pojo.*;
import com.sean.assignment.service.foodService;
import com.sean.assignment.service.userService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/foods")
public class foodController {
    @Autowired
    private foodService foodService;

    @GetMapping
    public Result list(@ModelAttribute Food food) {
        log.info("查询食物信息",food);
        List<Food> foodList = foodService.list(food.getEmail(),food.getName());
        return Result.success(foodList);
    }

    @DeleteMapping
    public Result delete(@ModelAttribute Food food) {
        log.info("删除食物",food.getEmail(),food.getName());
        foodService.delete(food.getEmail(),food.getName());
        return Result.success();
    }

    @PostMapping
    public Result add(@ModelAttribute Food food, @RequestParam("image") MultipartFile image) throws IOException, IOException {
        log.info("新增食物", food);
        log.info("获取图片{}", image);
        if(foodService.hasFood(food)) {
            return Result.error("已经存在食物");
        }
        if (image.isEmpty() || image == null) {
            food.setImg(null);
        } else {
            String originalFilename = image.getOriginalFilename();
            String path = "C:\\Users\\86178\\IdeaProjects\\webProject\\assignment\\src\\main\\resources\\static\\img\\foods\\" + originalFilename;
            image.transferTo(new File(path));
            food.setImg("http://localhost:8080/img/foods/" + originalFilename);
        }
        foodService.add(food);
        return Result.success();
    }

    @PutMapping
    public Result update(@ModelAttribute Food food, @RequestParam("image") MultipartFile image) throws IOException {
        log.info("修改食物", food);
        log.info("获取图片{}", image);
        if (image.isEmpty() || image == null) {
           food.setImg(null);
        } else {
            String originalFilename = image.getOriginalFilename();
            String path = "C:\\Users\\86178\\IdeaProjects\\webProject\\assignment\\src\\main\\resources\\static\\img\\foods\\" + originalFilename;
            image.transferTo(new File(path));
           food.setImg("http://localhost:8080/img/foods/" + originalFilename);
        }
        foodService.update(food);
        return Result.success();
    }
}