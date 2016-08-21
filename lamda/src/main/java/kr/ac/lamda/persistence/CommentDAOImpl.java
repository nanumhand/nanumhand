package kr.ac.lamda.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import kr.ac.lamda.domain.CommentVO;
import kr.ac.lamda.domain.Criteria;


@Repository
public class CommentDAOImpl implements CommentDAO {

  @Inject
  private SqlSession session;

  private static String namespace =  "kr.ac.lamda.mapper.CommentMapper";

  @Override
  public void create(CommentVO vo) throws Exception {
    session.insert(namespace + ".create", vo);
  }

  @Override
  public CommentVO read(Integer seq) throws Exception {
    return session.selectOne(namespace + ".read", seq);
  }

  
  @Override
  public void update(CommentVO vo) throws Exception {
    session.update(namespace + ".update", vo);
  }

  @Override
  public void delete(Integer seq) throws Exception {
    session.delete(namespace + ".delete", seq);
  }

  @Override
  public List<CommentVO> listAll() throws Exception {
    return session.selectList(namespace + ".listAll");
  }

  @Override
  public List<CommentVO> listPage(int page) throws Exception {

    if (page <= 0) {
      page = 1;
    }

    page = (page - 1) * 10;

    return session.selectList(namespace + ".listPage", page);
  }

  @Override
  public List<CommentVO> listCriteria(Criteria cri) throws Exception {

    return session.selectList(namespace + ".listCriteria", cri);
  }

  @Override
  public int countPaging(Criteria cri) throws Exception {

    return session.selectOne(namespace + ".countPaging", cri);
  }


}
