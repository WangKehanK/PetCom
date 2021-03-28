package com.petcom.community.controller;

import com.petcom.community.entity.Breeder;
import com.petcom.community.entity.DiscussPost;
import com.petcom.community.entity.Page;
import com.petcom.community.entity.User;
import com.petcom.community.service.BreederService;
import com.petcom.community.service.DiscussPostService;
import com.petcom.community.service.UserService;
import com.petcom.community.util.CommunityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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

    @Autowired
    private BreederService breederService;


    /**
     * For SringMVC - visualization
     * @index http://localhost:8080/community/index?current=1
     * @index http://localhost:8080/community/index?current=2
     */
    @RequestMapping(path = "/index", method = RequestMethod.GET)
    public String getIndexPage(Model model, Page page) {
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
        return "/index";
    }

    /**
     * For Flutter
     * @api http://localhost:8080/community/index?current=1
     * @api http://localhost:8080/community/index?current=2
     */
    @RequestMapping(path = "/api/article/all", method = RequestMethod.GET)
    @ResponseBody
    public String articlesAPI(Page page) {
        page.setRows(discussPostService.findDiscussPostRows(0));
        page.setPath("/article");
        List<DiscussPost> list = discussPostService.findDiscussPosts(0, page.getOffset(), page.getLimit());
//        List<Map<String, Object>> discussPosts = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        if (list != null) {
            map.put("total", page.getRows());
            map.put("total_page", page.getTotal());
            map.put("current_page", page.getCurrent());
            map.put("post", list);
//            for (DiscussPost post : list) {
//                map.put("post", post);
//                User user = userService.findUserById(post.getUserId());
//                map.put("user", user);
//                discussPosts.add(map);
//            }
        }
//        return discussPosts;
        return CommunityUtil.getJSONString(200, "success", map);
    }

    @RequestMapping(path = "/api/article/feature", method = RequestMethod.GET)
    @ResponseBody
    public String featuredarticleAPI(){
        List<DiscussPost> list = discussPostService.findFeaturedPosts();
        Map<String, Object> map = new HashMap<>();
        if (list!= null){
            map.put("total_page", 1);
            map.put("current_page", 1);
            map.put("post", list);
        }
        return CommunityUtil.getJSONString(200, "success", map);
    }

    @RequestMapping(path = "/api/article", params = {"id"}, method = RequestMethod.GET)
    @ResponseBody
    public String findPostByID(@RequestParam(value = "id") int id){
        DiscussPost discussPost = discussPostService.findPostById(id);
        Map<String, Object> map = new HashMap<>();
        if(discussPost != null) {
            map.put("total_page", 1);
            map.put("current_page", 1);
            map.put("post", discussPost);
        }
        return CommunityUtil.getJSONString(200, "success", map);
    }

    @RequestMapping(path = "/api/breeder/all", method = RequestMethod.GET)
    @ResponseBody
    public String breederAPI(Page page) {
        int rows = breederService.findBreederRows(0);
        page.setRows(rows);
        page.setPath("/breeder");

        List<Breeder> list = breederService.findBreeders(0, page.getOffset(), page.getLimit());
        Map<String, Object> map = new HashMap<>();
        if (page.getCurrent() > page.getTotal()){
            return CommunityUtil.getJSONString(204, "exceeded the total number of page");
        }
        if (list != null) {
            map.put("total", page.getRows());
            map.put("total_page", page.getTotal());
            map.put("current_page", page.getCurrent());
            map.put("breeder", list);
        }
        return CommunityUtil.getJSONString(200, "success", map);
    }

    @RequestMapping(path = "/api/breeder/feature", method = RequestMethod.GET)
    @ResponseBody
    public String fearturedBreeder() {
        List<Breeder> list = breederService.findFeaturedBreeder();
        Map<String, Object> map = new HashMap<>();
        if (list!= null){
            map.put("total_page", 1);
            map.put("current_page", 1);
            map.put("breeder", list);
        }
        return CommunityUtil.getJSONString(200, "success", map);
    }
    /****************************************************************/


}

