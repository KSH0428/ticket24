package kr.spring.testShow;

import java.nio.charset.StandardCharsets;
import java.util.List;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.xml.MappingJackson2XmlHttpMessageConverter;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import kr.spring.show.vo.ShowVO;

@Component
public class TestShowFetcher {

    public static List<ShowVO> fetchShowData() {
        // 외부 API의 엔드포인트 URL
        String apiUrl = "http://kopis.or.kr/openApi/restful/pblprfr?service=6a4fbcfc007a47a084e4278c7df01ffb&stdate=20240101&eddate=20241231&cpage=2&rows=999&newsql=Y";

        // RestTemplate 생성
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(StandardCharsets.UTF_8));
        restTemplate.getMessageConverters().add(new MappingJackson2XmlHttpMessageConverter());

        // HttpHeaders 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_XML);

        // HttpEntity 설정
        HttpEntity<String> entity = new HttpEntity<>(headers);

        // Exchange 메서드를 사용하여 외부 API에 요청 및 응답 수신
        ResponseEntity<List<ShowVO>> responseEntity = restTemplate.exchange(
            apiUrl,
            HttpMethod.GET,
            entity,
            new ParameterizedTypeReference<List<ShowVO>>() {}
        );

        // 응답 데이터 가져오기
        return responseEntity.getBody();
    }
}
