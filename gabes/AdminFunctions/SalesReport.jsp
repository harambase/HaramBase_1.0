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
		<title>Sales Summary Report</title>
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
		<h1>Sales Summary Report</h1>
<div class="table">




<table style="text-align: center; width: 63%; margin-left: auto; margin-right: auto; border="1"; cellpadding="2"; cellspacing="2"">
  <tbody>
    <tr>
      	<td style="vertical-align: top;"><b>Category</b><br> 
      	</td>
      	<td style="vertical-align: top;"><b>ItemID</b><br> 
      	</td>
      	<td style="vertical-align: top;"><b>Item Name</b><br>
      	</td>
     	 <td style="vertical-align:top;"><b>Final Selling price</b><br>
      	</td>
      	<td style="vertical-align: top;"><b>Commission</b><br>
      	</td>
   </tr>

    <% try{
    	ResultSet rs = admin.getSalesSummaryReport();
   	    while (rs.next()) {
   	    	  String curCate = rs.getString("ITEMCATEGORY");
   	    	  
   		      //System.out.println(rs.getString("ITEMCATEGORY")+" ");
   %>
      		<tr>
   	     	<td style="vertical-align: top; text-align:center;" contenteditable='false' bgcolor= "#babdb6 ">
   	     		<b><%=rs.getString("ITEMCATEGORY")%></b><br>
   	     	</td>
   	        </tr>
   	     	<tr>
   <%	      while(rs.getString("ITEMCATEGORY").equals(curCate)){%>

   	     	<td></td>
   	     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
   	     		<%=rs.getString("ITEMID")%><br>
   	     	</td>
   	     	
   	     	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
   	     		<%=rs.getString("ITEMNAME")%><br>
   	     	</td>
   	     	
   	    	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
   	    		$<%=rs.getDouble("FINAL_SELLING_PRICE")%><br>
   	    	</td>
   	    	
   	    	<td style="vertical-align: top; text-align:center;" contenteditable='false'>
   	    		$<%=rs.getDouble("COMMISSION")%><br>
   	    	</td>
   			</tr>
   	   		<%
   		        if(rs.next()) {rs.previous(); rs.next();}//A-?>B->A->B
   		        else break;
   		      }
   		      ResultSet rs2 = admin.getSubTotal(curCate);
   		      if(rs2.next())
   		    	  %>
   		    	  <tr>
   		    	  <td>SUBTOTAL</td>
   		    	  <td></td>
   		    	  <td></td>
   		    	  <td style="vertical-align: top; text-align:center;" contenteditable='false'>
   	    				$<%=rs2.getDouble("SUBTOTAL")%><br>
   	    		  </td>
   	    		  <td style="vertical-align: top; text-align:center;" contenteditable='false'>
   	    				$<%=rs2.getDouble("SUBCOM")%><br>
   	    		  </td>
   		    	  
   		      	  <% rs.previous();//C->B %> </tr> <%
    } 
    
    rs = admin.getTotal();
    if(rs.next())
    %>
	<tr>
		<td><b>TOTAL</b></td>
		<td></td>
		<td></td>
		<td style="vertical-align: top; text-align:center;" contenteditable='false'>
					$<%=rs.getDouble("TOTAL")%><br>
		</td>
		<td style="vertical-align: top; text-align:center;" contenteditable='false'>
		 			$<%=rs.getDouble("COMM")%><br>
		</td>
	</tr>
	<%
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