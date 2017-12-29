package com.djr.service;

import com.djr.dao.UserInfoDAO;
import com.djr.entity.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class UserInfoService {
    @Autowired
    UserInfoDAO userInfoDAO;

    public void reg(UserInfo ui){
        userInfoDAO.reg(ui);
    }

    public String checkUserName(String uName){
        boolean flag = userInfoDAO.checkUserName(uName);
        if(flag == true){
            return "false";
        }else{
            return "true";
        }
    }

    public UserInfo login(Map map){
        UserInfo ui = userInfoDAO.login(map);
        return ui;
    }

    public String findUname(int uId){
        String uName = userInfoDAO.findUname(uId);
        return uName;
    }

    public UserInfo getUserInfo(int uId){
        UserInfo userInfo = userInfoDAO.getUserInfo(uId);
        return userInfo;
    }
}
