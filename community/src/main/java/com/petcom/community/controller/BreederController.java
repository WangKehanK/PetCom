package com.petcom.community.controller;

import com.petcom.community.entity.Breeder;
import com.petcom.community.entity.Page;
import com.petcom.community.service.BreederService;
import com.petcom.community.util.CommunityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/api/breeder")
public class BreederController {

    @Autowired
    private BreederService breederService;
    @RequestMapping(path = "/all", method = RequestMethod.GET)
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

    @RequestMapping(path = "/feature", method = RequestMethod.GET)
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


    @RequestMapping(params = {"id"}, method = RequestMethod.GET)
    @ResponseBody
    public String findBreederByID(@RequestParam(value = "id") int id){
        List<Breeder> breeder = breederService.findBreederById(id);
        Map<String, Object> map = new HashMap<>();
        if(breeder != null) {
            map.put("total", 1);
            map.put("total_page", 1);
            map.put("current_page", 1);
            map.put("breeder", breeder);
        }
        return CommunityUtil.getJSONString(200, "success", map);
    }

}
