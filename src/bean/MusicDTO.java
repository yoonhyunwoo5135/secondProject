package bean;

import org.jsoup.nodes.Element;

public class MusicDTO {
	private int num; // 음원번호 primary key, auto_increment
	private String title; // 제목
	private String artist; // 가수
	private String date; // 발매일
	private String genre; // 장르
	private int views; // 조회수(스트리밍수)
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getArtist() {
		return artist;
	}
	public void setArtist(String artist) {
		this.artist = artist;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	
	
	
}
