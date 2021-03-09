package com.petcom.community.controller;


import com.petcom.community.entity.DiscussPost;
import com.petcom.community.entity.User;
import com.petcom.community.service.DiscussPostService;
import com.petcom.community.util.CommunityUtil;
import com.petcom.community.util.HostHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

@Controller
@RequestMapping("/discuss")
public class DiscussPostController {

    @Autowired
    DiscussPostService discussPostService;

    @Autowired
    private HostHolder hostHolder;

    @RequestMapping(path = "/add", method = RequestMethod.POST)
    @ResponseBody
    public String addDiscussPost(String title, String content, int userId){
        User user = hostHolder.getUser();
        if(user == null || userId == 0) {
            return CommunityUtil.getJSONString(403, "You haven't login yet");
        }
        DiscussPost post = new DiscussPost();
        post.setUserId(userId);
        post.setTitle(title);
        post.setContent(content);
        post.setCreateTime(new Date());
        discussPostService.addDiscussPost(post);
        //TODO: any other error
        return CommunityUtil.getJSONString(200, "Post successfully");
    }
}
