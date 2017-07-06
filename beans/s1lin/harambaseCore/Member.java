package s1lin.harambaseCore;

import java.io.*;
import java.sql.*;
import oracle.jdbc.*;

/**
 *
 * @author Shilei Lin
 */
public class Member implements Serializable {
  /**
   * The following fields correspond to the fields in Table ProductDeals_CUSTOMER in your
   * PRODUCTDEALS Oracle database
   */
  private int userID;
  private String email;
  private String uname;
  private String lname;
  private String fname;
  private String password;
  private int creatorId;
  private int isSeller;
  private int isBuyer;


  /**
   * The following stores whether or not the customer has successfully logged
   * to the System
   */    
  private boolean loggedIn = false;
  
  /**
   * A default constructor ... no need for other constructors
   */
  public Member() {}

  public int getUserID() { return userID;}
  public void setUserID(int userID) { this.userID = userID;}
 
  public String getLname() { return lname;}
  public void setLname(String lname) { this.lname = lname;}
  
  public String getFname() { return fname;}
  public void setFname(String fname) { this.fname = fname;}
  
  public String getUname() { return uname;}
  public void setUname(String uname) { this.uname = uname;}

  public void setLoggedIn(boolean loggedIn) { this.loggedIn = loggedIn;}
  
  public String getPassword() { return password;}
  public void setPassword(String password) { this.password = password;}	
  
  public int getCreatorId() { return creatorId;}
  public void setCreatorId(int creatorId) { this.creatorId = creatorId;}
  
  public int getIsSeller() { return isSeller;}
  public void setIsSeller(int isSeller) {this.isSeller = isSeller;}
  
  public int getIsBuyer() { return isBuyer;}
  public void setIsBuyer(int isBuyer) { this.isBuyer = isBuyer;}
  
  public String getEmail() { return email;}
  public void setEmail(String email) { this.email = email;}

  
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
   * A getter for class field loggedIn
   * @return whether the Customer is logged in or not
   */
  public Boolean isLoggedIn() {
    return this.loggedIn;
  }
  
  /**
   * NO1. Functionality:
   * Member Login
   */
  public boolean login() {
    try {
      Connection con = openDBConnection();   
      String queryString = "Select MEMBER_LOG_IN_FUNC(?,?) AS ISLOG from dual";
      PreparedStatement pstmt = con.prepareStatement(queryString);
      pstmt.clearParameters();
      pstmt.setString(1, this.getUname());
      pstmt.setString(2, this.getPassword());
      ResultSet rs = pstmt.executeQuery();
      
      if (rs.next()) {
    	  this.loggedIn = (rs.getInt(1)==1); 
    	  System.out.println(rs.getInt(1));
    	  queryString = "SELECT * FROM HARAMBASE_MEMBER M WHERE UNAME = ?";
    	  pstmt = con.prepareStatement(queryString);
    	  pstmt.setString(1, this.getUname());
    	  ResultSet rs2 = pstmt.executeQuery();
    	  if(rs2.next()){
    		  this.setUserID(rs2.getInt("USERID"));
    		  this.setCreatorId(rs2.getInt("CREATORID"));
    		  this.setFname(rs2.getString("FNAME"));
    		  this.setLname(rs2.getString("LNAME"));
    		  this.setEmail(rs2.getString("EMAIL"));
    		  this.setIsBuyer(rs2.getInt("ISBUYER"));
    		  this.setIsSeller(rs2.getInt("ISELLER"));
    	  }
      }
      else this.loggedIn = false;

    } catch (Exception e) {
      System.out.println("FAILURE:" + e.getMessage());
      System.out.println("FAILURE:" + e.getStackTrace());
    }  
    return loggedIn;
  }
  /**
   * sets loggedIn class field to false
   * @throws IllegalStateException if then method is called when loggedIn = false
   */
  public void logout() throws IllegalStateException {
    if(! isLoggedIn())
      throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
    this.loggedIn = false;
  }
  
  /**
   * NO2. Functionality:
   * Update Profile
   * @throws IllegalStateException if then method is called when loggedIn = false
   * @reutrn int status:1: success 
   * 					0: Violating rule 
   * 					-1: New passwords do not match
   * 					-2: old password is wrong
   * 					-3: SQL not executed
   */
  public int updateProfile(String np1, String np2)  throws IllegalStateException{
	if(! isLoggedIn())
		throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
	try {
		Connection con = openDBConnection();
		CallableStatement cStmt;
		cStmt = con.prepareCall("{call team2.UPDATE_PROFILE_PRO(?,?,?,?,?,?,?,?,?)}");
		cStmt.setInt(1, this.getUserID());
		cStmt.setString(2, this.getUname());
		cStmt.setString(3, this.getEmail());
		cStmt.setString(4, this.getFname());
		cStmt.setString(5, this.getLname());
		cStmt.setString(6, this.getPassword());
		cStmt.setString(7, np1);
		cStmt.setString(8, np2);
		cStmt.registerOutParameter(9, Types.INTEGER);
		cStmt.execute();
		
		return cStmt.getInt(9);
		
		} catch (Exception e) {
			System.out.println("FAILURE:" + e.getMessage());
			System.out.println("FAILURE:" + e.getStackTrace());
		}
	return -3;
  }
  
