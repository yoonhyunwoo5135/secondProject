package bean;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class MusicDAO {
	DBConnectionMgr mgr;
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	String url;
	String user;
	String password;

	public ArrayList<String> album(String code) throws Exception { // 앨범사진으로 앨범페이지가서 내용 추출
		Document doc = Jsoup.connect("https://www.genie.co.kr/" + code).get();
		String folder = doc.title();
		Element element = doc.select("div.recent-music").get(0);
		Elements img = element.select("img");
		int page = 0;
		ArrayList<String> cover = new ArrayList<String>();
		int i = 0;
		for (Element e : img) {
			String url = e.getElementsByAttribute("src").attr("src");
			cover.add(url);
			i++;
		}
		System.out.println("메인사진 가져오기 성공");
		return cover;
	}

	public ArrayList<String> mainImage(){ // 메인에 있는 앨범사진 추출
		ArrayList<String> cover = new ArrayList<String>();
		Document doc;
		try {
			doc = Jsoup.connect("https://www.genie.co.kr/").get();
		String folder = doc.title();
		Element element = doc.select("div.recent-music").get(0);
		Elements img = element.select("img");
		int page = 0;
		int i = 0;
		for (Element e : img) {
			String url = e.getElementsByAttribute("src").attr("src");
			cover.add(url);
			i++;
		}
		System.out.println("메인사진 가져오기 성공");
		}
		catch (IOException e1) {
			e1.printStackTrace();
		}
		return cover;
	}

	public String[] image() throws Exception { // top50 페이지의 이미지 주소배열
		Document doc = Jsoup.connect("https://www.genie.co.kr/chart/top200").get();
		String folder = doc.title();
		Element element = doc.select("div.music-list-wrap").get(0);
		Elements img = element.select("img");
		int page = 0;
		String[] cover = new String[50];
		int i = 0;
		for (Element e : img) {
			String url = e.getElementsByAttribute("src").attr("src");
			System.out.println(url);
			cover[i] = url;
			i++;
		}
		System.out.println("top50의 앨범사진 가져오기 성공");
		return cover;
	}
	public String[] newimage() throws Exception { // top50 페이지의 이미지 주소배열
		Document doc = Jsoup.connect("https://www.genie.co.kr/newest/song").get();
		String folder = doc.title();
		Element element = doc.select("div.music-list-wrap").get(0);
		Elements img = element.select("img");
		int page = 0;
		String[] cover = new String[50];
		int i = 0;
		for (Element e : img) {
			String url = e.getElementsByAttribute("src").attr("src");
			System.out.println(url);
			cover[i] = url;
			i++;
		}
		System.out.println("top50의 앨범사진 가져오기 성공");
		return cover;
	}

	public void drop() throws Exception { // mp3 테이블 내용삭제, 순번 초기화
		DBConnectionMgr mgr = DBConnectionMgr.getInstance();

		Connection con = mgr.getConnection();

		String sql1 = "delete from mp3;";
		String sql2 = "alter table mp3 auto_increment=1";

		PreparedStatement ps1 = con.prepareStatement(sql1);
		PreparedStatement ps2 = con.prepareStatement(sql2);

		ps1.executeUpdate();
		ps2.executeUpdate();
		System.out.println("mp3테이블 데이터 삭제, 순번 호기화 완료");
	}
	public void drop2() throws Exception { // mp3 테이블 내용삭제, 순번 초기화
		DBConnectionMgr mgr = DBConnectionMgr.getInstance();
		
		Connection con = mgr.getConnection();
		
		String sql1 = "delete from newmp3;";
		String sql2 = "alter table newmp3 auto_increment=1";
		
		PreparedStatement ps1 = con.prepareStatement(sql1);
		PreparedStatement ps2 = con.prepareStatement(sql2);
		
		ps1.executeUpdate();
		ps2.executeUpdate();
		System.out.println("mp3테이블 데이터 삭제, 순번 초기화 완료");
	}

	public void top50() {
		MusicDTO dto = new MusicDTO();
		String url1 = "https://www.genie.co.kr/chart/top200";
		Document doc = null;

		try {
			doc = Jsoup.connect(url1).get();
		} catch (IOException e) {
			e.printStackTrace();
		}

		Elements element = doc.select("td.info");
		// 원하는 내용이 있는 틀(?) 입력

		MusicDAO dao = new MusicDAO();
		ArrayList list = new ArrayList();
		int n = 0;

		for (Element artist : element.select("a.artist.ellipsis")) { // 가수명
			dto = new MusicDTO();
			try {
				dto.setArtist(artist.text());
				list.add(dto);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		n = 0;
		for (Element title : element.select("a.title.ellipsis")) { // 노래제목
			dto = new MusicDTO();
			try {
				dto = (MusicDTO)list.get(n);
				dto.setTitle(title.text());
				dao.insert(dto);
				n++;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println("top50곡 가수, 제목 DB저장완료");
	}

	public void insert(MusicDTO dto) throws Exception {
		DBConnectionMgr mgr = DBConnectionMgr.getInstance();

		Connection con = mgr.getConnection();

		String sql = "insert into mp3 (title,artist,date,genre,views) values (?,?,?,?,?)";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, dto.getTitle());
		ps.setString(2, dto.getArtist());
		ps.setString(3, dto.getDate());
		ps.setString(4, dto.getGenre());
		ps.setInt(5, dto.getViews());

		ps.executeUpdate();

		mgr.freeConnection(con, ps);
	}

	public ArrayList selectAll() {// 모든정보 검색

		ArrayList list = new ArrayList();
		MusicDTO dto = null;
		DBConnectionMgr mgr = DBConnectionMgr.getInstance();

		try {

			con = mgr.getConnection();

			System.out.println("2. DB연결 완료");

			String sql = "select * from mp3";
			ps = con.prepareStatement(sql);

			System.out.println("3. SQL문 객체화 완료");

			rs = ps.executeQuery();

			while (rs.next()) {
				dto = new MusicDTO();
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setArtist(rs.getString(3));
				dto.setDate(rs.getString(4));
				dto.setGenre(rs.getString(5));
				dto.setViews(rs.getInt(6));

				list.add(dto);
			}
			System.out.println("4. SQL문 전송 완료");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				ps.close();
				con.close();
				mgr.freeConnection(con, ps, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		System.out.println("저장된 mp3가져오기 성공");
		return list;
	}
	public void newmusic() {
		MusicDTO dto = new MusicDTO();
		String url2 = "https://www.genie.co.kr/newest/song";
		Document doc = null;
		
		try {
			doc = Jsoup.connect(url2).get();
		} catch (IOException e) {
			e.printStackTrace();
		}

		Elements element = doc.select("td.info");
		// 원하는 내용이 있는 틀(?) 입력

		MusicDAO dao = new MusicDAO();
		ArrayList list = new ArrayList();
		int n = 0;
		
		for (Element artist : element.select("a.artist.ellipsis")) { // 가수명
			dto = new MusicDTO();
			try {
				dto.setArtist(artist.text());
				list.add(dto);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		n = 0;
		for (Element title : element.select("a.title.ellipsis")) { // 노래제목
			dto = new MusicDTO();
			try {
				dto = (MusicDTO)list.get(n);
				dto.setTitle(title.text());
				dao.insertNew(dto);
				n++;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println("top50곡 가수, 제목 DB저장완료");
	}
	public ArrayList selectAllNew() {// 모든정보 검색

		ArrayList list = new ArrayList();
		MusicDTO dto = null;
		DBConnectionMgr mgr = DBConnectionMgr.getInstance();

		try {

			con = mgr.getConnection();

			System.out.println("2. DB연결 완료");

			String sql = "select * from newmp3";
			ps = con.prepareStatement(sql);

			System.out.println("3. SQL문 객체화 완료");

			rs = ps.executeQuery();

			while (rs.next()) {
				dto = new MusicDTO();
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setArtist(rs.getString(3));
				dto.setDate(rs.getString(4));
				dto.setGenre(rs.getString(5));
				dto.setViews(rs.getInt(6));

				list.add(dto);
			}
			System.out.println("4. SQL문 전송 완료");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				ps.close();
				con.close();
				mgr.freeConnection(con, ps, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		System.out.println("저장된 mp3가져오기 성공");
		return list;
	}
	public void insertNew(MusicDTO dto) throws Exception {
		DBConnectionMgr mgr = DBConnectionMgr.getInstance();

		Connection con = mgr.getConnection();

		String sql = "insert into newmp3 (title,artist,date,genre,views) values (?,?,?,?,?)";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, dto.getTitle());
		ps.setString(2, dto.getArtist());
		ps.setString(3, dto.getDate());
		ps.setString(4, dto.getGenre());
		ps.setInt(5, dto.getViews());

		ps.executeUpdate();

		mgr.freeConnection(con, ps);
	}
}