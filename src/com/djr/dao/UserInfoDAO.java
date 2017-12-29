package com.djr.dao;

import com.djr.entity.UserInfo;

import java.util.Map;


public interface UserInfoDAO {

    void reg(UserInfo ui);

    boolean checkUserName(String uName);

    UserInfo login(Map map);

    String findUname(int uId);

    UserInfo getUserInfo(int uId);
}
