<%
  String user_group = request.getParameter("user_group");
  String username = request.getParameter("username");
  String password = (String)session.getAttribute("password");
  String title = request.getParameter("title");
  String func = request.getParameter("func");

%>
<TABLE border=1>
    <tr>
        <td>Curation</td>
        <td align></td>
    </tr>

    <TR><TD align=left>Welcome <%=username%></TD></TR>
</TABLE>

<center>
 <TABLE border="1">
    <TR><td align=center><h2><%=title%></h2></td>
    <TD align=center><A href="http://<%=request.getServerName()%>/tools/curation/submit/main.cgi?action=logout">
    <IMG src="<%= request.getContextPath() %>/images/logoff1.gif" border=0 name=log alt="logoff" height="20"></A></TD>
    </TR>
  </TABLE></center> 

