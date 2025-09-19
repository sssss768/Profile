package com.sean.assignment.mapper;

import com.sean.assignment.pojo.User;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface userMapper {
    //    @Select("Select * from user")
//    public List<User> list();

    //    条件查询
    public List<User> list(String email);

//    分页查询
//    @Select("select * from user limit #{Start},#{pageSize}")
//    public List<User> page(Integer Start, Integer pageSize);

    //    批量删除
//    @Delete("Delete from user where  userName = #{userName}")
    public void delete(List<String> ids);

    @Options(useGeneratedKeys = true, keyProperty = "email")
    @Insert("INSERT into user(userName, email, password, realName, gender, img, phone, office, officeAdress, `desc`) " +
            "values (#{userName},#{email},#{password},#{realName},#{gender},#{img},#{phone},#{office},#{officeAdress},#{desc})")
    public void insert(User user);

    @Options(useGeneratedKeys = true, keyProperty = "email")
//    @Update("update user set userName = #{userName},email=#{email},password=#{password},realName=#{realName},gender=#{gender}," +
//            "<if test='img != null'>img = #{img},</if> ,phone=#{phone},office=#{office},officeAdress=#{officeAdress},`desc`=#{desc} where email = #{email} ")
    public void update(User user);

    //根据email查询用户
    @Select("Select * from user where email = #{email} and password = #{password}")
    public User getByEmail(User user);


    @Select("Select * from user where userName = #{name}")
    public User getByName(String name);


//     查询总数
//    @Select("select count(*) from user")
//    public Long count();


}
