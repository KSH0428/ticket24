package kr.spring.ticket.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

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

import kr.spring.ticket.service.TicketService;
import kr.spring.ticket.vo.TicketVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PageUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class TicketController {
	@Autowired
	private TicketService ticketService;
	
	/*=======================================
	 * 게시판 글 등록
	 *======================================*/
	//자바빈(VO)초기화
	@ModelAttribute
	public TicketVO initCommand() {
		return new TicketVO();
	}
	//등록 폼 호출
	@GetMapping("/ticket/write")
	public String form() {
		return "ticketWrite";
	}
	
	//전송된 데이터 처리
	@PostMapping("/ticket/write")
	public String submit(@Valid TicketVO ticketVO, BindingResult result,
						  HttpServletRequest request,
						  HttpSession session, Model model) throws IllegalStateException, IOException {
		log.debug("<<티켓양도 글 저장>> : " + ticketVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		//파일업로드
		ticketVO.setTicket_filename1(FileUtil.createFile(request, ticketVO.getUpload()));
		ticketVO.setTicket_filename2(FileUtil.createFile(request, ticketVO.getUpload2()));
		ticketVO.setTicket_filename3(FileUtil.createFile(request, ticketVO.getUpload3()));
		ticketVO.setTicket_filename4(FileUtil.createFile(request, ticketVO.getUpload4()));
		//글쓰기
		ticketService.insertTicket(ticketVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "상품등록이 완료되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/ticket/list");
			
		return "common/resultAlert";
	}
	/*=======================================
	 * 게시판 글 목록
	 *======================================*/
	@RequestMapping("/ticket/list")
	public ModelAndView process(@RequestParam(value="pageNum",defaultValue="1")int currentPage,
								@RequestParam(value="order",defaultValue="1") int order,
								@RequestParam(value="ticket_category", defaultValue="") String ticket_category,
								String keyfield, String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyword);
		map.put("keyword", keyword);
		map.put("ticket_category", ticket_category);
		
		//전체/검색 레코드 수
		int count = ticketService.SelectRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"list", "&order="+order+"&ticket_category="+ticket_category);
		
		List<TicketVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = ticketService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("ticketList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	/*=======================================
	 * 게시판 글 상세
	 *======================================*/
	@RequestMapping("/ticket/detail")
	public ModelAndView process(@RequestParam int ticket_num) {
		log.debug("<<티켓양도 글 상세 ticket_num>> : " + ticket_num);
		
		TicketVO ticket = ticketService.selectTicket(ticket_num);
		//제목에 태그를 허용하지 않음
		ticket.setTicket_name(StringUtil.useNoHtml(ticket.getTicket_name()));
								//타일스 설정명,   속성명,    속성값
		return new ModelAndView("ticketView", "ticket", ticket);
	}
	/*=======================================
	 * 파일 다운로드
	 *======================================*/
	@RequestMapping("/ticket/file")
	public ModelAndView download(@RequestParam int ticket_num, @RequestParam int file_num,
								 HttpServletRequest request) {
		TicketVO ticket = ticketService.selectTicket(ticket_num);
		
		//파일을 절대경로에서 읽어들여 byte[]로 변환
		byte[] downloadFile = FileUtil.getBytes(request.getServletContext().getRealPath("/upload")
												+"/"+ticket.getTicket_filename1());
		byte[] downloadFile2 = FileUtil.getBytes(request.getServletContext().getRealPath("/upload")
				+"/"+ticket.getTicket_filename2());
		byte[] downloadFile3 = FileUtil.getBytes(request.getServletContext().getRealPath("/upload")
				+"/"+ticket.getTicket_filename3());
		byte[] downloadFile4 = FileUtil.getBytes(request.getServletContext().getRealPath("/upload")
				+"/"+ticket.getTicket_filename4());
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("downloadView");
		mav.addObject("downloadFile", downloadFile);
		mav.addObject("downloadFile2", downloadFile2);
		mav.addObject("downloadFile3", downloadFile3);
		mav.addObject("downloadFile4", downloadFile4);
		mav.addObject("filename",ticket.getTicket_filename1());
		mav.addObject("filename",ticket.getTicket_filename2());
		mav.addObject("filename",ticket.getTicket_filename3());
		mav.addObject("filename",ticket.getTicket_filename4());
				
		return mav;
		
	}
	/*=======================================
	 * 티켓양도 글 수정
	 *======================================*/
	//수정폼 호출
	@GetMapping("/ticket/delete")
	public String formUpdate(@RequestParam int ticket_num,Model model) {
		TicketVO ticketVO = ticketService.selectTicket(ticket_num);
		
		model.addAttribute("ticketVO",ticketVO);
		
		return "ticketModify";		
	}
	//수정 폼에서 전송된 데이터 처리
	@PostMapping("/ticket/update")
	public String submitUpdate(@Valid TicketVO ticketVO,BindingResult result,
								HttpServletRequest request, Model model) throws IllegalStateException, IOException {
		log.debug("<<글 수정 >> : " + ticketVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			//title 또는 content가 입력되지 않아 유효성 체크에 걸리면 파일정보를 잃어버리기 때문에 폼을 호출 했을때 다시 셋팅 필요
			TicketVO vo = ticketService.selectTicket(ticketVO.getTicket_num());
			ticketVO.setTicket_filename1(vo.getTicket_filename1());
			ticketVO.setTicket_filename2(vo.getTicket_filename2());
			ticketVO.setTicket_filename3(vo.getTicket_filename3());
			ticketVO.setTicket_filename4(vo.getTicket_filename4());			
			return "ticketModify";
		}
		//DB에 저장된 파일 정보 구하기
		TicketVO db_ticket = ticketService.selectTicket(ticketVO.getTicket_num());
		
		//파일명 셋팅
		ticketVO.setTicket_filename1(FileUtil.createFile(request, ticketVO.getUpload()));
		ticketVO.setTicket_filename2(FileUtil.createFile(request, ticketVO.getUpload2()));
		ticketVO.setTicket_filename3(FileUtil.createFile(request, ticketVO.getUpload3()));
		ticketVO.setTicket_filename4(FileUtil.createFile(request, ticketVO.getUpload4()));
		
		//글 수정
		ticketService.updateTicket(ticketVO);
		
		//전송된 파일이 있을 경우 이전 파일 삭제
		if(ticketVO.getUpload() != null && !ticketVO.getUpload().isEmpty()) {
			// 수정전 파일 삭제 처리
			FileUtil.removeFile(request, db_ticket.getTicket_filename1());
		}
		else if(ticketVO.getUpload2() != null && !ticketVO.getUpload2().isEmpty()) {
			// 수정전 파일 삭제 처리
			FileUtil.removeFile(request, db_ticket.getTicket_filename2());
		}
		else if(ticketVO.getUpload3() != null && !ticketVO.getUpload3().isEmpty()) {
			// 수정전 파일 삭제 처리
			FileUtil.removeFile(request, db_ticket.getTicket_filename3());
		}
		else if(ticketVO.getUpload4() != null && !ticketVO.getUpload4().isEmpty()) {
			// 수정전 파일 삭제 처리
			FileUtil.removeFile(request, db_ticket.getTicket_filename4());
		}
		
		//View에 표시할 메시지
		model.addAttribute("message", "상품 수정 완료!!");
		model.addAttribute("url", request.getContextPath()+"/ticket/detail?ticket_num="+ticketVO.getTicket_num());
		
		return "common/resultAlert";
	}
	/*=======================================
	 * 게시판 글 삭제
	 *======================================*/
}
