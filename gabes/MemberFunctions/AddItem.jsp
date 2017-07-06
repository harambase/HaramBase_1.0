<%@ page language="java" import="java.sql.*" %>
<jsp:useBean id="member" class="s1lin.harambaseCore.Member" scope="session"/>
<jsp:useBean id="item" class="s1lin.harambaseCore.Item" scope="session"/>
<%if(member.login()){ %>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../Harambase.css">
	<link rel="stylesheet" type="text/css" href="../DropdownMenu.css">
	<link rel="stylesheet" type="text/css" href="Member.css">
	<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
	<title>Add Item</title>
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
	<h1>Add An Item</h1>



<%item.setMember(member);%>

<form method="post" action="AddItem_action.jsp" name="EditForm">
<div id="table">
<table style="text-align: center; width: 10%; margin-right: auto; border="1"; cellpadding="2"; cellspacing="2"">
<tbody>
	<tr>
    	<td>Item ID</td>
    	<td> <input readonly name="itemId" value="-1"></td>
    </tr><tr>
   		
   		<td>Item Name</td>
   		<td> <input name="itemName" value=""></td>
    </tr><tr>
    	<td>Category</td>
    	<td><input name="itemCategory" value=""></td>
    </tr><tr>
    <td>Start Price </td>
    	<td>$<input style = "width: 80%; margin-right:0%;" name="StartPrice" value="0.0"></td>
    </tr><tr>
   		<td style="vertical-align: middle;"><b>Auction starts</b><br> 
      	</td>
    	<td style="vertical-align: middle; margin:0 auto; text-align:left;" contenteditable='false'>
    	<input type="text" name ="TimeStart" value = "00:00:00">
    	<select name="StartMonth">
			    <option value="01">Jan.</option>
			    <option value="02">Feb.</option>
			    <option value="03">Mar.</option>
			    <option value="04">Apr.</option>
			    <option value="05">May.</option>
			    <option value="06">Jun.</option>
			    <option value="07">Jul.</option>
			    <option value="08">Aug.</option>
			    <option value="09">Sep.</option>
			    <option value="10">Oct.</option>
			    <option value="11">Nov.</option>
			    <option value="12">Dec.</option>
	    </select>
	    
	    <select name="StartDay" id = "Day"></select>
	    	<script>
		    	(function() { // don't leak
				    var elm = document.getElementById("Day"), // get the select
				        df = document.createDocumentFragment(); // create a document fragment to hold the options while we create them
				    for(var i = 1; i <= 31; i++){
				    	var option = document.createElement('option'); // create the option element
				    	if(i<10){
				    		option.value = "0" + i;
				    		option.appendChild(document.createTextNode("0"+i));
				    	}
				    	else{
				    		option.value = i;
				    		option.appendChild(document.createTextNode(i));
				    	}// set the textContent in a safe way.
				    	df.appendChild(option); // append the option to the document fragment
		     		}
				    elm.appendChild(df); // append the document fragment to the DOM. this is the better way rather than setting innerHTML a bunch of times (or even once with a long string)
				}());
		</script>
		
		<select name="StartYear">
			    <option value="2016">2016</option>
			    <option value="2017">2017</option>
			 </select>
		</td>
    </tr><tr>
    	<td style="vertical-align: middle;"><b>Auction Ends</b><br> 
      	</td>
    	<td style="vertical-align: middle; margin:0 auto; text-align:left;" contenteditable='false'>
		<input type="text" name ="TimeEnd" value = "00:00:00">
    	<select name="EndMonth">
			    <option value="01">Jan.</option>
			    <option value="02">Feb.</option>
			    <option value="03">Mar.</option>
			    <option value="04">Apr.</option>
			    <option value="05">May.</option>
			    <option value="06">Jun.</option>
			    <option value="07">Jul.</option>
			    <option value="08">Aug.</option>
			    <option value="09">Sep.</option>
			    <option value="10">Oct.</option>
			    <option value="11">Nov.</option>
			    <option value="12">Dec.</option>
	    </select>
	    
	    <select name="EndDay" id = "Day2"></select>
	    	<script>
		    	(function() { // don't leak
				    var elm = document.getElementById("Day2"), // get the select
				        df = document.createDocumentFragment(); // create a document fragment to hold the options while we create them
				    for(var i = 1; i <= 31; i++){
				    	var option = document.createElement('option'); // create the option element
				    	if(i<10){
				    		option.value = "0" + i;
				    		option.appendChild(document.createTextNode("0"+i));
				    	}
				    	else{
				    		option.value = i;
				    		option.appendChild(document.createTextNode(i));
				    	}// set the textContent in a safe way.
				    	df.appendChild(option); // append the option to the document fragment
		     		}
				    elm.appendChild(df); // append the document fragment to the DOM. this is the better way rather than setting innerHTML a bunch of times (or even once with a long string)
				}());
		</script>
		
		<select name="EndYear">
			    <option value="2016">2016</option>
			    <option value="2017">2017</option>
			 </select>
		</td>
	</tr><tr>
   		<td> Description</td>
   		<td> <input name="itemDescription" value=""></td>
    </tr>

</tbody>
</table>
</div>
<input name="Submit" class="btn" style="margin-right: 54%" value="Add an Item" type="submit"><br>
<input name="sellerID" class="btn" type="hidden" value="<%=member.getUserID()%>">
</form>

</body>
</html>
<%
	}
	else{
		response.sendRedirect("../index.jsp");
	}
%>

