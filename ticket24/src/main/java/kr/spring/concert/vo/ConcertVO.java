package kr.spring.concert.vo;

public class ConcertVO {
	private int concert_num;
	private String concert_title;
	private String period;
	private String concert_hall;
	private String monopoly;
	private String img_poster;
	private String getImg_poster;
	public int getConcert_num() {
		return concert_num;
	}
	public void setConcert_num(int concert_num) {
		this.concert_num = concert_num;
	}
	public String getConcert_title() {
		return concert_title;
	}
	public void setConcert_title(String concert_title) {
		this.concert_title = concert_title;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public String getConcert_hall() {
		return concert_hall;
	}
	public void setConcert_hall(String concert_hall) {
		this.concert_hall = concert_hall;
	}
	public String getMonopoly() {
		return monopoly;
	}
	public void setMonopoly(String monopoly) {
		this.monopoly = monopoly;
	}
	public String getImg_poster() {
		return img_poster;
	}
	public void setImg_poster(String img_poster) {
		this.img_poster = img_poster;
	}
	public String getGetImg_poster() {
		return getImg_poster;
	}
	public void setGetImg_poster(String getImg_poster) {
		this.getImg_poster = getImg_poster;
	}
	
	
}
