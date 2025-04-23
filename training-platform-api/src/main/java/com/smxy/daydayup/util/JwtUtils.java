package com.smxy.daydayup.util;

import com.smxy.daydayup.pojo.User;
import com.smxy.daydayup.pojo.ao.CourseContextAO;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

public class JwtUtils {

    // token过期时间 24h
    public static final long EXPIRE = 1000 * 60 * 60 * 24;

    // 秘钥
    public static final String APP_SECRET = "saseessrtkookppijhfewewsadhuutresxvhjkk";

    public static CourseContextAO getCourseContextAOByToken(HttpServletRequest request) {
        String jwtToken = request.getHeader("authorization");
        if (StringUtils.isEmpty(jwtToken)) {
            return null;
        }
        Jws<Claims> claimsJws;
        try {
            claimsJws = Jwts.parser().setSigningKey(APP_SECRET).parseClaimsJws(jwtToken);
        } catch (Exception e) {
            return null;
        }
        Claims claims = claimsJws.getBody();
        CourseContextAO user = new CourseContextAO();
        user.setUserId(claims.get("ddUserId", String.class));
        user.setCourseId(claims.get("courseId", Integer.class));
        return user;
    }
    /**
     * 根据token字符串获取用户
     */
    public static User getUserInfoByToken(HttpServletRequest request) {
        String jwtToken = request.getHeader("authorization");
        if (StringUtils.isEmpty(jwtToken)) {
            return null;
        }
        Jws<Claims> claimsJws;
        try {
            claimsJws = Jwts.parser().setSigningKey(APP_SECRET).parseClaimsJws(jwtToken);
        } catch (Exception e) {
            return null;
        }
        Claims claims = claimsJws.getBody();
        User user = new User();
        user.setUserId(claims.get("ddUserId", String.class));
        user.setUserName(claims.get("username", String.class));
        return user;
    }

    public static void main(String[] args) {
        User user = new User();
        user.setUserId("nnn");
        user.setUserName("aannaam");
        System.out.println(createDDToken(user));
    }

    // 生成token字符串的方法
    public static String createDDToken(User user) {
        return Jwts.builder().setHeaderParam("typ", "JWT").setHeaderParam("alg", "HS256")

                .setSubject("police-user")
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRE))

                .claim("username", user.getUserName())
                .claim("ddUserId", user.getUserId())
                .signWith(SignatureAlgorithm.HS256, APP_SECRET)
                .compact();
    }
    // 生成token字符串的方法
    public static String createZFToken(User user, Integer courseId, boolean teach) {
        return Jwts.builder().setHeaderParam("typ", "JWT").setHeaderParam("alg", "HS256")

                .setSubject("police-user")
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRE))

                .claim("roleId", teach? 2 : 1)
                .claim("username", user.getUserName())
                .claim("ddUserId", user.getUserId())
                .claim("courseId", courseId)

                .signWith(SignatureAlgorithm.HS256, APP_SECRET)
                .compact();
    }

    /**
     * 判断token是否存在与有效
     */
    public static boolean checkToken(String jwtToken) {
        if (StringUtils.isEmpty(jwtToken)) {
            return false;
        }
        try {
            Jwts.parser().setSigningKey(APP_SECRET).parseClaimsJws(jwtToken);
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    /**
     * 判断token是否存在与有效
     */
    public static boolean checkToken(HttpServletRequest request) {
        String jwtToken = request.getHeader("Authorization");
        if (jwtToken == null || StringUtils.isEmpty(jwtToken)) {
            return false;
        }
        return checkToken(jwtToken);
    }


}