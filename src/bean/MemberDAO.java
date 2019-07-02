package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import javax.websocket.Session;

import bean.DBConnectionMgr;
import bean.MemberDTO;
import sun.security.jca.GetInstance.Instance;

public class MemberDAO {

	private static MemberDAO instance;

	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	DBConnectionMgr mgr;

	public MemberDAO() {
		mgr = DBConnectionMgr.getInstance();
	}

	public static MemberDAO getInstance() {
		if (instance == null) {
			instance = new MemberDAO();
		}
		return instance;

	}

	public void insert(MemberDTO dto) throws Exception {

		con = mgr.getConnection();

		String sql = "insert into member values(?,?,?,?,?,?)";

		ps = con.prepareStatement(sql);
		ps.setString(1, dto.getId());
		ps.setString(2, dto.getPw());
		ps.setString(3, dto.getName());
		ps.setString(4, dto.getGender());
		ps.setString(5, dto.getBirth());
		ps.setString(6, dto.getEmail());

		ps.executeUpdate();

	}

	public boolean LoginCheck(String InputId, String InputPw) {
		MemberDTO dto = null;
		boolean result = false;

		try {
			con = mgr.getConnection();

			String sql = "select * from member where id = ? and pw = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, InputId);
			ps.setString(2, InputPw);

			rs = ps.executeQuery();

			if (rs.next()) {
				result = true;
			} else {
				result = false;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public String idCheck(String InputId) {
		System.out.println("DAO 입력된 id : " + InputId);
		String id = null;
		mgr = DBConnectionMgr.getInstance();
		try {
			con = mgr.getConnection();
			String sql = "select * from member where id=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, InputId);
			rs = ps.executeQuery();

			if (rs.next()) {
				id = rs.getString(1);
			} else {
				id = null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			mgr.freeConnection(con);
		}
		return id;
	}

	public MemberDTO select(MemberDTO dto) {

		MemberDTO dto2 = null;
		try {
			con = mgr.getConnection();
			// 3단계 sql문 결정
			String sql = "select * from member where id = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getId());

			// 4단계 sql문 실행 요청
			rs = ps.executeQuery();

			while (rs.next()) {
				dto2 = new MemberDTO();
				String id = rs.getString(1);
				String pw = rs.getString(2);
				String name = rs.getString(3);
				String gender = rs.getString(4);
				String birth = rs.getString(5);
				String email = rs.getString(6);

				dto2.setId(id);
				dto2.setPw(pw);
				dto2.setName(name);
				dto2.setGender(gender);
				dto2.setBirth(birth);
				dto2.setEmail(email);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto2;
	}

	// 제너릭 프로그래밍(객체생성시 타입 결정가능)
	// 형변환이 필요없어 내부 처리속도 더 빠름.

	public ArrayList<MemberDTO> selectAll() throws Exception { // 회원정보 전체 검색
		// => object로 형변환 x -> MemberDTO로 사용한다.

		ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();
		MemberDTO dto = null;

		con = mgr.getConnection();

		String sql = "select * from music";
		ps = con.prepareStatement(sql);

		rs = ps.executeQuery();

		while (rs.next()) {
			dto = new MemberDTO();
			String id = rs.getString(1);
			String pw = rs.getString(2);
			String name = rs.getString(3);
			String gender = rs.getString(4);
			String birth = rs.getString(5);
			String email = rs.getString(6);

			dto.setId(id);
			dto.setPw(pw);
			dto.setName(name);
			dto.setGender(gender);
			dto.setBirth(birth);
			dto.setEmail(email);

			list.add(dto);

		} // while end

		return list;

	} // select end

}
