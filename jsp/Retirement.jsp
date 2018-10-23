<%@ page language="java"
         import="online.*, common.*, manager.*,java.net.*, java.text.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ include file="curation_lib.jsp" %>
<%@ include file="headerarea.jsp" %>
<%
    String username = (String) session.getAttribute("username");
//System.out.println("username--nomen"+username);
    String user_group = (String) session.getAttribute("user_group");
    int user_key = Integer.parseInt((String) session.getAttribute("user_key"));
    String data_obj = (String) session.getAttribute("data_obj");

//if(username!=null) {
%>
<jsp:include page="user_menu.jsp" flush="true">
    <jsp:param name="highlighted" value="No1"/>
    <jsp:param name="user_group" value="<%=user_group%>"/>
    <jsp:param name="title" value="Online Curation"/>
    <jsp:param name="username" value="<%=username%>"/>
</jsp:include>

<jsp:useBean id="gene" scope="session" class="online.Gene"/>

<%
    int old_rgd = Integer.parseInt(request.getParameter("OLDRGD"));
    int new_rgd = Integer.parseInt(request.getParameter("NEWRGD"));
//System.out.println("old="+old_rgd);
//System.out.println("new="+new_rgd);
    boolean history = false;
    // initialize db handler via Servlet Context
    ServletContext context = request.getSession(true).getServletContext();
    DatabaseObj dbObj = (DatabaseObj) context.getAttribute("DEVHDL");
    if (dbObj == null) {
        dbObj = new DatabaseObj("dev_1");
        context.setAttribute("DEVHDL", dbObj);
    }
    gene.setContext(context);

    gene.log.setData_obj(data_obj);
    gene.log.setUser_key(user_key);
    history = gene.create_history_event(old_rgd, new_rgd);
    if (history) {
%>
<p>You have successfully Retired RGD ID: <%=old_rgd%>.<br>And a history record has been created.
    <%

      } else {

    %>

<p>Error occurred while creating history record. Try again later.
    <%}%>
    <%--} end of if(username!=null)--%>

    <jsp:include page="footerarea.jsp" flush="true"/>
