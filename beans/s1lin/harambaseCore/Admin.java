package s1lin.harambaseCore;

import java.io.*;
import java.sql.*;
import oracle.jdbc.*;

/**
 *
 * @author Shilei Lin
 */
public class Admin implements Serializable {
  /**
   * The following fields correspond to the fields in Table harambase_CUSTOMER in your
   * harambase Oracle database
   */
  private int userID;
  private String email;
  private String uname;
  private String lname;
  private String fname;
  private String password;
  private int creatorId;

  /**
   * The following stores whether or not the customer has successfully logged
   * to the System
   */    
  private boolean loggedIn = false;
  
  /**
   * A default constructor ... no need for other constructors
   */
  public Admin() {}

  public int getUserID() { return userID;}
  public void setUserID(int userID) { this.userID = userID;}
 
  public String getLname() { return lname;}
  public void setLname(String lname) { this.lname = lname;}
  
  public String getFname() { return fname;}
  public void setFirst(String fname) { this.fname = fname;}
  
  public String getUname() { return uname;}
  public void setUname(String uname) { this.uname = uname;}

  public void setLoggedIn(boolean loggedIn) { this.loggedIn = loggedIn;}
  
  public String getPassword() { return password;}
  public void setPassword(String password) { this.password = password;}	
  
  public int getCreatorId() { return creatorId;}
  public void setCreatorId(int creatorId) { this.creatorId = creatorId;}
  
