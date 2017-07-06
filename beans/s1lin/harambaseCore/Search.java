package s1lin.harambaseCore;

import java.io.*;
import java.sql.*;
import oracle.jdbc.*;

public class Search {
	private Integer itemID;
	private Double bidMin, bidMax;
	private String keyword;
	private String category;
	private String startTime, endTime;
	private boolean isSearched;
	private Member member;
	
	public Search(){
		bidMin = null;
		bidMax = null;
		keyword = null;
		category = null;
		startTime = null;
		endTime = null;
		itemID = null;
		isSearched = false;
	}
	
	public Member getMember(){ return this.member;}
	public void setMember(Member member){ this.member = member;}
	
	public Integer getItemID(){ return this.itemID;}
	public void setItemID(Integer itemID) { this.itemID = itemID; }

	public Double getBidMin() { return bidMin;}
	public void setBidMin(Double bidMin) {this.bidMin = bidMin;}

	public Double getBidMax() {	return bidMax;}
	public void setBidMax(Double bidMax) { this.bidMax = bidMax;}

	public String getKeyword() {return keyword;}
	public void setKeyword(String keyword) {this.keyword = keyword;}

	public String getCategory() {return category;	}
	public void setCategory(String category) {this.category = category;}

	public String getStartTime() { return startTime; }
	public void setStartTime(String startTime) {this.startTime = startTime;	}

	public String getEndTime() { return endTime;}
	public void setEndTime(String endTime) { this.endTime = endTime;}
	
	public boolean isSearched(){ return this.isSearched;}
	public void setSearched(boolean isSearch){ this.isSearched = isSearch;}
	
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
	   * NO12/13. Functionality:
	   * Search Items
	   * @throws IllegalStateException if then method is called when loggedIn = false
	   */
	  public ResultSet searchItems() throws IllegalStateException{
	      if(!member.isLoggedIn())
	        throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
	      try {
	        Connection con = openDBConnection();
	        CallableStatement cStmt = con.prepareCall("{call team2.Search_Item_Pro(?,?,?,?,?,?,?,?)}");
	       
	        if(this.itemID != null)
	        	cStmt.setInt(1, itemID);
	        else cStmt.setNull(1, java.sql.Types.INTEGER);  
	        
	        if(this.keyword != null)
	        	cStmt.setString(2, keyword); 
	        else cStmt.setNull(2, java.sql.Types.VARCHAR);
	        
	        if(this.category!= null)
	        	cStmt.setString(3, category); 
	        else cStmt.setNull(3, java.sql.Types.VARCHAR);
	        
	        
	        if(this.startTime != null){
	        	Timestamp ts = Timestamp.valueOf(this.startTime);
	        	cStmt.setTimestamp(4, ts);}
	        else cStmt.setNull(4, java.sql.Types.TIMESTAMP);
	        
	        if(this.endTime != null){
	        	Timestamp ts = Timestamp.valueOf(this.endTime);
	        	cStmt.setTimestamp(5, ts);} 
	        else cStmt.setNull(5, java.sql.Types.TIMESTAMP);
	        
	        if(this.bidMin != null)
	        	cStmt.setDouble(6, this.bidMin);
	        else cStmt.setNull(6, java.sql.Types.NUMERIC);
	        
	        if(this.bidMax != null)
	        	cStmt.setDouble(7, this.bidMax); 
	        else cStmt.setNull(7, java.sql.Types.NUMERIC);
	        
	        cStmt.registerOutParameter(8, OracleTypes.CURSOR);
	        cStmt.execute();
	        
	        return (ResultSet) cStmt.getObject(8);
	        
	      } catch (Exception e) {
	        System.out.println("FAILURE:" + e.getMessage());
	        System.out.println("FAILURE:" + e.getStackTrace());
	      }
	     return null;
	    
	  }
	  
	public static void main(String[] args) throws Exception{
		Search search = new Search();
		Member me = new Member();
		me.setUname("irahal");
		me.setPassword("Rahal");//id:3
		me.login();
		search.setMember(me);
		//Search for items
		search.setStartTime("2015-01-01 00:00:00");
		search.setEndTime("2017-12-01 00:00:00");
		search.setKeyword("INTRO");
		ResultSet rs = search.searchItems();
	    System.out.println("Search Result:");
	    while(rs.next()){
	    	System.out.print(rs.getString("ITEMID")+" ");
	        System.out.print(rs.getString("ITEMNAME")+ " ");
	        System.out.print(rs.getString("ITEMCATEGORY")+ " ");            
	        System.out.print(rs.getString("AUCTIONSTARTTIME")+ " ");
	        System.out.print(rs.getString("AUCTIONENDTIME")+" ");
	        System.out.print(rs.getString("CURRENTBID")+" ");
	        System.out.print(rs.getString("STATUS")+" ");
	        System.out.println();
	      }
	      System.out.println();

		me.logout();
	}
}
