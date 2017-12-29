package com.djr.controller;

import com.djr.entity.BoardInfo;
import com.djr.entity.ReplyInfo;
import com.djr.entity.TopicInfo;
import com.djr.entity.UserInfo;
import com.djr.service.BoardInfoService;
import com.djr.service.ReplyInfoService;
import com.djr.service.TopicInfoService;
import com.djr.service.UserInfoService;
import com.djr.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/bbs")
public class BBSController {

    @Autowired
    public UserInfoService userInfoService;
    @Autowired
    public TopicInfoService topicInfoService;
    @Autowired
    public BoardInfoService boardInfoService;
    @Autowired
    public ReplyInfoService replyInfoService;

    @RequestMapping("/index")
    public String index(Map map){
        List<BoardInfo> pList = boardInfoService.getAllFatherBoard();
        map.put("pList",pList);
        for (int i = 0;i < pList.size();i++) {
            BoardInfo pBoardInfo = pList.get(i);
            List<BoardInfo> cList = boardInfoService.getAllChildBoard(pBoardInfo.getBoardId());
            map.put("cList"+i,cList);
            for (int j = 0;j < cList.size();j++) {
                BoardInfo cBoardInfo = cList.get(j);
                TopicInfo topicInfo = topicInfoService.getLastTopicInfo(cBoardInfo.getBoardId());
                map.put("topicInfo"+i+j,topicInfo);
                if (topicInfo != null) {
                    int topicId = topicInfo.getTopicId();
                    map.put("topicId"+i+j,topicId);
                    String title = topicInfo.getTitle();
                    map.put("title"+i+j,title);
                    int countTopic = topicInfoService.countTopic(cBoardInfo.getBoardId());
                    map.put("countTopic"+i+j,countTopic);
                    int uId = topicInfo.getuId();
                    String uName = userInfoService.findUname(uId);
                    map.put("uName"+i+j,uName);
                    Timestamp publishTime = topicInfo.getPublishTime();
                    String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(publishTime);
                    map.put("time"+i+j,time);
                }
            }
        }
        return "index";
    }

    @RequestMapping("/exit")
    public String exit(){
        return "exit";
    }

    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    @RequestMapping("/reg")
    public String reg() {
        return "reg";
    }

    @RequestMapping("/doReg")
    public void doReg(String uName, String uPass, String head, String gender,HttpServletResponse response) {
        UserInfo userInfo = new UserInfo();
        userInfo.setuName(uName.trim());
        userInfo.setuPass(uPass);
        userInfo.setHead(head);
        userInfo.setGender(gender);
        userInfoService.reg(userInfo);
        try {
            response.getWriter().write("true");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/checkUserName")
    public void checkUserName(String uName, HttpServletResponse response) {
        String flag = userInfoService.checkUserName(uName.trim());
        try {
            response.getWriter().write(flag);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/doLogin")
    public void doLogin(String uName, String uPass, Map map,HttpServletRequest request, HttpServletResponse response) {
       map.put("uName",uName);
       map.put("uPass",uPass);
        UserInfo userInfo = userInfoService.login(map);
        if (userInfo != null) {
            request.getSession().setAttribute("userinfo", userInfo);
            try {
                response.getWriter().write("true");
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            try {
                response.getWriter().write("false");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @RequestMapping("/list")
    public String list(String boardId,String currentPage,Map map,HttpServletRequest request) {
        int currentPage1 = Integer.parseInt(currentPage);
        int boardId1 = Integer.parseInt(boardId);
        PageUtil pageUtil = new PageUtil(currentPage1,boardId1);
        String FirstPage = String.valueOf(pageUtil.getFirstPage());
        String NextPage = String.valueOf(pageUtil.getNextPage());
        String PrePage = String.valueOf(pageUtil.getPrePage());
        String LastPage = String.valueOf(pageUtil.getLastPage());
        map.put("FirstPage",FirstPage);
        map.put("NextPage",NextPage);
        map.put("PrePage",PrePage);
        map.put("LastPage",LastPage);
        List<TopicInfo> topicList = pageUtil.getTopicByPage(boardId1,map);
        map.put("topicList",topicList);
        for(int i=0;i<topicList.size();i++){
            TopicInfo topicInfo = topicList.get(i);
            String uName = userInfoService.findUname(topicInfo.getuId());
            map.put("uName"+i,uName);
            int count = replyInfoService.countReply(topicInfo.getTopicId());
            map.put("count"+i,count);
        }
        request.getSession().setAttribute("boardId", boardId);
        String boardName = boardInfoService.getBoardName(Integer.parseInt(boardId));
        request.getSession().setAttribute("boardName", boardName);
        return "list";
    }

    @RequestMapping("/post")
    public String post(){
        return "post";
    }

    @RequestMapping("/publish")
    public void publish(String uId, String bId, String title, String content,HttpServletResponse response) {
        TopicInfo topicInfo = new TopicInfo();
        topicInfo.setuId(Integer.parseInt(uId));
        topicInfo.setBoardId(Integer.parseInt(bId));
        topicInfo.setTitle(title);
        topicInfo.setContent(content);
        topicInfoService.AddNewTopic(topicInfo);
        try {
            response.getWriter().write("true");
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @RequestMapping("/detail")
    public String detail(String topicId,String currentPage,Map map,HttpServletRequest request) {
        int boardId = 0;
        int topicId1 = Integer.parseInt(topicId);
        request.getSession().setAttribute("topicId",topicId1);
        int currentPage1 = Integer.parseInt(currentPage);
        PageUtil pageUtil = new PageUtil(currentPage1, boardId, topicId1);
        String FirstPage = String.valueOf(pageUtil.getFirstPage());
        String NextPage = String.valueOf(pageUtil.getNextPage());
        String PrePage = String.valueOf(pageUtil.getPrePage());
        String LastPage = String.valueOf(pageUtil.getLastPage());
        map.put("FirstPage",FirstPage);
        map.put("NextPage",NextPage);
        map.put("PrePage",PrePage);
        map.put("LastPage",LastPage);
        TopicInfo topicInfo = topicInfoService.detailTopicInfo(topicId1);
        map.put("topicInfo",topicInfo);
        UserInfo userInfo = userInfoService.getUserInfo(topicInfo.getuId());
        map.put("userInfo",userInfo);
        String time = new SimpleDateFormat("yyyy-MM-dd").format(userInfo.getRegTime());
        map.put("time",time);
        String time1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(topicInfo.getPublishTime());
        map.put("time1",time1);
        List<ReplyInfo> replyList = pageUtil.getReplyByPage(topicId1,map);
        map.put("replyList",replyList);
        for(int i=0;i<replyList.size();i++){
            ReplyInfo replyInfo = replyList.get(i);
            String time2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(replyInfo.getPublishTime());
            map.put("time2",time2);
            UserInfo uInfo = userInfoService.getUserInfo(replyInfo.getuId());
            map.put("uInfo"+i,uInfo);
            String time3 = new SimpleDateFormat("yyyy-MM-dd").format(uInfo.getRegTime());
            map.put("time3"+i,time3);

        }
        return "detail";
    }

    @RequestMapping("/reply")
    public String reply(){
        return "reply";
    }

    @RequestMapping("/doReply")
    public void reply(String uId, String tId, String title, String content,HttpServletResponse response) {
        ReplyInfo replyInfo = new ReplyInfo();
        replyInfo.setuId(Integer.parseInt(uId));
        replyInfo.setTopicId(Integer.parseInt(tId));
        replyInfo.setTitle(title);
        replyInfo.setContent(content);
        replyInfoService.AddNewReply(replyInfo);
        try {
            response.getWriter().write("true");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
