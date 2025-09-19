package com.sean.assignment.controller;

import com.sean.assignment.pojo.PageBean;
import com.sean.assignment.pojo.Result;
import com.sean.assignment.pojo.User;
import com.sean.assignment.pojo.UserForm;
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
@RequestMapping("/users")
public class userController {


    @Autowired
    private userService userService;

    @GetMapping("/all")
    public Result list() {
        log.info("查询总用户信息");
        List<User> userList = userService.list();
        return Result.success(userList);
    }

    @GetMapping
    public Result page(@RequestParam(defaultValue = "1") Integer page,
                       @RequestParam(defaultValue = "5") Integer pageSize,
                       String email) {
        log.info("分页查询,{}", email);
        PageBean pageBean = userService.page(page, pageSize, email);
        return Result.success(pageBean);
    }

    @DeleteMapping("/{ids}")
    public Result delete(@PathVariable List<String> ids) {
        log.info("删除用户");
        userService.delete(ids);
        return Result.success();
    }

    @PutMapping
    public Result update(@ModelAttribute User user, @RequestParam("image") MultipartFile image) throws IOException {
        log.info("修改用户", user);
        log.info("获取文件{}", image);
        if (image.isEmpty()) {
            user.setImg(null);
        } else {
            String originalFilename = image.getOriginalFilename();
            String path = "C:\\Users\\86178\\IdeaProjects\\webProject\\assignment\\src\\main\\resources\\static\\img\\users\\" + originalFilename;
            image.transferTo(new File(path));
            user.setImg("http://localhost:8080/img/users/" + originalFilename);
        }
        userService.update(user);
        return Result.success();
    }

    @GetMapping("/{name}")
    public Result query(@PathVariable String name) {
        log.info("获取用户信息");
        User user = userService.query(name);
        return Result.success(user);
    }


}
