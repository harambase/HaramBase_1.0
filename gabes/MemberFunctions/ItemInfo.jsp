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
	<title>Item Information</title>
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
	<h1>Item Information</h1>


<div id="table">
<table style="text-align: left">
  <tbody>
    <% try{
    	item.setMember(member);
    	item.setItemId(Integer.parseInt(request.getParameter("ITEMID")));
    	ResultSet rs = item.getItemInformation(); 
   	    while (rs.next()) {
	%>
	<tr>
		<td style="vertical-align: top; text-align:left;"><b>Item ID</b><br> 
      	</td>
     	<td style="vertical-align: top; text-align:left;" contenteditable='false'>
     		<%=rs.getString("ITEMID")%><br>
     	</td>
    </tr><tr>
    	<td style="vertical-align: top; text-align:left;"><b>Item Name</b><br> 
      	</td>
     	<td style="vertical-align: top; text-align:left;" contenteditable='false'>
     		<%=rs.getString("ITEMNAME")%><br>
     	</td>
    </tr><tr>
   		 <td style="vertical-align: top; text-align:left;"><b>Category</b><br> 
      	</td>	
     	<td style="vertical-align: top; text-align:left;" contenteditable='false'>
     		<%=rs.getString("ITEMCATEGORY")%><br>
     	</td>
    </tr><tr>
   		 <td style="vertical-align: top; text-align:left;"><b>Start Price</b><br> 
      	</td>
    	<td style="vertical-align: top; text-align:left;" contenteditable='false'>
    		$<%=rs.getDouble("STARTPRICE")%><br>
    	</td>
    </tr><tr>
   		 <td style="vertical-align: top; text-align:left;"><b>Auction starts</b><br> 
      	</td>
    	<td style="vertical-align: top; text-align:left;" contenteditable='false'>
    		<%=rs.getString("AUCTIONSTARTTIME")%><br>
    	</td>
    </tr><tr>
    	<td style="vertical-align: top; text-align:left;"><b>Auction ends</b><br> 
    	<td style="vertical-align: top; text-align:left;" contenteditable='false'>
    		<%=rs.getString("AUCTIONENDTIME")%><br>
    	</td>
	</tr><tr>	
	</tr><tr>
    	<td style="vertical-align: top; text-align:left;"><b>Description</b><br> 
    	<td style="vertical-align: top; text-align:left;" contenteditable='false'>
    		<%=rs.getString("DESCRIPTION")%><br>
    	</td>
	</tr><tr>
    </tr>
    
   
    <%} rs.close();}

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