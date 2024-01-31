package kr.spring.event.controller;

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

import kr.spring.event.service.EventService;
import kr.spring.event.vo.EventVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.question.vo.QuestionVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PageUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EventController {
	@Autowired
	private EventService eventService;
	
	/*=====================
	 * 이벤트 등록(관리자)
	 *=====================*/
	//자바빈(VO) 초기화
	@ModelAttribute
	public EventVO initCommand() {
		return new EventVO();
	}
	
	//등록 폼 호출
	@GetMapping("/event/write")
	public String form() {
		return "eventWrite";
	}
	
	//전송된 데이터 처리
	@PostMapping("/event/write")
	public String submit(@Valid EventVO eventVO, BindingResult result,
						 HttpServletRequest request, HttpSession session, Model model) throws IllegalStateException, IOException {
		log.debug("<<이벤트 등록>> : " + eventVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		eventVO.setEvent_photo1(FileUtil.createFile(request, eventVO.getUpload1()));
		eventVO.setEvent_photo2(FileUtil.createFile(request, eventVO.getUpload2()));
		//글 쓰기
		eventService.insertEvent(eventVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "이벤트가 등록되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/event/list");
			    
		return "common/resultAlert";
	}
	
	/*=====================
	 * 이벤트 리스트
	 *=====================*/
	@RequestMapping("/event/list")
	public ModelAndView process(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
								String keyword) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		
		int count = eventService.selectRowCount(map);
		log.debug("<<count>> : " + count);
		
		PageUtil page = new PageUtil(null, keyword, currentPage, count, 9, 10, "list");
		
		List<EventVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = eventService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("eventList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*=====================
	 * 이벤트 상세
	 *=====================*/
	@RequestMapping("/event/detail")
	public ModelAndView process(@RequestParam int event_num, HttpSession session) {
		log.debug("<<이벤트 상세>> : " + event_num);
		
		//해당 글의 조회수 증가
		eventService.updateHit(event_num);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		//이벤트 조회
		EventVO event = eventService.selectEvent(event_num);
		event.setEvent_title(StringUtil.useNoHtml(event.getEvent_title()));
		
		ModelAndView mav = new ModelAndView("eventView");
		mav.addObject("event", event);
		mav.addObject("user", user);
		
		return mav;
	}
	
	/*=====================
	 * 이벤트 수정
	 *=====================*/
	//수정폼 호출
	@GetMapping("/event/update")
	public String formUpdate(@RequestParam int event_num, Model model) {
		EventVO eventVO = eventService.selectEvent(event_num);
		
		model.addAttribute("eventVO",eventVO);
		
		return "eventModify";
	}
	
	//수정폼에서 전송된 데이터 처리
	@PostMapping("/event/update")
	public String submitUpdate(@Valid EventVO eventVO, BindingResult result,
							   HttpServletRequest request, Model model) throws IllegalStateException, IOException {
		log.debug("<<이벤트 수정>> : " + eventVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			//title 또는 content가 입력되지 않아 유효성 체크에 걸리면
			//파일 정보를 잃어버리기 때문에 폼을 호출할 때 다시 셋팅해주어야 함
			EventVO vo = eventService.selectEvent(eventVO.getEvent_num());
			eventVO.setEvent_photo1(vo.getEvent_photo1());
			eventVO.setEvent_photo2(vo.getEvent_photo2());
			
			return "eventModify";
		}
		
		//DB에 저장된 파일 정보 구하기
		EventVO db_event = eventService.selectEvent(eventVO.getEvent_num());
		log.debug("<<db_event>> : " + db_event);
		//파일명 셋팅
		eventVO.setEvent_photo1(FileUtil.createFile(request, eventVO.getUpload1()));
		eventVO.setEvent_photo2(FileUtil.createFile(request, eventVO.getUpload2()));
		//이벤트 수정
		eventService.updateEvent(eventVO);
		//전송된 파일이 있을 경우 이전 파일 삭제
		if(eventVO.getUpload1() != null && !eventVO.getUpload1().isEmpty()) {
			//수정 전 파일 삭제 처리
			FileUtil.removeFile(request, db_event.getEvent_photo1());
		}else if(eventVO.getUpload2() != null && !eventVO.getUpload2().isEmpty()) {
			FileUtil.removeFile(request, db_event.getEvent_photo2());
		}
		
		model.addAttribute("message", "이벤트 수정 완료!");
		model.addAttribute("url", request.getContextPath() + "/event/detail?event_num=" + eventVO.getEvent_num());
		
		return "common/resultAlert";
	}
	
	/*=====================
	 * 이벤트 삭제
	 *=====================*/
	@RequestMapping("/event/delete")
	public String submitDelete(@RequestParam int event_num, HttpServletRequest request) {
		log.debug("<<이벤트 삭제>> : " + event_num);
		
		//DB에 저장된 이벤트 정보 구하기
		EventVO db_event = eventService.selectEvent(event_num);
		//이벤트 글 삭제
		eventService.deleteEvent(event_num);
		//사진 삭제
		if(db_event.getEvent_photo1() != null) {
			FileUtil.removeFile(request, db_event.getEvent_photo1());
		}else if(db_event.getEvent_photo2() != null) {
			FileUtil.removeFile(request, db_event.getEvent_photo2());
		}
		
		return "redirect:/event/list";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
