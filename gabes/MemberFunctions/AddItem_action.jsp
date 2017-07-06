
<%@ page language="java" import="java.sql.*"%>

<jsp:useBean id="member" class="s1lin.harambaseCore.Member" scope="session"/>
<jsp:useBean id="item" class="s1lin.harambaseCore.Item" scope="session"/>
<jsp:setProperty name="item" property="*"/> 

<% 
if(member.login()){
    try{
    	int status = 0;
    	String startTime = request.getParameter("StartYear") + "-" +
				   request.getParameter("StartMonth")+ "-" +
				   request.getParameter("StartDay")+ " "+request.getParameter("TimeStart");
		
		String endTime = request.getParameter("EndYear")+ "-" +
				 request.getParameter("EndMonth")+ "-" + 
				 request.getParameter("EndDay")+ " "+request.getParameter("TimeEnd");
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		
		if(Timestamp.valueOf(startTime).compareTo(ts) == 1 && 
				Timestamp.valueOf(startTime).compareTo(Timestamp.valueOf(endTime)) == -1)
			item.setAuctionStartTime(startTime);
		else{
			status = -1;
			item.setAuctionStartTime(null);
		}
		if(Timestamp.valueOf(endTime).compareTo(ts) == 1  && 
				Timestamp.valueOf(startTime).compareTo(Timestamp.valueOf(endTime)) == -1)
			item.setAuctionEndTime(endTime);
		else{
			status = -1;
			item.setAuctionEndTime(null);
		}
		Double startPrice = null;
		if(request.getParameter("StartPrice")!="")
			startPrice = Double.parseDouble(request.getParameter("StartPrice"));
		else startPrice = 0.0;
		
		if(startPrice > 0.0) item.setItemStartPrice(startPrice);
		else status = -2;
		
		
    	System.out.println(item.getItemName());
    	System.out.println(item.getItemCategory());
    	System.out.println(item.getItemStartPrice());
    	System.out.println(item.getItemDescription());
    	System.out.println(item.getSellerID());
    	System.out.println(item.getAuctionStartTime());
    	System.out.println(item.getAuctionEndTime());
    	if(status==0){
			item.addItemWithoutPram();
       		response.sendRedirect("ListItem.jsp");
    	}
    	else{
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
            	
            	   <%}%>
            
            		<body>
            			<h1>Add Failed</h1>
            			<%if (status == -1){%>
            			<p>!!Check Bidding Time.</p>
            			<%} if(status ==-2) %>
            			<p>!!Start Price must be bigger than zero.</p>
            			<form method="post" action="AddItem.jsp">  
            			<input name="Submit" class="btn" style="margin-right:50%" value="Back to Add Item" type="submit"><br>
            		   </form> 
            		</body>

            </html>
		<%

    	}
		System.out.println(item.getItemId());
    }
    catch(IllegalStateException ise){
        out.println(ise.getMessage());

    }
}
else{
	response.sendRedirect("../index.jsp");
}
%>