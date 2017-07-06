<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="member" class="s1lin.harambaseCore.Member" scope="session"/>
<jsp:useBean id="item" class="s1lin.harambaseCore.Item" scope="session"/>
<jsp:useBean id="search" class="s1lin.harambaseCore.Search" scope="session"/>
<jsp:setProperty name="search" property="*"/>
<%
if(member.isLoggedIn()){
%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../Harambase.css">
	<link rel="stylesheet" type="text/css" href="../DropdownMenu.css">
	<link rel="stylesheet" type="text/css" href="Member.css">
	<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
	<title>Search Result</title>
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
	</ul>
	
	   <%} %>
		<h1>Search Result</h1>
		
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
     	 <td style="vertical-align: middle;"><b>Auction Start Time</b><br>
      	</td>
      	<td style="vertical-align: middle;"><b>Auction End Time</b><br>
      	</td>
      	<td style="vertical-align: middle;"><b>Current Bid</b><br>
      	</td>
      	<td style="vertical-align: middle;"><b>View Item Info</b><br>
      	</td>
      	<td style="vertical-align: middle;"><b>Bid On this Item</b><br>
      	</td>
   </tr>

    <% try{
	     if(!search.isSearched()){
	    	search.setMember(member);
	    	
	    	if(!request.getParameter("itemID").equals(""))
	    		search.setItemID(Integer.parseInt(request.getParameter("itemID")));
	    	else
	    		search.setItemID(null);
	    	
	    	if(!request.getParameter("category").equals(""))
	    		search.setCategory(request.getParameter("category"));
	    	else
	    		search.setCategory(null);
	    	
	    	if(!request.getParameter("keyword").equals(""))
	        	search.setKeyword(request.getParameter("keyword"));
	    	else
	    		search.setKeyword(null);
	    	
	    	String startTime = request.getParameter("StartYear") + "-" +
					   request.getParameter("StartMonth")+ "-" +
					   request.getParameter("StartDay")+ " "+request.getParameter("TimeStart");
	    	System.out.println(startTime.contains("-00"));
	
		    if(startTime.contains("YYYY")||startTime.contains("-00")||startTime.contains("Mon"))
	    		search.setStartTime(null);
		    else 
		    	search.setStartTime(startTime);
		    
		    String endTime = request.getParameter("EndYear")+ "-" +
					 request.getParameter("EndMonth")+ "-" + 
					 request.getParameter("EndDay")+" "+request.getParameter("TimeEnd");
		    
			if(endTime.contains("YYYY")||endTime.contains("-00")||endTime.contains("Mon"))
				search.setEndTime(null);
			else 
				search.setEndTime(endTime);
		    
			if(!request.getParameter("bidMin").equals(""))
	    		search.setBidMin(Double.parseDouble(request.getParameter("bidMin")));
	    	else
	    		search.setBidMin(null);
			
			if(!request.getParameter("bidMax").equals(""))
	    		search.setBidMax(Double.parseDouble(request.getParameter("bidMax")));
	    	else
	    		search.setBidMax(null);
			
			System.out.println("-----------------------");
			System.out.println(search.getItemID());
		    System.out.println(search.getKeyword());
		    System.out.println(search.getCategory());
	    	System.out.println(search.getStartTime());
		    System.out.println(search.getEndTime());
		    System.out.println(search.getBidMin());	
		    System.out.println(search.getBidMax());	
		    System.out.println("-----------------------");
    	}
	    ResultSet rs = search.searchItems();
    	boolean isEmpty = true;
    	search.setSearched(true);
    	if (rs!=null){
   	    while (rs.next()) {
   	    	item.setMember(member);
   	    	item.setItemId(rs.getInt("ITEMID"));
   	    	ResultSet rd = item.getItemInformation();
   	    	int sellerID = -1;
   	    	if(rd.next()) sellerID = rd.getInt("SELLERID"); 
   	     	String status = "";
	        //Status: 1: SOLD, 0: ON AUCTION, -1:NOT ON AUCTION
	        if(rs.getInt("STATUS") == 0 && sellerID != member.getUserID()){
	        	isEmpty = false;
	%>
	<tr>
     	<td style="vertical-align: middle; text-align:center;" contenteditable='false'>
     		<%=rs.getInt("ITEMID")%><br>
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
    		$<%=rs.getDouble("CURRENTBID")%><br>
    	</td>

		<td style="vertical-align: middle">
			<form method="post" action="ItemInfoSearch.jsp">
				<input class = "btn" name="Submit" value="item-info" type="submit">
				<input name="ITEMID" type="hidden" value ="<%=rs.getString("ITEMID")%>">
			</form>
		</td>

		<td>
			<form method="post" action="Bid.jsp">
				<input name="submit" id="btn" type="submit" class="btn" value="Bid">
				<input name="ITEMID" type="hidden"  value ="<%=rs.getString("ITEMID")%>">
			</form>
		</td>
		
    </tr>  
 		<%}}
   	    
   		if(isEmpty){%>
	        <tr><td>No Result</td></tr>   
		<%}
   	  }
      if(rs!=null)
    	  rs.close(); 
      else{
    	  System.out.println();
    	%> <tr><td>No Result</td></tr> <%
      }
     }

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