<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="member" class="s1lin.harambaseCore.Member" scope="session"/>
<jsp:useBean id="search" class="s1lin.harambaseCore.Search" scope="session"/>
<%
if(member.isLoggedIn()){
%>
<%
	Double bidmax = null, bidmin = null;
%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../Harambase.css">
	<link rel="stylesheet" type="text/css" href="../DropdownMenu.css">
	<meta content="text/html; charset=ISO-8859-1" http-equiv="content-type">
	<title>Search</title>
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
	
	   <%} search.setSearched(false);%>
	  <h1>Search an Item</h1>

<div id="container" style="width:90%; margin-left:18%;">
	<div id="search" style="width:420px; margin-right:25%; position:relative; display: inline; float:right; background-color: #d3d7cf;">
	<h2 style="margin:0;">
The system supports the following search capabilities:<br></h2><p style="margin:5%;">
1. Search by item id alone,<br>
2. Search by keyword alone,<br>
3. Search by keyword and category,<br>
4. Search by keyword and current bid range,<br>
5. Search by keyword and auction time period,<br>
6. Search by keyword, category and current bid range,<br>
7. Search by keyword, category and auction time period,<br>
8. Search by keyword, current bid range and auction time period,<br>
9. Search by keyword, category, current bid range and auction time period.<br>
10. Inexact search on item name (i.e., Soundex)<br>
	</p>
	</div>
<div style="margin-left:18%; top:0%; display: inline; position:relative;">
<form method="post" action="SearchResult.jsp">

<table style="text-align: center; width: 30%; float:left; border="1"; cellpadding="2"; cellspacing="2"">
  <tbody>
	<tr>
		<td style="vertical-align: middle;"><b>Item ID</b><br> 
      	</td>
     	<td style="vertical-align: middle; text-align:left;" contenteditable='false'>
     		<input name = "itemID"  value = "">
     	</td>
    </tr><tr>
    	<td style="vertical-align: middle;"><b>Keyword</b><br> 
      	</td>
     	<td style="vertical-align: middle; text-align:left;" contenteditable='false'>
     		<input name = "keyword"  value = "">
     	</td>
    </tr><tr>
   		 <td style="vertical-align: middle;"><b>Category</b><br> 
      	</td>	
     	<td style="vertical-align: middle; text-align:left;" contenteditable='false'>
     	
     		  		<input name = "category"  value = "">
     	</td>
    </tr><tr>
    	<td style="vertical-align: middle;"><b>Bid Min</b><br> 
      	</td>	
     	<td style="vertical-align: middle; text-align:left;" contenteditable='false'>
     		<input name = "bidMin" value = "">
     	</td>
    </tr><tr>	
    	<td style="vertical-align: middle;"><b>Bid Max</b><br> 
      	</td>	
     	<td style="vertical-align: middle; text-align:left;" contenteditable='false'>
     		<input name = "bidMax" value = "">
     	</td>
    </tr><tr>
   		<td style="vertical-align: middle;"><b>Auction starts</b><br> 
      	</td>
    	<td style="vertical-align: middle; text-align:left;" contenteditable='false'>
    	<input type="hidden" name ="TimeStart" value = "00:00:00"> 	
    	<select name="StartMonth">
    			<option value="00">Mon.</option>
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
				    for(var i = 0; i <= 31; i++){
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
				<option value="YYYY">YYYY</option>
			    <option value="2015">2015</option>
			    <option value="2016">2016</option>
			    <option value="2017">2017</option>
			 </select>
		</td>
	
    </tr><tr>
    	<td style="vertical-align: middle;"><b>Auction Ends</b><br> 
      	</td>
    	<td style="vertical-align: middle; text-align:left;" contenteditable='false'>
		<input type="hidden" name ="TimeEnd" value = "00:00:00"> 
    	<select name="EndMonth">
    			<option value="00">Mon.</option>
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
				    for(var i = 0; i <= 31; i++){
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
				<option value="YYYY">YYYY</option>
			    <option value="2015">2015</option>
			    <option value="2016">2016</option>
			    <option value="2017">2017</option>
			 </select>
		</td>
	</tr><tr>	
	</tr>
	
   </tbody>
 </table>
<input name="Submit" class = "btnsearch2" value="Search" type="submit">
</form>
</div>
</div>

</body>
</html>
<%
	}
	else{
		response.sendRedirect("../index.jsp");
	}
%>