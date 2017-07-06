<!DOCTYPE html>
<html lang="en"><head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="index.css">
	<title>Log into Harambase</title>
</head>

<body id="cas">
	<div id="header">
		<div class="logo">
			<img src="Images/HaramBaseICON.png">
		</div>
	</div>
	<div id="outerWrapper">
	  <div id="innerWrapper">
		<h1>Welcome to Harambase</h1>
		<div id="content">

<div id="input">
  <form id="fm1" action="Login_action.jsp" method="post">
    <div id="usernamefield">
      <label for="username">Username</label>
	  <input id="username" name="uname" class="userpass" type="text" value="" size="25" autocomplete="off">
    </div>
    
	<div id="passwordfield">
		<label for="passpword">Password</label>
		<input id="password" name="password" class="userpass" type="password" value="" size="25" autocomplete="off">
	</div>
    	  <input name="submit" id="btnLogin" type="submit" class="btn" value="Login">
    	  <input type="reset" id="btnReset" class="btn"value="Reset"><br>
  </form>
  
</div>

		</div> 
		</div> 
	</div> 
	<div id="footer">
		<div id="copyright">
		<p><a>Copyright © 2016</a> - All Rights Reserved<br>
		<a>Harambase Development Team</a></p>
		</div>
	</div>
  

</body></html>