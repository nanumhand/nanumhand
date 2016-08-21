package kr.ac.lamda.test;

import java.util.List;

import javax.inject.Inject;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.MessageVO;
import org.zerock.domain.SearchCriteria;
import org.zerock.persistence.BoardDAO;
import org.zerock.persistence.MessageDAO;
import org.zerock.service.MessageService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
public class BoardDAOTest {

  @Inject
  private BoardDAO dao;
  
  @Inject
  private MessageService service;
  
  @Inject
  private MessageDAO messageDAO;

  private static Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);
  
  
  @Test
  public void addMessageTest() throws Exception {
	  MessageVO msg = new MessageVO();
	  msg.setTargetid("user02");
	  msg.setSender("user01");
	  msg.setMessage("hello Brad");
	  service.addMessage(msg);
  }
  
  @Test
  public void readMessageTest() throws Exception {
	  //MessageVO msg = service.readMessage(1);
	  //System.out.println(msg);
	  
//	  messageDAO.updateState(1);
//
//	    pointDAO.updatePoint(uid, 5);
//
	  System.out.println(messageDAO.readMessage(1));
  }
  
  @Ignore
  @Test
  public void testRead() throws Exception {
    logger.info(dao.read(4).toString());
  }

  @Ignore
  @Test
  public void testUpdate() throws Exception {
    BoardVO board = new BoardVO();
    board.setBno(3);
    board.setTitle("aaaa");
    board.setContent("bbbb ");
    board.setViewcnt(11);
    dao.update(board);
  }

  @Ignore
  @Test
  public void testDelete() throws Exception {
    dao.delete(3);
  }

  @Ignore
  @Test
  public void testListAll() throws Exception {

    logger.info(dao.listAll().toString());

  }

  @Ignore
  @Test
  public void testListPage() throws Exception {

    int page = 3;

    List<BoardVO> list = dao.listPage(page);

    for (BoardVO boardVO : list) {
      logger.info(boardVO.getBno() + ":" + boardVO.getTitle());
    }
  }

  @Ignore
  @Test
  public void testListCriteria() throws Exception {

    Criteria cri = new Criteria();
    cri.setPage(2);
    cri.setPerPageNum(20);

    List<BoardVO> list = dao.listCriteria(cri);

    for (BoardVO boardVO : list) {
      logger.info(boardVO.getBno() + ":" + boardVO.getTitle());
    }
  }

  @Ignore
  @Test
  public void testURI() throws Exception {

    UriComponents uriComponents = UriComponentsBuilder.newInstance().path("/board/read").queryParam("bno", 12)
        .queryParam("perPageNum", 20).build();

    logger.info("/board/read?bno=12&perPageNum=20");
    logger.info(uriComponents.toString());

  }

  @Ignore
  @Test
  public void testURI2() throws Exception {

    UriComponents uriComponents = UriComponentsBuilder.newInstance().path("/{module}/{page}").queryParam("bno", 12)
        .queryParam("perPageNum", 20).build().expand("board", "read").encode();

    logger.info("/board/read?bno=12&perPageNum=20");
    logger.info(uriComponents.toString());
  }

  @Ignore
  @Test
  public void testDynamic1() throws Exception {

    SearchCriteria cri = new SearchCriteria();
    cri.setPage(1);
    cri.setKeyword("kim");
    cri.setSearchType("kim");

    logger.info("=====================================");

    List<BoardVO> list = dao.listSearch(cri);

    for (BoardVO boardVO : list) {
      logger.info(boardVO.getBno() + ": " + boardVO.getTitle());
    }

    logger.info("=====================================");

    logger.info("COUNT: " + dao.listSearchCount(cri));
  }

}
