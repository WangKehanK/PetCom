package com.petcom.community.dao;

import com.petcom.community.entity.DiscussPost;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface DiscussPostMapper {

    /*
    offset
    limit: how many discuss post in one offset
     */
    List<DiscussPost> selectDiscussPosts(int userId, int offset, int limit);

    // @Param was used to name the parameter, if there is only one parameter, and used in <If>, this name has to be used
    int selectDiscussPostRows(@Param("userId") int userId);

    int insertDiscussPost(DiscussPost discussPost);

    List<DiscussPost> findFeaturedPosts();

    DiscussPost findPostById(int id);

}
