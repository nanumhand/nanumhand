package kr.ac.lamda.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import kr.ac.lamda.domain.UserVO;
import kr.ac.lamda.domain.Criteria;


@Repository
public class UserDAOImpl implements UserDAO {

  @Inject
  private SqlSession session;

  private static String namespace =  "kr.ac.lamda.mapper.UserMapper";

  @Override
  public void create(UserVO vo) throws Exception {
    session.insert(namespace + ".create", vo);
  }

  @Override
  public UserVO read_error(String user_id) throws Exception {
    return session.selectOne(namespace + ".read_error", user_id);
  }
  
  @Override
  public UserVO logincheck(UserVO vo) throws Exception {
    return session.selectOne(namespace + ".logincheck", vo);
  }
  
  @Override
  public UserVO idcheck(String user_id) throws Exception {
    return session.selectOne(namespace + ".idcheck", user_id);
  }
  
  @Override
  public UserVO emailcheck(String email) throws Exception {
    return session.selectOne(namespace + ".emailcheck", email);
  }
  

 @Override
  public void init_errorcnt(String user_id) throws Exception {
    session.update(namespace + ".init_errorcnt", user_id);
  }

 @Override
 public void plus_errorcnt(String user_id) throws Exception {
   session.update(namespace + ".plus_errorcnt", user_id);
 }
 
  @Override
  public void banned_date(String user_id) throws Exception {
    session.delete(namespace + ".banned_date", user_id);
  }


}
