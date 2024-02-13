package kr.spring.md.controller;

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
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.md.service.AdminMdService;
import kr.spring.md.service.MdService;
import kr.spring.md.vo.MdVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PageUtil;
import kr.spring.util.FileUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminMdController {

	@Autowired
	private AdminMdService adminMdService;

	/*==============================
	* 자바빈(VO) 초기화
	*==============================*/
		@ModelAttribute
		public MdVO initCommand() {
			return new MdVO();
		}
		
		/*==============================
		* 상품 등록
		*==============================*/
		
		//상품등록 폼 호출
			@GetMapping("/md/regMd")
			public String form() {
				return "insertMd";//타일스 설정명
			}
			
			//전송된 데이터 처리
			@PostMapping("/md/regMd")
			public String submit( MdVO mdVO, BindingResult result, Model model,
					            HttpServletRequest request, HttpSession session) throws IllegalStateException, IOException {
				
				
				mdVO.setMd_photo1(FileUtil.createFile(request, mdVO.getUpload1()));
				mdVO.setMd_photo2(FileUtil.createFile(request, mdVO.getUpload2()));
				
				//상품등록
				adminMdService.insertMd(mdVO);
				
				model.addAttribute("accessTitle", "상품 등록");
				model.addAttribute("accessMsg", "상품 등록이 완료되었습니다.");
				model.addAttribute("accessUrl", request.getContextPath()+"/main/main");
				
				return "common/resultView";
			}
			
			/*=================================
			 * 상품 목록
			 *=================================*/	
			@RequestMapping("/md/list")
			public ModelAndView process(
					       @RequestParam(value="pageNum",defaultValue="1") int currentPage,
					       @RequestParam(value="order",defaultValue="1") int order,
					       String keyfield, String keyword) {
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("keyfield", keyfield);
				map.put("keyword", keyword);
				
				//전체/검색 레코드수
				int count = adminMdService.selectRowCount(map);
				log.debug("<<count>> : " + count);
				
				PageUtil page = new PageUtil(keyfield,keyword,currentPage,
						                     count,20,10,"list","&order="+order);
				
				List<MdVO> list = null;
				if(count > 0) {
					map.put("order", order);
					map.put("start",page.getStartRow());
					map.put("end", page.getEndRow());
					
					list = adminMdService.selectList(map);
				}
				
				ModelAndView mav = new ModelAndView();
				mav.setViewName("mdList");
				mav.addObject("count", count);
				mav.addObject("list", list);
				mav.addObject("page", page.getPage());
				
				return mav;
			}
			
			/*=================================
			 * MD 상세페이지
			 *=================================*/
			@RequestMapping("/md/detail")
			public ModelAndView process(@RequestParam int md_num) {
				log.debug("<<Md 상세 md_num>> : " + md_num);
				
				MdVO md = adminMdService.selectMd(md_num);

				                        //타일스 설정명,속성명,속성값
				return new ModelAndView("/md/mdView","md",md);
			}
			
			/*=================================
			 * MD 정보 수정
			 *=================================*/
			//수정 폼 호출
			@GetMapping("/md/update")
			public String formUpdate(@RequestParam int md_num,Model model) {
				MdVO mdVO = adminMdService.selectMd(md_num);
				
				model.addAttribute("mdVO", mdVO);
				
				return "/md/mdModify";
			}
			//수정 폼에서 전송된 데이터 처리
			@PostMapping("/md/update")
			public String submitUpdate(@Valid MdVO mdVO,
					                   BindingResult result,
					                   HttpServletRequest request,
					                   Model model) throws IllegalStateException, IOException {
				log.debug("<<MD정보수정>> : " + mdVO);
					              
				if(result.hasErrors()) {
					MdVO md= adminMdService.selectMd(mdVO.getMd_num());
					md.setMd_num(md.getMd_num());
					return "/md/mdModify";
				}
				
				
				//MD 수정
				adminMdService.updateMd(mdVO);
				
				//View에 표시할 메시지
				model.addAttribute("message", "정보 수정 완료!!");
				model.addAttribute("url", request.getContextPath()+"/md/update?md_num="+mdVO.getMd_num());
				
				
				return "common/resultAlert";
			}
			/*=================================
			 * MD 삭제
			 *=================================*/
			@RequestMapping("/md/delete")
			public String submitDelete(@RequestParam int md_num,
					                   HttpServletRequest request) {
				log.debug("<<MD 삭제 md_num>> : " + md_num);
				
				//DB에 저장된 파일 정보 구하기
				//MdVO db_md = adminMdService.selectMd(md_num);
				
				//MD 삭제
				adminMdService.deleteMd(md_num);
				
				/*
				if(db_md.getMd_photo1() != null) {
					//파일 삭제
					FileUtil.removeFile(request, db_md.getMd_photo1());
				}
				*/
				
				return "redirect:/md/list";
			}
			
			
			
			
}
