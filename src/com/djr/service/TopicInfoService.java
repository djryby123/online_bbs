package com.djr.service;

import com.djr.dao.TopicInfoDAO;
import com.djr.entity.TopicInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class TopicInfoService {
    @Autowired
    TopicInfoDAO topicInfoDAO;

    public void AddNewTopic(TopicInfo topicInfo){
        topicInfoDAO.AddNewTopic(topicInfo);
    }

    public List<TopicInfo> listTopicInfo(int boardId){
        List<TopicInfo> list = topicInfoDAO.listTopicInfo(boardId);
        return list;
    }

    public int countTopic(int boardId){
        int count = topicInfoDAO.countTopic(boardId);
        return count;
    }

    public TopicInfo getLastTopicInfo(int boardId){
        TopicInfo topicInfo = topicInfoDAO.getLastTopicInfo(boardId);
        return topicInfo;
    }

    public TopicInfo detailTopicInfo(int topicId){
        TopicInfo topicInfo = topicInfoDAO.detailTopicInfo(topicId);
        return topicInfo;
    }

    public List<TopicInfo> getTopicByPage(Map map){
        List<TopicInfo> list = topicInfoDAO.getTopicByPage(map);
        return list;
    }
}
