<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="bid" class="s1lin.harambaseCore.Bid" scope="session"/>
<jsp:useBean id="member" class="s1lin.harambaseCore.Member" scope="session"/>
<jsp:useBean id="item" class="s1lin.harambaseCore.Item" scope="session"/>
<jsp:useBean id="search" class="s1lin.harambaseCore.Search" scope="session"/>
<%if(member.login()){ %>
<jsp:setProperty name="bid" property="*"/> 
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../Harambase.css">
	<link rel="stylesheet" type="text/css" href="../DropdownMenu.css">
	<link rel="stylesheet" type="text/css" href="Member.css">
	<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
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
  
	  <li class="dropdown", style="float:down">
	 	 <form method="post" action="Search.jsp">
		<input name="Submit" class = "btnsearch" value="Back To Search" type="submit"><br>
		</form>
	  </li>
	  
	  <li class="dropdown", style="float:down">
	 	 <form method="post" action="SearchResult.jsp">
		<input name="Submit" class = "btnsearch" value="Search Result" type="submit"><br>
		</form>
	  </li>
	</ul>
	
	   <%} %>
	
<% 
    try{
    	System.out.println(bid.getItemID());
    	System.out.println(bid.getBiddingTime());
    	System.out.println(bid.getUserID());
    	System.out.println(bid.getMaxBidLimit());
    	bid.setMember(member);
    	bid.bidAnItem();
    	
    }
    catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }
/* @return int status 1: success
* 					2: item has been sold --THIS WILL NOT HAPPEN
* 					-1: Auction has not started --THIS WILLNOT HAPPEN
* 					3: The MAXBIDLIMIT is smaller than the start price
* 					4: The user is currently the winner.
* 					0: The SQL is not executed 
*/
	if(bid.getStatus() == 1){
   	 	response.sendRedirect("ListOfBidOn.jsp");
	}
	else{
		%>
	
		<body>
			<h1>Bid Failure</h1>
			<%if (bid.getStatus() == 3){ %>
			<p> Error!! The Max bid submitted is lower than Start Price!</p>
			<%}if (bid.getStatus() == 4){ %>
			<p> Error!! You currently are the winner!</p>
			<%}if (bid.getStatus() == 0){ %>
			<p> Error!! SQL not executed</p>
			<%}%>
			<form method="post" action="Bid.jsp">  
			<input name="Submit" class="btn" style="margin-right:53%" value="Back to re-bid" type="submit"><br>
			<input name="ITEMID" type = "hidden" value="<%=bid.getItemID()%>">
			</form> 
		</body>
		<%}%>

</html>
<%
	}
	else{
		response.sendRedirect("../index.jsp");
	}
%>