<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="admin" class= "s1lin.harambaseCore.Admin" scope="session"/>
<jsp:useBean id="member" class= "s1lin.harambaseCore.Member" scope="session"/>
<jsp:setProperty name="admin" property="*"/>
<jsp:setProperty name="member" property="*"/> 


<%if (admin.login()) response.sendRedirect("WelcomeAdmin.jsp");
  else if (member.login()){
	  response.sendRedirect("WelcomeMember.jsp");
  }
  else response.sendRedirect("index.jsp");
%> 


