package com.petcom.community.controller;


import com.petcom.community.entity.DiscussPost;
import com.petcom.community.entity.Page;
import com.petcom.community.entity.User;
import com.petcom.community.service.DiscussPostService;
import com.petcom.community.util.CommunityUtil;
import com.petcom.community.util.HostHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Controller
@RequestMapping("/api/article")
public class DiscussPostController {

    @Autowired
    DiscussPostService discussPostService;

    /**
     * For Flutter
     * @api http://localhost:8080/community/index?current=1
     * @api http://localhost:8080/community/index?current=2
     */
    @RequestMapping(path = "/all", method = RequestMethod.GET)
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

    @RequestMapping(path = "/feature", method = RequestMethod.GET)
    @ResponseBody
    public String featuredarticleAPI(){
        List<DiscussPost> list = discussPostService.findFeaturedPosts();
        Map<String, Object> map = new HashMap<>();
        if (list!= null){
            map.put("total", 1);
            map.put("total_page", 1);
            map.put("current_page", 1);
            map.put("post", list);
        }
        return CommunityUtil.getJSONString(200, "success", map);
    }

    @RequestMapping(params = {"id"}, method = RequestMethod.GET)
    @ResponseBody
    public String findPostByID(@RequestParam(value = "id") int id){
        List<DiscussPost> discussPost = discussPostService.findPostById(id);
        Map<String, Object> map = new HashMap<>();
        if(discussPost != null) {
            map.put("total", 1);
            map.put("total_page", 1);
            map.put("current_page", 1);
            map.put("post", discussPost);
        }
        return CommunityUtil.getJSONString(200, "success", map);
    }

    @RequestMapping(path = "/add", method = RequestMethod.POST)
    @ResponseBody
    public String addDiscussPost(String title, String content){
//        User user = hostHolder.getUser();
//        if(user == null || userId == 0) {
//            return CommunityUtil.getJSONString(403, "You haven't login yet");
//        }
        DiscussPost post = new DiscussPost();
        Random random = new Random();
        post.setUserId(random.nextInt(150));
        post.setTitle(title);
        post.setContent(content);
        post.setCreateTime(new Date());
        discussPostService.addDiscussPost(post);
        //TODO: any other error
        return CommunityUtil.getJSONString(200, "Post successfully");
    }
}
