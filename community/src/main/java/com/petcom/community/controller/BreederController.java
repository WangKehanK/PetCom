package com.petcom.community.controller;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.petcom.community.entity.Breeder;
import com.petcom.community.entity.DiscussPost;
import com.petcom.community.entity.Page;
import com.petcom.community.service.BreederService;
import com.petcom.community.util.CommunityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.*;


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

    @RequestMapping(path = "/add", method = RequestMethod.POST)
    @ResponseBody
    /**
     * title = _name
     * type = _category
     * description = _description
     * contact = _phoneNumber
     * city = _city
     * state = _state
     * website = _url
     */
    public String addDiscussPost(@RequestBody Breeder breeder){
//        User user = hostHolder.getUser();
//        if(user == null || userId == 0) {
//            return CommunityUtil.getJSONString(403, "You haven't login yet");
//        }
        Breeder newBreeder = new Breeder();
//        breeder.setId(random.nextInt(150));
        newBreeder.setTitle(breeder.getTitle());
        newBreeder.setType(breeder.getType());
        newBreeder.setDescription(breeder.getDescription());
        newBreeder.setCity(breeder.getCity());
        newBreeder.setState(breeder.getState());
        newBreeder.setContact(breeder.getContact());
        newBreeder.setWebsite(breeder.getWebsite());
        newBreeder.setCreateTime(new Date());
        breederService.addBreeder(newBreeder);
        //TODO: any other error
        return CommunityUtil.getJSONString(200, "Post successfully, please waiting to be approved");
        // the status will be 2 here. 2 means unverified, 0 means verified, 1 means featured
    }

    @RequestMapping(path = "/search", method = RequestMethod.GET)
    @ResponseBody
    // http://localhost:8080/community/api/breeder/search?searchKey=rescue
    public String searchDiscussPost(@RequestParam(value = "searchKey") String searchKey){

        List<Breeder> resultList = breederService.searchBreeder(searchKey);
        Map<String, Object> map = new HashMap<>();
        map.put("total", 1);
        map.put("total_page", 1);
        map.put("current_page", 1);
        map.put("breeder", resultList);
        //TODO: any other error
        return CommunityUtil.getJSONString(200, "success", map);
        // the status will be 2 here. 2 means unverified, 0 means verified, 1 means featured
    }

    @RequestMapping(path = "/name", method = RequestMethod.GET)
    @ResponseBody
    // http://localhost:8080/community/api/breeder/name
    public String getBreederName(){
        List<String> resultList = breederService.getBreederName();
        Map<String, Object> map = new HashMap<>();
        map.put("breeder", resultList);
        //TODO: any other error
        return CommunityUtil.getJSONString(200, "success", map);
        // the status will be 2 here. 2 means unverified, 0 means verified, 1 means featured
    }
}
