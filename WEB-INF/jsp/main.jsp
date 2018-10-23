<%@ page language="java" import="java.net.*, java.text.*, common.*" %>
<%@ include file="headerarea.jsp" %>

<%
    String username = (String) session.getAttribute("username");
    System.out.println("username--gene " + username);
    String user_group = (String) session.getAttribute("user_group");
    if (username != null) {

%>

<jsp:include page="middle.jsp" flush="true">
    <jsp:param name="user_group" value="<%=user_group%>"/>
    <jsp:param name="title" value="Curation Main Page"/>
    <jsp:param name="username" value="<%=username%>"/>
    <jsp:param name="func" value="main"/>
</jsp:include>


<%} else { %>
<h2>Sorry, the Browser cannot get your username! </h2>
<% } %>

<jsp:include page="footerarea.jsp" flush="true"/>




