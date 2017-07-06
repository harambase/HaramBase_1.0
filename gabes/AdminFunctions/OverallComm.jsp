
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
<h1>Overall Commission Report</h1>
<div class="table">
<table style="text-align: center; width: 65%; margin-left: auto; margin-right: auto; border="1"; cellpadding="2"; cellspacing="2"">
  <tbody>
    <tr>
      	<td style="vertical-align: top;"><b>UserID</b><br> 
      	</td>
      	<td style="vertical-align: top;"><b>UserName</b><br> 
      	</td>
      	<td style="vertical-align: top;"><b>First Name</b><br>
      	</td>
     	 <td style="vertical-align:top;"><b>Last Name</b><br>
      	</td>
      	<td style="vertical-align: top;"><b>Email</b><br>
      	</td>
      	<td style="vertical-align: top;"><b>Seller Rating</b><br>
      	</td>
      	<td style="vertical-align: top;"><b>Commissions</b><br>
      	</td>
   </tr>

    <% try{
    	ResultSet rs = admin.getOverallCommReport(); 
   	    while (rs.next()) {
	%>
	<tr>
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<%=rs.getString("USERID")%><br>
     	</td>
     	
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<%=rs.getString("USER_NAME")%><br>
     	</td>
     	
     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
     		<%=rs.getString("FIRST_NAME")%><br>
     	</td>
     	
    	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
    		<%=rs.getString("LAST_NAME")%><br>
    	</td>
    	
    	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
    		<%=rs.getString("Email")%><br>
    	</td>
    	
    	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
    		<%=rs.getString("SELLER_RATING")%><br>
    	</td>
    	
    	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
    		$<%=rs.getDouble("COMMISSIONS")%><br>
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
  <% try{
    	ResultSet rs = admin.getTotalIncome();
   	   if (rs.next()) {
   	   %>
   <h2><b>
     	Total Income : </b> $<%=rs.getString("TOTAL")%>
	   <%} rs.close();}
	
	    catch(IllegalStateException ise){
	        out.println(ise.getMessage());
	    }
	    %>
   </h2>

</body>
</html>
<%
	}
	else{
		response.sendRedirect("../index.jsp");
	}
%>