package com.djr.util;

import com.djr.entity.ReplyInfo;
import com.djr.entity.TopicInfo;
import com.djr.service.ReplyInfoService;
import com.djr.service.TopicInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class PageUtil {
    //第一页页码
    public int firstPage = 1;
    //最后一页页码
    public int lastPage;
    //上一页
    public int prePage;
    //下一页
    public int nextPage;
    //当前页
    public int currentPage;
    //每页条数
    public int sizeOfPage = 10;

    ApplicationContext appCtx = SpringContextUtil.getApplicationContext();

    TopicInfoService topicInfoService = (TopicInfoService)SpringContextUtil.getBean(TopicInfoService.class);

    ReplyInfoService replyInfoService = (ReplyInfoService)SpringContextUtil.getBean(ReplyInfoService.class);

    public PageUtil(int currentPage, int boardId) {
        this.currentPage = currentPage;
        this.firstPage = 1;

        this.lastPage = topicInfoService.countTopic(boardId) % sizeOfPage == 0 ? topicInfoService.countTopic(boardId) / sizeOfPage :
                topicInfoService.countTopic(boardId) / sizeOfPage + 1;

    }

    public PageUtil(int currentPage, int boardId, int topicId) {
        this.currentPage = currentPage;
        this.firstPage = 1;

        this.lastPage = replyInfoService.countReply(topicId) % sizeOfPage == 0 ? replyInfoService.countReply(topicId) / sizeOfPage :
                replyInfoService.countReply(topicId) / sizeOfPage + 1;

    }

    public int getPrePage() {
        if (this.currentPage == 1) {
            this.prePage = 1;
        } else {
            this.prePage = this.currentPage - 1;
        }
        return this.prePage;
    }

    public int getNextPage() {
        if (this.currentPage == this.lastPage) {
            this.nextPage = this.lastPage;
        } else {
            this.nextPage = this.currentPage + 1;
        }
        return this.nextPage;
    }

    public int getFirstPage() {
        return this.firstPage;
    }

    public int getLastPage() {
        return this.lastPage;
    }

    public List<TopicInfo> getTopicByPage(int boardId,Map map) {
        List<TopicInfo> list = new ArrayList<TopicInfo>();
        int start = (this.currentPage - 1) * sizeOfPage;
        map.put("boardId",boardId);
        map.put("start",start);
        list = topicInfoService.getTopicByPage(map);

        return list;
    }

    public List<ReplyInfo> getReplyByPage(int topicId,Map map) {
        List<ReplyInfo> list = new ArrayList<ReplyInfo>();
        int start = (this.currentPage - 1) * sizeOfPage;
        map.put("topicId",topicId);
        map.put("start",start);
        list = replyInfoService.getReplyByPage(map);

        return list;
    }
}
