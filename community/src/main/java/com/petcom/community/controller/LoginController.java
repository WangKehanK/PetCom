package com.petcom.community.controller;

import com.google.code.kaptcha.Producer;
import com.petcom.community.entity.LoginTicket;
import com.petcom.community.entity.User;
import com.petcom.community.service.UserService;
import com.petcom.community.util.CommunityConstant;
import com.petcom.community.util.HostHolder;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController implements CommunityConstant {

    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private Producer kaptchaProducer;

    @Autowired
    private HostHolder hostHolder;

    @Value("${server.servlet.context-path}") //community
    private String contextPath;

    @RequestMapping(path = "/api/register", method = RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> registerAPI() {
        Map<String,Object> map = new HashMap<String,Object>();
        map.put(STATUS, ERROR);
        map.put(MESSAGE, "Please send POST request to api/register" );
        return new ResponseEntity<Map<String,Object>>(map , HttpStatus.SEE_OTHER);
    }

    // http://localhost:8080/community/api/register?username=wkh123123&password=123123&email=754113671@qq.com
    @RequestMapping(path = "/api/register", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> registerAPI(User user) {
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
    @RequestMapping(path = "/api/activation/{userId}/{code}", method = RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> activationAPI(Model model, @PathVariable("userId") int userId, @PathVariable("code") String code) {
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
            map.put(STATUS, ERROR);
            map.put(MESSAGE, "Activation failed");
            return new ResponseEntity<Map<String,Object>>(map, HttpStatus.SEE_OTHER);
        }
    }

    /**
     1. send GET request to /api/kaptcha get the verification code, and display the image to the frontend (there will be a cookie set at frondend)
     2. then send request to /api/login with the verification code, username, password, boolean(remember the user)
     3. if wanna to logout, just send out a request to /api/logout
    */
    @RequestMapping(path = "/api/kaptcha", method = RequestMethod.GET)
    @ResponseBody
    public void getKaptchaAPI(HttpServletResponse response, HttpSession session) {
        // generate kaptcha
        String text = kaptchaProducer.createText();
        BufferedImage image = kaptchaProducer.createImage(text);
        // save code into session
        session.setAttribute("kaptcha", text);
        // send image to front end
        response.setContentType("image/png");
        try {
            OutputStream os = response.getOutputStream();
            ImageIO.write(image, "png", os);
        } catch (IOException e) {
            logger.error("Failed" + e.getMessage());
        }
        /**
         * To refresh the kaptcha in js:
         *         function refresh_kaptcha() {
         *             var path = "community/kaptcha?p=" + Math.random();
         *             $("#kaptcha").attr("src", path);
         *         }
         */

    }

    // http://localhost:8080/community/api/login?username=SYSTEM&password=SYSTEM&rememberme=1&code=****
    @RequestMapping(path = "/api/login", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> loginAPI(String username, String password, String code, boolean rememberme, Model model, HttpSession session, HttpServletResponse response){
        String kaptcha = (String) session.getAttribute("kaptcha");
        Map<String,Object> map = new HashMap<String,Object>();
        //check kaptcha code
        if (StringUtils.isBlank(kaptcha) || StringUtils.isBlank(code) || !kaptcha.equalsIgnoreCase(code)) {
            map.put("codeMsg", "kaptcha code is not right");
            return new ResponseEntity<Map<String,Object>>(map, HttpStatus.NOT_ACCEPTABLE);
        }
        // check username, password
        int expiredSeconds = rememberme ? REMEBER_EXPIRED_SECOND : DEFAULT_EXPIRED_SECOND;
        Map<String, Object> res = userService.login(username, password, expiredSeconds);
        if(res.containsKey("ticket")) {
            String ticket = res.get("ticket").toString();
            if (ticket != null) {
                LoginTicket loginTicket = userService.findLoginTicket(ticket);
                Cookie cookie = new Cookie("ticket", ticket);
                cookie.setPath(contextPath);
                cookie.setMaxAge(expiredSeconds);
                response.addCookie(cookie);
                map.put(STATUS, SUCCESS);
                if (loginTicket != null && loginTicket.getStatus() == 0 && loginTicket.getExpired().after(new Date())) {
                    User user = userService.findUserById(loginTicket.getUserId());
                    hostHolder.setUser(user);
                }
            }
            User user = hostHolder.getUser();
            //TODO: parse personal information e.g. username, password
            map.put("user", user);
            return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
        } else {
            map.put(STATUS, FAIL);
            map.put("usernameMsg", res.get("usernameMsg"));
            map.put("passwordMsg", res.get("passwordMsg"));
            return new ResponseEntity<Map<String,Object>>(map, HttpStatus.NOT_ACCEPTABLE);
        }
    }

    @RequestMapping(path = "/api/logout", method = RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> logoutAPI(@CookieValue("ticket") String ticket){
        Map<String,Object> map = new HashMap<String,Object>();
        userService.logout(ticket);
        map.put(STATUS, SUCCESS);
        hostHolder.clear();
        return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
    }


    /******************************************************************************/

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

    @RequestMapping(path = "/kaptcha", method = RequestMethod.GET)
    public void getKaptcha(HttpServletResponse response, HttpSession session) {
        // generate kaptcha
        String text = kaptchaProducer.createText();
        BufferedImage image = kaptchaProducer.createImage(text);

        // save code into session
        session.setAttribute("kaptcha", text);

        // send image to front end
        response.setContentType("image/png");
        try {
            OutputStream os = response.getOutputStream();
            ImageIO.write(image, "png", os);
        } catch (IOException e) {
            logger.error("Failed" + e.getMessage());
        }
    }

    @RequestMapping(path = "/login", method = RequestMethod.POST)
    public String login(String username, String password, String code, boolean rememberme, Model model, HttpSession session, HttpServletResponse response){
        String kaptcha = (String) session.getAttribute("kaptcha");
        //check kaptcha code
        if (StringUtils.isBlank(kaptcha) || StringUtils.isBlank(code) || !kaptcha.equalsIgnoreCase(code)) {
            model.addAttribute("codeMsg", "kaptcha code is not right");
            return "site/login";
        }
        // check username, password
        int expiredSeconds = rememberme ? REMEBER_EXPIRED_SECOND : DEFAULT_EXPIRED_SECOND;
        Map<String, Object> map = userService.login(username, password, expiredSeconds);
        if(map.containsKey("ticket")) {
            Cookie cookie = new Cookie("ticket", map.get("ticket").toString());
            cookie.setPath(contextPath);
            cookie.setMaxAge(expiredSeconds);
            response.addCookie(cookie);
            return "redirect:/index";
        } else {
            model.addAttribute("usernameMsg", map.get("usernameMsg"));
            model.addAttribute("passwordMsg", map.get("passwordMsg"));
            return "/site/login";
        }
    }

    @RequestMapping(path = "/logout", method = RequestMethod.GET)
    public String logout(@CookieValue("ticket") String ticket){
        userService.logout(ticket);
        return "redirect:/login";
    }

}
