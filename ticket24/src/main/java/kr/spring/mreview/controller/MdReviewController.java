package kr.spring.mreview.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.member.vo.MemberVO;
import kr.spring.mreview.service.MdReviewService;
import kr.spring.mreview.vo.MdReviewVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PageUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MdReviewController {
	@Autowired
	private MdReviewService mdReviewService;

	/*=================================
	 * 리뷰 등록
	 *=================================*/
	//자바빈(VO) 초기화
	@ModelAttribute
	public MdReviewVO initCommand() {
		return new MdReviewVO();
	}

	//등록 폼 호출
	@GetMapping("/mdReview/reviewWrite")
	public String form() {
		return "/mdReview/reviewWrite";
	}

	//전송된 데이터 처리
	@PostMapping("/mdReview/reviewWrite")
	public String submit(@Valid MdReviewVO mdReviewVO, BindingResult result,
			HttpServletRequest request,HttpSession session,
			Model model) 
					throws IllegalStateException, IOException {
		log.debug("<<리뷰 저장>> : " + mdReviewVO);

		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}

		//회원 번호 셋팅
		MemberVO vo = (MemberVO)session.getAttribute("user");
		mdReviewVO.setMem_num(vo.getMem_num());
		//ip셋팅
		mdReviewVO.setMd_ip(request.getRemoteAddr());
		//파일 업로드
		mdReviewVO.setMd_filename(FileUtil.createFile(request, mdReviewVO.getUpload()));
		//글쓰기
		mdReviewService.insertMdReview(mdReviewVO);

		//View에 표시할 메시지
		model.addAttribute("message", "리뷰작성이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/mdReview/reviewList");

		return "common/resultAlert";
	}

	/*=================================
	 * 리뷰 목록
	 *=================================*/
	@RequestMapping("/mdReview/reviewList") 
	public ModelAndView process(
			@RequestParam(value="pageNum",defaultValue="1") int currentPage,
			@RequestParam(value="order",defaultValue="1") int order, String keyfield,
			String keyword) {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("keyfield", keyfield); 
			map.put("keyword", keyword);

			//전체/검색 레코드수 
			int count = mdReviewService.selectRowCount(map);
			log.debug("<<count>> : " + count);

			PageUtil page = new PageUtil(keyfield,keyword,currentPage,
					count,20,10,"list","&order="+order);

			List<MdReviewVO> list = null; 
			if(count > 0) { map.put("order", order);
							map.put("start",page.getStartRow()); 
							map.put("end", page.getEndRow());

			list = mdReviewService.selectList(map); }
			

			ModelAndView mav = new ModelAndView(); 
			mav.setViewName("reviewList");
			mav.addObject("count", count); 
			mav.addObject("list", list);
			mav.addObject("page", page.getPage());

			return mav; 
			
			
	}


	/*=================================
	 * 리뷰 상세
	 *=================================*/
	
	  @RequestMapping("/mdReview/reviewView") 
	  public ModelAndView process(
			  @RequestParam int md_review_num) { 
		  log.debug("<<리뷰 상세 md_review_num>> : " + md_review_num);
	  
	  
	  MdReviewVO review = mdReviewService.selectMdReview(md_review_num); 
	  //제목에 태그를 허용하지 않음
	  review.setMd_title(StringUtil.useNoHtml(review.getMd_title())); 

	  return new ModelAndView("reviewView","review",review); 
	  }
	 

	/*=================================
	 * 리뷰 수정
	 *=================================*/
	//수정 폼 호출
	@GetMapping("/mdReview/update")
	public String formUpdate(@RequestParam int md_review_num,Model model) {
		MdReviewVO mdReviewVO = mdReviewService.selectMdReview(md_review_num);

		model.addAttribute("mdReviewVO", mdReviewVO);

		return "reviewModify";
	}
	//수정 폼에서 전송된 데이터 처리
	@PostMapping("/mdReview/update")
	public String submitUpdate(@Valid MdReviewVO mdReviewVO,
			BindingResult result,
			HttpServletRequest request,
			Model model) throws IllegalStateException, IOException {
		log.debug("<<리뷰 수정>> : " + mdReviewVO);

		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			//title 또는 content가 입력되지 않아 유효성 체크에 걸리면
			//파일 정보를 잃어버리기 때문에 폼을 호출할 때 다시 셋팅해주어야 함
			MdReviewVO vo = mdReviewService.selectMdReview(mdReviewVO.getMd_review_num());
			mdReviewVO.setMd_filename(vo.getMd_filename());
			return "/mdReview/reviewModify";
		}

		//DB에 저장된 파일 정보 구하기
		
		  MdReviewVO db_review = mdReviewService.selectMdReview(
		  mdReviewVO.getMd_review_num());
		 
	
		//파일명 셋팅
		mdReviewVO.setMd_filename(FileUtil.createFile(
				request, mdReviewVO.getUpload()));
		//ip 셋팅
		mdReviewVO.setMd_ip(request.getRemoteAddr());

		//리뷰 수정
		mdReviewService.updateMdReview(mdReviewVO);

		//전송된 파일이 있을 경우 이전 파일 삭제
		if(mdReviewVO.getUpload() != null && !mdReviewVO.getUpload().isEmpty()) {
			//수정전 파일 삭제 처리
			FileUtil.removeFile(request, db_review.getMd_filename());
		}

		//View에 표시할 메시지
		model.addAttribute("message", "리뷰 수정 완료");
		model.addAttribute("url", 
				request.getContextPath()+"/mdReview/list?md_review_num="
						+mdReviewVO.getMd_review_num());

		return "common/resultAlert";
	}
	/*=================================
	 * 리뷰 삭제
	 *=================================*/
	@RequestMapping("/mdReview/delete")
	public String submitDelete(@RequestParam int md_review_num,
			HttpServletRequest request) {
		log.debug("<<리뷰 삭제 md_review_num>> : " + md_review_num);

		//DB에 저장된 파일 정보 구하기
		MdReviewVO db_review= mdReviewService.selectMdReview(md_review_num);

		//리뷰 삭제
		mdReviewService.deleteMdReview(md_review_num);

		if(db_review.getMd_filename() != null) {
			//파일 삭제
			FileUtil.removeFile(request, db_review.getMd_filename());
		}

		return "redirect:/mdReview/list";
	}
}












