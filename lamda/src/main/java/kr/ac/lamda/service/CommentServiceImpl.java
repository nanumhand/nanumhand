package kr.ac.lamda.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import kr.ac.lamda.domain.CommentVO;
import kr.ac.lamda.domain.Criteria;
import kr.ac.lamda.persistence.CommentDAO;

@Service
public class CommentServiceImpl implements CommentService {

  @Inject
  private CommentDAO dao;

  @Override
  public void create(CommentVO comment) throws Exception {
    dao.create(comment);
  }

  
  

  @Transactional(isolation=Isolation.READ_COMMITTED)
  @Override
  public CommentVO read(Integer seq) throws Exception {
    
    return dao.read(seq);
  }

  
  @Override
  public void update(CommentVO comment) throws Exception {
    dao.update(comment);
  }

  @Override
  public void delete(Integer seq) throws Exception {
    dao.delete(seq);
  }

  @Override
  public List<CommentVO> listAll() throws Exception {
    return dao.listAll();
  }
  
  @Override
  public List<CommentVO> listPage(int page) throws Exception {
	    return dao.listPage(page);
	  }
  @Override
  public List<CommentVO> listCriteria(Criteria cri) throws Exception {

    return dao.listCriteria(cri);
  }

  @Override
  public int countPaging(Criteria cri) throws Exception {

    return dao.countPaging(cri);
  }

 }
