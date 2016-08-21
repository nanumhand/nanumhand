package kr.ac.lamda.persistence;

import java.util.List;

import kr.ac.lamda.domain.CommentVO;
import kr.ac.lamda.domain.Criteria;


public interface CommentDAO {

  public void create(CommentVO vo) throws Exception;
 
  public void update_fordelete(int seq_comment) throws Exception;

  public void delete(Integer seq_comment) throws Exception;  

  public List<CommentVO> listPage(CommentVO vo) throws Exception;

  public int countPaging(Criteria cri) throws Exception;
  
  
}
