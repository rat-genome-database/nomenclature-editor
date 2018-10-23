<%-- *********************
Program Name - Edit_object.jsp
Programmer -  jiali chen
Creation Date - 07/05/2002

Description - This program allows user to update current object information 
in the database.  The screen is prepopulated with values retrieved from 
database based on the key information entered by user

Modification log: none

***********************--%>
<%@ page language="java" import="online.*, common.*, java.net.*, java.text.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ include file="headerarea.jsp"%>
<%@ include file="curation_lib.jsp"%>

<%
String username = (String)session.getAttribute("username");
String user_group = (String)session.getAttribute("user_group");
//if(username!=null) {
%>

  <jsp:include page="user_menu.jsp"  flush="true">
    <jsp:param name="highlighted" value="No2"/>
    <jsp:param name="user_group" value="<%=user_group%>"/>
    <jsp:param name="title" value="Online Curation"/>
    <jsp:param name="username" value="<%=username%>"/>
  </jsp:include>

<jsp:useBean id="gene" scope="session" class="online.Gene" />
<!--<jsp:useBean id="alias" scope="session" class="online.Alias" /> -->
<%
  // initialize db handler via Servlet Context
  ServletContext context = request.getSession(true).getServletContext();
  DatabaseObj dbObj = (DatabaseObj)context.getAttribute("DEVHDL");
//System.out.println("EO=="+dbObj);
  if(dbObj == null) {
   dbObj = new DatabaseObj("dev_1");
   context.setAttribute("DEVHDL",dbObj);
  }
  gene.setContext(context);

  String[] gene_types = gene.getGene_types();
  String[] gene_type_desc = gene.getGene_type_desc();

  String data_obj = request.getParameter("OBJECT");
  session.setAttribute("data_obj", data_obj);
  String event = request.getParameter("EVENT"); 
  String condition = null;
  if(event.equals("editCurrent")) {
     String gene_symbol = request.getParameter("SYMBOL");
     String rgd_id = request.getParameter("RGDID");
     if(gene_symbol != null) { 
        condition = " WHERE gene_symbol_lc=lower('" + gene_symbol + "')";
     }
     else if(rgd_id != null) {
        condition = " WHERE g.rgd_id=" + rgd_id;
     }
  }
  
  boolean isThere = gene.searchGene(condition);
  String column_name[] = {"Symbol","Name","Product","Function","Description","Type"};
  String col_vals[] = new String[6];

  if(isThere) {
     col_vals[0] = gene.getGene_symbol();
     col_vals[1] = gene.getFull_name();
     col_vals[2] = gene.getProduct();
     col_vals[3] = gene.getFunction();
     col_vals[4] = gene.getGene_desc();
     col_vals[5] = gene.getGene_type_lc();

     // set values to bean for later use
     gene.setGene_symbol(col_vals[0]);
     int rgdid = gene.getRgd_id();         
     gene.setRgd_id(rgdid); 

     // get aliases to display
     //boolean hasAlias = gene.search_Aliases(rgdid);
     Alias[] aliases = gene.search_Aliases(rgdid);
     int len = aliases.length;
%>
  <FORM action=Object_Update.jsp method=post>
		 <table border="1" bgcolor="#FFFFFF" align="center">
			<TR BGCOLOR="#CCCCCC">
			  <TD colspan=4 bordercolor="#CCCCCC" align=center><b>Edit Current Object</b></TD>
			</TR>
      <!-- display aliases values -->
<%    //if(hasAlias)  { 
        //Alias[] aliases = gene.getAlias();
      if(len > 0 ) {
%> 
        <TR><TD colspan=4><table border="1" bgcolor="#FFFFFF" align="center">
            <tr><td><b>Alias Type</b></td><td><b>Alias Value</b></td></tr>
<%
        for (int i = 0; i < aliases.length; i++) {
%>              
          <tr><td><font size=2><%=aliases[i].getAlias_type_name_lc()%></font></td>
              <td><font size=2><%=aliases[i].getAlias_value()%></font></td></tr>
<%      } //end of for  %>
        </table></TD></TR>
<%
      }  //end of if
%>
      <TR>
        <TD colspan=2><font color="#0033CC"><b>Current Value</b></font></TD>
        <TD><font color="#0033CC"><b>New Value</b></font></TD>
      </TR>
<!-- start loop here -->
<%  for(int i = 0; i < column_name.length; i++ ) { %>        
			<TR>        
<%    if(column_name[i].equals("Symbol")||column_name[i].equals("Name")) { %>       
        <TD><b><%=column_name[i]%>:</b> <%=col_vals[i]%></TD>
        <TD><b>make&nbsp;Alias</b><input type="checkbox" name="<%=column_name[i]%>" value="ON" checked></TD>
        <TD><INPUT TYPE="TEXT" SIZE="40" NAME="new_<%=column_name[i]%>" VALUE="<%=col_vals[i]%>"></TD>
<%    } else { %> 
           <TD colspan=2><b><%=column_name[i]%>:</b> <%=col_vals[i]%></TD>
<%         if(column_name[i].equals("Type")) { %>
			       <TD><select name="new_<%=column_name[i]%>" size="1">
                  <option value="">-- select one --</option>
                <%  for(int j = 0; j < gene_types.length; j++ ) { %>              
                       <option value="<%=gene_types[j]%>" <%= itemSelected(col_vals[i], gene_types[j])%>>
                          -- <%=gene_type_desc[j]%> --</option>
                 <% } %>  
               </select>
             </TD>
<%         } else {%>
             <TD><textarea rows="3" cols="30" NAME="new_<%=column_name[i]%>" wrap="virtual"><%=col_vals[i]%></textarea></TD>
<%         } %>          
<%    } %>        
	 </TR>
<%
}  // end for
%>
      <br>
			<TR bgcolor="#FFFFFF" bordercolor="#FFFFFF"> 
			  <TD colspan=4><CENTER><input type="submit"  value="submit data"></CENTER></TD>
			</TR>
		  </table>
</FORM>
<%
  } // end of if(isThere)
  else  {
%>
    <p><center><b>No record found in RGD for the given gene symbol or rgd id<br>Or it has been retired.</b></center>
<%} %>
<%-- } end of if(username!=null)--%>
<jsp:include page="footerarea.jsp" flush="true" />

