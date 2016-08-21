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
  public void updateHits(Integer seq) throws Exception{
	 dao.updateHits(seq);
  }
  
  @Override
  public void updateLike(Integer seq) throws Exception{
	 dao.updateLike(seq);
  }
  

  @Transactional(isolation=Isolation.READ_COMMITTED)
  @Override
  public BoardVO read(Integer seq) throws Exception {
    dao.updateHits(seq);
    return dao.read(seq);
  }

  
  @Override
  public void update(BoardVO board) throws Exception {
    dao.update(board);
  }

  @Override
  public void delete(Integer seq) throws Exception {
    dao.delete(seq);
  }

  @Override
  public List<BoardVO> listAll() throws Exception {
    return dao.listAll();
  }
  
  @Override
  public List<BoardVO> listPage(int page) throws Exception {
	    return dao.listPage(page);
	  }
  @Override
  public List<BoardVO> listCriteria(Criteria cri) throws Exception {

    return dao.listCriteria(cri);
  }

  @Override
  public int countPaging(Criteria cri) throws Exception {

    return dao.countPaging(cri);
  }

 }
