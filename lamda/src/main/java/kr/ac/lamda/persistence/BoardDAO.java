package kr.ac.lamda.persistence;

import java.util.List;

import kr.ac.lamda.domain.BoardVO;
import kr.ac.lamda.domain.Criteria;


public interface BoardDAO {

  public void create(BoardVO vo) throws Exception;

  public BoardVO read(Integer seq) throws Exception;

  public void update(BoardVO vo) throws Exception;

  public void delete(Integer seq) throws Exception;

  public List<BoardVO> listAll() throws Exception;

  public List<BoardVO> listPage(int page) throws Exception;

  public List<BoardVO> listCriteria(Criteria cri) throws Exception;

  public int countPaging(Criteria cri) throws Exception;
  
  public void updateHits(Integer seq) throws Exception;
  
  public void updateLike(Integer seq) throws Exception;

}
