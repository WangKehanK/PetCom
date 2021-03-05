package com.petcom.community.dao;

import com.petcom.community.entity.Breeder;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BreederMapper {

    List<Breeder> selectBreederList(int id, int offset, int limit);
    
}

