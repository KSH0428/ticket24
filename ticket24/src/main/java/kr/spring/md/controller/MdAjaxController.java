package kr.spring.md.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.md.service.AdminMdService;
import kr.spring.md.service.MdService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MdAjaxController {
	@Autowired
	private AdminMdService adminMdService;
	
	
	}
	
	
