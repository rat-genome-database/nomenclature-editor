<%-- *********************
Program Name - Merge_Edit_object.jsp
Programmer -  jiali chen

Description - This program allows user to Merge two Genes as one and 
create the other one as an alias. 
Meanwhile, user is allowed 
 - to modify other information about this gene.
 - to make association with other objects such as references, homolog, etc..

Modification log: none

***********************--%>
<SCRIPT>
function check_data() {
}
</SCRIPT>

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
<!--<jsp:useBean id="alias" scope="session" class="online.Alias" />-->
<jsp:useBean id="dtset" scope="session" class="online.Data_set" />

<%
  // initialize db handler via Servlet Context
  ServletContext context = request.getSession(true).getServletContext();
  DatabaseObj dbObj = (DatabaseObj)context.getAttribute("DEVHDL");
//System.out.println("MEO=="+dbObj);
  if(dbObj == null) {
   dbObj = new DatabaseObj("dev_1");
   context.setAttribute("DEVHDL",dbObj);
  }
  gene.setContext(context);
  dtset.setContext(context);

  //values get from previous page
  String data_obj = request.getParameter("OBJECT");
  session.setAttribute("data_obj", data_obj);
  String event = request.getParameter("EVENT"); 
  String sql = "";
  String symbol_one = "";
  String symbol_two = "";
  String id_one = "";
  String id_two = ""; 
  int rgd_id_one = 0;
  int rgd_id_two = 0;
  boolean isThere = false;
  boolean active = true;
  String stmt = "";
  
  if(event.equals("merge")) {
     symbol_one = request.getParameter("SYMONE");
     symbol_two = request.getParameter("SYMTWO");
     id_one = request.getParameter("RGDONE");
     id_two = request.getParameter("RGDTWO");
    
     if(id_one != null) {
       rgd_id_one = Integer.parseInt(id_one);
       rgd_id_two = Integer.parseInt(id_two);
     }
     String order = "asc";
     if(symbol_one != null) {
       //check if symbols or rgdids are still ACTIVE
       stmt = "Select count(*) COUNT from rgd_ids r, genes g "+
              " where r.rgd_id = g.rgd_id "+
              " and gene_symbol_lc in (lower('"+symbol_one+"'), lower('"+symbol_two+"'))" +        
              " and r.object_status = 'ACTIVE'";

       active = dtset.checkStatus(stmt);

       if(active) {        
         if(symbol_one.compareToIgnoreCase(symbol_two) > 0) {
            order = "desc";
         }
         sql="Select * from Genes " +
            " WHERE gene_symbol_lc in (lower('"+symbol_one+"'), lower('"+symbol_two+"'))" +
            " order by gene_symbol_lc "+order; 
       }
     }
     else if(rgd_id_one != 0) {       
        stmt = "select count(*) COUNT from rgd_ids "+
              " where rgd_id in ("+rgd_id_one+","+rgd_id_two+")" +
              " and object_status='ACTIVE'";
        active = dtset.checkStatus(stmt);

        if(active) {
          //if(rgd_id_one.compareTo(rgd_id_two) > 0 ) {
          if(rgd_id_one > rgd_id_two) {
              order = "desc";
          }
          sql="Select * from Genes WHERE rgd_id in ("+rgd_id_one+","+rgd_id_two+")" +
            " order by rgd_id "+order;
        }
     }
//System.out.println("sql=" + sql );
     isThere = dtset.searchGeneset(sql);
  }
//System.out.println("isthere=" + isThere );


