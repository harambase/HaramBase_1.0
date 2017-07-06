<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="admin" class="s1lin.harambaseCore.Admin" scope="session"/> 
<!DOCTYPE html>
<%if(admin.login()){%>
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
	  	<a href="WelcomeAdmin.jsp">Welcome</a>
		
	  <li class="dropdown">
	  	<a href="AdminFunctions/OverallComm.jsp">View Overall Commission Report</a>
  
	  <li class="dropdown">
	  <a href="AdminFunctions/SalesReport.jsp" class="dropbtn">View Sales Summary Report</a>
	   
	   
	  <li class="dropdown">
	    <a href="AdminFunctions/ViewUsers.jsp" class="dropbtn">View Members and add Member</a>
	  </li>
	  
	  <li class="dropdown", style="float:down">
	  	<form method="post" action="Logout_action_admin.jsp">  
			<input class = "btnlogout" name="Submit" value="Logout" type="submit"><br>
		</form>
	  </li>
	</ul>
	   
		<h1>Welcome Back Admin</h1>
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

		
	</body>
</html>
<%
}
else{
	response.sendRedirect("index.jsp");
}
%>

