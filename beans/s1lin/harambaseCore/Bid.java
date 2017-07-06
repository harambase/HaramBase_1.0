package s1lin.harambaseCore;

import java.io.*;
import java.sql.*;
import oracle.jdbc.*;

public class Bid {
	private int itemID;
	private int userID;
	private String biddingTime;
	private double maxBidLimit;
	private Member member;
	private int status;
	
	public Bid(){}
	
	public Member getMember(){ return this.member;}
	public void setMember(Member member){ this.member = member;}
	
	public int getItemID(){ return this.itemID;}
	public void setItemID(int itemID) { this.itemID = itemID; }
	
	public int getUserID() { return this.userID;}
	public void setUserID(int userID) { this.userID = userID; }

	public double getMaxBidLimit() { return maxBidLimit; }
	public void setMaxBidLimit(double maxBidLimit) { this.maxBidLimit = maxBidLimit; }

	public String getBiddingTime() { return biddingTime;}
	public void setBiddingTime(String biddingTime) { this.biddingTime = biddingTime; }
	
	public int getStatus() { return status;}
	public void setSatus(int status) { this.status = status;}
	
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
	  /**
	   * NO7. Functionality:
	   * Bid an Item
	   * @throws IllegalStateException if then method is called when loggedIn = false
	   * @return int status 1: success
	   * 					2: item has been sold
	   * 					-1: Auction has not started
	   * 					3: The MAXBIDLIMIT is smaller than the start price
	   * 					4: The user is currently the winner.
	   * 					0: The SQL is not executed 
	   */
	  public void bidAnItem()throws IllegalStateException{
	      if(! member.isLoggedIn())
	        throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
	      try {
	        Connection con = openDBConnection();
	        CallableStatement cStmt;
	        cStmt = con.prepareCall("{call team2.ADD_BID_PRO(?,?,?,?)}");
	        cStmt.setInt(1, this.getUserID());
	        cStmt.setInt(2, this.getItemID());
	        cStmt.setDouble(3, this.getMaxBidLimit());
	        cStmt.registerOutParameter(4, Types.INTEGER);
	        cStmt.execute();
	        this.status = cStmt.getInt(4);
	        
	      } catch (Exception e) {
	        System.out.println("FAILURE:" + e.getMessage());
	        System.out.println("FAILURE:" + e.getStackTrace());
	      }
	  }
	  
	public static void main(String[] args) throws Exception{
		Bid bid = new Bid();
		Member me = new Member();
		me.setUname("slin");
		me.setPassword("Lin");//id:3
		me.setUserID(4);
		me.login();
		bid.setItemID(106);
		bid.setMaxBidLimit(100);
		bid.setMember(me);
		bid.setUserID(me.getUserID());
		
		//Bid on ITEM:
//	    int status = bid.bidAnItem();
//	    System.out.println("Expected:1 " + status);
//	    status = bid.bidAnItem();
//	    System.out.println("Expected:4 " + status);
	    
	    me.displayBidOnItem(me);

		
	}
}
