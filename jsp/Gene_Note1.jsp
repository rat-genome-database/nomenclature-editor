<%@ page language="java" import="java.net.*, manager.*, java.text.*" %>
<%@ include file="/template/header.jsp"%>

<%
String username = (String)session.getAttribute("username");
//System.out.println("username--gene note1"+username);
String user_group = (String)session.getAttribute("user_group");
if(username!=null) { %>

  <jsp:include page="user_menu.jsp"  flush="true">
    <jsp:param name="highlighted" value="No1"/>
    <jsp:param name="user_group" value="<%=user_group%>"/>
    <jsp:param name="username" value="<%=username%>"/>
  </jsp:include>

<!--<jsp:useBean id="log" scope="session" class="manager.Log" /> -->
<% String data_obj = request.getParameter("data_obj");
   session.setAttribute("data_obj", data_obj);
%>
  <FORM name=myForm method=post action="Gene_Note2.jsp">
  <CENTER>
      <TABLE width=500 border="0"  cellpadding=2 cellspacing=0 bgcolor="#CCCCCC">
			<TR bgcolor="#99CCFF"> 
			  <TD colspan=3 align=center><b><FONT size="4" face="Geneva, Arial, Helvetica, san-serif">Genes 
				Information</FONT></b></TD>
			</TR>
			<tr bgcolor="#CCCCCC"> 
			  <td colspan=3 align=center><b></b></td>
			</tr>
			<TR> 
			  <TD width="110"><b>Gene RGD ID</b></TD>
			  <TD width="265"> 
				<input type=text name=rgd_id size=30 value=>
			  </TD>
			  <TD width="113"> 
				<input type=submit name="get_value1" value="Get Info" onClick=check_field("rgd_id");>
			  </TD>
			</TR>
			<TR> 
			  <TD width="110"><b>Gene Symbol</b></TD>
			  <TD width="265"> 
				<input type=text name=gene_symbol_lc size=30 value="">
			  </TD>
			  <TD width="113"> 
				<input type=submit name="get_value2" value="Get Info" onClick=check_field("gene_symbol_lc");>
			  </TD>
			</TR>
			<TR> 
			  <TD width="110"><b>Full Name</b></TD>
			  <TD width="265"> 
				<INPUT type=text name=full_name size=30 value="">
			  </TD>
			  <TD width="113"> 
				<INPUT type=submit name="get_value3" value="Get Info" onClick=check_field("full_name");>
			  </TD>
			</TR>
			<TR> 
			  <TD colspan="3">&nbsp;</TD>
			</TR>
			<TR bgcolor="#CCCCCC"> 
			  <TD colspan="3">
				<CENTER>
				  <FONT size="3" color="#005E8A" face="Times New Roman, Times, serif"><b>Please enter gene RGD ID or Symbol 
				  or Full name.</b></FONT>
				</CENTER>
			  </TD>
			</TR>
		  </TABLE>
        </CENTER>

  </FORM>

<%} else { %>
    <h2>Sorry, the Browser cannot get your username! </h2>
<% } %>

    <jsp:include page="footerarea.jsp" flush="true"/>



