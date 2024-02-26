package kr.spring.classic.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.classic.service.ClassicService;
import kr.spring.classic.vo.ClassicVO;
import kr.spring.util.PageUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ClassicController {
	@Autowired
	private ClassicService classicService;
	
	
	//클래식 목록
	@RequestMapping("/classic/list")
	public ModelAndView process(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
								@RequestParam(value="order", defaultValue="1") int order,
								String keyfield, String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드 수
		int count = classicService.selectRowCount(map);
		log.debug("<<count>> : " + count);

		System.out.print(">>");
		System.out.println(count);

		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"list","&order="+order);
		
		List<ClassicVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start",page.getStartRow());
			map.put("end", page.getEndRow());

			list = classicService.selectList(map);
		}
		 

		ModelAndView mav = new ModelAndView();
		mav.setViewName("classic");
		mav.addObject("count", count);
		mav.addObject("list",list);
		mav.addObject("page",page.getPage());
		 
		return mav;
	}
	
	
	//---------------------------------------------------------------------------------------------------
	//웹 크롤링 호출
	@RequestMapping("/classic.do")
	public String upload() throws InterruptedException {
		//웹 크롤링할 주소
		//클래식
		String url = "http://ticket.yes24.com/New/Genre/GenreList.aspx?genretype=1&genre=15459";
		//뮤지컬
		//String url = "http://ticket.yes24.com/New/Genre/GenreList.aspx?genretype=1&genre=15457";
		//연극
		//String url = "http://ticket.yes24.com/New/Genre/GenreList.aspx?genretype=1&genre=15458";

		runSelenium(url);

		return "test/test";
	}

	public void runSelenium(String url) throws InterruptedException {
		// 1. WebDriver와 ChromeDriver 설정
		// 프로젝트 폴더 기준으로 chromedirver.exe 파일의 위치를 작성
		System.setProperty("webdriver.chrome.driver", "driver/chromedriver.exe");

		//WebDriver 객체 생성
		ChromeOptions chromeOptions=new ChromeOptions(); // 1) 크롬옵션 생성
		chromeOptions.addArguments("--remote-allow-origins=*"); // 2) 크롬옵션에 설정추가
		WebDriver driver = new ChromeDriver(chromeOptions); // 3) 크롬옵션으로 크롬드라이버 생성



		//웹 페이지 요청
		driver.get(url);
		Thread.sleep(6000); //브라우저 로딩될때까지 잠시 기다린다.//5000 = 5초

		try {

			//이미지
			List<WebElement> link = driver.findElements(By.className("lazyload"));
			//텍스트
			List<WebElement> link2 = driver.findElements(By.className("list-bigger-txt"));
			//상세정보 링크 따기
			List<WebElement> link3 = driver.findElements(By.xpath("/html/body/section/div/a"));

			int num = 0;
			for(int i = 0; i < link.size(); i++) {

				ClassicVO classic = new ClassicVO();

				//이미지
				classic.setImg_poster(link.get(i).getAttribute("src"));
				//텍스트
				String[] str = link2.get(i).getText().split("\n");

				if(str.length == 4) {
					classic.setMonopoly("단독");
				}else {
					classic.setMonopoly("일반");
				}

				String st = link3.get(i).getAttribute("onclick");

				classic.setClassic_title(str[0]);
				classic.setPeriod(str[1]);
				classic.setClassic_hall(str[2]);

				classicService.insertClassic(classic);

				//세부 정보 크롤링 (순서 : 리스트 만들고 그 다음 상세 정보 넣기)
				//runSelenium_detail(st.replaceAll("[^0-9]",""), ++num);
			}

			//WebDriver 종료
			System.out.println("종료");
			driver.quit();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}


		
}
