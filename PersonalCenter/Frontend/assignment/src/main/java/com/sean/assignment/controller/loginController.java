package com.sean.assignment.controller;


import com.sean.assignment.pojo.Result;
import com.sean.assignment.pojo.User;
import com.sean.assignment.pojo.UserForm;
import com.sean.assignment.service.userService;
import com.sean.assignment.utils.JwtUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/login")
public class loginController {
    @Autowired
    private userService userService;

    @PostMapping
    public Result login(@RequestBody User user) {
        log.info("用户登录");
        User u = userService.login(user);
        if (u != null) {
            Map<String, Object> claims = new HashMap<>();
            claims.put("userName", u.getUserName());
            claims.put("email", u.getEmail());
            String token = JwtUtils.createJwt(claims);
            return Result.success(token);
        }
        return Result.error("用户名或密码错误");
    }

//    @PostMapping("/register")
//    public Result add(@RequestBody UserForm form) {
//        log.info("新增用户");
//        log.info("接受信息：{}",form);
//        User user = UserForm.mapToUser(form);
//        userService.add(user);
//        return Result.success(user);
//    }

    @PostMapping("/register")
    public Result add(@ModelAttribute UserForm userForm, @RequestParam("img") MultipartFile img) throws IOException, IOException {
        // 处理非文件表单数据
        log.info("新增用户");
        log.info("接受信息：{}", userForm);
        User user = UserForm.mapToUser(userForm);

        log.info("获取文件{}", img);
        String originalFilename = img.getOriginalFilename();
        String path = "C:\\Users\\86178\\IdeaProjects\\webProject\\assignment\\src\\main\\resources\\static\\img\\users\\" + originalFilename;
        img.transferTo(new File(path));
        user.setImg("http://localhost:8080/img/users/" + originalFilename);

        userService.add(user);
        return Result.success(user);
    }
}
