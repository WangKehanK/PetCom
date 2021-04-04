package com.petcom.community.service;

import com.petcom.community.dao.BreederMapper;
import com.petcom.community.entity.Breeder;
import com.petcom.community.entity.DiscussPost;
import com.petcom.community.util.SensitiveFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.HtmlUtils;

import java.util.List;

@Service
public class BreederService {

    @Autowired
    private BreederMapper breederMapper;

    @Autowired
    private SensitiveFilter sensitiveFilter;

    public List<Breeder> findBreeders(int id, int offset, int limit) {
        return breederMapper.selectBreederList(id, offset, limit);
    }

    public int findBreederRows(int id) { return breederMapper.selectBreederRows(id);};


    public List<Breeder> findFeaturedBreeder() {
        return breederMapper.findFeatureBreeder();
    }

    public List<Breeder> findBreederById(int id) {return breederMapper.findBreederById(id); }

    public int addBreeder(Breeder breeder) {
        if (breeder == null) {
            throw new IllegalArgumentException("Breeder cannot be empty!");
        }
        // parse HTML tag
        breeder.setTitle(HtmlUtils.htmlEscape(breeder.getTitle()));
        breeder.setDescription(HtmlUtils.htmlEscape(breeder.getDescription()));
        // filter sensitive word
        breeder.setTitle(sensitiveFilter.filter(breeder.getTitle()));
        breeder.setDescription(sensitiveFilter.filter(breeder.getDescription()));

        return breederMapper.insertBreeder(breeder);
    }

    public List<Breeder> searchBreeder(String searchKey) {
        if (searchKey == null) {
            throw new IllegalArgumentException("searchKey cannot be empty!");
        }

        return breederMapper.searchBreeder(searchKey);
    }
}
