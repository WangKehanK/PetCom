package com.petcom.community.service;

import com.petcom.community.dao.LoginTicketMapper;
import com.petcom.community.dao.UserMapper;
import com.petcom.community.entity.LoginTicket;
import com.petcom.community.entity.User;
import com.petcom.community.util.CommunityConstant;
import com.petcom.community.util.CommunityUtil;
import com.petcom.community.util.MailClient;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Service
public class UserService implements CommunityConstant {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private LoginTicketMapper loginTicketMapper;

    @Autowired
    private MailClient mailClient;

    @Autowired
    private TemplateEngine templateEngine;

    @Value("${community.path.domain}") //localhost:8080
    private String domain;

    @Value("${server.servlet.context-path}") //community
    private String contextPath;

    public User findUserById(int id){
        return userMapper.selectById(id);
    }

    public Map<String, Object> register(User user) {
        Map<String, Object> map = new HashMap<>();
        // null
        if(user == null) {
            throw new IllegalArgumentException("Input can not be null");
        }
        if(StringUtils.isBlank(user.getUsername())) {
            map.put("usernameMsg", "username can not be null");
            return map;
        }
        if(StringUtils.isBlank(user.getPassword())) {
            map.put("passwordMsg", "password can not be null");
            return map;
        }
        if(StringUtils.isBlank(user.getEmail())) {
            map.put("emailMsg", "email can not be null");
            return map;
        }

        // verify username
        User u = userMapper.selectByName(user.getUsername());
        if(u != null) {
            map.put("usernameMsg", "This account has been registered");
            return map;
        }

        // verify email
        u = userMapper.selectByEmail(user.getEmail());
        if(u !=null) {
            map.put("emailMsg", "This email has been registered");
            return map;
        }

        // register main logic
        user.setSalt(CommunityUtil.generateUUID().substring(0, 5));
        user.setPassword(CommunityUtil.md5(user.getPassword() + user.getSalt()));
        user.setType(0);
        user.setStatus(0);
        user.setActivationCode(CommunityUtil.generateUUID());
        user.setHeaderUrl(String.format("https://images.nowcoder.com/head/%dt.png", new Random().nextInt(1000)));
        user.setCreateTime(new Date());
        userMapper.insertUser(user); // userId will be created by MyBatis; mybatis.configuration.useGeneratedKeys=true

        // send out activation email
        Context context = new Context();
        context.setVariable("email", user.getEmail());
        // http://localhost:8080/community/activation/101/code
        // This url is used for SpringMVC
        // String url = domain + contextPath + "/api/activation/" + user.getId() + "/" + user.getActivationCode();
        String url = domain + contextPath + "/api/activation/" + user.getId() + "/" + user.getActivationCode();
        context.setVariable("url", url);
        String content = templateEngine.process("/mail/activation", context);
        mailClient.sendMail(user.getEmail(), "Account Activation", content);

        return map;
    }

    public int activation(int userId, String code){
        User user = userMapper.selectById(userId);
        if(user.getStatus() == 1) {
            return ACTIVATION_REPEAT;
        } else if (user.getActivationCode().equals(code)) {
            userMapper.updateStatus(userId, 1);
            return ACTIVATION_SUCCESS;
        } else {
            return ACTIVATION_FAILURE;
        }
    }

    public Map<String, Object> login(String username, String password, int expiredSecond){
        Map<String, Object> map = new HashMap<>();
        // null
        if(StringUtils.isBlank(username)){
            map.put("usernameMsg", "username cannot be null!");
            return map;
        }
        if(StringUtils.isBlank(password)){
            map.put("passwordMsg", "password cannot be null!");
            return map;
        }

        // verify username
        User user = userMapper.selectByName(username);
        if(user == null) {
            map.put("usernameMsg", "This username didn't exist");
        }
        // verify status
        if(user.getStatus() == 0){
            map.put("usernameMsg", "please activate your account first");
        }

        password = CommunityUtil.md5(password + user.getSalt());

        if(!user.getPassword().equals(password)) {
            map.put("password", "password is not correct");
        }

        // generate login token

        LoginTicket loginTicket = new LoginTicket();
        loginTicket.setUserId(user.getId());
        loginTicket.setTicket(CommunityUtil.generateUUID());
        loginTicket.setStatus(0);
        loginTicket.setExpired(new Date(System.currentTimeMillis() + expiredSecond * 1000));
        loginTicketMapper.insertLoginTicket(loginTicket);

        map.put("ticket", loginTicket.getTicket());
        return map;
    }

    public void logout(String ticket){
        loginTicketMapper.updateStatus(ticket, 1); // 1 not active
    }

    public LoginTicket findLoginTicket(String ticket) {
        return loginTicketMapper.selectByTicket(ticket);
    }

}
