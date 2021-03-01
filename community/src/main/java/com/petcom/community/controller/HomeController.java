package com.petcom.community.controller;

import com.petcom.community.entity.DiscussPost;
import com.petcom.community.entity.Page;
import com.petcom.community.entity.User;
import com.petcom.community.service.DiscussPostService;
import com.petcom.community.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class HomeController {

    @Autowired
    private DiscussPostService discussPostService;

    @Autowired
    private UserService userService;

    /**
     * This is a basic getArticle function
     * @param model
     * @param page
     * @return
     */
    public List getIndexPageBasic(Model model, Page page) {
        page.setRows(discussPostService.findDiscussPostRows(0));
        page.setPath("/index");

        List<DiscussPost> list = discussPostService.findDiscussPosts(0, page.getOffset(), page.getLimit());
        List<Map<String, Object>> discussPosts = new ArrayList<>();
        if (list != null) {
            for (DiscussPost post : list) {
                Map<String, Object> map = new HashMap<>();
                map.put("post", post);
                User user = userService.findUserById(post.getUserId());
                map.put("user", user);
                discussPosts.add(map);
            }
        }
        model.addAttribute("discussPosts", discussPosts);
        return discussPosts;
    }

    /**
     * For SringMVC - visualization
     * @index http://localhost:8080/community/index?current=1
     * @index http://localhost:8080/community/index?current=2
     */
    @RequestMapping(path = "/index", method = RequestMethod.GET)
    public List getIndexPage(Model model, Page page) {
        return getIndexPageBasic(model, page);
    }

    /**
     * For Flutter
     * @api http://localhost:8080/community/articles?current=1
     * @api http://localhost:8080/community/articles?current=2
     */
    @RequestMapping(path = "/articles", method = RequestMethod.GET)
    @ResponseBody
    public List getArticles(Model model, Page page) {
        return getIndexPageBasic(model, page);
    }

    /****************************************************************/


}
