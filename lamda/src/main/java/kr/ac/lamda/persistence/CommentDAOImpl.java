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
  public void update_fordelete(int seq_comment) throws Exception {
    session.update(namespace + ".update", seq_comment);
  }

  @Override
  public void delete(Integer seq_comment) throws Exception {
    session.delete(namespace + ".delete", seq_comment);
  }

  @Override
  public List<CommentVO> listPage(CommentVO vo) throws Exception {

    if (vo.getPage() <= 0) {
    	vo.setPage(1);
    }

    vo.setPage((vo.getPage() - 1) * 10);

    return session.selectList(namespace + ".listPage", vo);
  }

 @Override
  public int countPaging(Criteria cri) throws Exception {

    return session.selectOne(namespace + ".countPaging", cri);
  }


}
