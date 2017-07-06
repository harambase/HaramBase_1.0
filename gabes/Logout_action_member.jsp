<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="member" class="s1lin.harambaseCore.Member" scope="session"/> 
<% 
    try{
    	member.logout();
 		session.invalidate();
    }
    catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }
    response.sendRedirect("index.jsp");
   %> 