if(active) {
  // get all display info storing in arrays for later use
  if(isThere) {
  String column_name[] = {"header","Symbol","Name","Product","Function","Description","Type"};
  // object info
  Gene[] geneAry = dtset.getGene();
  String[] gene_types = gene.getGene_types();
  String[] gene_type_desc = gene.getGene_type_desc();

  // get Notes info
  Note[][] noteAry = dtset.getNoteset(geneAry);

  // get references info
  Reference[][] refAry = dtset.getRefset(geneAry);

  // get aliases info
  Alias[][] aliasAry = dtset.getAliasset(geneAry);

  // get homolog info
  Homologs[][] hmlgAry = dtset.getHmlgset(geneAry);

  //hmlgAry[0] = new online.Homologs[0];
 // hmlgAry[1] = new online.Homologs[0];


  // get Sequences info
  Sequence[][] seqAry = dtset.getSeqset(geneAry);

  // get Exernal Database info(?)
  XDB[][] xdbAry = dtset.getXdbset(geneAry);

  // get Strain info
  Strain[][] strainAry = dtset.getStrainset(geneAry);
  
  // get SSLP info
  SSLP[][] sslpAry = dtset.getSslpset(geneAry);

  // get QTL info
  QTL[][] qtlAry = dtset.getQtlset(geneAry);

  // get Maps Data info
  Maps[][] mapsAry = dtset.getMapset(geneAry);

  // get Nomen Events info
  Nomen_event[][] nomenAry = dtset.getNomenset(geneAry);

  // get Phenotypes info
  Phenotype[][] pheAry = dtset.getPheset(geneAry);
  
%>
  <FORM action=Merge_Summary.jsp method=post>
	<table border="1" bgcolor="#FFFFFF" align="center">
		<TR BGCOLOR="#CCCCCC">
		  <TD colspan=6 bordercolor="#CCCCCC" align=center><b>Merge/Edit Current Objects</b></TD>
		</TR>
    <tr><td colspan=6>&nbsp;</td></tr>

<%  for(int i = 0; i < column_name.length; i++ )  {  %>       
<%    if(column_name[i].equals("header")) { %> 
        <TR><TD>&nbsp;</TD>        
<%    } else { %>
			  <TR><TD><b><%=column_name[i]%>:</b></TD>
<%    } %> 
<%   for(int j = 0; j < geneAry.length; j++ )  {	%> 	      
<%     if(column_name[i].equals("header")) { 
          if(j == 0) {
%> 
           <TD colspan="2"><b>Merge From (<%=geneAry[j].getRgd_id()%>)</b></TD>         
<%        } else  {  
           // set bean
           //gene.setRgd_id(geneAry[j].getRgd_id());
           //gene.setGene_key(geneAry[j].getGene_key());
%>
           <TD colspan="2"><b>Merge To (<%=geneAry[j].getRgd_id()%>)</b></TD>  
<%        } %>           
<%     } else if(column_name[i].equals("Symbol")) { %>
        <td>&nbsp;</td>
<%     } else if(column_name[i].equals("Name")) { %>
        <td>&nbsp;</td>
<%     } else if(column_name[i].equals("Type")) { %>
        <!--<TD><INPUT type="radio" name="rd_<%=column_name[i]%>" value="ON"></TD>-->
        <TD><INPUT type="checkbox" name="rd_<%=column_name[i]%>_<%=j%>" value="ON"></TD>
<%     } else { %>
        <TD><INPUT type="checkbox" name="ck_<%=column_name[i]%>_<%=j%>" value="ON"></TD>
<%     } %> 

<%     if(column_name[i].equals("Symbol"))  {
         // set bean
         //gene.setGene_symbol(geneAry[j].getGene_symbol());
%>        
        <TD><INPUT TYPE="TEXT" SIZE="40" NAME="<%=column_name[i]%>_<%=j%>" VALUE="<%=geneAry[j].getGene_symbol()%>"></TD>
<%     } else if(column_name[i].equals("Name")) { 
         // set bean
         //gene.setFull_name(geneAry[j].getFull_name());
%>
        <TD><INPUT TYPE="TEXT" SIZE="40" NAME="<%=column_name[i]%>_<%=j%>" VALUE="<%=geneAry[j].getFull_name()%>"></TD>
<%     } else if(column_name[i].equals("Product")) {  
         // set bean
         //gene.setProduct(geneAry[j].getProduct());
%>
        <TD><textarea rows="4" cols="30" NAME="<%=column_name[i]%>_<%=j%>" wrap="virtual"><%=geneAry[j].getProduct()%></textarea></TD>
<%     } else if(column_name[i].equals("Function")) {  
         // set bean
         //gene.setFunction(geneAry[j].getFunction());
%>
        <TD><textarea rows="4" cols="30" NAME="<%=column_name[i]%>_<%=j%>" wrap="virtual"><%=geneAry[j].getFunction()%></textarea></TD>
<%     } else if(column_name[i].equals("Description")) {  
         // set bean
         //gene.setGene_desc(geneAry[j].getGene_desc());
%>
        <TD><textarea rows="4" cols="30" NAME="<%=column_name[i]%>_<%=j%>" wrap="virtual"><%=geneAry[j].getGene_desc()%></textarea></TD>
<%     } else if(column_name[i].equals("Type")) {  
         // set bean
         //gene.setGene_type_lc(geneAry[j].getGene_type_lc());
%>

        <TD><select name="<%=column_name[i]%>_<%=j%>" size="1">
                  <option value="">-- select one --</option>
 
                <%for(int k = 0; k < gene_types.length; k++ ) { 
//System.out.println("pp="+geneAry[j].getGene_type_lc());
//System.out.println("kk="+gene_types[k]);
                    if(geneAry[j].getGene_type_lc()!=null) {
                %>              
                       <option value="<%=gene_types[k]%>" <%= itemSelected(geneAry[j].getGene_type_lc(), gene_types[k])%>>
                          -- <%=gene_type_desc[k]%> --</option>
                <%  } 
                    else {
                %>
                     <option value="<%=gene_types[k]%>">-- <%=gene_type_desc[k]%> --</option>
                <%
                    }
                  }
                %>  
            </select>
         </TD>  

         
<%     } %>

<%   }  // end inner for 
    // start to print third column
     if(column_name[i].equals("header")) { 
%> 
       <TD><b>New Value</b></TD>
<%   } else if(column_name[i].equals("Symbol")||column_name[i].equals("Name")) { %>
       <!--<TD><INPUT TYPE="TEXT" SIZE="40" NAME="new_<%=column_name[i]%>" VALUE=""></TD> -->
       <!--<TD>&nbsp;</TD>-->
       <TD>Make&nbsp;Alias<input type="checkbox" name="<%=column_name[i]%>" value="ON" checked></TD>
       
<%   } else if(column_name[i].equals("Type")) {  %>
       <TD><select name="new_<%=column_name[i]%>" size="1">
                  <option value="">-- select one --</option>
                <%  for(int j = 0; j < gene_types.length; j++ ) { %>              
                       <option value="<%=gene_types[j]%>">
                          -- <%=gene_type_desc[j]%> --</option>
                 <% } %>  
               </select>
             </TD>
<%   } else  { %>
       <TD><textarea rows="4" cols="30" NAME="new_<%=column_name[i]%>" wrap="virtual"></textarea></TD>
<%   } %>
     </TR>
<% }  // end outer for  %>

       <TR><TD colspan=6>&nbsp;</TD></TR>
	</table>

  
 <!-- **************************
  Start Association screen 
 *******************************-->
 <table border="1" bgcolor="#FFFFFF" align="center">
		<TR BGCOLOR="#CCCCCC">
		  <TD colspan=6 bordercolor="#CCCCCC" align=center><b>Association</b></TD>
		</TR>
    <tr><td colspan=3><b><%=geneAry[0].getGene_symbol()%> (<%=geneAry[0].getRgd_id()%>)</b></TD>
       <td colspan=3><b><%=geneAry[1].getGene_symbol()%> (<%=geneAry[1].getRgd_id()%>)</b></TD>
    </tr>

 <!-- start Notes section -->
   <tr>
     <TD colspan=6 align=left><font color="0000FF"><b>Notes</b></font></TD>
   </tr>
<%
 int len31 = noteAry[0].length;
 int len32 = noteAry[1].length;

//System.out.println("len31==" +len31);
//System.out.println("len32==" +len32);
 if(len31 > 0 && len31 >= len32) {
   for(int m=0;m<noteAry[0].length;m++) {
%>
      <tr>
      <td><%=noteAry[0][m].getNotes_type_name_lc()%></td>
      <td><%=noteAry[0][m].getNotes()%></td>
      <td><INPUT type="checkbox" name="note_c_<%=m%>" value="ON" checked>copy</td>
<%   if(m < len32 ) {    
%>
      <td><%=noteAry[1][m].getNotes_type_name_lc()%></td>
      <td><%=noteAry[1][m].getNotes()%></td>
      <td><INPUT type="radio" name="note_kd_<%=m%>" value="keep" checked>keep<INPUT type="radio" name="note_kd_<%=m%>" value="del">delete</td>
<%   } else { %>
      <td colspan=3>&nbsp;</td>
<%   } %>
     </tr>
<%
   }
 }
  else if(len32 > 0 && len32 >= len31) {
   for(int n=0;n<noteAry[1].length;n++) {
%>
     <tr>
<%
     if(n < len31) { 
%>
      <td><%=noteAry[0][n].getNotes_type_name_lc()%></td>
      <td><%=noteAry[0][n].getNotes()%></td>
      <td><INPUT type="checkbox" name="note_c_<%=n%>" value="ON" checked>copy</td>
   <%} else { %>
      <td colspan=3>&nbsp;</td>
   <%}%>
   <td><%=noteAry[1][n].getNotes_type_name_lc()%></td>
   <td><%=noteAry[1][n].getNotes()%></td>
   <td><INPUT type="radio" name="note_kd_<%=n%>" value="keep" checked>keep<INPUT type="radio" name="note_kd_<%=n%>" value="del">delete</td>
<% } %>
   </tr>   
<%
 }
 // end of Notes section 
%>
<!-- start References section  -->
    <tr>
     <TD colspan=6 align=left><font color="0000FF"><b>Curated References</b></font></TD>
    </tr>
<% 
  int len1 = refAry[0].length;
  int len2 = refAry[1].length;

//System.out.println("len1==" +len1);
//System.out.println("len2==" +len2);
  if(len1 > 0 && len1 >= len2) {
   for(int m=0;m<refAry[0].length;m++) {      
%>
      <tr>
      <td><%=refAry[0][m].getRgd_id()%></td>
      <td><%=refAry[0][m].getCitation()%></td>
      <td><INPUT type="checkbox" name="ref_c_<%=m%>" value="ON" checked>copy</td>
<%   if(m < len2 ) {  //avoid ArrayIndexOutOfBoundsException  
%>
      <td><%=refAry[1][m].getRgd_id()%></td>
      <td><%=refAry[1][m].getCitation()%></td>
      <td><INPUT type="radio" name="ref_kd_<%=m%>" value="keep" checked>keep<INPUT type="radio" name="ref_kd_<%=m%>" value="del">delete</td>
<%   } else { %>
      <td colspan=3>&nbsp;</td>
<%   } %>
     </tr>
<%
   }
 }
 else if(len2 > 0 && len2 >= len1) {
   for(int n=0;n<refAry[1].length;n++) {
%>
    <tr>
<%
     if(n < len1) {  //avoid ArrayIndexOutOfBoundsException   
%>
      <td><%=refAry[0][n].getRgd_id()%></td>
      <td><%=refAry[0][n].getCitation()%></td>
      <td><INPUT type="checkbox" name="ref_c_<%=n%>" value="ON" checked>copy</td>
   <%} else { %>
      <td colspan=3>&nbsp;</td>
   <%}%>
   <td><%=refAry[1][n].getRgd_id()%>&nbsp;</td>
   <td><%=refAry[1][n].getCitation()%>&nbsp;</td>
   <td><INPUT type="radio" name="ref_kd_<%=n%>" value="keep" checked>keep<INPUT type="radio" name="ref_kd_<%=n%>" value="del">delete</td>
<% } %>
   </tr>   
<%
 } // end else if <!-- end References Section -->
%>
  <!-- Start Alias Section -->
   <tr>
     <TD colspan=6 align=left><font color="0000FF"><b>Alias</b></font></TD>
   </tr>
<%
 int len3 = aliasAry[0].length;
 int len4 = aliasAry[1].length;
//System.out.println("len3==" +len3);
//System.out.println("len4==" +len4);
  if(len3 > 0 && len3 >= len4) {
   for(int m=0;m<aliasAry[0].length;m++) {
%>
      <tr>
      <td><%=aliasAry[0][m].getAlias_type_name_lc()%></td>
      <td><%=aliasAry[0][m].getAlias_value()%></td>
      <td><INPUT type="checkbox" name="alias_c_<%=m%>" value="ON" checked>copy</td>
<%   if(m < len4 ) {  //avoid ArrayIndexOutOfBoundsException  
%>
      <td><%=aliasAry[1][m].getAlias_type_name_lc()%></td>
      <td><%=aliasAry[1][m].getAlias_value()%></td>
      <td><INPUT type="radio" name="alias_kd_<%=m%>" value="keep" checked>keep<INPUT type="radio" name="alias_kd_<%=m%>" value="del">delete</td>
<%   } else { %>
      <td colspan=3>&nbsp;</td>
<%   } %>
     </tr>
<%
   }
 }
  else if(len4 > 0 && len4 >= len3) {
   for(int n=0;n<aliasAry[1].length;n++) {
%>
     <tr>
<%
     if(n < len3) {  //avoid ArrayIndexOutOfBoundsException
%>
      <td><%=aliasAry[0][n].getAlias_type_name_lc()%></td>
      <td><%=aliasAry[0][n].getAlias_value()%></td>
      <td><INPUT type="checkbox" name="alias_c_<%=n%>" value="ON" checked>copy</td>
   <%} else { %>
      <td colspan=3>&nbsp;</td>
   <%}%>
   <td><%=aliasAry[1][n].getAlias_type_name_lc()%></td>
   <td><%=aliasAry[1][n].getAlias_value()%></td>
   <td><INPUT type="radio" name="alias_kd_<%=n%>" value="keep" checked>keep<INPUT type="radio" name="alias_kd_<%=n%>" value="del">delete</td>
<% } %>
   </tr>   
<%
 }
 // end of Alias section 
%>
  <!-- start Homolog section -->
   <tr>
     <TD colspan=6 align=left><font color="0000FF"><b>Homolog</b></font></TD>
   </tr>
<%

 int len5 = hmlgAry[0].length;
 int len6 = hmlgAry[1].length;

//System.out.println("len5==" +len5);
//System.out.println("len6==" +len6);
  if(len5 > 0 && len5 >= len6) {
   for(int m=0;m<hmlgAry[0].length;m++) {
%>
      <tr>
      <td colspan=2><b>sym:</b><%=hmlgAry[0][m].getHomolog_symbol()%>&nbsp;
                    <b>chr:</b><%=hmlgAry[0][m].getChromosome()%>&nbsp;
                    <b>sp:</b><%=hmlgAry[0][m].getOrganism_genus()%>&nbsp;<%=hmlgAry[0][m].getOrganism_species()%></td>
      <td><INPUT type="checkbox" name="hmlg_c_<%=m%>" value="ON" checked>copy</td>
<%   if(m < len6 ) {  //avoid ArrayIndexOutOfBoundsException  
%>
      <td colspan=2><b>sym:</b><%=hmlgAry[1][m].getHomolog_symbol()%>&nbsp;
                    <b>chr:</b><%=hmlgAry[1][m].getChromosome()%>&nbsp;
                    <b>sp:</b><%=hmlgAry[1][m].getOrganism_genus()%>&nbsp;<%=hmlgAry[1][m].getOrganism_species()%></td>
      <td><INPUT type="radio" name="hmlg_kd_<%=m%>" value="keep" checked>keep<INPUT type="radio" name="hmlg_kd_<%=m%>" value="del">delete</td>
<%   } else { %>
      <td colspan=3>&nbsp;</td>
<%   } %>
     </tr>
<%
   }
 }
  else if(len6 > 0 && len6 >= len5) {
   for(int n=0;n<hmlgAry[1].length;n++) {
%>
     <tr>
<%
     if(n < len5) {  //avoid ArrayIndexOutOfBoundsException
%>
      <td colspan=2><b>sym:</b><%=hmlgAry[0][n].getHomolog_symbol()%>&nbsp;
                    <b>chr:</b><%=hmlgAry[0][n].getChromosome()%>&nbsp;
                    <b>sp:</b><%=hmlgAry[0][n].getOrganism_genus()%>&nbsp;<%=hmlgAry[0][n].getOrganism_species()%></td>
      <td><INPUT type="checkbox" name="hmlg_c_<%=n%>" value="ON" checked>copy</td>
   <%} else { %>
      <td colspan=3>&nbsp;</td>
   <%}%>
   <td colspan=2><b>sym:</b><%=hmlgAry[1][n].getHomolog_symbol()%>&nbsp;
                 <b>chr:</b><%=hmlgAry[1][n].getChromosome()%>&nbsp;
                 <b>sp:</b><%=hmlgAry[1][n].getOrganism_genus()%>&nbsp;<%=hmlgAry[1][n].getOrganism_species()%></td>
   <td><INPUT type="radio" name="hmlg_kd_<%=n%>" value="keep" checked>keep<INPUT type="radio" name="hmlg_kd_<%=n%>" value="del">delete</td>
<% } %>
   </tr>   
<%
 }
 // end of Homolog section 
%>
 <!-- start Nomen Event section -->
   <tr>
     <TD colspan=6 align=left><font color="0000FF"><b>Nomen Events</b></font></TD>
   </tr>
<%
 int len35 = nomenAry[0].length;
 int len36 = nomenAry[1].length;
//System.out.println("len35==" +len35);
//System.out.println("len36==" +len36);
 if(len35 > 0 && len35 >= len36) {
   for(int m=0;m<nomenAry[0].length;m++) {
%>
      <tr>
      <td colspan=2><b>sym:</b><%=nomenAry[0][m].getSymbol()%>&nbsp;
                    <b>nm:</b><%=nomenAry[0][m].getName()%>&nbsp;
                    <b>desc:</b><%=nomenAry[0][m].getDescription()%>&nbsp;
                    <b>date:</b><%=nomenAry[0][m].getEvent_date()%></td>
      <td><INPUT type="checkbox" name="nomen_c_<%=m%>" value="ON" checked>copy</td>
<%   if(m < len36 ) {    
%>
      <td colspan=2><b>sym:</b><%=nomenAry[1][m].getSymbol()%>&nbsp;
                     <b>nm:</b><%=nomenAry[1][m].getName()%>&nbsp;
                     <b>desc:</b><%=nomenAry[1][m].getDescription()%>&nbsp;
                     <b>date:</b><%=nomenAry[1][m].getEvent_date()%></td>
      <td><INPUT type="radio" name="nomen_kd_<%=m%>" value="keep" checked>keep<INPUT type="radio" name="nomen_kd_<%=m%>" value="del">delete</td>
<%   } else { %>
      <td colspan=3>&nbsp;</td>
<%   } %>
     </tr>
<%
   }
 }
  else if(len36 > 0 && len36 >= len35) {
   for(int n=0;n<nomenAry[1].length;n++) {
%>
     <tr>
<%
     if(n < len35) { 
%>
      <td colspan=2><b>sym:</b><%=nomenAry[0][n].getSymbol()%>&nbsp;
                    <b>nm:</b><%=nomenAry[0][n].getName()%>&nbsp;
                    <b>desc:</b><%=nomenAry[0][n].getDescription()%>&nbsp;
                    <b>date:</b><%=nomenAry[0][n].getEvent_date()%></td>
      <td><INPUT type="checkbox" name="nomen_c_<%=n%>" value="ON" checked>copy</td>
   <%} else { %>
      <td colspan=3>&nbsp;</td>
   <%}%>
    <td colspan=2><b>sym:</b><%=nomenAry[1][n].getSymbol()%>&nbsp;
                  <b>nm:</b><%=nomenAry[1][n].getName()%>&nbsp;
                  <b>desc:</b><%=nomenAry[1][n].getDescription()%>&nbsp;
                  <b>date:</b><%=nomenAry[1][n].getEvent_date()%></td>
    <td><INPUT type="radio" name="nomen_kd_<%=n%>" value="keep" checked>keep<INPUT type="radio" name="nomen_kd_<%=n%>" value="del">delete</td>
<% } %>
   </tr>   
<%
 }
 // end of Nomen Events section 
%>
 <!-- start External Databse section -->
  <tr>
    <TD colspan=6 align=left><font color="0000FF"><b>External Database</b></font></TD>
  </tr>
<%int len7 = xdbAry[0].length;
  int len8 = xdbAry[1].length;
//System.out.println("len7==" +len7);
//System.out.println("len8==" +len8);
  if(len7 > 0 && len7 >= len8) {
   for(int m=0;m<xdbAry[0].length;m++) {
%>
      <tr>
      <td><%=xdbAry[0][m].getAcc_id()%></td>
      <td><%=xdbAry[0][m].getXdb_name()%></td>
      <td><INPUT type="checkbox" name="xdb_c_<%=m%>" value="ON" checked>copy</td>
<%   if(m < len8 ) {    
%>
      <td><%=xdbAry[1][m].getAcc_id()%></td>
      <td><%=xdbAry[1][m].getXdb_name()%></td>
      <td><INPUT type="radio" name="xdb_kd_<%=m%>" value="keep" checked>keep<INPUT type="radio" name="xdb_kd_<%=m%>" value="del">delete</td>
<%   } else { %>
      <td colspan=3>&nbsp;</td>
<%   } %>
     </tr>
<%
   }
 }
  else if(len8 > 0 && len8 >= len7) {
   for(int n=0;n<xdbAry[1].length;n++) {
%>
     <tr>
<%
     if(n < len7) { 
%>
      <td><%=xdbAry[0][n].getAcc_id()%></td>
      <td><%=xdbAry[0][n].getXdb_name()%></td>
      <td><INPUT type="checkbox" name="xdb_c_<%=n%>" value="ON" checked>copy</td>
   <%} else { %>
      <td colspan=3>&nbsp;</td>
   <%}%>
   <td><%=xdbAry[1][n].getAcc_id()%></td>
   <td><%=xdbAry[1][n].getXdb_name()%></td>
   <td><INPUT type="radio" name="xdb_kd_<%=n%>" value="keep" checked>keep<INPUT type="radio" name="xdb_kd_<%=n%>" value="del">delete</td>
<% } %>
   </tr>   
<%
 }
 // end of External Database section 
%>
 <!-- start Sequences section -->
   <tr>
     <TD colspan=6 align=left><font color="0000FF"><b>Sequences</b></font></TD>
   </tr>
<%
 int len33 = seqAry[0].length;
 int len34 = seqAry[1].length;

//System.out.println("len33==" +len33);
//System.out.println("len34==" +len34);
 if(len33 > 0 && len33 >= len34) {
   for(int m=0;m<seqAry[0].length;m++) {
%>
     <tr>
     <td colspan=2>
<%
      if(seqAry[0][m].getClone_name() != null) {
%>
                   <b>nm:</b><%=seqAry[0][m].getClone_name()%>&nbsp;
<%    } else { %>
                   <b>for:</b><%=seqAry[0][m].getForward_seq()%>&nbsp;
                   <b>rev:</b><%=seqAry[0][m].getReverse_seq()%>
<%    } %>
     </td>
     <td><INPUT type="checkbox" name="seq_c_<%=m%>" value="ON" checked>copy</td>
<%   if(m < len34 ) {    
%>
      <td colspan=2>
<%
      if(seqAry[1][m].getClone_name() != null) {
%>
                    <b>nm:</b><%=seqAry[1][m].getClone_name()%>&nbsp;
<%    } else { %>
                    <b>for:</b><%=seqAry[1][m].getForward_seq()%>&nbsp;
                    <b>rev:</b><%=seqAry[1][m].getReverse_seq()%>
<%    } %>
      </td>
      <td><INPUT type="radio" name="seq_kd_<%=m%>" value="keep" checked>keep<INPUT type="radio" name="seq_kd_<%=m%>" value="del">delete</td>
<%   } else { %>
      <td colspan=3>&nbsp;</td>
<%   } %>
     </tr>
<%
   }
 }
  else if(len34 > 0 && len34 >= len33) {
   for(int n=0;n<seqAry[1].length;n++) {
%>
     <tr>
<%
     if(n < len33) { 
%>
      <td colspan=2>
<%
       if(seqAry[0][n].getClone_name() != null) {
%>
                    <b>nm:</b><%=seqAry[0][n].getClone_name()%>&nbsp;
<%     } else { %>
                    <b>for:</b><%=seqAry[0][n].getForward_seq()%>&nbsp;
                    <b>rev:</b><%=seqAry[0][n].getReverse_seq()%>
<%     } %>
      </td>
      <td><INPUT type="checkbox" name="seq_c_<%=n%>" value="ON" checked>copy</td>
   <%} else { %>
      <td colspan=3>&nbsp;</td>
   <%}%>
   <td colspan=2>
<%
        if(seqAry[1][n].getClone_name() != null) {
%>  
                 <b>nm:</b><%=seqAry[1][n].getClone_name()%>&nbsp;
<%      } else { %>
                 <b>for:</b><%=seqAry[1][n].getForward_seq()%>&nbsp;
                 <b>rev:</b><%=seqAry[1][n].getReverse_seq()%>
<%      } %>
   </td>    
   <td><INPUT type="radio" name="seq_kd_<%=n%>" value="keep" checked>keep<INPUT type="radio" name="seq_kd_<%=n%>" value="del">delete</td>
<% } %>
   </tr>   
<%
 }
 // end of Sequences section 
%>
 <!--start SSLPs section -->
 <tr>
   <TD colspan=6 align=left><font color="0000FF"><b>SSLP</b></font></TD>
 </tr>
<%int len13 = sslpAry[0].length;
  int len14 = sslpAry[1].length;

//System.out.println("len13==" +len13);
//System.out.println("len14==" +len14);
  if(len13 > 0 && len13 >= len14) {
   for(int m=0;m<sslpAry[0].length;m++) {
%> 
      <tr>
      <td colspan=2><%=sslpAry[0][m].getRgd_name()%></td>
      <td><INPUT type="checkbox" name="sslp_c_<%=m%>" value="ON" checked>copy</td>
<%   if(m < len14 ) {    
%>
      <td colspan=2><%=sslpAry[1][m].getRgd_name()%></td>
      <td><INPUT type="radio" name="sslp_kd_<%=m%>" value="keep" checked>keep<INPUT type="radio" name="sslp_kd_<%=m%>" value="del">delete</td>
<%   } else { %>
      <td colspan=3>&nbsp;</td>
<%   } %>
     </tr>
<%
   }
 }
  else if(len14 > 0 && len14 >= len13) {
   for(int n=0;n<sslpAry[1].length;n++) {
%>
     <tr>
<%
     if(n < len13) { 
%>
      <td colspan=2><%=sslpAry[0][n].getRgd_name()%></td>
      <td><INPUT type="checkbox" name="sslp_c_<%=n%>" value="ON" checked>copy</td>
   <%} else { %>
      <td colspan=3>&nbsp;</td>
   <%}%>
   <td colspan=2><%=sslpAry[1][n].getRgd_name()%></td>
   <td><INPUT type="radio" name="sslp_kd_<%=n%>" value="keep" checked>keep<INPUT type="radio" name="sslp_kd_<%=n%>" value="del">delete</td>
<% } %>
   </tr>   
<%
 }
 // end of SSLPs section 
%>

 <!-- start QTLs section-->
 <tr>
   <TD colspan=6 align=left><font color="0000FF"><b>QTL</b></font></TD>
 </tr>
<%
  int len17 = qtlAry[0].length;
  int len18 = qtlAry[1].length;

//System.out.println("len17==" +len17);
//System.out.println("len18==" +len18);
  if(len17 > 0 && len17 >= len18) {
   for(int m=0;m<qtlAry[0].length;m++) {
%> 
      <tr>
      <td colspan=2><%=qtlAry[0][m].getQtl_symbol()%></td>
      <td><INPUT type="checkbox" name="qtl_c_<%=m%>" value="ON" checked>copy</td>
<%   if(m < len18 ) {    
%>
      <td colspan=2><%=qtlAry[1][m].getQtl_symbol()%></td>
      <td><INPUT type="radio" name="qtl_kd_<%=m%>" value="keep" checked>keep<INPUT type="radio" name="qtl_kd_<%=m%>" value="del">delete</td>
<%   } else { %>
      <td colspan=3>&nbsp;</td>
<%   } %>
     </tr>
<%
   }
 }
 else if(len18 > 0 && len18 >= len17) {
   for(int n=0;n<qtlAry[1].length;n++) {
%>
     <tr>
<%
     if(n < len17) { 
%>
      <td colspan=2><%=qtlAry[0][n].getQtl_symbol()%></td>
      <td><INPUT type="checkbox" name="qtl_c_<%=n%>" value="ON" checked>copy</td>
   <%} else { %>
      <td colspan=3>&nbsp;</td>
   <%}%>
   <td colspan=2><%=qtlAry[1][n].getQtl_symbol()%></td>
   <td><INPUT type="radio" name="qtl_kd_<%=n%>" value="keep" checked>keep<INPUT type="radio" name="qtl_kd_<%=n%>" value="del">delete</td>
<% } %>
   </tr>   
<%
 }
 // end of QTLs section 
%>
 <!--start Strain section -->
  <tr>
    <TD colspan=6 align=left><font color="0000FF"><b>Strain</b></font></TD>
  </tr>
<%int len11 = strainAry[0].length;
  int len12 = strainAry[1].length;

//System.out.println("len11==" +len11);
//System.out.println("len12==" +len12);
  if(len11 > 0 && len11 >= len12) {
   for(int m=0;m<strainAry[0].length;m++) {
%>
      <tr>
      <td colspan=2><%=strainAry[0][m].getStrain_symbol()%></td>
      <td><INPUT type="checkbox" name="strain_c_<%=m%>" value="ON" checked>copy</td>
<%   if(m < len12 ) {    
%>
      <td colslpan=2><%=strainAry[1][m].getStrain_symbol()%></td>
      <td><INPUT type="radio" name="strain_kd_<%=m%>" value="keep" checked>keep<INPUT type="radio" name="strain_kd_<%=m%>" value="del">delete</td>
<%   } else { %>
      <td colspan=3>&nbsp;</td>
<%   } %>
     </tr>
<%
   }
 }
  else if(len12 > 0 && len12 >= len11) {
   for(int n=0;n<strainAry[1].length;n++) {
%>
     <tr>
<%
     if(n < len11) { 
%>
      <td colspan=2><%=strainAry[0][n].getStrain_symbol()%></td>
      <td><INPUT type="checkbox" name="strain_c_<%=n%>" value="ON" checked>copy</td>
   <%} else { %>
      <td colspan=3>&nbsp;</td>
   <%}%>
   <td colspan=2><%=strainAry[1][n].getStrain_symbol()%></td>
   <td><INPUT type="radio" name="strain_kd_<%=n%>" value="keep" checked>keep<INPUT type="radio" name="strain_kd_<%=n%>" value="del">delete</td>
<% } %>
   </tr>   
<%
 }
 // end of Strain section 
%>
 <!-- start Maps_Data section-->
 <tr>
   <TD colspan=6 align=left><font color="0000FF"><b>Maps Data</b></font></TD>
 </tr>
<%
  int len21 = mapsAry[0].length;
  int len22 = mapsAry[1].length;
//System.out.println("len21==" +len21);
//System.out.println("len22==" +len22);
  if(len21 > 0 && len21 >= len22) {
   for(int m=0; m<mapsAry[0].length; m++) {
%> 
      <tr>
      <td colspan=2><b>chr:</b><%=mapsAry[0][m].getChromosome()%>&nbsp;
                    <b>band:</b><%=mapsAry[0][m].getFish_band()%>&nbsp;
                    <b>pos:</b><%=mapsAry[0][m].getAbs_position()%>&nbsp;
                    <b>map:</b><%=mapsAry[0][m].getMap_name()%></td>
      <td><INPUT type="checkbox" name="maps_c_<%=m%>" value="ON" checked>copy</td>
<%   if(m < len22 ) {    
%>
      <td colspan=2><b>chr:</b><%=mapsAry[1][m].getChromosome()%>&nbsp;
                    <b>band:</b><%=mapsAry[1][m].getFish_band()%>&nbsp;
                    <b>pos:</b><%=mapsAry[1][m].getAbs_position()%>&nbsp;
                    <b>map:</b><%=mapsAry[1][m].getMap_name()%></td>
      <td><INPUT type="radio" name="maps_kd_<%=m%>" value="keep" checked>keep<INPUT type="radio" name="maps_kd_<%=m%>" value="del">delete</td>
<%   } else { %>
      <td colspan=3>&nbsp;</td>
<%   } %>
     </tr>
<%
   }
 }
 else if(len22 > 0 && len22 >= len21) {
   for(int n=0;n<mapsAry[1].length;n++) {
%>
     <tr>
<%
     if(n < len21) { 
%>
      <td colspan=2><b>chr:</b><%=mapsAry[0][n].getChromosome()%>&nbsp;
                    <b>band:</b><%=mapsAry[0][n].getFish_band()%>&nbsp;
                    <b>pos:</b><%=mapsAry[0][n].getAbs_position()%>&nbsp;
                    <b>map:</b><%=mapsAry[0][n].getMap_name()%></td>
      <td><INPUT type="checkbox" name="maps_c_<%=n%>" value="ON" checked>copy</td>
   <%} else { %>
      <td colspan=3>&nbsp;</td>
   <%}%>
   <td colspan=2><b>chr:</b><%=mapsAry[1][n].getChromosome()%>&nbsp;
                 <b>band:</b><%=mapsAry[1][n].getFish_band()%>&nbsp;
                 <b>pos:</b><%=mapsAry[1][n].getAbs_position()%>&nbsp;
                 <b>map:</b><%=mapsAry[1][n].getMap_name()%></td>
   <td><INPUT type="radio" name="maps_kd_<%=n%>" value="keep" checked>keep<INPUT type="radio" name="maps_kd_<%=n%>" value="del">delete</td>
<% } %>
   </tr>   
<%
 }
 // end of Maps_Data section 
%>
 <!-- start Phenotypes section-->
 <tr>
   <TD colspan=6 align=left><font color="0000FF"><b>Phenotypes</b></font></TD>
 </tr>
<%
  int len23 = pheAry[0].length;
  int len24 = pheAry[1].length;
//System.out.println("len23==" +len23);
//System.out.println("len24==" +len24);
  if(len23 > 0 && len23 >= len24) {
   for(int m=0; m<pheAry[0].length; m++) {
%> 
      <tr>
      <td></td><%=pheAry[0][m].getPhe_symbol()%></td>
      <td></td><%=pheAry[0][m].getPhe_desc()%></td>
      <td><INPUT type="checkbox" name="phe_c_<%=m%>" value="ON" checked>copy</td>
<%   if(m < len24 ) {    
%>
      <td><%=pheAry[1][m].getPhe_symbol()%></td>
      <td><%=pheAry[1][m].getPhe_desc()%></td>
      <td><INPUT type="radio" name="phe_kd_<%=m%>" value="keep" checked>keep<INPUT type="radio" name="phe_kd_<%=m%>" value="del">delete</td>
<%   } else { %>
      <td colspan=3>&nbsp;</td>
<%   } %>
     </tr>
<%
   }
 }
 else if(len24 > 0 && len24 >= len23) {
   for(int n=0;n<pheAry[1].length;n++) {
%>
     <tr>
<%
     if(n < len23) { 
%>
      <td></td><%=pheAry[0][n].getPhe_symbol()%></td>
      <td></td><%=pheAry[0][n].getPhe_desc()%></td>
      <td><INPUT type="checkbox" name="phe_c_<%=n%>" value="ON" checked>copy</td>
   <%} else { %>
      <td colspan=3>&nbsp;</td>
   <%}%>
   <td>chr:<%=pheAry[1][n].getPhe_symbol()%></td>
   <td>chr:<%=pheAry[1][n].getPhe_desc()%></td>
   <td><INPUT type="radio" name="phe_kd_<%=n%>" value="keep" checked>keep<INPUT type="radio" name="phe_kd_<%=n%>" value="del">delete</td>
<% } %>
   </tr>   
<%
 }
 // end of Phenotypes section 
%>

  <TR><TD colspan=6><CENTER><input type="submit" value="Submit Data"></CENTER></TD></TR> 
  </table>

</FORM>
  
<%
  } // end of if(isThere)
  else  {
%>
  <p><b>No record(s) found in RGD for the given gene symbol(s) or rgd id(s)</b>
<%}
 }
 else {
%>
 <p><b>Gene symbol(s) or Rgd id(s) has been RETIRED.</b>
<%
 } 
%>

<%-- } end of if(username!=null)--%>

<jsp:include page="footerarea.jsp" flush="true" />
