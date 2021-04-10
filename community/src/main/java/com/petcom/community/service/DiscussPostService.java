package com.petcom.community.service;


import com.petcom.community.dao.DiscussPostMapper;
import com.petcom.community.entity.DiscussPost;
import com.petcom.community.util.SensitiveFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.HtmlUtils;

import java.util.List;

@Service
public class DiscussPostService {

    @Autowired
    private DiscussPostMapper discussPostMapper;

    @Autowired
    private SensitiveFilter sensitiveFilter;

    public List<DiscussPost> findDiscussPosts(int userId, int offset, int limit) {
        return discussPostMapper.selectDiscussPosts(userId, offset, limit);
    }

    public int findDiscussPostRows(int userId) {
        return discussPostMapper.selectDiscussPostRows(userId);
    }

    public int addDiscussPost(DiscussPost post) {
        if (post == null) {
            throw new IllegalArgumentException("Post cannot be empty!");
        }
        // parse HTML tag
        post.setTitle(HtmlUtils.htmlEscape(post.getTitle()));
        post.setContent(HtmlUtils.htmlEscape(post.getContent()));
        // filter sensitive word
        post.setTitle(sensitiveFilter.filter(post.getTitle()));
        post.setContent(sensitiveFilter.filter(post.getContent()));

        return discussPostMapper.insertDiscussPost(post);
    }

    public List<DiscussPost> findFeaturedPosts(){
        return discussPostMapper.findFeaturedPosts();
    }

    public List<DiscussPost> findPostById(int id){
        discussPostMapper.AddScoreForPost(id);
        return discussPostMapper.findPostById(id);
    }

    public List<DiscussPost> searchDiscussPost(String searchKey) {
        if (searchKey == null) {
            throw new IllegalArgumentException("searchKey cannot be empty!");
        }

        return discussPostMapper.searchDiscussPost(searchKey);
    }
}
