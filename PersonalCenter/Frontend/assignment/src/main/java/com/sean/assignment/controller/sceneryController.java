package com.sean.assignment.controller;

import com.sean.assignment.pojo.*;
import com.sean.assignment.service.cultureService;
import com.sean.assignment.service.foodService;
import com.sean.assignment.service.sceneryService;
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
@RequestMapping("/scenery")
public class sceneryController {
    @Autowired
    private sceneryService sceneryService;

    @GetMapping
    public Result list(@ModelAttribute Scenery scenery) {
        log.info("查询景点信息",scenery);
        List<Scenery> sceneryList = sceneryService.list(scenery.getEmail(),scenery.getName());
        return Result.success(sceneryList);
    }

    @DeleteMapping
    public Result delete(@ModelAttribute Scenery scenery) {
        log.info("删除景点");
        sceneryService.delete(scenery.getEmail(),scenery.getName());
        return Result.success();
    }

    @PostMapping
    public Result add(@ModelAttribute Scenery scenery, @RequestParam("image") MultipartFile image) throws IOException, IOException {
        log.info("新增文化", scenery);
        log.info("获取图片{}", image);
        if(sceneryService.hasScenery(scenery)) {
            return Result.error("已经存在景点");
        }
        if (image.isEmpty()) {
           scenery.setImg(null);
        } else {
            String originalFilename = image.getOriginalFilename();
            String path = "C:\\Users\\86178\\IdeaProjects\\webProject\\assignment\\src\\main\\resources\\static\\img\\scenery\\" + originalFilename;
            image.transferTo(new File(path));
            scenery.setImg("http://localhost:8080/img/scenery/" + originalFilename);
        }
       sceneryService.add(scenery);
        return Result.success();
    }

    @PutMapping
    public Result update(@ModelAttribute Scenery scenery, @RequestParam("image") MultipartFile image) throws IOException {
        log.info("修改文化", scenery);
        log.info("获取图片{}", image);
        if (image.isEmpty()) {
           scenery.setImg(null);
        } else {
            String originalFilename = image.getOriginalFilename();
            String path = "C:\\Users\\86178\\IdeaProjects\\webProject\\assignment\\src\\main\\resources\\static\\img\\scenery\\" + originalFilename;
            image.transferTo(new File(path));
            scenery.setImg("http://localhost:8080/img/scenery/" + originalFilename);
        }
       sceneryService.update(scenery);
        return Result.success();
    }
}