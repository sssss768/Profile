package com.sean.assignment.pojo;

import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
public class UserForm {
    private String name;
    private String email;
    private String pass;
    private String checkPass;
    private String realName;
    private String sex;
    private String fileList;  // 前端文件列表
//    private String phoneNumber;
//    private String company;
//    private Map<String, String> companyAddress;  // ca1, ca2, ca3
//    private List<String> hobby;
//    private String desc;
    public static User mapToUser(UserForm form) {
        User user = new User();
        user.setUserName(form.getName());
        user.setEmail(form.getEmail());
        user.setPassword(form.getPass());
        user.setRealName(form.getRealName());
        user.setGender("male".equalsIgnoreCase(form.getSex()) ? 1 : 0); // 性别转换
//        user.setImg(form.fileList());  图片
//        user.setPhone(form.getPhoneNumber());
//        user.setOffice(form.getCompany());
//        user.setOfficeAdress(
//                String.join(", ", form.getCompanyAddress().values())); // 地址拼接
//        user.setHobby(String.join(", ", form.getHobby())); // 兴趣爱好拼接
//        user.setDesc(form.getDesc());
        return user;
    }
}