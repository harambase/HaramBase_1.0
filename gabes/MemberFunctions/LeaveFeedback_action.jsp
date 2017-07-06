<%@ page language="java" import="java.sql.*"%>

<jsp:useBean id="member" class="s1lin.harambaseCore.Member" scope="session"/>
<jsp:useBean id="feedback" class="s1lin.harambaseCore.Feedback" scope="session"/>

<jsp:setProperty name="feedback" property="*"/> 
<%
if(member.isLoggedIn()){
%>
<% 

    try{
    	System.out.println("ID   = " + feedback.getItemID());
    	System.out.println("OVER = " + feedback.getOverall());
    	System.out.println("DELI = " + feedback.getDeli());
    	System.out.println("QUAL = " + feedback.getItemQua());
    	System.out.println("COMM = " +feedback.getComment());
    	feedback.addFeedbackWithoutParm();
    }
    catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }
    response.sendRedirect("ListOfBought.jsp");
%>
<%
	}
	else{
		response.sendRedirect("../index.jsp");
	}
%>

