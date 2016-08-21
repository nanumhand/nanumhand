package kr.ac.lamda.service;

import java.util.List;

import kr.ac.lamda.domain.UserVO;
import kr.ac.lamda.domain.Criteria;


public interface UserService {

	  public void create(UserVO vo) throws Exception;

	  public UserVO read_error(String user_id) throws Exception;
	  
	  public UserVO logincheck(UserVO vo) throws Exception;
	  
	  public UserVO idcheck(String user_id) throws Exception;
	  
	  public UserVO emailcheck(String email) throws Exception;

	  public void init_errorcnt(String user_id) throws Exception;
	  
	  public void plus_errorcnt(String user_id) throws Exception;
	  
	  public void banned_date(String user_id) throws Exception;
	  
}