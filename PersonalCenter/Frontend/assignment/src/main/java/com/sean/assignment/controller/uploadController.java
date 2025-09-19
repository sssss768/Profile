package com.sean.assignment.controller;

import com.sean.assignment.pojo.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

@Slf4j
@RestController
public class uploadController {

    @PostMapping("/upload")
    public Result upload(MultipartFile img) throws IOException {
        log.info("获取文件{}", img);
        String originalFilename = img.getOriginalFilename();
        String path = "C:\\Users\\86178\\IdeaProjects\\webProject\\assignment\\src\\main\\resources\\static\\img\\users\\" + originalFilename;
        img.transferTo(new File(path));
        return Result.success(path);
    }
}
