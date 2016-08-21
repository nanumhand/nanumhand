package kr.ac.lamda.service;

import java.util.List;

import kr.ac.lamda.domain.CommentVO;
import kr.ac.lamda.domain.Criteria;


public interface CommentService {

	  public void create(CommentVO vo) throws Exception;

	  public CommentVO read(Integer seq) throws Exception;

	  public void update(CommentVO vo) throws Exception;

	  public void delete(Integer seq) throws Exception;

	  public List<CommentVO> listAll() throws Exception;

	  public List<CommentVO> listPage(int page) throws Exception;

	  public List<CommentVO> listCriteria(Criteria cri) throws Exception;

	  public int countPaging(Criteria cri) throws Exception;
	  
	  

	}