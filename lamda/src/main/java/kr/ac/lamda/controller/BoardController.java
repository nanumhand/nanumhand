package kr.ac.lamda.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import kr.ac.lamda.domain.BoardVO;

import kr.ac.lamda.domain.Criteria;
import kr.ac.lamda.domain.PageMaker;
import kr.ac.lamda.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

  private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

  @Inject
  private BoardService service;
  
 
  @RequestMapping(value = "/create", method = RequestMethod.POST)
  public String registPOST(BoardVO vo, RedirectAttributes rttr) throws Exception {

    logger.info("regist post ...........");
    logger.info(vo.toString());

    service.create(vo);
    
    rttr.addFlashAttribute("msg", "success");
    rttr.addAttribute("page", 1);
    return "redirect:/board/listPage";
  }

 @RequestMapping(value = "/updateLike", method = RequestMethod.GET)
  public void likecnt(@RequestParam("seq_board") int seq_board, Model model) throws Exception {

	service.updateLike(seq_board);  
    model.addAttribute(service.read(seq_board));
  }
  
 @RequestMapping(value = "/readPage", method = RequestMethod.GET)
 public void read(@RequestParam("seq_board") int seq_board, @ModelAttribute("cri") Criteria cri, Model model) throws Exception {

   model.addAttribute(service.read(seq_board));
   service.updateHits(seq_board);
 }

 @RequestMapping(value = "/removePage", method = RequestMethod.POST)
 public String remove(@RequestParam("seq_board") int seq_board, Criteria cri, RedirectAttributes rttr) throws Exception {

   service.delete(seq_board);

   rttr.addAttribute("page", cri.getPage());
   rttr.addAttribute("perPageNum", cri.getPerPageNum());
   rttr.addFlashAttribute("msg", "SUCCESS");

   return "redirect:/board/listPage";
 }

 @RequestMapping(value = "/modifyPage", method = RequestMethod.GET)
 public void modifyPagingGET(@RequestParam("seq_board") int seq_board, @ModelAttribute("cri") Criteria cri, Model model)
     throws Exception {

   model.addAttribute(service.read(seq_board));
 }




  @RequestMapping(value = "/listPage", method = RequestMethod.GET)
  public void listPage(@ModelAttribute("cri") Criteria cri, Model model) throws Exception {

	int page = (cri.getPage()==0)? 1: cri.getPage();
	cri.setPage(page);
	cri.setRowS(page);
	cri.setRowE(page);
	int totalcount = service.countPaging(cri);
    logger.info(cri.toString());    
    logger.info(Integer.toString(totalcount));
    
    model.addAttribute("list", service.listPage(cri));
    PageMaker pageMaker = new PageMaker();
    pageMaker.setCri(cri);

    pageMaker.setTotalCount(totalcount);
    model.addAttribute("pageMaker", pageMaker);    
  }

 
}
