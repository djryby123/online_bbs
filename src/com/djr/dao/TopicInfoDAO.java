package com.djr.dao;

import com.djr.entity.TopicInfo;

import java.util.List;
import java.util.Map;


public interface TopicInfoDAO {

    void AddNewTopic(TopicInfo topicInfo);

    List<TopicInfo> listTopicInfo(int boardId);

    int countTopic(int boardId);

    TopicInfo getLastTopicInfo(int boardId);

    TopicInfo detailTopicInfo(int topicId);

    List<TopicInfo> getTopicByPage(Map map);
}
