package kr.spring.comm.controller;

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

import kr.spring.comm.service.CommService;
import kr.spring.comm.vo.CommVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PageUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CommController {
	@Autowired
	private CommService commService;
	
	/*=======================================
	 * 게시판 글 등록
	 *======================================*/
	//자바빈(VO)초기화
	@ModelAttribute
	public CommVO initCommand() {
		return new CommVO();
	}
	//등록 폼 호출
	@GetMapping("/comm/write")
	public String form() {
		
		return "commWrite";
	}
	
	//전송된 데이터 처리
	@PostMapping("/comm/write")
	public String submit(@Valid CommVO commVO, BindingResult result, 
						 HttpServletRequest request,
						 HttpSession session, Model model) throws IllegalStateException, IOException {
		log.debug("<<게시판 글 저장>> : " + commVO);	
		
		//유효성 채크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		//회원번호 셋팅
		MemberVO vo = (MemberVO)session.getAttribute("user");
		commVO.setMem_num(vo.getMem_num());
		//ip셋팅
		commVO.setComm_ip(request.getRemoteAddr());
		//파일업로드
		commVO.setComm_filename(FileUtil.createFile(request, commVO.getUpload()));
		//글쓰기
		commService.insertComm(commVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "글쓰기가 완료되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/comm/list");
				
		return "common/resultAlert";		
	}
	/*=======================================
	 * 게시판 글 목록
	 *======================================*/
	@RequestMapping("/comm/list")
	public ModelAndView proces(@RequestParam(value="pageNum",defaultValue="1")int currentPage,
			                   @RequestParam(value="order",defaultValue="1") int order,
			                   @RequestParam(value="comm_category",defaultValue="") Integer comm_category,
			                   String keyfield, String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("comm_category", comm_category);
		
		//전체/검색 레코드 수
		int count = commService.selectRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"list","&order="+order+"&comm_category="+comm_category);
		
		List<CommVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = commService.selectList(map);			
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("commList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	/*=======================================
	 * 게시판 글 상세
	 *======================================*/
	@RequestMapping("/comm/detail")
	public ModelAndView process(@RequestParam int comm_num) {
		log.debug("<<게시판 글 상세 comm_num>> : " + comm_num);
		
		//해당 글의 조회수 증가
		commService.updateComm_hit(comm_num);
		
		CommVO comm = commService.selectComm(comm_num);
		//제목에 태그를 허용하지 않음
		comm.setComm_title(StringUtil.useNoHtml(comm.getComm_title()));
								//타일스 설정명, 속성명, 속성값
		return new ModelAndView("commView", "comm",comm);
	}
	/*=======================================
	 * 파일 다운로드
	 *======================================*/
	@RequestMapping("/comm/file")
	public ModelAndView download(@RequestParam int comm_num,
								 HttpServletRequest request) {
		CommVO comm = commService.selectComm(comm_num);
		
		//파일을 절대경로에서 읽어들여 byte[]로 변환
		byte[] downloadFile = FileUtil.getBytes(request.getServletContext().getRealPath("/upload")
												+"/"+comm.getComm_filename());
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("downloadView");
		mav.addObject("downloadFile", downloadFile);
		mav.addObject("filename", comm.getComm_filename());
		
		return mav;
	}
	/*=======================================
	 * 게시판 글 수정
	 *======================================*/
	//수정 폼 호출
	@GetMapping("/comm/update")
	public String formUpdate(@RequestParam int comm_num,Model model) {
		CommVO commVO = commService.selectComm(comm_num);
		
		model.addAttribute("commVO", commVO);
		
		return "commModify";
	}
	//수정 폼에서 전송된 데이터 처리
	@PostMapping("/comm/update")
	public String submitUpdate(@Valid CommVO commVO,BindingResult result,
			                   HttpServletRequest request, Model model) throws IllegalStateException, IOException {
		log.debug("<<글 수정>> : " + commVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			//title 또는 content가 입력되지 않아 유효성 체크에 걸리면 파일정보를 잃어버리기 때문에 폼을 호출 했을때 다시 셋팅 필요
			CommVO vo = commService.selectComm(commVO.getComm_num());
			commVO.setComm_filename(vo.getComm_filename());				
			return "commModify";
		}
		//DB에 저장된 파일 정보 구하기
		CommVO db_comm = commService.selectComm(commVO.getComm_num());
		
		//파일명 셋팅
		commVO.setComm_filename(FileUtil.createFile(request, commVO.getUpload()));
		//ip셋팅
		commVO.setComm_ip(request.getRemoteAddr());
		
		//글 수정
		commService.updateComm(commVO);
		
		//전송된 파일이 있을 경우 이전 파일 삭제
		if(commVO.getUpload() != null && !commVO.getUpload().isEmpty()) {
			//수정전 파일 삭제 처리
			FileUtil.removeFile(request, db_comm.getComm_filename());
		}
		
		//View에 표시할 메시지
		model.addAttribute("message", "글 수정 완료!!");
		model.addAttribute("url", request.getContextPath()+"/comm/detail?comm_num="+commVO.getComm_num());
			
		return "common/resultAlert";
	}
	/*=======================================
	 * 게시판 글 삭제
	 *======================================*/
	@RequestMapping("/comm/delete")
	public String sumbmitDelete(@RequestParam int comm_num, HttpServletRequest request) {
		log.debug("<<게시판 글 삭제 comm_num>> : " + comm_num);
		
		//DB에 저장된 파일 정보 구하기
		CommVO db_comm = commService.selectComm(comm_num);
		
		//글 삭제
		commService.deleteComm(comm_num);
		
		if(db_comm.getComm_filename() != null) {
			//파일 삭제
			FileUtil.removeFile(request, db_comm.getComm_filename());
		}
		
		return "redirect:/comm/list";
	}
}