  /**
   * NO4. Functionality:
   * Show List of Items that current Seller Listed
   * -----Status:  1: SOLD, 0: ON AUCTION, -1: NOT ON AUCTION-----
   * @throws IllegalStateException if then method is called when loggedIn = false
   */
  public ResultSet getListofItems() throws IllegalStateException{
	  if(! isLoggedIn())
      throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
    try {
      Connection con = openDBConnection();
      String queryString = "SELECT ITEM.ITEMID, ITEM.ITEMNAME, ITEM.ITEMCATEGORY, ITEM.STARTPRICE, ITEM.AUCTIONSTARTTIME,"
      		+ " ITEM.AUCTIONENDTIME, HARAMBASE_GETPRICE_FUNC(ITEM.ITEMID) AS CURRENT_BID,"
      		+ " GET_STATUS_FUNC(ITEM.ITEMID) AS STATUS "
      		+ " FROM HARAMBASE_ITEM ITEM "
      		+ " WHERE ITEM.SELLERID IN (SELECT M.USERID"
      								+ " FROM HARAMBASE_MEMBER M)"
      								+ " AND ITEM.SELLERID = ? "
      		+ " ORDER BY GET_STATUS_FUNC(ITEM.ITEMID) DESC, ITEM.ITEMID";
      PreparedStatement pstmt = con.prepareStatement(queryString);
      pstmt.clearParameters();
      pstmt.setInt(1, this.getUserID());
      ResultSet rs = pstmt.executeQuery();
      return rs;
      
    } catch (Exception e) {
      System.out.println("FAILURE:" + e.getMessage());
      System.out.println("FAILURE:" + e.getStackTrace());
    }
    return null;
  }
  
  /**
   * NO8. Functionality:
   * Show Items Bid on
   * @throws IllegalStateException if then method is called when loggedIn = false
   */
  public ResultSet getBidOnItems() throws IllegalStateException{
	if(! isLoggedIn())
      throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
    try {
      Connection con = openDBConnection();
      String queryString = "SELECT Distinct I.ItemID, I.ItemName, I.ItemCategory, I.AuctionStartTime, "
      		+ " I.AuctionEndTime, Harambase_getPrice_Func(I.ItemID) AS CURRENTPRICE, X.MAXBIDLIMIT AS CURRENTBID, M.Uname AS Winner "
      		+ " FROM Harambase_BID B, Harambase_ITEM I, Harambase_Member M, Harambase_BID X"
      		+ " WHERE B.UserID = ? AND B.ItemID = I.ItemID AND M.UserID = GetWinner_Func(I.ItemID) AND GET_STATUS_FUNC(I.ItemID) = 0 "
      		+ " AND M.USERID = X.USERID AND I.ITEMID = X.ITEMID"
      		+ " ORDER BY I.ITEMID";
      PreparedStatement pstmt = con.prepareStatement(queryString);
      pstmt.clearParameters();
      pstmt.setInt(1, this.getUserID());
      ResultSet rs = pstmt.executeQuery();
      return rs;
      
    } catch (Exception e) {
      System.out.println("FAILURE:" + e.getMessage());
      System.out.println("FAILURE:" + e.getStackTrace());
    }
    return null;
  }
  
  /**
   * NO9. Functionality:
   * Show Items Bid on
   * @throws IllegalStateException if then method is called when loggedIn = false
   */
  public ResultSet getBoughtItems() throws IllegalStateException{
	  if(! isLoggedIn())
      throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
    try {
      Connection con = openDBConnection();
      String queryString = "SELECT DISTINCT I.ItemID, I.ItemName, I.ItemCategory, I.AuctionStartTime, I.AuctionEndTime, "
      		+ " I.StartPrice, Harambase_getPrice_Func(I.ItemID) AS SoldPrice, M.UName AS SellerUname, M.Email "
      		+ " FROM Harambase_ITEM I, Harambase_BID B, Harambase_MEMBER M "
      		+ " WHERE B.UserID = ? AND M.UserID = I.SellerID AND B.UserID = GetWinner_Func(I.ItemID) AND GET_STATUS_FUNC(I.ItemID) = 1 "
      		+ " ORDER BY I.ITEMID";
      PreparedStatement pstmt = con.prepareStatement(queryString);
      pstmt.clearParameters();
      pstmt.setInt(1, this.getUserID());
      ResultSet rs = pstmt.executeQuery();
      return rs;
      
    } catch (Exception e) {
      System.out.println("FAILURE:" + e.getMessage());
      System.out.println("FAILURE:" + e.getStackTrace());
    }
    return null;
  }
  
  
  /**
   * NO12/13. Second Functionality:
   * Get All ItemCategories
   * @throws IllegalStateException if then method is called when loggedIn = false
   */
  public ResultSet getAllCategories() throws IllegalStateException{
	  if(! isLoggedIn())
      throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
    try {
      Connection con = openDBConnection();
      String queryString = "SELECT DISTINCT I.ItemCategory"
      		+ " FROM Harambase_ITEM I"
      		+ " WHERE GET_STATUS_FUNC(I.ITEMID) = 0";
      PreparedStatement pstmt = con.prepareStatement(queryString);
      pstmt.clearParameters();
      ResultSet rs = pstmt.executeQuery();
      return rs;
      
    } catch (Exception e) {
      System.out.println("FAILURE:" + e.getMessage());
      System.out.println("FAILURE:" + e.getStackTrace());
    }
    return null;
  }
  
