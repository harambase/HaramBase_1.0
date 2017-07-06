package s1lin.harambaseCore;

import java.io.*;
import java.sql.*;
import oracle.jdbc.*;

/**
 *
 * @author 
 */
public class Item implements Serializable {
  /**
   * The following fields correspond to the fields in Table ProductDeals_CUSTOMER in your
   * PRODUCTDEALS Oracle database
   */
  private int itemId;
  private String itemName;
  private String itemCategory;
  private double itemStartPrice;
  private String itemDescription;
  private int sellerID;
  private String auctionStartTime;
  private String auctionEndTime;
  private Member member;
  
  /**
   * A default constructor ... no need for other constructors
   */
  public Item(){}
  
  public Member getMember(){ return this.member;}
  public void setMember(Member member){ this.member = member;}
  
  public int getItemId() { return this.itemId;}		
  public void setItemId(int itemId) {this.itemId = itemId; }
		
  public String getItemName() {return itemName;}		
  public void setItemName(String itemName) {this.itemName = itemName; }
	
  public String getItemCategory() { return itemCategory; }
  public void setItemCategory(String itemCategory) {this.itemCategory = itemCategory; }
	
  public double getItemStartPrice() { return itemStartPrice;}
  public void setItemStartPrice(double itemStartPrice) { this.itemStartPrice = itemStartPrice;}
	
  public String getItemDescription() {  return itemDescription;}	
  public void setItemDescription(String itemDescription) { this.itemDescription = itemDescription;}
	
  public int getSellerID() { return sellerID;}	
  public void setSellerID(int sellerID) { this.sellerID = sellerID;}
	
  public String getAuctionStartTime() { return auctionStartTime;}	
  public void setAuctionStartTime(String auctionStartTime) { this.auctionStartTime = auctionStartTime;}
	
