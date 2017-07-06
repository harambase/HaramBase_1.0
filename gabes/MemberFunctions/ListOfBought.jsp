<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="member" class="s1lin.harambaseCore.Member" scope="session"/>
<jsp:useBean id="feedback" class="s1lin.harambaseCore.Feedback" scope="session"/>
<%
if(member.isLoggedIn()){
%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../Harambase.css">
	<link rel="stylesheet" type="text/css" href="../DropdownMenu.css">
	<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
	<title>List of Bought</title>
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
	  <h1>List of Items Bought</h1>

<div id="table">

<table style="text-align: center; width: 100%; margin-left: auto; margin-right: auto; border="1"; cellpadding="2"; cellspacing="2"">
  <tbody>
    <tr>
      	<td style="vertical-align: middle;"><b>itemID</b><br> 
      	</td>
      	<td style="vertical-align: middle;"><b>Item Name</b><br> 
      	</td>
      	<td style="vertical-align: middle;"><b>Category</b><br>
      	</td>
     	 <td style="vertical-align:middle;"><b>Auction Start Time</b><br>
      	</td>
      	<td style="vertical-align: middle;"><b>Auction End Time</b><br>
      	</td>
      	<td style="vertical-align: middle;"><b>Start Price</b><br>
      	</td>
      	<td style="vertical-align: middle;"><b>Sold Price</b><br>
      	</td>
      	<td style="vertical-align: middle;"><b>Seller Username</b><br>
      	</td>
      	<td style="vertical-align: middle;"><b>Seller Email</b><br>
      	</td>
      	<td style="vertical-align: middle;"><b>Leave Feedback</b><br>
   </tr>

    <% try{
    	ResultSet rs = member.getBoughtItems();
   	    while (rs.next()) {
	%>
	<tr>
     	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
     		<%=rs.getString("ITEMID")%><br>
     	</td>
     	
     	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
     		<%=rs.getString("ITEMNAME")%><br>
     	</td>
     	
     	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
     		<%=rs.getString("ITEMCATEGORY")%><br>
     	</td>
     	
    	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
    		<%=rs.getTimestamp("AUCTIONSTARTTIME")%><br>
    	</td>
    	
    	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
    		<%=rs.getTimestamp("AUCTIONENDTIME")%><br>
    	</td>
    	
    	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
    		$<%=rs.getDouble("STARTPRICE")%><br>
    	</td>
    	
    	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
    		$<%=rs.getDouble("SoldPrice")%><br>
    	</td>
    	
    	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
    		<%=rs.getString("SellerUname")%><br>
    	</td>
    	
    	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
    		<%=rs.getString("Email")%><br>
    	</td>
    	<%
    		feedback.setMember(member);
    		ResultSet rd = feedback.getFeedbackByItemID(rs.getInt("ITEMID"));
    		if(rd.next()){
    		%>
    			<td style="vertical-align: middle; text-align:center;" contenteditable='false'>You have left feedback</td>
    		<%
    		}
    		else{
		    	%>
				<td>
					<form method="post" action="LeaveFeedback.jsp">
						<input name="Submit" value="rate-Seller" class="btn" type="submit"><br>
						<input name="ITEMID" type="hidden" value ="<%=rs.getString("ITEMID")%>">
						<input name="ITEMNAME" type = "hidden" value="<%=rs.getString("ITEMNAME")%>">
					</form>
				</td>
			<%} %>
    </tr>
    	<%
		}rs.close();}

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