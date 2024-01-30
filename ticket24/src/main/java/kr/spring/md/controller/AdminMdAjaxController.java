package kr.spring.md.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import kr.spring.md.service.AdminMdService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminMdAjaxController {
	@Autowired
	private AdminMdService adminMdService;

}
