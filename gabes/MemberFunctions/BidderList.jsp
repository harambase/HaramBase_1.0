<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="member" class="s1lin.harambaseCore.Member" scope="session"/>
<jsp:useBean id="item" class="s1lin.harambaseCore.Item" scope="session"/>
<jsp:setProperty name="item" property="*"/>
<%
if(member.isLoggedIn()){
%>
<html>

<head>
	<link rel="stylesheet" type="text/css" href="../Harambase.css">
	<link rel="stylesheet" type="text/css" href="../DropdownMenu.css">
	<link rel="stylesheet" type="text/css" href="Member.css">
	<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
	<title>List of Bidders</title>
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
	 	 <form method="post" action="ListItem.jsp">
		<input name="Submit" class = "btnsearch" value="To List of Sells" type="submit"><br>
		</form>
	  </li>
	</ul>
	
	   <%} %>
	<h1>List of Bidders</h1>

<p>
</p>
<h2>Item ID: <%=request.getParameter("ITEMID")%></h2>
<%try{
	item.setMember(member);
	int itemId = Integer.parseInt(request.getParameter("ITEMID"));
	item.setItemId(itemId);
	ResultSet rs = item.getItemInformation();
	String startDate = "", endDate = "";
	int status = 10;
	if(rs.next()){
		startDate = rs.getDate("AUCTIONSTARTTIME").toString();
		endDate = rs.getDate("AUCTIONENDTIME").toString();
		status = rs.getInt("STATUS");
	}
%>
<h2>(<%=startDate %>  ---  <%=endDate %>)</h2>
<div id="table">
<table>
  
  <tbody>
  	<tr>
  		<td style="vertical-align: top; text-align:left;"><b>Bidding Time</b><br> 
      	</td>
      	<td style="vertical-align: top; text-align:left;"><b>User Name</b><br> 
      	</td>
      	<td style="vertical-align: top; text-align:left;"><b>Bidding Price</b><br> 
      	</td>
  	</tr>
    <% 
  		rs = item.getListOfBidders();
   	    while (rs.next()) {
	%>

	<tr>
     	<td style="vertical-align: top; text-align:left;" contenteditable='false'>
     		<%=rs.getString("BIDDINGTIME")%><br>
     	</td>

     	<td style="vertical-align: top; text-align:left;" contenteditable='false'>
     		<%=rs.getString("UserName")%><br>
     	</td>	
     	<td style="vertical-align: top; text-align:left;" contenteditable='false'>
     		$<%=rs.getDouble("Max_Bid_Limit")%><br>
     	</td>
    </tr>
    
   
    <%} 
		if(status == 1){
			System.out.println(itemId);
			rs = item.getAdditionalItemInfo(itemId);
			if(rs.next()){
			%>
				<tr>
					<td style="vertical-align: top; text-align:left;" contenteditable='false'><b>Winne</b>r</td>
					<td style="vertical-align: top; text-align:left;" contenteditable='false'><b><%=rs.getString("UNAME")%></b></td>
					<td style="vertical-align: top; text-align:left;" contenteditable='false'><b>$<%=rs.getDouble("SOLDPRICE")%></b></td> 
				</tr>
			<% 
			}
		}
	  	    rs.close();
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