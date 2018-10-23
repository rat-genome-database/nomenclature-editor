<%-- *********************
Program Name - Nomen_Event.jsp
Programmer -  jiali chen
Creation Date - 07/10/2002

Description - This program will do the actual database updates for
the new object information.  Then display nomen event screen.

Modification log: none

***********************--%>
<%@ page language="java" import="online.*, common.*, manager.*,java.net.*, java.text.*,javax.servlet.*,javax.servlet.http.*"%>
<%@ include file="curation_lib.jsp"%>
<%@ include file="headerarea.jsp"%>
<%
String username = (String)session.getAttribute("username");
//System.out.println("username--nomen"+username);
String user_group = (String)session.getAttribute("user_group");
//if(username!=null) {
%>

  <jsp:include page="user_menu.jsp"  flush="true">
    <jsp:param name="highlighted" value="No1"/>
    <jsp:param name="user_group" value="<%=user_group%>"/>
    <jsp:param name="title" value="Online Curation"/>
    <jsp:param name="username" value="<%=username%>"/>
  </jsp:include>

<jsp:useBean id="gene" scope="session" class="online.Gene" />
<jsp:useBean id="alias" scope="session" class="online.Alias" />
<jsp:useBean id="xdb" scope="session" class="online.XDB" />

<%
  // initialize db handler via Servlet Context
  ServletContext context = request.getSession(true).getServletContext();
  DatabaseObj dbObj = (DatabaseObj)context.getAttribute("DEVHDL");
  if(dbObj == null) {
   dbObj = new DatabaseObj("dev_1");
   context.setAttribute("DEVHDL",dbObj);
  }
  gene.setContext(context);
  alias.setContext(context);
  xdb.setContext(context); 
  
  int user_key = Integer.parseInt((String)session.getAttribute("user_key"));
  String data_obj = (String)session.getAttribute("data_obj");
  // get new values
  String gene_symbol = request.getParameter("new_Symbol");
  gene_symbol = gene_symbol.trim();
  String full_name = request.getParameter("new_Name");
  full_name = full_name.trim();
  String product = request.getParameter("new_Product");
  product = product.trim();
  String function = request.getParameter("new_Function");
  function = function.trim();

  String description = request.getParameter("new_Description");
  description = description.trim();
  String gene_type = request.getParameter("new_Type");
  String chk_symbol = request.getParameter("Symbol");
  String chk_name = request.getParameter("Name");
