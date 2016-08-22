package kr.ac.lamda.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import kr.ac.lamda.domain.BoardVO;
import kr.ac.lamda.domain.Criteria;


@Repository
public class BoardDAOImpl implements BoardDAO {

  @Inject
  private SqlSession session;

  private static String namespace = "kr.ac.lamda.mapper.BoardMapper";

  @Override
  public void create(BoardVO vo) throws Exception {
    session.insert(namespace + ".create", vo);
  }

  @Override
  public BoardVO read(Integer seq_board) throws Exception {
    return session.selectOne(namespace + ".read", seq_board);
  }

  @Override
  public void updateHits(Integer seq_board) throws Exception{
	  session.update(namespace + ".updateHits", seq_board);
  }
  
  @Override
  public void updateLike(Integer seq_board) throws Exception{
	  session.update(namespace + ".updateLike", seq_board);
  }
  
  @Override
  public void update(BoardVO vo) throws Exception {
    session.update(namespace + ".update", vo);
  }

  @Override
  public void delete(Integer seq_board) throws Exception {
    session.delete(namespace + ".delete", seq_board);
  }

  @Override
  public List<BoardVO> listPage(Criteria cri) throws Exception {

    return session.selectList(namespace + ".listPage", cri);
  }
  

  @Override
  public int countPaging(Criteria cri) throws Exception {

    return session.selectOne(namespace + ".countPaging", cri);
  }


}
