package com.sean.assignment.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private String userName;
    private String email;
    private String password;
    private String realName;
    private Integer gender;
    private String img;
    private String phone;
    private String office;
    private String officeAdress;
    private String desc;
//    美食，景点，文化三张表
}
