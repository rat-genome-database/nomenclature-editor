<%-- *********************
Program Name - index.jsp
Programmer -  jiali chen
Creation Date - 07/05/2002

Description - This program displays user login screen and 
checks the security information for a user in the RGD Curation System. 

Modification log: none

***********************--%>
<%@ page language="java"
         import="common.*,manager.*, java.net.*, java.text.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ include file="headerarea.jsp" %>
<%@ include file="curation_lib.jsp" %>
<%
    if (request.getParameter("login") == null) {
%>
<H2>Online Curation Home Page</H2>

<P>

<FORM name="form1" action="index.jsp" method="post">
    <TABLE width=400 border=0>
        <TBODY>
            <TR>
                <TD colSpan=2><IMG src="images/login.gif" border=0> <B>Log On</B></TD>
                <TD>New user? <A href="http://<%=request.getServerName()%>/tools/curation/submit/signup.cgi">
                    Sign up</A></TD></TR>
            <TR>
                <TD>User Name:</TD>
                <TD>Password:</TD>
                <TD></TD></TR>
            <TR>
                <TD><INPUT size=10 name=username value=""></TD>
                <TD><INPUT type=password size=10 name=password value=""></TD>
                <TD>
                    <INPUT type=submit name=login src="images/button_g_logon.gif" border=0 value="Login">
                </TD></TR>
            <TR>
                <TD colSpan=3>User name and password are not case sensitive.</TD></TR>
        </TBODY>
    </TABLE>
</FORM>
<P>&nbsp;</P>

<P>&nbsp;</P>

<FORM action=http://<%=request.getServerName()%>/tools/curation/submit/main.cgi method=post>
    <TABLE width=400 border=0>
        <TBODY>
            <TR>
                <TD colSpan=3><B>Forget your password?</B></TD></TR>
            <TR>
                <TD>User Name:</TD>
                <TD>Email:</TD>
                <TD></TD></TR>
            <TR>
                <TD><INPUT size=10 name=new_username></TD>
                <TD><INPUT size=10 name=email></TD>
                <TD><INPUT type=image
                           src="images/button_g_submit.gif" border=0></TD></TR>
            <TR>
                <TD colSpan=3>We will send your password to your email
                    address.
                </TD></TR>
        </TBODY></TABLE>
</FORM>
<P>&nbsp;</P>

<P>&nbsp;</P>

<P>For any question, please contact <A
        href="http://<%=request.getServerName()%>/contact/">us</A>. </P>

<% } else { %>

<jsp:useBean id="user" scope="session" class="manager.User"/>


<%
    // initialize db handler via Servlet Context if not exists
    ServletContext context = request.getSession(true).getServletContext();

    DatabaseObj dbObj = (DatabaseObj) context.getAttribute("DSSHDL");
    if (dbObj == null) {
        dbObj = new DatabaseObj("dss");

        System.out.println("test=" + dbObj);
        context.setAttribute("DSSHDL", dbObj);
    }
    user.setContext(context);

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    boolean isCorrect = user.verifyUser(username, password);

    if (!isCorrect) {
%>
<H3 align="center">THE SYSTEM WAS UNABLE TO AUTHENTICATE THE USER .. PLEASE TRY AGAIN ...</H3>

<div align="center"><a href="index.jsp">Try Again</a>
    <%



      }
      else {
        session.setAttribute("username", username);
        session.setAttribute("password", password);
        String user_group = user.getUser_group();
        session.setAttribute("user_group", user_group);
        int user_key = user.getUser_key();
        session.setAttribute("user_key", ""+user_key);



    %>
    <jsp:include page="user_menu.jsp" flush="true">
        <jsp:param name="user_group" value="<%=user_group%>"/>
        <jsp:param name="username" value="<%=username%>"/>
    </jsp:include>

	<CENTER>
		<br>
		<br>
		<a href="Nomen.jsp?edit_record=job&notes=task&event_list=editCurrent"><b>-- Edit Current --</b></a></h3>
		<br>
		<a href="Nomen.jsp?edit_record=job&notes=task&event_list=merge"><b>-- Merge --</b></a>
		<br>
		<a href="Nomen.jsp?edit_record=job&notes=task&event_list=retirement"><b>-- Retirement --</b></a>
	</CENTER>
    <%



      }
    }



    %>

    <jsp:include page="footerarea.jsp" flush="true"/>
