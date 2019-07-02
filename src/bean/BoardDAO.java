package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.catalina.Session;

public class BoardDAO {

   Connection con;
   PreparedStatement ps;
   ResultSet rs;
   DBConnectionMgr mgr;

   public BoardDAO() {
      mgr = DBConnectionMgr.getInstance();
   }

   public void insert(BoardDTO dto) throws Exception {

      con = mgr.getConnection();
      String sql = "insert into board values(null,?,?,?,?,?)";
      ps = con.prepareStatement(sql);
      System.out.println(dto.getId());

      ps.setString(1, dto.getTitle());
      ps.setString(2, dto.getId());
      ps.setString(3, dto.getContent());
      ps.setString(4, dto.getDate());
      ps.setInt(5, dto.getCount());

      ps.executeUpdate();
      System.out.println("DB입력완료");   
      }

   public void update(BoardDTO dto) {
	      try {
	    	 BoardUpdateDTO dto2 = new BoardUpdateDTO();
	         con = mgr.getConnection();
	         
	         String sql = "update board set title = ?, id = ?, content = ? where num = ?";
	         ps = con.prepareStatement(sql);

	         ps.setString(1, dto.getTitle());
	         ps.setString(2, dto.getId());
	         ps.setString(3, dto.getContent());
	         ps.setInt(4, Integer.parseInt(dto2.getNum1()));

	         	
	         System.out.println(dto2.getNum1());
	         ps.executeUpdate();
	      } catch (Exception e) {
	         e.printStackTrace();
	      }

	   }

   public BoardDTO readCnt(int num) {
      
      updateCnt(num);
      
      String sql = "select * from board where num = ?";
      BoardDTO dto = new BoardDTO();
      try {
         con = mgr.getConnection();
         ps = con.prepareStatement(sql);
         ps.setInt(1, num);
         rs = ps.executeQuery();
         if (rs.next()) {
            dto.setNum(rs.getInt("num"));
            dto.setTitle(rs.getString("title"));
            dto.setId(rs.getString("id"));
            dto.setContent(rs.getString("content"));
            dto.setDate(rs.getString("date"));
            dto.setCount(rs.getInt("count"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (ps != null)
               ps.close();
            if (con != null)
               con.close();
         } catch (SQLException e) {
            e.printStackTrace();
         }
      }
      return dto;
   }
   
   public void updateCnt(int num) {
   
      try {
         con = mgr.getConnection();
         
         String sql = "update board set count = count+1 where num = ?";
         ps = con.prepareStatement(sql);
         
         ps.setInt(1, num);
         
         ps.executeUpdate();
         
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         try {
            if (rs != null)
               rs.close();
            if (ps != null)
               ps.close();
            if (con != null)
               con.close();
         } catch (SQLException e) {
            e.printStackTrace();
         }
      }
   }
   
   
   public void delete(int num) throws Exception {

      con = mgr.getConnection();

      String sql = "delete from board where num = ?";
      ps = con.prepareStatement(sql);
      ps.setInt(1, num);

      ps.executeUpdate();
   }

   public BoardDTO select(BoardDTO dto) throws Exception {

	      con = mgr.getConnection();

	      String sql = "select * from board where num = ?";
	      ps = con.prepareStatement(sql);
	      ps.setInt(1, dto.getNum());

	      rs = ps.executeQuery();
	      BoardDTO dto2 = null;

	      while (rs.next()) {
	         dto2 = new BoardDTO();
	         String title = rs.getString(1);
	         String id = rs.getString(2);
	         String content = rs.getString(3);

	         dto2.setTitle(title);
	         dto2.setId(id);
	         dto2.setContent(content);
	      }
	      return dto2;
	   }
   public BoardDTO select2(int num) throws Exception {

	      con = mgr.getConnection();

	      String sql = "select * from board where num = ?";
	      ps = con.prepareStatement(sql);
	      ps.setInt(1, num);

	      rs = ps.executeQuery();
	      BoardDTO dto2 = null;

	      while (rs.next()) {
	         dto2 = new BoardDTO();
	         int num1 = rs.getInt(1);
	         String title = rs.getString(2);
	         String id = rs.getString(3);
	         String content = rs.getString(4);

	         dto2.setTitle(title);
	         dto2.setId(id);
	         dto2.setContent(content);
	      }
	      return dto2;
	   }
   
   public ArrayList<BoardDTO> selectAll() {

      ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
      BoardDTO dto = null;

      try {
         con = mgr.getConnection();
         
         String sql = "select * from board";
         ps = con.prepareStatement(sql);
         
         rs = ps.executeQuery();
         
         while (rs.next()) {

            dto = new BoardDTO();
            int num = rs.getInt(1);
            String title = rs.getString(2);
            String id = rs.getString(3);
            String content = rs.getString(4);
            String date = rs.getString(5);
            int count = rs.getInt(6);

            dto.setNum(num);
            dto.setTitle(title);
            dto.setId(id);
            dto.setContent(content);
            dto.setDate(date);
            dto.setCount(count);

            list.add(dto);
            
         } // while end

      } catch (Exception e) {
         e.printStackTrace();
      }
      return list;
   } // selectAll end

}