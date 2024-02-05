package kr.spring.concert.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import kr.spring.concert.service.ConcertService;
import kr.spring.concert.vo.ConcertDetailVO;
import kr.spring.concert.vo.ConcertRoundVO;
import kr.spring.concert.vo.ConcertVO;
import kr.spring.util.PageUtil;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ConcertController {
	@Autowired
	private ConcertService concertService;

	//콘서트 목록
	@RequestMapping("/concert/list")
	public ModelAndView process(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
								@RequestParam(value="order", defaultValue="1") int order,
								String keyfield, String keyword) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드 수
		int count = concertService.selectRowCount(map);
		log.debug("<<count>> : " + count);

		System.out.print(">>");
		System.out.println(count);

		PageUtil page = new PageUtil(keyfield,keyword,currentPage,count,20,10,"list","&order="+order);
		
		List<ConcertVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start",page.getStartRow());
			map.put("end", page.getEndRow());

			list = concertService.selectList(map);
		}
		 

		ModelAndView mav = new ModelAndView();
		mav.setViewName("concert"); //tiles-def.ysw.xml name="concert"
		mav.addObject("count", count);
		mav.addObject("list",list);
		mav.addObject("page",page.getPage());
		 
		return mav;
	}
	
	//게시판 상세 글
	@RequestMapping("/concert/detail")
	public ModelAndView process(@RequestParam int concert_num) {
		log.debug("<<콘서트 게시물 상세 concert_num>> : " + concert_num);
		
		//조회수 처리?
		
		ConcertDetailVO concert = concertService.selectConcert(concert_num);
		List<ConcertRoundVO> round = concertService.selectRoundList(concert_num);
		
		//System.out.println(concert);
		
		//제목에 노태그 처리?
		
		
		
		return new ModelAndView("concertView","concert",concert);
	}

	//예약 팝업 창
	@RequestMapping
	public ModelAndView reserveConcert() {
		
		
		return null;
	}
	//---------------------------------------------------------------------------------------------------
	//웹 크롤링 호출
	@RequestMapping("/concert.do")
	public String upload() throws InterruptedException {
		//웹 크롤링할 주소
		//콘서트
		String url = "http://ticket.yes24.com/New/Genre/GenreList.aspx?genretype=1&genre=15456";
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

				ConcertVO concert = new ConcertVO();

				//이미지
				concert.setImg_poster(link.get(i).getAttribute("src"));
				//텍스트
				String[] str = link2.get(i).getText().split("\n");

				if(str.length == 4) {
					concert.setMonopoly("단독");
				}else {
					concert.setMonopoly("일반");
				}

				String st = link3.get(i).getAttribute("onclick");

				concert.setConcert_title(str[0]);
				concert.setPeriod(str[1]);
				concert.setConcert_hall(str[2]);

				concertService.insertConcert(concert);

				//세부 정보 크롤링 (순서 : 리스트 만들고 그 다음 상세 정보 넣기)
				runSelenium_detail(st.replaceAll("[^0-9]",""), ++num);
			}

			//WebDriver 종료
			System.out.println("종료");
			driver.quit();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void runSelenium_detail(String sub_url, int num) throws InterruptedException {

		//기본 주소에 상세 정보 번호를 붙임
		String url = "http://ticket.yes24.com/Special/" + sub_url;

		//WebDriver 객체 생성
		ChromeOptions chromeOptions = new ChromeOptions(); // 1) 크롬옵션 생성
		chromeOptions.addArguments("--remote-allow-origins=*"); // 2) 크롬옵션에 설정추가
		WebDriver driver = new ChromeDriver(chromeOptions); // 3) 크롬옵션으로 크롬드라이버 생성

		//웹 페이지 요청
		driver.get(url);
		Thread.sleep(3000); //브라우저 로딩될때까지 잠시 기다린다.//5000 = 5초

		ConcertDetailVO concert = new ConcertDetailVO();

		try {
			//등급, 공연시간
			WebElement list_detail = driver.findElement(By.className("rn-product-area1"));
			//공연 날짜
			WebElement list_detail2 = driver.findElement(By.className("rn-product-area3"));
			//이미지
			List<WebElement> list_detail3 = driver.findElements(By.className("txc-image"));

			//개행 문자를 기준으로 문자열 추출하여 배열로 저장
			String[] str = list_detail.getText().split("\n");
			String[] str2 = list_detail2.getText().split("\n");		

			//상세 설명 이미지 담을 배열
			String[] str3 = null;


			//등급
			str[1] = str[1].trim();
			if(str[1].length()>16 || str[1].contains("--")) {
				str[1] = "전체관람가";
			}

			concert.setConcert_num(num);
			concert.setGrade(str[1]);

			//관람시간
			str[3] = str[3].trim();
			concert.setViewing_time(str[3]);

			//출연진
			str[5] = str[5].trim();
			concert.setCasting(str[5]);

			//공연정보
			str2[1] = str2[1].trim();
			
			//문자열이 숫자로 시작하지 않으면
			if(!str2[1].matches("^\\d.*")) {
				//숫자로 시작하는 인덱스를 찾아서 앞부분을 자른다.
				int index = 0;
				for(int i = 0; i < str2[1].length(); i++) {
					char c = str2[1].charAt(i);
					if (Character.isDigit(c)) {
		                index = i;
		                str2[1] = str2[1].substring(index,str2[1].length());
		                break;
		            }
				}
			}
			
			
			//기간으로 표시된 경우 잘라서 표시한다.
			if(str2[1].matches(".*[,|~].*")) {
				String[] strArr = str2[1].split(",|~");
				int cnt = 0;
				for(String s : strArr) {
					str2[++cnt] = s;
				}
				
				//날짜 형식 맞춰주기
				//"일"으로 끝나는지 확인. 이떄 (일)요일은 후순위라 신경쓰지 않아도 된다.
				if(str2[1].contains("일")&&!(str2[1].matches(".*['PM'|'AM'].*"))) {
					//오전/오후 시간 포함인지 파악
					if(str2[1].contains("오")) {
						str2[2] = str2[1].substring(0,str2[1].indexOf("오")+2) + str2[2];
					//오전/오후 시간 앞 시간대에 가져오기
					}else if(str2[2].contains("오")) {
						str2[1] = str2[1] + str2[2].substring(str2[2].indexOf("오")-1);
						str2[2] = str2[1].substring(0,str2[1].indexOf("일")-2) + str2[2];
					//X박X일 형식
					}else if(str2[2].contains("박")&&!str2[1].contains("박")){
						str2[1] = str2[1] + str2[2].substring(str2[2].indexOf("박")-2);
						str2[2] = "2024년 " + str2[2];
						//오전/오후 없는 경우
					}else {
						str2[2] = str2[1].substring(0,str2[1].indexOf("일")-2) + str2[2];
					}
				}else if(!str2[2].contains("년")) {
					str2[2] = "2024년 " + str2[2].trim();
				}
				
				
				concert.setC_round_2(str2[2].trim());
			}else if(!str2[2].contains("배송")) {
				str2[2] = str2[2].trim();
				concert.setC_round_2(str2[2]);
				//else if로 분기 한 번 더 만들어야함
			}else {
				concert.setC_round_2("null");
			}
			
			concert.setC_round_1(str2[1]);
			
			/*
			System.out.print("c_round_1 : ");
			System.out.println(concert.getC_round_1());
			System.out.print("c_round_2 : ");
			System.out.println(concert.getC_round_2());
			System.out.println("-----------------------------");
			*/
			

			concert_round(concert.getC_round_1(), num);
			concert_round(concert.getC_round_2(), num);


			//소개 이미지
			switch(list_detail3.size()) {
			case 7:
				concert.setImage_7(list_detail3.get(6).getAttribute("src"));
			case 6:
				concert.setImage_6(list_detail3.get(5).getAttribute("src"));
			case 5:
				concert.setImage_5(list_detail3.get(4).getAttribute("src"));
			case 4:
				concert.setImage_4(list_detail3.get(3).getAttribute("src"));
			case 3:
				concert.setImage_3(list_detail3.get(2).getAttribute("src"));
			case 2:
				concert.setImage_2(list_detail3.get(1).getAttribute("src"));
			case 1:
				concert.setImage_1(list_detail3.get(0).getAttribute("src"));
			}



			concertService.insertConcertDetail(concert);

			//드라이버 종료
			driver.quit();
		}catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	private void concert_round(String src, int num) {
		
		System.out.println("num : " + num + ", " + src);
		System.out.println("---------------------------");
		
		if(src.matches(".*[(|)].*")) {
			
			String[] strArr = src.split("\\(|\\)");
			String src_date = strArr[0];
			String src_time = null;
			if(strArr.length > 2) {
				src_time = strArr[2].trim();
			}
			
			//가끔 형태가 다른 것들이 나오므로(ex.2024년, 24년. 3월, 03월) 날짜 포맷을 통일시키고 년, 월, 일 순으로 자른다.
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy년 MM월 dd일");
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
			
			try {
				Date fm = sdf1.parse(src_date);
				String s = sdf2.format(fm);
				
				String[] date = s.split("-");
				
				String year = date[0];
				String month = date[1];
				String day = date[2];
				
				ConcertRoundVO round = new ConcertRoundVO();
				
				round.setConcert_num(num);
				round.setYear(year);
				round.setMonth(month);
				round.setDay(day);
				round.setConcert_time(src_time);
				
				concertService.insertConcertRound(round);
				
				/*
				System.out.print("year : ");
				System.out.print(year);
				System.out.print(", ");
				System.out.print("month : ");
				System.out.print(month);
				System.out.print(", ");
				System.out.print("day : ");
				System.out.println(day);
				*/
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
		}
		
		
	}
}
