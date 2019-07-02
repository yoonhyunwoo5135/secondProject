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

public class ChartDAO {
	DBConnectionMgr mgr;
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	String url;
	String user;
	String password;
	
	public ArrayList genre(int x){// 0~7 까지 장르별로 선택
		
		ArrayList list = new ArrayList();
		ChartDTO dto = null;
		String[] sql = new String[8];
		mgr = DBConnectionMgr.getInstance();
		try {
			con = mgr.getConnection();
			System.out.println("2. DB연결 완료");
			
				sql[0] = "select title, artist, genre, count from chart where genre like '%발라드%'";
				sql[1] = "select title, artist, genre, count from chart where genre like '%힙합%'";
				sql[2] = "select title, artist, genre, count from chart where genre like '%OST%'";
				sql[3] = "select title, artist, genre, count from chart where genre like '%댄스%'";
				sql[4] = "select title, artist, genre, count from chart where genre like '%블루스%'";
				sql[5] = "select title, artist, genre, count from chart where genre like '%일렉트로니카%'";
				sql[6] = "select title, artist, genre, count from chart where genre like '%인디%'";
				sql[7] = "select title, artist, genre, count from chart where genre like '%락%'";
			
			ps = con.prepareStatement(sql[x]);
			System.out.println("3. SQL문 객체화 완료");
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				dto = new ChartDTO();
				String title = rs.getString(1);
				String time = rs.getString(2);
				String genre = rs.getString(3);
				String count = rs.getString(4);
				
				dto.setTitle(title);
				dto.setArtist(time);
				dto.setGenre(genre);
				dto.setCount(count);
				list.add(dto);
			} 
			System.out.println("4. SQL문 전송 완료");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
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
		System.out.println("저장된 chart가져오기 성공");
		return list;
	} // selectAll end
	
	public ArrayList pop(int x){ // 0일때는 가요, 1일때는 팝송 선택
		
		ArrayList list = new ArrayList();
		ChartDTO dto = null;
		mgr = DBConnectionMgr.getInstance();
		try {
			con = mgr.getConnection();
			System.out.println("2. DB연결 완료");
			String sql = null;
			if(x==0) {
				sql = "select title from chart where genre like '%가요%'";
			} else {
				sql = "select title from chart where genre like '%POP%'";
			}
			ps = con.prepareStatement(sql);
			System.out.println("3. SQL문 객체화 완료");
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				dto = new ChartDTO();
				String title = rs.getString(1);
				list.add(title);
			} 
			System.out.println("4. SQL문 전송 완료");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
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
		System.out.println("저장된 chart가져오기 성공");
		return list;
		
	} // selectAll end
	
	public ArrayList selectAll(){ // 모든 콜롬가져옴
		
		ArrayList list = new ArrayList();
		ChartDTO dto = null;
		mgr = DBConnectionMgr.getInstance();
		try {
			con = mgr.getConnection();
			System.out.println("2. DB연결 완료");
			
			String sql = "select * from chart";
			ps = con.prepareStatement(sql);
			System.out.println("3. SQL문 객체화 완료");
			
			rs = ps.executeQuery();
			
			
			while(rs.next()) {
				dto = new ChartDTO();
				String title = rs.getString(1);
				String artist = rs.getString(2);
				String genre = rs.getString(3);
				String count = rs.getString(4);
				dto.setTitle(title);
				dto.setArtist(artist);
				dto.setGenre(genre);
				dto.setCount(count);
				
				list.add(dto);
				
			} 
			System.out.println("4. SQL문 전송 완료");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
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
		System.out.println("저장된 chart가져오기 성공");
		return list;
	} // selectAll end
	
	public void update(String title, String time, String genre, int count) throws Exception { // 제목으로 DB찾아서 장르, 재생횟수 입력 , title 이후에 실행
		DBConnectionMgr mgr = DBConnectionMgr.getInstance();

		Connection con = mgr.getConnection();

		String sql = "insert into chart values(?,?,?,?)";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, title);
		ps.setString(2, time);
		ps.setString(3, genre);
		ps.setInt(4, count);

		ps.executeUpdate();

		mgr.freeConnection(con, ps);
	}

	public void delete() throws Exception { // DTO를 DB입력
		DBConnectionMgr mgr = DBConnectionMgr.getInstance();

		Connection con = mgr.getConnection();
		
		String sql = "delete from chart";
		
		PreparedStatement ps = con.prepareStatement(sql);

		ps.executeUpdate();

		mgr.freeConnection(con, ps);
	}
	
	public void insert(ChartDTO dto) throws Exception { // DTO를 DB입력
		DBConnectionMgr mgr = DBConnectionMgr.getInstance();

		Connection con = mgr.getConnection();
		
		String sql = "insert into chart (title,artist,genre,count) values (?,?,?,?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getTitle());
		ps.setString(2, dto.getArtist());
		ps.setString(3, dto.getGenre());
		ps.setString(4, dto.getCount());

		ps.executeUpdate();

		mgr.freeConnection(con, ps);
	}

	public void title() { // 해당 날짜의 top200위 제목, 가수 DB입력
		ChartDTO dto = new ChartDTO();
		ChartDAO dao = new ChartDAO();
		String url = "https://www.genie.co.kr/chart/top200?pg=";

		Document doc = null;

		
		try {
			for (int j = 1; j < 5; j++) { // 1~4페이지까지 50개씩 저장
				doc = Jsoup.connect(url + Integer.toString(j)).get();
				Elements element = doc.select("td.info");
				// 원하는 내용이 있는 틀(?) 입력

				ArrayList list = new ArrayList();
				int n = 0;

				for (Element artist : doc.select("td.info a.artist.ellipsis")) { // 가수명
					dto = new ChartDTO();
					try {
						dto.setArtist(artist.text());
						list.add(dto);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				System.out.println("가수명 들어간 DTO list에 입력완료");
				
				n = 0;
				for (Element title : doc.select("td.info a.title.ellipsis")) { // 노래제목
					dto = null;
					try {
						dto = (ChartDTO) list.get(n);
						dto.setTitle(title.text());
						dao.insert(dto);
						n++;
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				System.out.println("top50곡 가수, 제목 DB저장완료");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
