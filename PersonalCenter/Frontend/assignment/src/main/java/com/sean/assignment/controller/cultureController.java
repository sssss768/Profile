package com.sean.assignment.controller;

import com.sean.assignment.pojo.*;
import com.sean.assignment.service.cultureService;
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
@RequestMapping("/cultures")
public class cultureController {
    @Autowired
    private cultureService cultureService;

    @GetMapping
    public Result list(@ModelAttribute Culture culture) {
        log.info("查询文化信息",culture);
        List<Culture> cultureList = cultureService.list(culture.getEmail(),culture.getName());
        return Result.success(cultureList);
    }

    @DeleteMapping
    public Result delete(@ModelAttribute Culture culture) {
        log.info("删除文化");
        cultureService.delete(culture.getEmail(),culture.getName());
        return Result.success();
    }

    @PostMapping
    public Result add(@ModelAttribute Culture culture, @RequestParam("image") MultipartFile image) throws IOException, IOException {
        log.info("新增文化", culture);
        log.info("获取图片{}", image);
        if(cultureService.hasCulture(culture)) {
            return Result.error("已经存在文化");
        }
        if (image.isEmpty()) {
            culture.setImg(null);
        } else {
            String originalFilename = image.getOriginalFilename();
            String path = "C:\\Users\\86178\\IdeaProjects\\webProject\\assignment\\src\\main\\resources\\static\\img\\cultures\\" + originalFilename;
            image.transferTo(new File(path));
            culture.setImg("http://localhost:8080/img/cultures/" + originalFilename);
        }
        cultureService.add(culture);
        return Result.success();
    }

    @PutMapping
    public Result update(@ModelAttribute Culture culture, @RequestParam("image") MultipartFile image) throws IOException {
        log.info("修改文化", culture);
        log.info("获取图片{}", image);
        if (image.isEmpty()) {
           culture.setImg(null);
        } else {
            String originalFilename = image.getOriginalFilename();
            String path = "C:\\Users\\86178\\IdeaProjects\\webProject\\assignment\\src\\main\\resources\\static\\img\\cultures\\" + originalFilename;
            image.transferTo(new File(path));
            culture.setImg("http://localhost:8080/img/cultures/" + originalFilename);
        }
        cultureService.update(culture);
        return Result.success();
    }
}