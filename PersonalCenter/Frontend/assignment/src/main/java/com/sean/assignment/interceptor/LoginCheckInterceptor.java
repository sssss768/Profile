package com.sean.assignment.interceptor;

import com.alibaba.fastjson.JSONObject;
import com.sean.assignment.pojo.Result;
import com.sean.assignment.utils.JwtUtils;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;

@Slf4j
@Component
public class LoginCheckInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String url = request.getRequestURL().toString();

//        登陆放行
        log.info("url:{}", url);
        if (url.toLowerCase().contains("login")) {
            log.info("登录");
            return true;
        }
        String jwt = request.getHeader("token");
        if (!StringUtils.hasLength(jwt)) {
            log.info("未登录");
            response.getWriter().write(JSONObject.toJSONString(Result.error("Not Login")));
            return false;
        }
//        令牌校验
        try {
            JwtUtils.parseJWT(jwt);
        } catch (Exception e) {
            e.printStackTrace();
            log.info("令牌不通过");
            response.getWriter().write(JSONObject.toJSONString(Result.error("Error Login")));
            return false;
        }
        log.info("放行");
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
    }
}
