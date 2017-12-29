package com.djr.dao;

import com.djr.entity.BoardInfo;

import java.util.List;


public interface BoardInfoDAO {

    List<BoardInfo> getAllFatherBoard();

    List<BoardInfo> getAllChildBoard(int parentId);

    String getBoardName(int boardId);
}
