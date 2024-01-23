package kr.spring.show.vo;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class ShowDataRequest {
    private final String apiUrl;
    private final String apiKey;
    private final String stdate;
    private final String eddate;
    private final String cpage;
    private final String rows;
    private final String shprfnm;
    private final String shprfnmfct;
    private final String shcate;
    private final String prfplccd;
    private final String signgucode;
    private final String signgucodesub;
    private final String kidstate;
    private final String prfstate;
    private final String newsql;

    // Spring이 빈을 생성할 때 사용하는 기본 생성자
    public ShowDataRequest() {
        this.apiUrl = null;
        this.apiKey = null;
        this.stdate = null;
        this.eddate = null;
        this.cpage = null;
        this.rows = null;
        this.shprfnm = null;
        this.shprfnmfct = null;
        this.shcate = null;
        this.prfplccd = null;
        this.signgucode = null;
        this.signgucodesub = null;
        this.kidstate = null;
        this.prfstate = null;
        this.newsql = null;
    }

    // 인스턴스를 생성할 때 사용하는 매개변수가 있는 생성자
    public ShowDataRequest(String apiUrl, String apiKey, String stdate, String eddate,
            String cpage, String rows, String shprfnm, String shprfnmfct, String shcate,
            String prfplccd, String signgucode, String signgucodesub, String kidstate,
            String prfstate, String newsql) {
        this.apiUrl = apiUrl;
        this.apiKey = apiKey;
        this.stdate = stdate;
        this.eddate = eddate;
        this.cpage = cpage;
        this.rows = rows;
        this.shprfnm = shprfnm;
        this.shprfnmfct = shprfnmfct;
        this.shcate = shcate;
        this.prfplccd = prfplccd;
        this.signgucode = signgucode;
        this.signgucodesub = signgucodesub;
        this.kidstate = kidstate;
        this.prfstate = prfstate;
        this.newsql = newsql;
    }
}