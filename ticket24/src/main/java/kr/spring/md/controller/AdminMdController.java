package kr.spring.md.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import ch.qos.logback.core.util.FileUtil;
import kr.spring.md.service.MdService;
import kr.spring.md.vo.MdVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminMdController {

	 @Autowired
	private MdService mdService;

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
				
				/*
				//파일 업로드
				mdVO.setFilename(FileUtil.createFile(request, mdVO.getUpload()));
				*/
				//상품등록
				mdService.insertMd(mdVO);
				
				model.addAttribute("accessTitle", "상품 등록");
				model.addAttribute("accessMsg", "상품 등록이 완료되었습니다.");
				model.addAttribute("accessUrl", request.getContextPath()+"/main/main");
				
				return "common/resultView";		
		
	
			}
}
