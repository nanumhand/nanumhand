package kr.ac.lamda.persistence;

import java.util.List;

import kr.ac.lamda.domain.UserVO;
import kr.ac.lamda.domain.Criteria;


public interface UserDAO {

  public void create(UserVO vo) throws Exception;

  public UserVO read(Integer seq) throws Exception;

  public void update(UserVO vo) throws Exception;

  public void delete(Integer seq) throws Exception;

  public List<UserVO> listAll() throws Exception;

  public List<UserVO> listPage(int page) throws Exception;

  public List<UserVO> listCriteria(Criteria cri) throws Exception;

  public int countPaging(Criteria cri) throws Exception;
  
 }