  public static void main(String[] args) throws Exception{
	  Member me = new Member();
	  me.setUname("slin");
	  me.setPassword("Lin");//id:3
	  
	  //LOGIN TEST:
	  me.login();
	  System.out.println("LOGIN Test:");
	  System.out.println("ISLOGIN? T/F " + me.isLoggedIn());
	  System.out.println("USERID= " + me.getUserID());
	  System.out.println("ISBUYER= " + me.getIsBuyer());
	  System.out.println("ISELLER= " + me.getIsSeller());
	  System.out.println();
	  
      //LIST OF SELLER TEST:
      ResultSet rs = me.getListofItems();
      System.out.println("Get LIST OF Items:");
      while(rs.next()){
    	System.out.print(rs.getString("ITEMID")+" ");
        System.out.print(rs.getString("ITEMNAME")+ " ");
        System.out.print(rs.getString("ITEMCATEGORY")+ " "); 
        System.out.print(rs.getString("AUCTIONSTARTTIME")+ " ");     
        System.out.print(rs.getString("AUCTIONENDTIME")+ " ");     
        System.out.print(rs.getString("CURRENT_BID")+ " ");     
        System.out.print(rs.getString("STATUS")+ " ");         
        System.out.println();
      }
      
      System.out.println();
      
//      System.out.println("Add bid");
//      //Bid on ITEM:
//      int status = me.bidAnItem(106, 100);
//      System.out.println("Expected:1 " + status);
//      status = me.bidAnItem(106, 100);
//      System.out.println("Expected:4 " + status);
	  
      me.setUserID(4);
      rs = me.getBidOnItems();
      System.out.println("Show Items Bid on:");
      while(rs.next()){
    	System.out.print(rs.getString("ITEMID")+" ");
        System.out.print(rs.getString("ITEMNAME")+ " ");
        System.out.print(rs.getString("ITEMCATEGORY")+ " ");            
        System.out.print(rs.getString("AUCTIONSTARTTIME")+ " ");
        System.out.print(rs.getString("AUCTIONENDTIME")+" ");
        System.out.print(rs.getString("CurrentBid")+" ");
        System.out.print(rs.getString("Winner")+" ");
        System.out.println();
      }
      System.out.println();
      
      //Show bought items:
      rs = me.getBoughtItems();
      System.out.println("Show Items bought:");
      while(rs.next()){
    	System.out.print(rs.getString("ITEMID")+" ");
        System.out.print(rs.getString("ITEMNAME")+ " ");
        System.out.print(rs.getString("ITEMCATEGORY")+ " ");            
        System.out.print(rs.getString("AUCTIONSTARTTIME")+ " ");
        System.out.print(rs.getString("AUCTIONENDTIME")+" ");
        System.out.print(rs.getString("SOLDPRICE")+" ");
        System.out.print(rs.getString("SellerUname")+" ");
        System.out.print(rs.getString("Email")+" ");
        System.out.println();
      }
      System.out.println();
          
      rs = me.getAllCategories();
      System.out.println("ITEMCATEGORY:");
      while(rs.next()){
        System.out.print(rs.getString("ITEMCATEGORY")+ " "); 
        System.out.println();
      }
      System.out.println();
      
      me.logout();
      System.out.println(me.isLoggedIn());
      
  }
  
  public void displayBidOnItem(Member me) throws Exception{
	  ResultSet rs = me.getBidOnItems();
      System.out.println("Show Items bought:");
      while(rs.next()){
		  System.out.print(rs.getString("ITEMID")+" ");
	      System.out.print(rs.getString("ITEMNAME")+ " ");
	      System.out.print(rs.getString("ITEMCATEGORY")+ " ");            
	      System.out.print(rs.getString("AUCTIONSTARTTIME")+ " ");
	      System.out.print(rs.getString("AUCTIONENDTIME")+" ");
	      System.out.print(rs.getString("CurrentBid")+" ");
	      System.out.print(rs.getString("Winner")+" ");
	      System.out.println();
      }
      System.out.println();
  }
 
}
