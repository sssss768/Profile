package com.sean.assignment;

import com.sean.assignment.mapper.userMapper;
import com.sean.assignment.pojo.User;
import io.jsonwebtoken.JwtParser;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.crypto.SecretKey;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SpringBootTest
class AssignmentApplicationTests {
    @Autowired
    private userMapper userMapper;

    @Test
    public void testJWTtoken(){
        Map<String,Object> claims = new HashMap<>();
        claims.put("university","CJLU");
        claims.put("Subject","JavaWeb");
        System.out.println(Jwts.builder()
                .signWith(SignatureAlgorithm.HS256,"ComputerScienceAndTechnologywfdwefcweqedwwefcw")
                .claims(claims)
                .expiration(new Date(System.currentTimeMillis() + 600*1000))
                .compact());
    }

//    @Test
//    public void testList(){
//      System.out.println(userMapper.list(null));
//    }
//   @Test
//    public void testDelete(){
//       userMapper.delete("aosid");
//   }

//    @Test
//    public void testInsert(){
//        User user = new User("lasjdhskd","2160459978@qq.com","123123","Sean",1,"none","13867457786","none","none","none","none");
//        userMapper.insert(user);
//        System.out.println(user.getEmail());
//    }

//    @Test
//    public void testUpdate() {
//        User user = new User("Tee", "2160459978@qq.com", "123123", "Sean", 1, "none",
//                "13867457786", "qedqcfqfd", "qwesdxs", "qwewqewe", "none");
//        userMapper.update(user);
//        System.out.println(user.getEmail());
//    }
//
//    @Test
//    public void testQuery(){
//        System.out.println(userMapper.getByEmail("2160459978@qq.com"));
//    }

}
