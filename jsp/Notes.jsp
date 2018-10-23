<%@ page language="java" import="java.net.*, java.text.*, manager.*" %>
<%@ include file="headerarea.jsp"%>

<%
String username = (String)session.getAttribute("username");
String user_group = (String)session.getAttribute("user_group");
if(username!=null) {
%>
  <jsp:include page="user_menu.jsp"  flush="true">
    <jsp:param name="highlighted" value="No1"/>
    <jsp:param name="user_group" value="<%=user_group%>"/>
    <jsp:param name="username" value="<%=username%>"/>
  </jsp:include>

<!--
  <FORM action=Gene_Note1.jsp method=post>
    <center><TABLE width=400 border=0>
      <TBODY>
        <TR>
          <TD>Select object</TD>
          <TD align=left>
            <SELECT size=1 name=data_obj> 
            <OPTION value=genes selected>-- Genes --</OPTION></SELECT></TD></TR>
        <TR>
          <TD>&nbsp;</TD>
          <TD>
          <INPUT type=button value="Edit notes" name=New>
          </TD></TR>
      </TBODY></TABLE></center>
          <INPUT type=hidden value=edit_record name=job> 
          <INPUT type=hidden value=notes name=task> 
  </FORM>
-->
   <h4><center>Under construction</center></h4>

<%} else { %>
    <h2>Sorry, the Browser cannot get your username! </h2>
<%} 
%>
<jsp:include page="footerarea.jsp" flush="true"/> >
	




