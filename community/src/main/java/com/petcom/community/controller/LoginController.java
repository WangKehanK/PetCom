package com.petcom.community.controller;

import com.petcom.community.entity.User;
import com.petcom.community.service.UserService;
import com.petcom.community.util.CommunityConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class LoginController implements CommunityConstant {


    @Autowired
    private UserService userService;

    @RequestMapping(path = "/register", method = RequestMethod.GET)
    public String getRegisterPage() {
        return "/site/register";
    }


    @RequestMapping(path = "/login", method = RequestMethod.GET)
    public String getLoginPage() {
        return "/site/login";
    }

    @RequestMapping(path = "/register", method = RequestMethod.POST)
    public String register(Model model, User user) {
        Map<String, Object> map = userService.register(user);
        if (map == null || map.isEmpty()) {
            model.addAttribute("msg", "register success, we've sent out to an activation email, please activate it soon!");
            model.addAttribute("target", "/index");
            return "/site/operate-result";
        } else {
            model.addAttribute("usernameMsg", map.get("usernameMsg"));
            model.addAttribute("passwordMsg", map.get("passwordMsg"));
            model.addAttribute("emailMsg", map.get("emailMsg"));
            return "/site/register";
        }
    }

    @RequestMapping(path = "/v2/register", method = RequestMethod.POST)
    @ResponseBody
    public String registerV2(User user) {
        Map<String, Object> map = userService.register(user);
        if (map == null || map.isEmpty()) {
            return "register success, we've sent out to an activation email, please activate it soon!";
        } else {
            map.put("usernameMsg", map.get("usernameMsg"));
            map.put("passwordMsg", map.get("passwordMsg"));
            map.put("emailMsg", map.get("emailMsg"));
            return map.get("usernameMsg").toString();
        }
    }

    // http://localhost:8080/community/activation/101/code
    @RequestMapping(path = "/activation/{userId}/{code}", method = RequestMethod.GET)
    public String activation(Model model, @PathVariable("userId") int userId, @PathVariable("code") String code) {
        int result = userService.activation(userId, code);
        if(result == ACTIVATION_SUCCESS) {
            model.addAttribute("msg", "activate success");
            model.addAttribute("target", "/login");
        } else if (result == ACTIVATION_REPEAT){
            model.addAttribute("msg", "This account has been activated");
            model.addAttribute("target", "/index");
        } else{
            model.addAttribute("msg", "Activation failed");
            model.addAttribute("target", "/index");
        }
        return "/site/operate-result";
    }
}
