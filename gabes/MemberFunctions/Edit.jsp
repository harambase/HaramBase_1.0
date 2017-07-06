<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="member" class="s1lin.harambaseCore.Member" scope="session"/>
<jsp:useBean id="feedback" class="s1lin.harambaseCore.Feedback" scope="session"/>
<%
if(member.isLoggedIn()){
%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="Member.css">
	<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
	<title>Update Profile</title>
</head>
<body>

<head>
	<link rel="stylesheet" type="text/css" href="../Harambase.css">
	<link rel="stylesheet" type="text/css" href="../DropdownMenu.css">
	<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
	<title>Update Profile</title>
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

	  <h1>Update Profile</h1>



<form method="post" action="Edit_action.jsp" name="Update">
<div id="table">
<table>

<tbody>
	    <tr>
	    	<td>Username</td>  
	    	<td>  <input type="text" readonly="readonly" name="uname" value="<%=member.getUname()%>"></td>
	    </tr>
	    <tr>
	    	<td>First Name</td>  
	    	<td> <input type="text"  name="fname" value="<%=member.getFname()%>"></td>
	    </tr>
	    
	    <tr>
	    	<td>Last Name</td>  
	    	<td> <input type="text"  name="lname" value="<%=member.getLname()%>"></td>
	    </tr>
	    
	    <tr>
	    	<td>Email</td>  
	    	<td> <input type="text"  name="email" value="<%=member.getEmail()%>"></td>
	    </tr>
	    <%if(member.getIsSeller() == 1){ 
	    	try{
	    		feedback.setMember(member);
	    		ResultSet rs = feedback.getAvgOverall();
	    		if(rs.next()){
	    %>
	    <tr>
	    	<td>Seller Rating</td>  
	    	<td> <%=rs.getString("overall")%></td>
	    </tr>
	    <%
	    		}
	    		rs = feedback.getNumOfRating();
	    		if(rs.next()){
	    %>
	    <tr>
	    	<td>Number of Seller Ratings</td>  
	    	<td> <%=rs.getString("ct")%></td>
	    </tr>
	    <% }rs.close();} 
	
		    catch(IllegalStateException ise){
		        out.println(ise.getMessage());
		    }
	    }
	    %>
	    <tr>
	    	<td>Password</td>  
	    	<td> <input name="password" type = "password" value=""></td>
	    </tr>
	    
	    <tr>
	    	<td>New Password</td>  
	    	<td> <input name="NEWPASSWORD1" type = "password" value=""></td>
	    </tr>
	    
	    <tr>
	    	<td>Retype Password</td>  
	    	<td> <input name="NEWPASSWORD2" type = "password" value=""></td>
	    </tr>
	    
</tbody>
</table> 
</div>
	<input name="Submit" class = "btnlogout" style = "margin-right:55%" value="Edit" type="submit">
</form>
</body>
</html>
<%
	}
	else{
		response.sendRedirect("../index.jsp");
	}
%>
