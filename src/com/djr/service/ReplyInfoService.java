package com.djr.service;

import com.djr.dao.ReplyInfoDAO;
import com.djr.entity.ReplyInfo;
import com.djr.entity.TopicInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ReplyInfoService {
    @Autowired
    ReplyInfoDAO replyInfoDAO;

    public List<ReplyInfo> getReplyInfo(int topicId){
        List<ReplyInfo> list = replyInfoDAO.getReplyInfo(topicId);
        return  list;
    }

    public int countReply(int topicId){
        int count = replyInfoDAO.countReply(topicId);
        return count;
    }

    public void AddNewReply(ReplyInfo replyInfo){
        replyInfoDAO.AddNewReply(replyInfo);
    }

    public List<ReplyInfo> getReplyByPage(Map map){
        List<ReplyInfo> list = replyInfoDAO.getReplyByPage(map);
        return list;
    }
}
