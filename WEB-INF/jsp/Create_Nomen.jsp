<%-- ***************************************
Program Name - Create_Nomen.jsp
Programmer -  jiali chen
Creation Date - 10/13/2002

Description - This program creates nomen even 
              for the given gene.
*****************************************--%>
<%@ page language="java" import="online.*, common.*, manager.*,java.net.*, java.text.*,javax.servlet.*,javax.servlet.http.*"%>
<%@ include file="curation_lib.jsp"%>
<%@ include file="headerarea.jsp"%>
<%
String username = (String)session.getAttribute("username");
//System.out.println("username--nomen"+username);
String user_group = (String)session.getAttribute("user_group");
String event = (String)session.getAttribute("event");
String newsym = (String)session.getAttribute("NEWSYM");
String newnm = (String)session.getAttribute("NEWNM");
int user_key = Integer.parseInt((String)session.getAttribute("user_key"));
String data_obj = (String)session.getAttribute("data_obj");

//if(username!=null) {
%>
  <jsp:include page="user_menu.jsp"  flush="true">
    <jsp:param name="highlighted" value="No1"/>
    <jsp:param name="user_group" value="<%=user_group%>"/>
    <jsp:param name="title" value="Online Curation"/>
    <jsp:param name="username" value="<%=username%>"/>
  </jsp:include>

<jsp:useBean id="gene" scope="session" class="online.Gene" />
<jsp:useBean id="nomen_event" scope="session" class="online.Nomen_event" />
<jsp:useBean id="dtset" scope="session" class="online.Data_set" />
<%
  // initialize db handler via Servlet Context
  ServletContext context = request.getSession(true).getServletContext();
  DatabaseObj dbObj = (DatabaseObj)context.getAttribute("DEVHDL");
  if(dbObj == null) {
   dbObj = new DatabaseObj("dev_1");
   context.setAttribute("DEVHDL",dbObj);
  }
  dtset.setContext(context);
  gene.setContext(context);
  nomen_event.setContext(context);

  Gene[] geneAry = dtset.getGene(); // in case of Merge
  int rgd_id = gene.getRgd_id();
  String symbol = gene.getGene_symbol();
  String name = gene.getFull_name();
  int ref_key = Integer.parseInt(request.getParameter("ref_key"));
  String nomen_status_type = request.getParameter("nomen_status_type");
  String description = request.getParameter("new_desc");
  if(description==null || description.equals("")) {
    description = request.getParameter("description_list");
  }
  String notes = request.getParameter("notes");
  
  // form SQL stmt
  String sql_vals = ""; 
  
  if(event.equals("merge")) {
     sql_vals = ",'" +geneAry[1].getGene_symbol()+"'";
     sql_vals += ",'" +geneAry[1].getFull_name()+"'";
  }
  else  {
     if(newsym != null) {
      sql_vals = ",'"+newsym+"'";
     }
     else { sql_vals = ",''";  }
     if(newnm != null) {
      sql_vals += ",'"+newnm+"'"; 
     }
     else { sql_vals += ",''";  }
  }
  // previous_symbol, previous_name
  if(event.equals("merge")) {
     sql_vals += ",'" +geneAry[0].getGene_symbol()+"'";
     sql_vals += ",'" +geneAry[0].getFull_name()+"'";
  }
  else  {
     sql_vals += ",'"+symbol+"'";  
     sql_vals += ",'"+name+"'";  
  }
   
  sql_vals += "," +ref_key;
  if(nomen_status_type!=null) {
   sql_vals += ",'" +nomen_status_type+"'";
  } 
  else { sql_vals += ",''";  }
  if(description!=null) {
    sql_vals += ",'" +formatTicks(description)+"'"; 
  }
  else { sql_vals += ",''";  }
  if(notes!=null) {
    sql_vals += ",'" +formatTicks(notes)+"'";
  }
  else { sql_vals += ",''";  }
  
  if(event.equals("merge")) {
    sql_vals += "," +geneAry[1].getRgd_id();
    sql_vals += "," +geneAry[0].getRgd_id(); // original_rgd_id
  }
  else {
    sql_vals += "," +rgd_id;
    sql_vals += "," +rgd_id;  // original_rgd_id
  }
//System.out.println("sql_vals=="+sql_vals);  
  boolean success = true;
  success = nomen_event.Create_NomenEvent(sql_vals);

  boolean history = false;
  if(event.equals("merge")) { 

    gene.log.setData_obj(data_obj);
    gene.log.setUser_key(user_key);
    // update object_status in rgd_ids table
    // create_history_event() behind the sence
    int old_rgd_id = geneAry[0].getRgd_id();
    int new_rgd_id = geneAry[1].getRgd_id();
    history = gene.create_history_event(old_rgd_id,new_rgd_id);  
  }
  
  if(success) {
%>
   <p>You have successfully Create a Nomen Event Record.
<%} else { %>
   <p>Error occurred while you are Creating a Nomen Event Record. No Nomen Event Was Created!!
<%
  }
  if(history) {
%>
   <p>You have successfully Retired RGD ID: <%=geneAry[0].getRgd_id()%> and Created a History Record.
<%}%>
<%--} end of if(username!=null)--%>

<jsp:include page="footerarea.jsp" flush="true" />
