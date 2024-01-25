package kr.spring.md.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import ch.qos.logback.core.util.FileUtil;
import kr.spring.md.service.AdminMdService;
import kr.spring.md.service.MdService;
import kr.spring.md.vo.MdVO;
import kr.spring.util.PageUtil;
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
			
			//전송된 상품 데이터 처리
			@PostMapping("/md/regMd")
			public String submit(@Valid MdVO mdVO, BindingResult result, Model model,
					                                           HttpServletRequest request) {
				log.debug("<<상품등록>> : " + mdVO);
				
				//유효성 체크 결과 오류가 있으면 폼 호출
				if(result.hasErrors()) {
					return form();
				}
				
				
				//파일 업로드
				//mdVO.setMd_photo1(FileUtil.createFile(request, mdVO.getUpload()));
				
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
				//제목에 태그를 허용하지 않음
				md.setMd_name(StringUtil.useNoHtml(md.getMd_name()));
				                        //타일스 설정명,속성명,속성값
				return new ModelAndView("mdView","md",md);
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
			public String submitUpdate( MdVO mdVO,
					                   BindingResult result,
					                   HttpServletRequest request,
					                   Model model) throws IllegalStateException, IOException {
				log.debug("<<MD정보수정>> : " + mdVO);
				
				//유효성 체크 결과 오류가 있으면 폼 호출
				/*
				if(result.hasErrors()) {
					//title 또는 content가 입력되지 않아 유효성 체크에 걸리면
					//파일 정보를 잃어버리기 때문에 폼을 호출할 때 다시 셋팅해주어야 함
					MdVO vo = adminMdService.selectMd(mdVO.getMd_num());
					mdVO.setMd_photo1(vo.getMd_photo1());
					mdVO.setMd_photo2(vo.getMd_photo2());
					return "mdModify";
				}
				*/
				
				//DB에 저장된 파일 정보 구하기
				//MdVO db_md = adminMdService.selectMd(
				//		                         mdVO.getMd_num());
				
				//파일명 셋팅
				//MdVO.setmd_photo1(FileUtil.createFile(
				//		                 request, mdVO.getUpload()));
						                 
				
				//정보 수정
				adminMdService.updateMd(mdVO);
				
				//전송된 파일이 있을 경우 이전 파일 삭제
				/*
				if(mdVO.getUpload() != null && !mdVO.getUpload().isEmpty()) {
					//수정전 파일 삭제 처리
					FileUtil.removeFile(request, db_md.getFilename());
				}
				*/
				
				//View에 표시할 메시지
				model.addAttribute("message", "정보 수정 완료!!");
				model.addAttribute("url", 
				           request.getContextPath()+"/md/list?md_num="+mdVO.getMd_num());
				/*
				model.addAttribute("url", 
				           request.getContextPath()+"/md/list?md_num="
				                                        +mdVO.getMd_num());
				*/ 
				
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