//System.out.println("s=" + chk_symbol);
//System.out.println("n=" + chk_name);
  
  // get old values
  int gene_key = gene.getGene_key();
  int rgd_id = gene.getRgd_id();
  String old_symbol = gene.getGene_symbol();
  old_symbol = old_symbol.trim();
  String old_name = gene.getFull_name();
  old_name = old_name.trim();
  String old_prdt = gene.getProduct();
  old_prdt = old_prdt.trim();
  String old_func = gene.getFunction();
  old_func = old_func.trim();
  String old_desc = gene.getGene_desc();
  old_desc = old_desc.trim();
  String old_type = gene.getGene_type_lc();

  // form update sql stmt here
  String updt_sql = "";
  String old_record = "";
  boolean success = false;
  String err_msg = "";
  boolean nomen_flag = false;

  if(gene_symbol !=null && old_symbol != null) { 
     //if(!gene_symbol.equalsIgnoreCase(old_symbol)) {
     if(!gene_symbol.equals(old_symbol)) {
       nomen_flag = true;
       // needed when creating nomen_events
       session.setAttribute("NEWSYM", gene_symbol);     
       updt_sql = " GENE_SYMBOL='" +gene_symbol+"'";
       updt_sql += ",GENE_SYMBOL_LC='" +gene_symbol.toLowerCase()+"'";
       if(!old_symbol.equals(""))  {
        old_record = "GENE_SYMBOL==" + old_symbol;
       }
     }
  }
  else if(gene_symbol !=null && gene_symbol == null) {
       nomen_flag = true;
       session.setAttribute("NEWSYM", gene_symbol);
       updt_sql = " GENE_SYMBOL='" +gene_symbol+"'";
       updt_sql += ",GENE_SYMBOL_LC='" +gene_symbol.toLowerCase()+"'"; 
  }
  
  if(full_name !=null && old_name != null) {
     //if(!full_name.equalsIgnoreCase(old_name)) {
     if(!full_name.equals(old_name)) {
       nomen_flag = true;
       session.setAttribute("NEWNM", full_name);
       updt_sql += ",FULL_NAME='" + full_name+"'";
       updt_sql += ",FULL_NAME_LC='" + full_name.toLowerCase()+"'";
       if(!old_name.equals(""))  {
         old_record += "::FULL_NAME==" + old_name;
       }
     }
  }
  else if(full_name !=null && old_name == null) {
     nomen_flag = true;
     session.setAttribute("NEWNM", full_name);
     updt_sql += ",FULL_NAME='" + full_name+"'";
     updt_sql += ",FULL_NAME_LC='" + full_name.toLowerCase()+"'";
  }
  
  if(product!=null && old_prdt != null) {
     //if(!product.equalsIgnoreCase(old_prdt)) {
     if(!product.equals(old_prdt)) {
       updt_sql += ",PRODUCT='" + formatTicks(product)+"'";
       if(!old_prdt.equals(""))  {
         old_record += "::PRODUCT==" + old_prdt;
       }
     }
  }
  else if(product!=null && old_prdt == null) {
     updt_sql += ",PRODUCT='" + formatTicks(product)+"'";
  }
  
  if(function!=null && old_func != null) {
     //if(!function.equalsIgnoreCase(old_func)) {
     if(!function.equals(old_func)) {
       updt_sql += ",FUNCTION='" + formatTicks(function)+"'";
       if(!old_func.equals(""))  {
         old_record += "::FUNCTION==" + old_func;
       }
     }
  }
  else if(function!=null && old_func == null) {
    updt_sql += ",FUNCTION='" + formatTicks(function)+"'"; 
  }
  
  if(description!=null && old_desc != null) {
     //if(!description.equalsIgnoreCase(old_desc)) {
     if(!description.equals(old_desc)) {
       updt_sql += ",GENE_DESC='" + formatTicks(description)+"'";
       if(!old_desc.equals(""))  {
         old_record += "::GENE_DESC==" + old_desc;
       }
     }
  }
  else if(description!=null && old_desc ==null) {
     updt_sql += ",GENE_DESC='" + formatTicks(description)+"'";
  }
  
  
  if(gene_type!=null && old_type != null) {
     if(!gene_type.equalsIgnoreCase(old_type)) {
       updt_sql += ",GENE_TYPE_LC='" + gene_type+"'";
       if(!old_type.equals(""))  {
         old_record += "::GENE_TYPE_LC==" + old_type;
       }
     }
  }
  else if(gene_type!=null && old_type == null) {
     updt_sql += ",GENE_TYPE_LC='" + gene_type+"'";
  }
  
  // trim out comma if needed
  if(updt_sql.indexOf(',') == 0) {
     updt_sql = updt_sql.substring(1);
  }
  // trim out :: if needed
  if(old_record.indexOf(':') == 0) {
     old_record = old_record.substring(2);
  }
//out.println("updt=" + updt_sql);
//System.out.println("old=" + old_record);


  // do database updates and record changes in log table
  if(!updt_sql.equals("")) {
     gene.log.setData_obj(data_obj);
     gene.log.setUser_key(user_key);
     success = gene.updateGenes(gene_key, updt_sql, old_record);

     if(success) {

        XDB[] xdbs = gene.search_xdb(rgd_id);
        // need to update link_text in rgd_acc_xdb table if symbol==link_text
        for (int i = 0; i < xdbs.length; i++) {
          if(xdbs[i].getLink_text().equals(old_symbol))  { 
             success = xdb.updateXdbs(gene_symbol,xdbs[i].getAcc_xdb_key());
          }
        }       
 
        if(success) {

           // create alias if make alias check box is checked
           String alias_type = "";
           if(chk_symbol!=null && chk_symbol.equals("ON")) {       
               alias_type = "old_gene_symbol";
               success = alias.createAlias(rgd_id,old_symbol,alias_type);
               if(!success) {
                  err_msg = "Error occurred while creating alias (old gene symbol)";
               }
           }
           if(chk_name!=null && chk_name.equals("ON")) {
               alias_type = "old_gene_name";
               success = alias.createAlias(rgd_id,old_name,alias_type);
               if(!success) {
                 err_msg = "Error occurred while creating alias (old gene name)";
               }
           }
        }
        else {
            err_msg = "Error occurred while updating Link Text";
        }
     }
     else {
        err_msg = "Error occurred while updating gene object..";
     }
  }


// a check needs to add later
//do the rest only if updates are successful, otherwise display error page
if(!err_msg.equals("")) {  %>
  <p><%=err_msg%></p>  
<%
} else { 
   if(nomen_flag)  { 
%>
   <jsp:include page="Nomen_Event.jsp" flush="true" />
<% } else  { %>
      <p>You have sucessfully updated Gene Attributes.
<% } %>
<%} //end of else for if(!success) %>
<%--} end of if(username!=null)--%>

<jsp:include page="footerarea.jsp" flush="true" />

