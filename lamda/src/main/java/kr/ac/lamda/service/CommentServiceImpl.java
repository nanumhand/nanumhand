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
  public void create(CommentVO vo) throws Exception {
    dao.create(vo);  
  }
  
  @Override
  public void update_fordelete(int seq_comment) throws Exception {
    dao.update_fordelete(seq_comment);
  }

  @Override
  public void delete(Integer seq_comment) throws Exception {
    dao.delete(seq_comment);
  }

  @Override
  public List<CommentVO> listPage(CommentVO vo) throws Exception {
	    return dao.listPage(vo);
	  }

  @Override
  public int countPaging(Criteria cri) throws Exception {

    return dao.countPaging(cri);
  }

 }
