<%@ page language="java" import="java.sql.*" %> 
<jsp:useBean id="member" class="s1lin.harambaseCore.Member" scope="session"/>
<jsp:useBean id="feedback" class="s1lin.harambaseCore.Feedback" scope="session"/>
<%
if(member.isLoggedIn()){
%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../DropdownMenu.css">
	<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
	<title>View my Feedback</title>
</head>
<body>
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
	  <h1>View my Feedback</h1>


<% 
	double overall = 0;
	int ct = 0;
    try{
    	feedback.setMember(member);
    	ResultSet rs = feedback.getFeedback();
		if(rs.next()){
			rs.previous();
%>
<div id="table">
<table>
  <tbody>
    <tr>
      	<td style="vertical-align: top;"><b>Rater</b>
      	</td>
      	<td style="vertical-align: top;"><b>IteamID</b> 
      	</td>
      	<td style="vertical-align: top;"><b>Overall Rating</b>
      	</td>
     	 <td style="vertical-align:top;"><b>Item Quality</b>
      	</td>
      	<td style="vertical-align: top;"><b>Delivery</b>
      	</td>
      	<td style="vertical-align: top;"><b>Comments</b>
      	</td>
      	<td></td>
      	<td></td>
   </tr>

	<%
   	    while (rs.next()) {
			overall += rs.getInt("OVERALLRATING");
			ct++;
	%>
	<tr>
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<%=rs.getString("UNAME")%>
     	</td>
     	
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<%=rs.getString("ITEMID")%>
     	</td>
     	
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<%=rs.getInt("OVERALLRATING")%> 
     	</td>
     	
    	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
    		<%=rs.getInt("ITEMQUALITY")%>
    	</td>
    	
    	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
    		<%=rs.getInt("DELIVERY")%>
    	</td>
    	
    	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
    		<%=rs.getString("COMMENTS")%>
    	</td>    		
    </tr>
    
   
    	<%} rs.close();	%>
    
   </tbody>
 </table>
 </div>
 <h2>Summary:</h2>
 <p>Average Rating: <%=overall/ct %></p>
 <p>Number of Records: <%=ct%></p>
 <%
}
    else{
        %>
        <h2>There is 0 record.</h2>
        <%
        }}
	catch(IllegalStateException ise){
     out.println(ise.getMessage());
}
   
    
%>
</body>
</html>
<%
	}
	else{
		response.sendRedirect("../index.jsp");
	}
%>