
<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="admin" class="s1lin.harambaseCore.Admin" scope="session"/>
<%
	if(admin.login()){
%>
<html>
<head>
		<link rel="stylesheet" type="text/css" href="../DropdownMenu.css">
		<link rel="stylesheet" type="text/css" href="../Harambase.css">
		<link rel="stylesheet" type="text/css" href="Admin.css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>View All Users</title>
	</head>
	
	<body>
	   	<div id="header">
			<div class="logo">
				<img src="../Images/HaramBaseICON.png">
			</div>			
	    </div>
	<ul>
	
	<li class="active">
	  	<a href="../WelcomeAdmin.jsp">Welcome</a>
		
	  <li class="dropdown">
	  	<a href="OverallComm.jsp">View Overall Commission Report</a>
  
	  <li class="dropdown">
	  <a href="SalesReport.jsp" class="dropbtn">View Sales Summary Report</a>
	   
	   
	  <li class="dropdown">
	    <a href="ViewUsers.jsp" class="dropbtn">View Members and add Member</a>
	  </li>
	  
	  <li class="dropdown", style="float:down">
	  	<form method="post" action="../Logout_action_admin.jsp">  
			<input class = "btnlogout" name="Submit" value="Logout" type="submit"><br>
		</form>
	  </li>
	</ul>
	<h1>View All Users</h1>
<div class="table">
	<table style="text-align: center; width: 65%; margin-left: auto; margin-right: auto; border="1";cellpadding="2"; cellspacing="2"">
	  <tbody>
	    <tr>
	      	<td style="vertical-align: top;"><b>UserID</b><br> 
	      	</td>
	      	<td style="vertical-align: top;"><b>User Name</b><br> 
	      	</td>
	      	<td style="vertical-align: top;"><b>First Name</b><br>
	      	</td>
	     	 <td style="vertical-align:top;"><b>Last Name</b><br>
	      	</td>
	      	<td style="vertical-align: top;"><b>Email</b><br>
	      	</td>
	      	<td style="vertical-align: top;"><b>Password</b><br>
	   </tr>
	
	    <% try{
	    	ResultSet rs = admin.getMemberInfo();
	   	   while (rs.next()) {
		%>
	    <tr>		
			<td style="vertical-align: top; text-align:center;" contenteditable='false'>
	     		<%=rs.getString("USERID")%><br>
	     	</td>
	     	
	     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
	     		<%=rs.getString("UNAME")%><br>
	     	</td>
	     	
	     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
	     		<%=rs.getString("FNAME")%><br>
	     	</td>
	     	
	    	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
	    		<%=rs.getString("LNAME")%><br>
	    	</td>
	    	
	    	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
	    		<%=rs.getString("EMAIL")%><br>
	    	</td>
	    	
	    	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
	    		<%=rs.getString("PASSWORD")%><br>
	   	</td>
	    	</tr>
	    
	    <%} rs.close();}
	
	    catch(IllegalStateException ise){
	        out.println(ise.getMessage());
	    }
	
		%>
	</tbody>
	</table>
</div>
<h2>Add User</h2>


<form method="post" action="AddUsers_action.jsp">
<div class="table">
<table style="text-align: center; width: 30%; margin-left: 20%; margin-right: auto; border="1";cellpadding="2"; cellspacing="2"">
  <tbody>
    <tr>
      	<td style="vertical-align: top;">UserID<br> 
      	</td>
      	<td style="vertical-align: top; text-align:center;">
	     		<input type="text" readonly name = "userID" value="-1"><br>
	    </td>	
    </tr> <tr>
      	<td style="vertical-align: top;">User Name<br> 
      	</td>
      	<td style="vertical-align: top; text-align:center;">
	     		<input type="text" name = "uname" value=""><br>
	     </td>
    </tr> <tr>
      	<td style="vertical-align: top;">First Name<br>
      	</td>
      	<td style="vertical-align: top; text-align:center;">
	     		<input type="text" name = "fname" value=""><br>
	    </td>
    </tr> <tr>
     	<td style="vertical-align:top;">Last Name<br>
      	</td>
      	<td style="vertical-align: top; text-align:center;">
	    		<input type="text" name = "lname" value=""><br>
	    </td>
    </tr> <tr>
      	<td style="vertical-align: top;">Email<br>
      	</td>
      	<td style="vertical-align: top; text-align:center;">
	    		<input type="text" name = "email" value=""><br>
	    </td>
    </tr> <tr>
      	<td style="vertical-align: top;">Password<br>
      	</td>
      	<td style="vertical-align: top; text-align:center;">
	    		<input type="text" name = "password" value=""><br>
	    </td>
    </tr>
</table>
</div>
	<input name="Submit" class="btnlogout" style="margin-right:45%" value="Add User" type="submit"><br>
</form>


</body>
</html>
<%
	}
	else{
		response.sendRedirect("../index.jsp");
	}
%>