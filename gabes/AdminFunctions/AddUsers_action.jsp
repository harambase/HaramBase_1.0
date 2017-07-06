
<%@ page language="java" import="java.sql.*"%>

<jsp:useBean id="member" class="s1lin.harambaseCore.Member" scope="session"/>
<jsp:useBean id="admin" class="s1lin.harambaseCore.Admin" scope="session"/>

<jsp:setProperty name="member" property="*"/> 

<% 
if(admin.login()){
    try{
    	System.out.println(member.getUserID());
    	System.out.println(member.getUname());
    	System.out.println(member.getFname());
    	System.out.println(member.getLname());
    	System.out.println(member.getPassword());
    	System.out.println(member.getEmail());
    	System.out.println(admin.getUserID());//creator ID
    	
    	
    	admin.addUser(member.getUserID(),
    			member.getUname(), member.getFname(), 
    			member.getFname(), member.getLname(), 
    			member.getPassword(),admin.getUserID(), 1, 1);
    	response.sendRedirect("ViewUsers.jsp");
    }
    catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }
}
else{
	response.sendRedirect("../index.jsp");
}
%>