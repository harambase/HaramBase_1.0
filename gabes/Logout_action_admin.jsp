<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="admin" class="s1lin.harambaseCore.Admin" scope="session"/> 
<% 
    try{
    	admin.logout();
 		session.invalidate();
    }
    catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }
    response.sendRedirect("index.jsp");
   %> 