package com.petcom.community.service;

import com.petcom.community.dao.BreederMapper;
import com.petcom.community.entity.Breeder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BreederService {

    @Autowired
    private BreederMapper breederMapper;

    public List<Breeder> findBreeders(int id, int offset, int limit) {
        return breederMapper.selectBreederList(id, offset, limit);
    }

    public int findBreederRows(int id) { return breederMapper.selectBreederRows(id);};
}
