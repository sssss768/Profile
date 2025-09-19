package com.sean.assignment.mapper;

import com.sean.assignment.pojo.Food;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface foodMapper {
    @Insert("INSERT into foods(name, material, description, img, email) VALUES " +
            "(#{name},#{material},#{description},#{img},#{email})")
    public void insert(Food food);

    List<Food> list(String email,String name);

    @Delete("DELETE from foods where email=#{email} and name=#{name}")
    void delete(String email, String name);

    void update(Food food);
    boolean hasFood(Food food);
}
