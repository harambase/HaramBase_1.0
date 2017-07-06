<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="member" class="s1lin.harambaseCore.Member" scope="session"/>
<%
if(member.isLoggedIn()){
%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../Harambase.css">
	<link rel="stylesheet" type="text/css" href="../DropdownMenu.css">
	<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
	<title>Item List</title>
</head>
<body>
   	<div id="header">
			<div class="logo">
				<img src="../Images/HaramBaseICON.png">
			</div>	
	    </div>
	<ul>
	
	<li class="active">
	  	<a href="../WelcomeMember.jsp">Welcome</a>
		<%
			if(member.getIsBuyer()==1){
		%>
	  <li class="dropdown">
	  	<a href="javascript:void(0)" class="dropbtn">Buying Management Tools</a>
	    <div class="dropdown-content">
			<a href="ListOfBidOn.jsp">List Of Bids</a>
			<a href="Search.jsp">Search</a>
			<a href="ListOfBought.jsp">List of Bought</a>
	    </div>
	    
		<%  }
		
			if(member.getIsSeller()==1){
		%>
	  <li class="dropdown">
	  <a href="javascript:void(0)" class="dropbtn">Selling management Tools</a>
	    <div class="dropdown-content">
		  	<a href="AddItem.jsp">Add an Item</a>
			<a href="ListItem.jsp">List of Selling</a>
			<a href="ViewMyFeedback.jsp">View my Rating</a>
	    </div>
	     <%
			}if(member.isLoggedIn()){
		%>
	  <li class="dropdown">
	    <a href="javascript:void(0)" class="dropbtn">Member Management Tool</a>
	    <div class="dropdown-content">
	      <a href="Edit.jsp">Update Profiles</a>
	    </div>
	  </li>
	  <li class="dropdown", style="float:down">
	  	<form method="post" action="../Logout_action_member.jsp">  
			<input class = "btnlogout" name="Submit" value="Logout" type="submit"><br>
		</form>
	  </li>
	</ul>
	
	   <%} %>
	  <h1>List of Your Items</h1>

<div id="table">

<table style="text-align: center; width: 100%; margin-left: auto; margin-right: auto; border="1"; cellpadding="2"; cellspacing="2"">
  <tbody>
    <tr>
      	<td style="vertical-align: top;"><b>itemID</b>
      	</td>
      	<td style="vertical-align: top;"><b>Item Name</b> 
      	</td>
      	<td style="vertical-align: top;"><b>Category</b>
      	</td>
     	 <td style="vertical-align:top;"><b>Start Time</b>
      	</td>
      	<td style="vertical-align: top;"><b>End Time</b>
      	</td>
      	<td style="vertical-align: top;"><b>Start Price</b>
      	</td>
      	<td style="vertical-align: top;"><b>Current Bid</b>
      	</td>
      	<td style="vertical-align: top;"><b>Status</b>
      	</td>
      	<td style="vertical-align: top;"><b>Item Info</b>
      	</td>
      	<td style="vertical-align: top;"><b>Bidder List</b>
      	</td>
   </tr>

    <% try{
    	ResultSet rs = member.getListofItems(); 
   	    while (rs.next()) {
   	        String status = "";
   	        //Status: 1: SOLD, 0: ON AUCTION, -1: 
 			//NOT ON AUCTION
   	        if(rs.getInt("STATUS") == 1) status = "SOLD";
   	        else if(rs.getInt("STATUS") == 0) status = "ON AUCTION";
   	        else if(rs.getInt("STATUS") == -1) status = "NOT ON AUCTION";
	%>
	<tr>
     	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
     		<%=rs.getString("ITEMID")%>
     	</td>
     	
     	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
     		<%=rs.getString("ITEMNAME")%>
     	</td>
     	
     	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
     		<%=rs.getString("ITEMCATEGORY")%>
     	</td>
     	
    	<td style="vertical-align: middle; text-align:left;" contenteditable='false'>
    		<%=rs.getTimestamp("AUCTIONSTARTTIME")%>
    	</td>
    	
    	<td style="vertical-align: middle; text-align:left;" contenteditable='false'>
    		<%=rs.getTimestamp("AUCTIONENDTIME")%>
    	</td>
    	
    	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
    		$<%=rs.getDouble("STARTPRICE")%>
    	</td>
    	<%if(rs.getDouble("CURRENT_BID")!=0){ %>
    	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
    		$<%=rs.getDouble("CURRENT_BID")-1%>
    	</td>
    	<%}if(rs.getDouble("CURRENT_BID")==0){ %>
    	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
    		$0.00
    	</td>
    	<%} %>
    	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
    		<%=status%>
    	</td>
    		
		<td style="vertical-align: middle">
			<form method="post" action="ItemInfo.jsp">
				<input class = "btn" name="Submit" value="item-info" type="submit">
				<input class = "btn" name="ITEMID" type="hidden" value ="<%=rs.getString("ITEMID")%>">
				<input class = "btn" name="LISTITEM" type="hidden" value ="1">
			</form>
		</td>
		<%if(rs.getInt("STATUS") != -1){ %>
		<td  style="vertical-align: middle">
			<form method="post" action="BidderList.jsp">
				<input class = "btn" name="Submit" value="bidder-List" type="submit">
				<input class = "btn" name="ITEMID" type="hidden" value ="<%=rs.getString("ITEMID")%>">
			</form>
		</td>
    </tr>
    	<%}
		} rs.close();}

    catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }
	%>
   </tbody>
 </table>
 </div>

</body>
</html>
<%
	}
	else{
		response.sendRedirect("../index.jsp");
	}
%>