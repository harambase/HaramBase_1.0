package s1lin.harambaseCore;

import java.io.*;
import java.sql.*;
import oracle.jdbc.*;

/**
*
* @author Shilei Lin
*/
public class Feedback {
	private int itemID;
	private double overall;
	private double itemQua;
	private double deli;
	private String comment;
	private Member member;
	
	public Feedback(){}
	
	public Member getMember(){ return this.member;}
	public void setMember(Member member){ this.member = member;}
	
	public int getItemID(){ return this.itemID;}
	public void setItemID(int itemID) { this.itemID = itemID; }
	
	public double getOverall() { return this.overall;}
	public void setOverall(double overall) { this.overall = overall; }

	public double getItemQua() { return itemQua; }
	public void setItemQua(double itemQua) { this.itemQua = itemQua; }

	public double getDeli() { return deli; }
	public void setDeli(double deli) { this.deli = deli;}

	public String getComment() { return comment;}

	public void setComment(String comment) { this.comment = comment; }
	
	 /**
	   *********************Our Team ORACLE USERNAME:team2 AND PASSWORD:Lkf3H  *****************
	   * This method and creates and returns a Connection object to the database. 
	   * All other methods that need database access should call this method.
	   * @return a Connection object to Oracle
	   */
	  public Connection openDBConnection() {
	    try {
	    	// Load driver and link to driver manager
	    	Class.forName("oracle.jdbc.OracleDriver");
	    	// Create a connection to the specified database
	    	Connection myConnection = DriverManager.getConnection("jdbc:oracle:thin:@//cscioraclesrv.ad.csbsju.edu:1521/" +
	                                        "csci.cscioraclesrv.ad.csbsju.edu","team2", "Lkf3H");
		      return myConnection;
		    } catch (Exception E) {
		      E.printStackTrace();
		    }
		    return null;
	   }
	  public ResultSet getFeedbackByItemID(int itemID){
		if(!member.isLoggedIn())
	          throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
	    try {
	        Connection con = openDBConnection();
	        String queryString = "SELECT *"
	        					+" FROM Harambase_FEEDBACK F, Harambase_ITEM I"
	        					+" WHERE I.ItemID = ? AND I.ItemID = F.ItemID";
	        PreparedStatement pstmt = con.prepareStatement(queryString,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
	        pstmt.clearParameters();
	        pstmt.setInt(1, itemID);
	        ResultSet rs = pstmt.executeQuery();
	        return rs;
	        
	      } catch (Exception e) {
	        System.out.println("FAILURE:" + e.getMessage());
	        System.out.println("FAILURE:" + e.getStackTrace());
	      }
	      return null;
	  }
	  /**
	   * NO11. Functionality:
	   * View Feedback
	   * @throws IllegalStateException if then method is called when loggedIn = false
	   */
	  public ResultSet getFeedback(){
	    if(!member.isLoggedIn())
	          throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
	    try {
	        Connection con = openDBConnection();
	        String queryString = "SELECT Distinct M.UName, B.ItemID, F.OverallRating, F.ItemQuality, F.Delivery, F.Comments"
	        					+" FROM Harambase_FEEDBACK F, Harambase_ITEM I, Harambase_MEMBER M, Harambase_BID B"
	        					+" WHERE I.SellerID = ? AND I.ItemID = F.ItemID AND B.MaxBidLimit = (SELECT Max(MaxBidLimit) "
	        					+" FROM Harambase_BID B WHERE I.ItemID = B.ItemID) AND F.ItemID = B.ItemID AND B.UserID = M.UserID";
	        PreparedStatement pstmt = con.prepareStatement(queryString,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
	        pstmt.clearParameters();
	        pstmt.setInt(1, member.getUserID());
	        ResultSet rs = pstmt.executeQuery();
	        return rs;
	        
	      } catch (Exception e) {
	        System.out.println("FAILURE:" + e.getMessage());
	        System.out.println("FAILURE:" + e.getStackTrace());
	      }
	      return null;
	}
	  /**
	   * NO11. Second Functionality:
	   * get Average Overall rating
	   * @throws IllegalStateException if then method is called when loggedIn = false
	   */
	  public ResultSet getAvgOverall(){
	      if(!member.isLoggedIn())
	          throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
	    try {
	        Connection con = openDBConnection();
	        String queryString = "SELECT AVG(F.OverallRating) As Overall"
	        					+" FROM Harambase_FEEDBACK F, Harambase_ITEM I, Harambase_MEMBER M, Harambase_BID B"
	        					+" WHERE I.SellerID = ? AND I.ItemID = F.ItemID AND B.MaxBidLimit = (SELECT Max(MaxBidLimit) "
	        					+" FROM Harambase_BID B WHERE I.ItemID = B.ItemID) AND F.ItemID = B.ItemID AND B.UserID = M.UserID";
	        PreparedStatement pstmt = con.prepareStatement(queryString);
	        pstmt.clearParameters();
	        pstmt.setInt(1, member.getUserID());
	        ResultSet rs = pstmt.executeQuery();
	        return rs;
	        
	      } catch (Exception e) {
	        System.out.println("FAILURE:" + e.getMessage());
	        System.out.println("FAILURE:" + e.getStackTrace());
	      }
	      return null;
	}
	  /**
	   * NO11. Third Functionality:
	   * get total Count of rating
	   * @throws IllegalStateException if then method is called when loggedIn = false
	   */
	  public ResultSet getNumOfRating(){
	      if(!member.isLoggedIn())
	          throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
	    try {
	        Connection con = openDBConnection();
	        String queryString = "SELECT Count(*) As ct"
	        					+" FROM Harambase_FEEDBACK F, Harambase_ITEM I, Harambase_MEMBER M, Harambase_BID B"
	        					+" WHERE I.SellerID = ? AND I.ItemID = F.ItemID AND B.MaxBidLimit = (SELECT Max(MaxBidLimit) "
	        					+" FROM Harambase_BID B WHERE I.ItemID = B.ItemID) AND F.ItemID = B.ItemID AND B.UserID = M.UserID";
	        PreparedStatement pstmt = con.prepareStatement(queryString);
	        pstmt.clearParameters();
	        pstmt.setInt(1, member.getUserID());
	        ResultSet rs = pstmt.executeQuery();
	        return rs;
	        
	      } catch (Exception e) {
	        System.out.println("FAILURE:" + e.getMessage());
	        System.out.println("FAILURE:" + e.getStackTrace());
	      }
	      return null;
	}
	  
	  /**
	   * NO10. Functionality:
	   * Rate Seller
	   * @throws IllegalStateException if then method is called when loggedIn = false
	   */
	public void addFeedbackWithoutParm(){
	      if(!member.isLoggedIn())
	          throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
	      try {
	        Connection con = openDBConnection();
	        CallableStatement cStmt;
	        cStmt = con.prepareCall("{call team2.ADD_FEEDBACK_PRO(?,?,?,?,?)}");
	        cStmt.setInt(1, this.getItemID());
	        cStmt.setDouble(2, this.getOverall());
	        cStmt.setDouble(3, this.getItemQua());
	        cStmt.setDouble(4, this.getDeli());
	        cStmt.setString(5, this.getComment());
	        cStmt.execute();
	        
	      } catch (Exception e) {
	        System.out.println("FAILURE:" + e.getMessage());
	        System.out.println("FAILURE:" + e.getStackTrace());
	      }
	}
	  /**
	   * NO10. Functionality:
	   * Rate Seller
	   * @throws IllegalStateException if then method is called when loggedIn = false
	   */
	public void addFeedback(int itemID, double overall, double itemQua, double deli, String comment){
	      if(!member.isLoggedIn())
	          throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
		try {
	        Connection con = openDBConnection();
	        CallableStatement cStmt;
	        cStmt = con.prepareCall("{call team2.ADD_FEEDBACK_PRO(?,?,?,?,?)}");
	        cStmt.setInt(1, itemID);
	        cStmt.setDouble(2, overall);
	        cStmt.setDouble(3, itemQua);
	        cStmt.setDouble(4, deli);
	        cStmt.setString(5, comment);
	        cStmt.execute();
	        
	      } catch (Exception e) {
	        System.out.println("FAILURE:" + e.getMessage());
	        System.out.println("FAILURE:" + e.getStackTrace());
	      }
	}
	
	
	public static void main(String[] args) throws Exception{
		Feedback fb = new Feedback();
		fb.setItemID(3);
		Member me = new Member();
		me.setUname("slin");
		me.setPassword("Lin");//id:3
		me.setUserID(3);
		me.login();
		fb.setMember(me);
		
		ResultSet rs = fb.getFeedback();
		while(rs.next()){
			System.out.print(rs.getString("ITEMID") + " ");
			System.out.print(rs.getString("OverallRating") + " ");
			System.out.print(rs.getString("ItemQuality") + " ");
			System.out.print(rs.getString("Delivery") + " ");
			System.out.print(rs.getString("Comments") + " ");
			System.out.println();
		}
		
	}
}
