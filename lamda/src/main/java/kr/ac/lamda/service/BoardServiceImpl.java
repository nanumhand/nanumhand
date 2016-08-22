package kr.ac.lamda.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import kr.ac.lamda.domain.BoardVO;
import kr.ac.lamda.domain.Criteria;
import kr.ac.lamda.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

  @Inject
  private BoardDAO dao;

  @Override
  public void create(BoardVO board) throws Exception {
    dao.create(board);
  }

  @Override
  public void updateHits(Integer seq_board) throws Exception{
	 dao.updateHits(seq_board);
  }
  
  @Override
  public void updateLike(Integer seq_board) throws Exception{
	 dao.updateLike(seq_board);
  }
  

  @Transactional(isolation=Isolation.READ_COMMITTED)
  @Override
  public BoardVO read(Integer seq_board) throws Exception {
    dao.updateHits(seq_board);
    return dao.read(seq_board);
  }

  
  @Override
  public void update(BoardVO vo) throws Exception {
    dao.update(vo);
  }

  @Override
  public void delete(Integer seq_board) throws Exception {
    dao.delete(seq_board);
  }


  
  @Override
  public List<BoardVO> listPage(Criteria cri) throws Exception {
	    return dao.listPage(cri);
	  }

  @Override
  public int countPaging(Criteria cri) throws Exception {

    return dao.countPaging(cri);
  }

 }
