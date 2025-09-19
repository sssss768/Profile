package com.sean.assignment.mapper;

import com.sean.assignment.pojo.Culture;
import com.sean.assignment.pojo.Food;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface cultureMapper {
    @Insert("INSERT into cultures (name, address, description, img, email) VALUES " +
            "(#{name},#{address},#{description},#{img},#{email})")
    public void insert(Culture culture);

    List<Culture> list(String email,String name);

    @Delete("DELETE from cultures where email=#{email} and name=#{name}")
    void delete(String email, String name);

    void update(Culture culture);
    boolean hasCulture(Culture culture);
}
