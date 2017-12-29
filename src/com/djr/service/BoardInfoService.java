package com.djr.service;

import com.djr.dao.BoardInfoDAO;
import com.djr.entity.BoardInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardInfoService  {
    @Autowired
    BoardInfoDAO boardInfoDAO;

    public List<BoardInfo> getAllFatherBoard(){
        List<BoardInfo> list = boardInfoDAO.getAllFatherBoard();
        return list;
    }

    public List<BoardInfo> getAllChildBoard(int parentId){
        List<BoardInfo> list = boardInfoDAO.getAllChildBoard(parentId);
        return list;
    }

    public String getBoardName(int boardId){
        String boardName = boardInfoDAO.getBoardName(boardId);
        return  boardName;
    }
}
