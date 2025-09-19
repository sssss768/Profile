package com.sean.assignment.utils;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import jakarta.annotation.PostConstruct;
import lombok.Data;
import lombok.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.Map;


public class JwtUtils {

    private static String userSecretKey = "afvaSDfvnalkdfsdFvhdasgvkjabnee32";
    private static long userTtl = 7200000;
    private static String userTokenName = "sean";


    public static String createJwt(Map<String, Object> claims) {
        // 生成JWT的时间
        Date exp = new Date(System.currentTimeMillis() + userTtl);
        //生成 HMAC 密钥，根据提供的字节数组长度选择适当的 HMAC 算法，并返回相应的 SecretKey 对象。
        SecretKey key = Keys.hmacShaKeyFor(userSecretKey.getBytes(StandardCharsets.UTF_8));
        // 设置jwt的body
        JwtBuilder builder = Jwts.builder()
                // 设置签名使用的签名算法和签名使用的秘钥
                .signWith(key)
                .claims(claims)
                // 设置过期时间
                .expiration(exp);
        return builder.compact();
    }

    //    解密
    public static Claims parseJWT(String token) {
        //生成 HMAC 密钥，根据提供的字节数组长度选择适当的 HMAC 算法，并返回相应的 SecretKey 对象。
        SecretKey key = Keys.hmacShaKeyFor(userSecretKey.getBytes(StandardCharsets.UTF_8));
        // 得到DefaultJwtParser
        JwtParser jwtParser = Jwts.parser()
                // 设置签名的秘钥
                .verifyWith(key)
                .build();
        Jws<Claims> jws = jwtParser.parseSignedClaims(token);
        Claims claims = jws.getPayload();
        return claims;
    }

}