  public String getAuctionEndTime() { return auctionEndTime;}	
  public void setAuctionEndTime(String auctionEndTime) { this.auctionEndTime = auctionEndTime;}
  
  
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
   * NO3. Functionality:
   * Show List of Bidders
   */
   public ResultSet getListOfBidders() throws IllegalStateException{
	if(!member.isLoggedIn())
	      throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
    try {
      Connection con = openDBConnection();
      ResultSet rs;
      Statement stmt;
      stmt = con.createStatement();
      String queryString = "SELECT HB.BIDDINGTIME ,HM.UNAME AS USERNAME,HB.MAXBIDLIMIT AS MAX_BID_LIMIT "
      		+ " FROM HARAMBASE_BID HB, HARAMBASE_MEMBER HM"
      		+ " WHERE HB.USERID IN (SELECT HM.USERID"
      							+ " FROM HARAMBASE_ITEM HM)"
      							+ " AND HB.ITEMID ='"+this.getItemId()
      		+ "' ORDER BY HB.BIDDINGTIME";
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
   * View Item Information(NO CURRENTBID)
   */
   public ResultSet getItemInformation() throws IllegalStateException{
	 if(!member.isLoggedIn())
	       throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
     try {
       Connection con = openDBConnection();
       ResultSet rs;
       Statement stmt;
       stmt = con.createStatement();
       String queryString = "SELECT ITEM.ITEMID, ITEM.ITEMNAME, ITEM.ITEMCATEGORY, ITEM.AUCTIONSTARTTIME, ITEM.AUCTIONENDTIME, ITEM.DESCRIPTION,"
       		+ " ITEM.STARTPRICE, ITEM.SELLERID, "
       		+ " GET_STATUS_FUNC(ITEM.ITEMID) AS STATUS"
       		+ " FROM HARAMBASE_ITEM ITEM"
       		+ " WHERE ITEM.ITEMID ='" + this.getItemId() + "'";
       rs = stmt.executeQuery(queryString);
       return rs;
     } catch (Exception e) {
       System.out.println("FAILURE:" + e.getMessage());
       System.out.println("FAILURE:" + e.getStackTrace());
     }
     return null;
   }
   
   /**
    * NO5. Second Functionality:
    * View Item additional Information
    */
   public ResultSet getAdditionalItemInfo(int itemId){
	 if(!member.isLoggedIn())
	       throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
     try {
       Connection con = openDBConnection();
       ResultSet rs;
       Statement stmt;
       stmt = con.createStatement();
       String queryString = "SELECT Harambase_getPrice_Func(I.ItemID) AS SOLDPRICE, M.UNAME"
       		+ " FROM HARAMBASE_ITEM I, HARAMBASE_MEMBER M"
       		+ " WHERE M.UserID = GetWinner_Func(I.ItemID) AND I.ITEMID ='" + itemId + "'";
       rs = stmt.executeQuery(queryString);
       return rs;
     } catch (Exception e) {
       System.out.println("FAILURE:" + e.getMessage());
       System.out.println("FAILURE:" + e.getStackTrace());
     }
     return null;
   }
   
   /**
    * NO5. Third Functionality:
    * View Item additional Information
    */
   public ResultSet getBidItemInfo(int itemId){
	 if(!member.isLoggedIn())
	       throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
     try {
       Connection con = openDBConnection();
       ResultSet rs;
       Statement stmt;
       stmt = con.createStatement();
       String queryString = "SELECT Harambase_getPrice_Func(I.ItemID) AS CURRENTBID, I.ITEMNAME, I.STARTPRICE"
       		+ " FROM HARAMBASE_ITEM I"
       		+ " WHERE I.ITEMID ='" + itemId + "'";
       rs = stmt.executeQuery(queryString);
       return rs;
     } catch (Exception e) {
       System.out.println("FAILURE:" + e.getMessage());
       System.out.println("FAILURE:" + e.getStackTrace());
     }
     return null;
   }
   
   /**
    * NO6. Functionality:
    * ADD ITEM
    */
   public void addItemWithoutPram(){
	   if(!member.isLoggedIn())
	       throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
	   try {
	      Connection con = openDBConnection();
	      CallableStatement cStmt;
	      cStmt = con.prepareCall("{call team2.ADD_ITEM_PRO(-1,?,?,?,?,?,?,?)}");
	      cStmt.setString(1, this.getItemName());
	      cStmt.setString(2, this.getItemCategory());
	      cStmt.setDouble(3, this.getItemStartPrice());
	      cStmt.setString(4, this.getItemDescription());
	      cStmt.setInt(5, this.getSellerID());
	      cStmt.setTimestamp(6, Timestamp.valueOf(this.getAuctionStartTime()));
	      cStmt.setTimestamp(7, Timestamp.valueOf(this.getAuctionEndTime()));
	      cStmt.execute();
	      
	    } catch (Exception e) {
	      System.out.println("FAILURE:" + e.getMessage());
	      System.out.println("FAILURE:" + e.getStackTrace());
	    }
   }
   
   /**
    * Additional Functionality
    * Get Maximum bid
    */
   public ResultSet getMaxBid(){
		 if(!member.isLoggedIn())
		      throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
	     try {
	    	 Connection con = openDBConnection();
	         String queryString = "SELECT Distinct MAX(X.MAXBIDLIMIT) AS MaxBid"
	         		+ " FROM Harambase_BID X"
	         		+ " WHERE X.ITEMID = ?";
	         PreparedStatement pstmt = con.prepareStatement(queryString);
	         pstmt.clearParameters();
	         pstmt.setInt(1, this.getItemId());
	         ResultSet rs = pstmt.executeQuery();
	         return rs;
	     } catch (Exception e) {
	       System.out.println("FAILURE:" + e.getMessage());
	       System.out.println("FAILURE:" + e.getStackTrace());
	     }
	     return null;
   }
   /**
    * NO6. Functionality:
    * Add ITEM
    */
   public void addItem(String itemName, String itemCate, double itemStartPirce, String itemDes, int sellerID, String startTime, String endTime){
	   if(!member.isLoggedIn())
	       throw new IllegalStateException("MUST BE LOGGED IN FIRST!");
	   try {
	      Connection con = openDBConnection();
	      CallableStatement cStmt;
	      cStmt = con.prepareCall("{call team2.ADD_ITEM_PRO(-1,?,?,?,?,?,?,?)}");
	      cStmt.setString(1, itemName);
	      cStmt.setString(2, itemCate);
	      cStmt.setDouble(3, itemStartPirce);
	      cStmt.setString(4, itemDes);
	      cStmt.setInt(5, sellerID);
	      cStmt.setString(6, startTime);
	      cStmt.setString(7, endTime);
	      cStmt.execute();
	      
	    } catch (Exception e) {
	      System.out.println("FAILURE:" + e.getMessage());
	      System.out.println("FAILURE:" + e.getStackTrace());
	    }
   }
   
   public static void main(String[] args) throws Exception{
	   Item it = new Item();
	   it.setItemId(101);
	   Member me = new Member();
	   me.setUname("slin");
	   me.setPassword("Lin");//id:3
	   me.setUserID(3);
	   me.login();
	   it.setMember(me);
	   
	   //LIST OF SELLER TEST:
	   ResultSet rs = it.getListOfBidders();
	   System.out.println("show List of Bidders");
	   while(rs.next()){
		   System.out.print(rs.getString("BIDDINGTIME")+ " "); 
		   System.out.print(rs.getString("USERNAME")+" ");
		   System.out.print(rs.getString("MAX_BID_LIMIT")+ " ");       
		   System.out.println();
	   }
	   System.out.println();
	   
	  //SHOW ITEM INFO TEST:
	   rs = it.getItemInformation();
	   System.out.println("show ITEM INFO");
	   while(rs.next()){
		   System.out.print(101); 
		   System.out.print(rs.getString("ITEMNAME")+ " "); 
		   System.out.print(rs.getString("ITEMCATEGORY")+" ");
		   System.out.print(rs.getString("AUCTIONSTARTTIME")+ " ");  
		   System.out.print(rs.getString("AUCTIONENDTIME")+ " ");  
		   System.out.print(rs.getString("DESCRIPTION")+ " ");  
		   System.out.println();
	   }
	   System.out.println();
	   
	   //ADD item test:
//	   it.setAuctionEndTime("TO_TIMESTAMP('03-NOV-2016 11:00:00', 'DD-MM-YYYY HH:MI:SS')");
//	   it.setAuctionStartTime("TO_TIMESTAMP('10-NOV-2017 12:00:00', 'DD-MM-YYYY  HH:MI:SS')");
//	   it.setItemCategory("BOOK");
//	   it.setItemName("Database Management");
//	   it.setItemStartPrice(50);
//	   it.setSellerID(3);
//	   it.setItemDescription("BRAND NEW");
//	   
//	   it.addItemWithoutPram();
	   
//	   rs = it.getItemInformation();
//	   System.out.println("show ITEM INFO");
//	   while(rs.next()){
//		   System.out.print(107); 
//		   System.out.print(rs.getString("ITEMNAME")+ " "); 
//		   System.out.print(rs.getString("ITEMCATEGORY")+" ");
//		   System.out.print(rs.getString("AUCTIONSTARTTIME")+ " ");  
//		   System.out.print(rs.getString("AUCTIONENDTIME")+ " ");  
//		   System.out.print(rs.getString("DESCRIPTION")+ " ");  
//		   System.out.println();
//	   }
//	   System.out.println();
	   
	   rs = it.getAdditionalItemInfo(101);
	   System.out.println("Show additional information");
	   while(rs.next()){
		   System.out.println(rs.getString("UNAME"));
	   }
	   
	   me.logout();
	   
   }

}