<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="member" class="s1lin.harambaseCore.Member" scope="session"/> 
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="DropdownMenu.css">
		<link rel="stylesheet" type="text/css" href="Harambase.css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	</head>
	
	<body>
	   	<div id="header">
			<div class="logo">
				<img src="Images/HaramBaseICON.png">
			</div>			
	    </div>
	<ul>
	
	<li class="active">
	  	<a href="WelcomeMember.jsp">Welcome</a>
		<%
			if(member.getIsBuyer()==1){
		%>
	  <li class="dropdown">
	  	<a href="javascript:void(0)" class="dropbtn">Buying Management Tools</a>
	    <div class="dropdown-content">
			<a href="MemberFunctions/ListOfBidOn.jsp">List Of Bids</a>
			<a href="MemberFunctions/Search.jsp">Search</a>
			<a href="MemberFunctions/ListOfBought.jsp">List of Bought</a>
	    </div>
	    
		<%  }
		
			if(member.getIsSeller()==1){
		%>
	  <li class="dropdown">
	  <a href="javascript:void(0)" class="dropbtn">Selling management Tools</a>
	    <div class="dropdown-content">
		  	<a href="MemberFunctions/AddItem.jsp">Add an Item</a>
			<a href="MemberFunctions/ListItem.jsp">List of Selling</a>
			<a href="MemberFunctions/ViewMyFeedback.jsp">View my Rating</a>
	    </div>
	     <%
			}if(member.isLoggedIn()){
		%>
	  <li class="dropdown">
	    <a href="javascript:void(0)" class="dropbtn">Member Management Tool</a>
	    <div class="dropdown-content">
	      <a href="MemberFunctions/Edit.jsp">Update Profiles</a>
	    </div>
	  </li>
	  <li class="dropdown", style="float:down">
	  	<form method="post" action="Logout_action_member.jsp">  
			<input class = "btnlogout" name="Submit" value="Logout" type="submit"><br>
		</form>
	  </li>
	</ul>
	
	   <%} %>
	   <div id="title">
		   <header class="mega-header">
			 	<h2>Welcome Back <%=member.getFname()%>!</h2>
	 			<p> UserID: <%=member.getUserID() %></p>
			</header>
		</div>	  
	  
		<p style="margin-right:20%">GABeS is an online information system that operates on top of a database backend in order to manage users and auctions.
			There are two distinct types of users: Administrators and Customers; customers also come in two flavors: Sellers and
			Bidders. Unique customer IDs are assigned to customers to keep track of them. A customer may update their own user
			profile; each customer has an email address and a unique username in addition to other pertinent information as
			described later on in this document. Sellers post item(s) they want to auction/sell and bidders bid on any item of interest
			as long as the item is on auction. Auction winners pay the current (winning) bid for items won (for now, payments occur
			outside GABeS). When posting new items for auction/sale, a seller must specify all item information (item name, item
			description, etc.), starting bid, and the auction end date. The system generates unique item IDs to keep track of auction
			items.
		</p>
		<div id="footer">
		<div id="copyright">
		<p><a>Copyright © 2016</a> - All Rights Reserved<br>
		<a>Harambase Development Team</a></p>
		</div>
	</div>
	</body>
</html>


