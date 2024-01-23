package kr.spring.show.vo;


import lombok.Data;

@Data
public class ShowVO {
	private String mt20id;      // 공연ID
	private String prfnm;       // 공연명
	private String prfpdfrom;     // 공연시작일
	private String prfpdto;       // 공연종료일
	private String fcltynm;     // 공연시설명
	private String poster;      // 포스터이미지경로
	private String area;        // 공연지역
	private String genrenm;     // 공연 장르명
	private String prfstate;    // 공연상태
	private String openrun;     // 오픈런
	
}
