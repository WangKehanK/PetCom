package com.petcom.community.controller;

import com.petcom.community.entity.User;
import com.petcom.community.service.UserService;
import com.petcom.community.util.CommunityConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController implements CommunityConstant {


    @Autowired
    private UserService userService;

    @RequestMapping(path = "api/register", method = RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> getRegister() {
        Map<String,Object> map = new HashMap<String,Object>();
        map.put(STATUS, ERROR);
        map.put(MESSAGE, "Please send POST request to api/register" );
        return new ResponseEntity<Map<String,Object>>(map , HttpStatus.SEE_OTHER);
    }

    // http://localhost:8080/community/api/register?username=wkh123123&password=123123&email=754113671@qq.com
    @RequestMapping(path = "/api/register", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> registerV2(User user) {
        Map<String, Object> map = userService.register(user);
        Map<String,Object> res = new HashMap<String,Object>();

        if (map == null || map.isEmpty()) {
            res.put(STATUS, SUCCESS);
            res.put(MESSAGE, "register success, we've sent out to an activation email, please activate it soon!");
            return new ResponseEntity<Map<String,Object>>(res, HttpStatus.OK);
        } else {
            map.put(STATUS, ERROR);
            map.put("usernameMsg", map.get("usernameMsg"));
            map.put("passwordMsg", map.get("passwordMsg"));
            map.put("emailMsg", map.get("emailMsg"));
            return new ResponseEntity<Map<String,Object>>(map, HttpStatus.NOT_ACCEPTABLE);
        }
    }

    // http://localhost:8080/community/activation/101/code
    @RequestMapping(path = "api/activation/{userId}/{code}", method = RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> GetActivation(Model model, @PathVariable("userId") int userId, @PathVariable("code") String code) {
        int result = userService.activation(userId, code);
        Map<String,Object> map = new HashMap<String,Object>();
        if(result == ACTIVATION_SUCCESS) {
            map.put(STATUS, SUCCESS);
            map.put(MESSAGE, "activate success");
            return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
        } else if (result == ACTIVATION_REPEAT){
            map.put(STATUS, ERROR);
            map.put(MESSAGE, "This account has been activated");
            return new ResponseEntity<Map<String,Object>>(map, HttpStatus.NOT_ACCEPTABLE);
        } else{
            map.put(STATUS, FAIL);
            map.put(MESSAGE, "Activation failed");
            return new ResponseEntity<Map<String,Object>>(map, HttpStatus.SEE_OTHER);
        }
    }

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
