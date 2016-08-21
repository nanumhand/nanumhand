package kr.ac.lamda.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import kr.ac.lamda.domain.UserVO;
import kr.ac.lamda.domain.Criteria;
import kr.ac.lamda.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {

  @Inject
  private UserDAO dao;

  @Override
  public void create(UserVO user) throws Exception {
    dao.create(user);
  }

 
  @Transactional(isolation=Isolation.READ_COMMITTED)
  @Override
  public UserVO read(Integer seq) throws Exception {
      return dao.read(seq);
  }

  
  @Override
  public void update(UserVO user) throws Exception {
    dao.update(user);
  }

  @Override
  public void delete(Integer seq) throws Exception {
    dao.delete(seq);
  }

  @Override
  public List<UserVO> listAll() throws Exception {
    return dao.listAll();
  }
  
  @Override
  public List<UserVO> listPage(int page) throws Exception {
	    return dao.listPage(page);
	  }
  @Override
  public List<UserVO> listCriteria(Criteria cri) throws Exception {

    return dao.listCriteria(cri);
  }

  @Override
  public int countPaging(Criteria cri) throws Exception {

    return dao.countPaging(cri);
  }

 }
