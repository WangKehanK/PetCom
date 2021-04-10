package com.petcom.community.entity;

import com.fasterxml.jackson.annotation.JsonAutoDetect;

import java.util.Date;
@JsonAutoDetect(fieldVisibility=JsonAutoDetect.Visibility.ANY, getterVisibility= JsonAutoDetect.Visibility.NONE)
public class Breeder {
    private int id;
    private String title;
    private int score;
    private int type; // 0-Breeder, 1-Shelter
    private String description;
    private Date createTime;
    private String address;
    private String city;
    private String state;
    private String contact;
    private String website;

    public int getStatus() {
        return status;
    }

    @Override
    public String toString() {
        return "Breeder{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", score=" + score +
                ", type=" + type +
                ", description='" + description + '\'' +
                ", createTime=" + createTime +
                ", address='" + address + '\'' +
                ", city='" + city + '\'' +
                ", state='" + state + '\'' +
                ", contact='" + contact + '\'' +
                ", website='" + website + '\'' +
                ", status=" + status +
                '}';
    }

    public void setStatus(int status) {
        this.status = status;
    }

    private int status;

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

}
