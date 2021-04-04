package com.petcom.community.dao;

import com.petcom.community.entity.Breeder;
import com.petcom.community.entity.DiscussPost;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BreederMapper {

    List<Breeder> selectBreederList(int id, int offset, int limit);

    int selectBreederRows(@Param("id") int id);

    List<Breeder> findFeatureBreeder();

    List<Breeder> findBreederById(int id);

    int insertBreeder(Breeder breeder);

    List<Breeder> searchBreeder(@Param("searchKey") String searchKey);
}

