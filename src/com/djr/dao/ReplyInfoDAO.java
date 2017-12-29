package com.djr.dao;

import com.djr.entity.ReplyInfo;

import java.util.List;
import java.util.Map;


public interface ReplyInfoDAO {

    List<ReplyInfo> getReplyInfo(int topicId);

    int countReply(int topicId);

    void AddNewReply(ReplyInfo replyInfo);

    List<ReplyInfo> getReplyByPage(Map map);
}
