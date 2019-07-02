package bean;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Cover {

	MusicDTO dto = new MusicDTO();
	MusicDAO dao = new MusicDAO();
	 public static void main(String[] args) throws Exception {
	        
	        Document doc = Jsoup.connect("https://www.genie.co.kr/chart/top200").get();
	        String folder = doc.title();
	        Element element = doc.select("div.music-list-wrap").get(0);
	        Elements img = element.select("img");
	        int page = 0;
	        for (Element e : img) {
	            String url = e.getElementsByAttribute("src").attr("src");
	            System.out.println(url);
	        }
	    }


	
	}

