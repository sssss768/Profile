//package com.sean.assignment.filter;
//
//import ch.qos.logback.core.util.StringUtil;
//import com.alibaba.fastjson.JSONObject;
//import com.sean.assignment.pojo.Result;
//import com.sean.assignment.utils.JwtUtils;
//import jakarta.servlet.*;
//import jakarta.servlet.annotation.WebFilter;
//import jakarta.servlet.http.HttpServletRequest;
//import lombok.extern.slf4j.Slf4j;
//import org.apache.coyote.Request;
//import org.springframework.util.StringUtils;
//
//import java.io.IOException;
//
//@Slf4j
//@WebFilter(urlPatterns = "/*")
//public class userFilter implements Filter {
//    @Override
//    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
//        HttpServletRequest req = (HttpServletRequest) servletRequest;
//
//        String url = req.getRequestURL().toString();
////        登陆放行
//        log.info("url:{}", url);
//        if (url.contains("login")) {
//            log.info("登录");
//            filterChain.doFilter(servletRequest, servletResponse);
//            return;
//        }
////        令牌检测
//        String jwt = req.getHeader("token");
//        if(!StringUtils.hasLength(jwt)){
//            log.info("未登录");
//            servletResponse.getWriter().write(JSONObject.toJSONString(Result.error("Not Login")));
//            return;
//        }
////        令牌校验
//        try {
//            JwtUtils.parseJWT(jwt);
//        } catch (Exception e) {
//            e.printStackTrace();
//            log.info("令牌不通过");
//            servletResponse.getWriter().write(JSONObject.toJSONString(Result.error("Not Login")));
//            return;
//        }
//        log.info("放行");
//        filterChain.doFilter(servletRequest,servletResponse);
//    }
//}
