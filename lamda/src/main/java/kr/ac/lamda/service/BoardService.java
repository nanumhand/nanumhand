package kr.ac.lamda.service;

import java.util.List;

import kr.ac.lamda.domain.BoardVO;
import kr.ac.lamda.domain.Criteria;


public interface BoardService {

	public void create(BoardVO vo) throws Exception;

	  public BoardVO read(Integer seq_board) throws Exception;

	  public void update(BoardVO vo) throws Exception;

	  public void delete(Integer seq_board) throws Exception;

	  public List<BoardVO> listPage(int page) throws Exception;
	  
	  public int countPaging(Criteria cri) throws Exception;
	  
	  public void updateHits(Integer seq_board) throws Exception;
	  
	  public void updateLike(Integer seq_board) throws Exception;
	  
	}