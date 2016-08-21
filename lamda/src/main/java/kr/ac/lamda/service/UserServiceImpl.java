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
  public void create(UserVO vo) throws Exception {
    dao.create(vo);
  }

 
 @Override
  public UserVO read_error(String user_id) throws Exception {
      return dao.read_error(user_id);
  }
 
 @Override
 public UserVO logincheck(UserVO vo) throws Exception {
     return dao.logincheck(vo);
 }
 
 @Override
 public UserVO idcheck(String user_id) throws Exception {
     return dao.idcheck(user_id);
 }
 
 @Override
 public UserVO emailcheck(String email) throws Exception {
     return dao.emailcheck(email);
 }

  
  @Override
  public void init_errorcnt(String user_id) throws Exception {
    dao.init_errorcnt(user_id);
  }
  
  @Override
  public void plus_errorcnt(String user_id) throws Exception {
    dao.plus_errorcnt(user_id);
  }
  
  @Override
  public void banned_date(String user_id) throws Exception {
    dao.banned_date(user_id);
  }

 }
