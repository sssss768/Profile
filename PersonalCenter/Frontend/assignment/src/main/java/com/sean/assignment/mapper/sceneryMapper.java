package com.sean.assignment.mapper;

import com.sean.assignment.pojo.Culture;
import com.sean.assignment.pojo.Food;
import com.sean.assignment.pojo.Scenery;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface sceneryMapper {
    @Insert("INSERT into scenery (name, address, description, img, email) VALUES " +
            "(#{name},#{address},#{description},#{img},#{email})")
    public void insert(Scenery scenery);

    List<Scenery> list(String email,String name);

    @Delete("DELETE from scenery where email=#{email} and name=#{name}")
    void delete(String email, String name);

    void update(Scenery scenery);
    boolean hasScenery(Scenery scenery);
}
