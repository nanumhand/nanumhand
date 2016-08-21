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
  
 
  @RequestMapping(value = "/register", method = RequestMethod.GET)
  public void registerGET(BoardVO board, Model model) throws Exception {

    logger.info("register get ...........");
  }


  @RequestMapping(value = "/register", method = RequestMethod.POST)
  public String registPOST(BoardVO board, RedirectAttributes rttr) throws Exception {

    logger.info("regist post ...........");
    logger.info(board.toString());

    service.create(board);

    Thread.sleep(5000);
    
    rttr.addFlashAttribute("msg", "success");
    rttr.addAttribute("page", 1);
    rttr.addAttribute("perPageNum", 10);
    return "redirect:/board/listPage";
  }

 @RequestMapping(value = "/likecnt", method = RequestMethod.GET)
  public void likecnt(@RequestParam("seq") int seq, Model model) throws Exception {

	service.updateLike(seq);  
    model.addAttribute(service.read(seq));
  }
  
  
  @RequestMapping(value = "/read", method = RequestMethod.GET)
  public void read(@RequestParam("seq") int seq, Model model) throws Exception {

    model.addAttribute(service.read(seq));
    service.updateHits(seq);
  }

  @RequestMapping(value = "/remove", method = RequestMethod.POST)
  public String remove(@RequestParam("seq") int seq, RedirectAttributes rttr) throws Exception {

    service.delete(seq);

    rttr.addFlashAttribute("msg", "SUCCESS");
    rttr.addAttribute("page", 1);
    rttr.addAttribute("perPageNum", 10);

    return "redirect:/board/listPage";
  }

  @RequestMapping(value = "/modify", method = RequestMethod.GET)
  public void modifyGET(int seq, Model model) throws Exception {

    model.addAttribute(service.read(seq));
  }

  @RequestMapping(value = "/modify", method = RequestMethod.POST)
  public String modifyPOST(BoardVO board, RedirectAttributes rttr) throws Exception {

    logger.info("mod post............");

    service.update(board);
    rttr.addFlashAttribute("msg", "SUCCESS");
    rttr.addAttribute("page", 1);
    rttr.addAttribute("perPageNum", 10);

    return "redirect:/board/listPage";
  }



  @RequestMapping(value = "/listPage", method = RequestMethod.GET)
  public void listPage(@ModelAttribute("cri") Criteria cri, Model model) throws Exception {

    logger.info(cri.toString());

    model.addAttribute("list", service.listPage(cri.getPage()));
    PageMaker pageMaker = new PageMaker();
    pageMaker.setCri(cri);

    pageMaker.setTotalCount(service.countPaging(cri));

    model.addAttribute("pageMaker", pageMaker);
  }

  @RequestMapping(value = "/readPage", method = RequestMethod.GET)
  public void read(@RequestParam("seq") int seq, @ModelAttribute("cri") Criteria cri, Model model) throws Exception {

    model.addAttribute(service.read(seq));
    service.updateHits(seq);
  }

 
}
