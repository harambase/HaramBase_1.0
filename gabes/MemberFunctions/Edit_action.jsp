<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="member" class="s1lin.harambaseCore.Member" scope="session"/>
<jsp:setProperty name="member" property="*"/> 

<%
if(member.isLoggedIn()){
%>
<%
	int status = 0;
    try{
    	status = member.updateProfile(request.getParameter("NEWPASSWORD1"),request.getParameter("NEWPASSWORD2"));
    }
    catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }
%>

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
	</ul>
	
	   <%} %>
	
<% 
	if(status != 1){
%>
		<body>
			<h1>Update Failed</h1>
			<%if (status == -2){ %>
			<p> Error! Invalid password!</p>
			<%}if (status == -1){ %>
			<p> Error!! New Password does not match</p>
			<%}if (status == 0){ %>
			<p> Error!! SQL not executed</p>
			<%}%>
			<form method="post" action="Edit.jsp">  
			<input name="Submit" class="btn" style="margin-right:45%" value="Back to Update Profile" type="submit"><br>
			<input name="USERID" type = "hidden" value="<%=member.getUserID()%>">
			</form> 
		</body>
		<%}%>
<%
	if(status == 1){
%>
		<body>
		<h1>Update Successful</h1>

		<form method="post" action="Edit.jsp">  
		<input name="Submit" class="btn" style="margin-right:45%" value="Back to Update Profile" type="submit"><br>
		<input name="USERID" type = "hidden" value="<%=member.getUserID()%>">
		</form> 
	</body>
<%
	}
%>
</html>
<%
	}
	else{
		response.sendRedirect("../index.jsp");
	}
%>