  public String getEmail() { return this.email;}
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
   * @throws IllegalStateException if then method is called when loggedIn = false
   */
  public Boolean isLoggedIn() {
    return this.loggedIn;
  }
  /**
   * NO1. Functionality:
   * Admin Login
   */
  public boolean login() {
    try {
      Connection con = openDBConnection();   
      String queryString = "Select ADMIN_LOG_IN_FUNC(?,?) AS ISLOG from dual";
      PreparedStatement pstmt = con.prepareStatement(queryString);
      pstmt.clearParameters();
      System.out.println(this.getPassword());
      pstmt.setString(1, this.getUname());
      pstmt.setString(2, this.getPassword());
      ResultSet rs = pstmt.executeQuery();
      
      if (rs.next()) {this.loggedIn = (rs.getInt(1)==1); System.out.println(rs.getInt(1));}
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
   * View Users
   * @throws IllegalStateException if then method is called when loggedIn = false
   */
  public ResultSet getMemberInfo() throws IllegalStateException{
    if(!isLoggedIn())
      throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
    try {
      Connection con = openDBConnection();
      ResultSet rs;
      Statement stmt;
      stmt = con.createStatement();
      String queryString = "SELECT USERID, UNAME, FNAME, LNAME, EMAIL, PASSWORD FROM HARAMBASE_MEMBER ORDER BY USERID";
      rs = stmt.executeQuery(queryString);
      return rs;
    } catch (Exception e) {
      System.out.println("FAILURE:" + e.getMessage());
      System.out.println("FAILURE:" + e.getStackTrace());
    }
    return null;
  }
  
  
  /**
   * NO3. Functionality:
   * Add user by Procedure: ADD_USER_PRO
   * NOTICE:THE TIGGER SHOULD BE WORKING FOR GENERATING NEW ID
   * @throws IllegalStateException if then method is called when loggedIn = false
   * @return status: 0:successful, -1:Query is not executed, other number:Something is wrong.
   */
  public int addUser(int userid, String uname, String email, String first, String last, String password,
		  				int creatorID, int isSeller, int isBuyer)  throws IllegalStateException{
    if(! isLoggedIn())
      throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
    try {
      Connection con = openDBConnection();
      CallableStatement cStmt;
      cStmt = con.prepareCall("{call team2.ADD_USER_PRO(-1,?,?,?,?,?,?,?,?,?)}");
      cStmt.setString(1, uname);
      cStmt.setString(2, email);
      cStmt.setString(3, first);
      cStmt.setString(4, last);
      cStmt.setString(5, password);
      cStmt.setInt(6, creatorID);
      cStmt.setInt(7, isSeller);
      cStmt.setInt(8, isBuyer);
      cStmt.registerOutParameter(9, Types.INTEGER);
      cStmt.execute();

      return cStmt.getInt(9);
      
    } catch (Exception e) {
      System.out.println("FAILURE:" + e.getMessage());
      System.out.println("FAILURE:" + e.getStackTrace());
    }
    return -1;
  }
  
  /**
   * NO4. Functionality:
   * View Sales Summary Report
   * @throws IllegalStateException if then method is called when loggedIn = false
   */
  public ResultSet getSalesSummaryReport()  throws IllegalStateException{
    if(! isLoggedIn())
      throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
    try {
      Connection con = openDBConnection();
      ResultSet rs;
      Statement stmt;
      stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
      String queryString = "SELECT * FROM SALES_SUMMARY_REPORT";
      rs = stmt.executeQuery(queryString);
      return rs;
    } catch (Exception e) {
      System.out.println("FAILURE:" + e.getMessage());
      System.out.println("FAILURE:" + e.getStackTrace());
    }
    return null;
  }
  
  /**
   * NO4. Second Functionality
   * Subtotal of current Category
   */
  public ResultSet getSubTotal(String category){
    if(! isLoggedIn())
        throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
    try {
        Connection con = openDBConnection();
        ResultSet rs;
        Statement stmt;
        stmt = con.createStatement();
        String queryString = "SELECT SUM(COMMISSION) AS SUBCOM, SUM(FINAL_SELLING_PRICE) AS SUBTOTAL FROM SALES_SUMMARY_REPORT"
        					+" WHERE ITEMCATEGORY = '" + category + "'";
        rs = stmt.executeQuery(queryString);
        return rs;
      } catch (Exception e) {
        System.out.println("FAILURE:" + e.getMessage());
        System.out.println("FAILURE:" + e.getStackTrace());
      }
      return null;
  }
  /**
   * NO4. Third Functionality
   * Total of all category
   */
  public ResultSet getTotal(){
    if(! isLoggedIn())
        throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
    try {
        Connection con = openDBConnection();
        ResultSet rs;
        Statement stmt;
        stmt = con.createStatement();
        String queryString = "SELECT SUM(COMMISSION) AS COMM, SUM(FINAL_SELLING_PRICE) AS TOTAL FROM SALES_SUMMARY_REPORT";
        rs = stmt.executeQuery(queryString);
        return rs;
      } catch (Exception e) {
        System.out.println("FAILURE:" + e.getMessage());
        System.out.println("FAILURE:" + e.getStackTrace());
      }
      return null;
   }
  
  /**
   * NO5. Functionality:
   * View Overall Commission Report
   * @throws IllegalStateException if then method is called when loggedIn = false
   */
  public ResultSet getOverallCommReport()  throws IllegalStateException{
    if(! isLoggedIn())
      throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
    try {
      Connection con = openDBConnection();
      ResultSet rs;
      Statement stmt;
      stmt = con.createStatement();
      String queryString = "SELECT * FROM OVERALL_COMMISSION_VIEW";
      rs = stmt.executeQuery(queryString);
      return rs;
    } catch (Exception e) {
      System.out.println("FAILURE:" + e.getMessage());
      System.out.println("FAILURE:" + e.getStackTrace());
    }
    return null;
  }
  
  /**
   * NO5. Second Functionality
   * Total Income
   * @param args
   * @throws Exception
   */
  public ResultSet getTotalIncome(){
	 if(! isLoggedIn())
	     throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
	 try {
		  Connection con = openDBConnection();
	      ResultSet rs;
	      Statement stmt;
	      stmt = con.createStatement();
	      String queryString = "SELECT SUM(COMMISSIONS) AS TOTAL FROM OVERALL_COMMISSION_VIEW";
	      rs = stmt.executeQuery(queryString);
	      return rs;
	  } catch (Exception e) {
	      System.out.println("FAILURE:" + e.getMessage());
	      System.out.println("FAILURE:" + e.getStackTrace());
      }
	  return null; 
  }
  
  public static void main(String[] args) throws Exception{
	  Admin ad = new Admin();
	  ad.setUname("admin");
	  ad.setPassword("admin");
	  ad.login();
      System.out.println(ad.isLoggedIn());
      
      //SUMMARYREPORT TEST:
      ResultSet rs = ad.getSalesSummaryReport();
      
      System.out.println("Summary Report:");
      while (rs.next()){
    	  String curCate = rs.getString("ITEMCATEGORY");
    	  
	      System.out.println(rs.getString("ITEMCATEGORY")+" ");
	    	  
	      while(rs.getString("ITEMCATEGORY").equals(curCate)){
	        System.out.print(rs.getString("ITEMID")+ " ");
	        System.out.print(rs.getString("ITEMNAME")+ " ");            
	        System.out.print(rs.getString("FINAL_SELLING_PRICE")+ " ");
	        System.out.print(rs.getString("COMMISSION")+" ");
	        System.out.println();
	        if(rs.next()) {rs.previous(); rs.next();}//A-?>B->A->B
	        else break;
	      }
	      ResultSet rs2 = ad.getSubTotal(curCate);
	      if(rs2.next())
	    	  System.out.println("SUBTOTAL:     " + rs2.getString("SUBTOTAL") +"   "+ rs2.getString("SUBCOM"));
	      rs.previous();//C->B      
	  }
      rs = ad.getTotal();
      if(rs.next())
    	  System.out.println("TOTAL:     " + rs.getString("TOTAL") +"   "+ rs.getString("COMM"));
      
      System.out.println();
      System.out.println("OVERALL COMMISSION:");
      //OVERALL COMMISSION TEST:
      rs = ad.getOverallCommReport();
      while(rs.next()){
    	System.out.print(rs.getString("USERID")+" ");
        System.out.print(rs.getString("USER_NAME")+ " ");
        System.out.print(rs.getString("FIRST_NAME")+ " ");            
        System.out.print(rs.getString("LAST_NAME")+ " ");
        System.out.print(rs.getString("EMAIL")+" ");
        System.out.print(rs.getString("SELLER_RATING")+" ");
        System.out.print(rs.getString("COMMISSIONS")+" ");
        System.out.println();
      }
      
      rs = ad.getTotalIncome();
      if(rs.next()) System.out.println(rs.getString("TOTAL"));
      
      rs = ad.getSubTotal("BOOK");
      if(rs.next()) System.out.println(rs.getString("SUBTOTAL"));
      
      System.out.println();
      ad.logout();
      System.out.println(ad.isLoggedIn());
      //Should throw exception:
      //rs = ad.getOverallCommReport();
  }
  
 
}
