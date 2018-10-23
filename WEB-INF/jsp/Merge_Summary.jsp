<%-- *********************
Program Name - Merge_summary.jsp
Programmer -  jiali chen

Description - This program generates summary report 
for the Merge Edit object page
Modification log: none
***********************--%>
<%@ page language="java" import="online.*, common.*, java.net.*, java.text.*,java.util.*,java.lang.*,javax.servlet.*,javax.servlet.http.*"%>
<%@ include file="curation_lib.jsp"%>
<%@ include file="headerarea.jsp"%>
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

<!--<jsp:useBean id="gene" scope="session" class="online.Gene" />-->
<jsp:useBean id="dtset" scope="session" class="online.Data_set" />

<%
 // initialize db handler via Servlet Context if not exists
 ServletContext context = request.getSession(true).getServletContext();
 DatabaseObj dbObj = (DatabaseObj)context.getAttribute("DEVHDL");
//System.out.println("MS=="+dbObj);
 if(dbObj == null) {
   dbObj = new DatabaseObj("dev_1");
   context.setAttribute("DEVHDL",dbObj);
 }
 dtset.setContext(context);

 // get all info from beans
 Gene[] geneAry = dtset.getGene();
 Note[][] noteAry = dtset.getNote(); 
 Reference[][] refAry = dtset.getReference();
 Alias[][] aliasAry = dtset.getAlias();
 Homologs[][] hmlgAry = dtset.getHomologs();
 //hmlgAry[0] = new online.Homologs[0];
 //hmlgAry[1] = new online.Homologs[0];


 Sequence[][] seqAry = dtset.getSequence();
 Nomen_event[][] nomenAry = dtset.getNomen_event();
 XDB[][] xdbAry = dtset.getXdb();
 Strain[][] strainAry = dtset.getStrain();
 SSLP[][] sslpAry = dtset.getSslp();
 EST[][] estAry = dtset.getEst();
 QTL[][] qtlAry = dtset.getQtl();
 Maps[][] mapsAry = dtset.getMaps();
 Phenotype[][] pheAry = dtset.getPhenotype();

 String chk_symbol = request.getParameter("Symbol");
 session.setAttribute("symbol_alias", chk_symbol);
 String chk_name = request.getParameter("Name"); 
 session.setAttribute("name_alias", chk_name); 
 
 String column_name[] = {"Symbol","Name","Product","Function","Description","Type"};
// String old_symbol="";
// String old_name="";
%>
    <FORM action=Merge_Update.jsp method=post>
		 <table border="1" bgcolor="#FFFFFF" align="center">
			<TR BGCOLOR="#CCCCCC">
			  <TD colspan=3 bordercolor="#CCCCCC" align=center><b>Merged Object Summary</b></TD>
			</TR>
<% for(int i = 0; i < column_name.length; i++ )  { 
     if(column_name[i].equals("Symbol") || column_name[i].equals("Name"))  {
       //old_symbol = request.getParameter(column_name[0]+"_0");
       //old_name = request.getParameter(column_name[1]+"_0");
       String val = request.getParameter(column_name[i]+"_1");
       if(val !=null && !val.equals("")) {
%>
       <tr>
       <td><b><%=column_name[i]%>:</b></td>
       <td colspan=2><%=val%></td>
       </tr>
<%     }
     }
     else if(column_name[i].equals("Type"))  {
       String new_val = request.getParameter("new_"+column_name[i]);
       if(new_val !=null && new_val.equals("")) {
         String x = request.getParameter("rd_"+column_name[i]+"_0");
         String s = request.getParameter("rd_"+column_name[i]+"_1");
         if(s!=null && s.equals("ON")) {
             new_val = request.getParameter(column_name[i]+"_1");
         }
         else if(x!=null && x.equals("ON")) {
             new_val = request.getParameter(column_name[i]+"_0");
         }        
       }
       if(new_val !=null && !new_val.equals("")) {
%>
       <tr>
       <td><b><%=column_name[i]%>:</b></td>
       <td colspan=2><%=new_val%><input type=hidden name=newType value="<%=new_val%>"></td>
       </tr>
<%     }
     }
     else {
       String my_val = request.getParameter("new_"+column_name[i]);
       if(my_val !=null && my_val.equals("")) {
           String a = request.getParameter("ck_"+column_name[i]+"_0");
           String b = request.getParameter("ck_"+column_name[i]+"_1");

           if((a!=null && a.equals("ON")) && (b!= null &&b.equals("ON"))) {
              my_val = request.getParameter(column_name[i]+"_0");
              //my_val += "\n" + request.getParameter(column_name[i]+"_1");
              my_val += "; " + request.getParameter(column_name[i]+"_1");  
           }
           else if(a!=null && a.equals("ON")) {
              my_val = request.getParameter(column_name[i]+"_0");
           }
           else if(b != null && b.equals("ON")) {
              my_val = request.getParameter(column_name[i]+"_1");
           }
           else {
              my_val = "";
           }
       }
       if(my_val !=null && !my_val.equals(""))  {
%>     
       <tr>
       <td><b><%=column_name[i]%>:</b></td>
       <td colspan=2><textarea rows="3" cols="50" NAME="<%=column_name[i]%>" wrap="virtual"><%=my_val%></textarea></td>
       </tr>
<%     }
    }
  } // end for
%>
 <!--display alias entries need to be created for use here-->
<%
  if(chk_symbol!=null && chk_symbol.equals("ON")) { 
%>
  <tr>
   <td><b><font color="##FF00FF">new alias</font></b></td>
   <td colspan=2><b>old_gene_symbol: </b><%=geneAry[0].getGene_symbol()%></td>
  </tr>
<%}
  if(chk_name!=null && chk_name.equals("ON")) {
%>
  <tr>
   <td><b><font color="##FF00FF">new alias</font></b></td>
   <td colspan=2><b>old_gene_name: </b><%=geneAry[0].getFull_name()%></td>
  </tr>
<% } %>

  
<!-- **** Start Association ******** -->
  <tr BGCOLOR="#CCCCCC">
    <td colspan=3 bordercolor="#CCCCCC" align=center><b>Associations</b></td>
  </tr>
<!-- Notes section -->
<%int len11 = noteAry[1].length;
  int len12 = noteAry[0].length;
  String note_del = "";
  String note_cp = "";
  if(len11 > 0 || len12 > 0)  {
%>
  <tr><td colspan=3><b>NOTES</b></td></tr>
<%}
 if(len11 > 0 ) {
  for(int i=0;i<noteAry[1].length;i++) {
    String note_kd = request.getParameter("note_kd_"+i);
%>
    <tr>
    <td><%=noteAry[1][i].getNotes_type_name_lc()%></td>
    <td><%=noteAry[1][i].getNotes()%></td>
<%
    if(note_kd.equals("del")) {
      note_del +=noteAry[1][i].getNote_key()+"#";
%>
      <td><b><font color="#FF0000">delete</font></b></td>
      </tr>
<%  } else {  %>
      <td>keep</td>
      </tr>
<%  }
  } // end for
 }
%>
<%if(len12 > 0 ) {
  for(int i=0;i<noteAry[0].length;i++) {
    String note_c = request.getParameter("note_c_"+i);
    if(note_c !=null && note_c.equals("ON"))  {
%>
      <tr>
      <td><%=noteAry[0][i].getNotes_type_name_lc()%></td>
      <td><%=noteAry[0][i].getNotes()%></td>
      <td><b><font color="##FF00FF">new</font></b></td>
      </tr>
<%    note_cp +=noteAry[0][i].getNote_key()+"#";     
    }
  }
 }
%>
<input type=hidden name="note del" value="<%=note_del%>">
<input type=hidden name="note new" value="<%=note_cp%>">

  <!-- Reference section  -->  
<%int len1 = refAry[1].length;
  int len2 = refAry[0].length;
  String ref_del = "";
  String ref_cp = "";
  if(len1 > 0 || len2 > 0)  {
%>
  <tr><td colspan=3><b>CURATED REFERENCE</b></td></tr>
<%}
 if(len1 > 0 ) {
  for(int i=0;i<refAry[1].length;i++) {
    String ref_kd = request.getParameter("ref_kd_"+i);
%>
    <tr>
      <td><%=refAry[1][i].getRgd_id()%></td>
      <td><%=refAry[1][i].getCitation()%></td>
<%
    if(ref_kd.equals("del")) {
      // mark this record as deleting record
      ref_del +=refAry[1][i].getRef_key() +"#";   
%>
      <td><b><font color="#FF0000">delete</font></b></td>
      </tr>
<%  } else {  %>
      <td>keep</td>
      </tr>
<%  }
  } // end for
 }
%>
<%if(len2 > 0 ) {
  for(int i=0;i<refAry[0].length;i++) {
    String ref_c = request.getParameter("ref_c_"+i);
    if(ref_c !=null && ref_c.equals("ON"))  {
%>
      <tr>
         <td><%=refAry[0][i].getRgd_id()%></td>
         <td><%=refAry[0][i].getCitation()%></td>
         <td><b><font color="##FF00FF">new</font></b></td>
      </tr>
<%  
      // mark this record as new record
      ref_cp +=refAry[0][i].getRef_key() +"#"; 
    }
  }
 }
%> 
<!-- hidden fields for reference  -->
<input type=hidden name="ref del" value="<%=ref_del%>">
<input type=hidden name="ref new" value="<%=ref_cp%>">

   <!-- Alias section  -->  
<%int len3 = aliasAry[1].length;
  int len4 = aliasAry[0].length;
  String alias_del = "";
  String alias_cp = "";
  
  if(len3 > 0 || len4 > 0)  {
%>
  <tr><td colspan=3><b>ALIAS</b></td></tr>
<%}
 if(len3 > 0 ) {
  for(int i=0;i<aliasAry[1].length;i++) {
    String alias_kd = request.getParameter("alias_kd_"+i);
%>
    <tr>
      <td><%=aliasAry[1][i].getAlias_type_name_lc()%></td>
      <td><%=aliasAry[1][i].getAlias_value()%></td>
<%
    if(alias_kd.equals("del")) {
      alias_del +=aliasAry[1][i].getAlias_key()+"#";
%>
      <td><b><font color="#FF0000">delete</font></b></td>
      </tr>
<%  } else {  %>
      <td>keep</td>
      </tr>
<%  }
  } // end for
 }
%>
<%if(len4 > 0 ) {
  for(int i=0;i<aliasAry[0].length;i++) {
    String alias_c = request.getParameter("alias_c_"+i);
    if(alias_c !=null && alias_c.equals("ON"))  {
%>
      <tr>
         <td><%=aliasAry[0][i].getAlias_type_name_lc()%></td>
         <td><%=aliasAry[0][i].getAlias_value()%></td>
         <td><b><font color="##FF00FF">new</font></b></td>
      </tr>
<%    
      alias_cp +=aliasAry[0][i].getAlias_key()+"#";
    }
  }
 }
%>   
<!-- hidden fields for Alias  -->
<input type=hidden name="alias del" value="<%=alias_del%>">
<input type=hidden name="alias new" value="<%=alias_cp%>">

 <!-- Homolog section -->
<%int len5 = hmlgAry[1].length;
  int len6 = hmlgAry[0].length;
  String hmlg_del = "";
  String hmlg_cp = "";
  if(len5 > 0 || len6 > 0)  {
%>
  <tr><td colspan=3><b>HOMOLOG</b></td></tr>
<%}
 if(len5 > 0 ) {
  for(int i=0;i<hmlgAry[1].length;i++) {
    String hmlg_kd = request.getParameter("hmlg_kd_"+i);
%>
    <tr>
     <td colspan=2><b>sym:</b><%=hmlgAry[1][i].getHomolog_symbol()%>&nbsp;
                   <b>chr:</b><%=hmlgAry[1][i].getChromosome()%>&nbsp;
                   <b>sp:</b><%=hmlgAry[1][i].getOrganism_genus()%>&nbsp;<%=hmlgAry[1][i].getOrganism_species()%></td>
<%
    if(hmlg_kd.equals("del")) {
      hmlg_del +=hmlgAry[1][i].getHomolog_key()+"#";
%>
      <td><b><font color="#FF0000">delete</font></b></td>
      </tr>
<%  } else {  %>
      <td>keep</td>
      </tr>
<%  }
  } // end for
 }
%>
<%if(len6 > 0 ) {
  for(int i=0;i<hmlgAry[0].length;i++) {
    String hmlg_c = request.getParameter("hmlg_c_"+i);
    if(hmlg_c !=null && hmlg_c.equals("ON"))  {
%>
      <tr>
      <td colspan=2><b>sym:</b><%=hmlgAry[0][i].getHomolog_symbol()%>&nbsp;
                    <b>chr:</b><%=hmlgAry[0][i].getChromosome()%>&nbsp;
                    <b>sp:</b><%=hmlgAry[0][i].getOrganism_genus()%>&nbsp;<%=hmlgAry[0][i].getOrganism_species()%></td>
      <td><b><font color="##FF00FF">new</font></b></td>
      </tr>
<%    
      hmlg_cp +=hmlgAry[0][i].getHomolog_key()+"#";
    }
  }
 }
%> 
<input type=hidden name="hmlg del" value="<%=hmlg_del%>">
<input type=hidden name="hmlg new" value="<%=hmlg_cp%>">
<!-- Sequence section -->
<%int len7 = seqAry[1].length;
  int len8 = seqAry[0].length;
  String seq_del = "";
  String seq_cp = "";
  if(len7 > 0 || len8 > 0)  {
%>
  <tr><td colspan=3><b>SEQUENCE</b></td></tr>
<%}
 if(len7 > 0 ) {
  for(int i=0;i<seqAry[1].length;i++) {
    String seq_kd = request.getParameter("seq_kd_"+i);
%>
    <tr>
    <td colspan=2><b>type:</b><%=seqAry[1][i].getSequence_type()%>&nbsp;
                 <b>nm:</b><%=seqAry[1][i].getClone_name()%>&nbsp;
                 <b>for:</b><%=seqAry[1][i].getForward_seq()%>&nbsp;
                 <b>rev:</b><%=seqAry[1][i].getReverse_seq()%></td>
<%
    if(seq_kd.equals("del")) {
      seq_del +=seqAry[1][i].getSequence_key()+"#";
%>
      <td><b><font color="#FF0000">delete</font></b></td>
      </tr>
<%  } else {  %>
      <td>keep</td>
      </tr>
<%  }
  } // end for
 }
%>
<%if(len8 > 0 ) {
  for(int i=0;i<seqAry[0].length;i++) {
    String seq_c = request.getParameter("seq_c_"+i);
    if(seq_c !=null && seq_c.equals("ON"))  {
%>
      <tr>
      <td colspan=2><b>type:</b><%=seqAry[0][i].getSequence_type()%>&nbsp;
                 <b>nm:</b><%=seqAry[0][i].getClone_name()%>&nbsp;
                 <b>for:</b><%=seqAry[0][i].getForward_seq()%>&nbsp;
                 <b>rev:</b><%=seqAry[0][i].getReverse_seq()%></td>
      <td><b><font color="##FF00FF">new</font></b></td>
      </tr>
<%    
      seq_cp +=seqAry[0][i].getSequence_key()+"#";
    }
  }
 }
%>
<input type=hidden name="seq del" value="<%=seq_del%>">
<input type=hidden name="seq new" value="<%=seq_cp%>">

<!-- Nomen_Event section -->
<%int len13 = nomenAry[1].length;
  int len14 = nomenAry[0].length;
  String nomen_del = "";
  String nomen_cp = "";
  if(len13 > 0 || len14 > 0)  {
%>
  <tr><td colspan=3><b>NOMEN EVENTS</b></td></tr>
<%}
 if(len13 > 0 ) {
  for(int i=0;i<nomenAry[1].length;i++) {
    String nomen_kd = request.getParameter("nomen_kd_"+i);
%>
    <tr>
     <td colspan=2><b>sym:</b><%=nomenAry[1][i].getSymbol()%>&nbsp;
                    <b>nm:</b><%=nomenAry[1][i].getName()%>&nbsp;
                    <b>desc:</b><%=nomenAry[1][i].getDescription()%>&nbsp;
                    <b>date:</b><%=nomenAry[1][i].getEvent_date()%></td>
<%
    if(nomen_kd.equals("del")) {
      nomen_del +=nomenAry[1][i].getNomen_event_key()+"#";
%>
      <td><b><font color="#FF0000">delete</font></b></td>
      </tr>
<%  } else {  %>
      <td>keep</td>
      </tr>
<%  }
  } // end for
 }
%>
<%if(len14 > 0 ) {
  for(int i=0;i<nomenAry[0].length;i++) {
    String nomen_c = request.getParameter("nomen_c_"+i);
    if(nomen_c !=null && nomen_c.equals("ON"))  {
%>
      <tr>
      <td colspan=2><b>sym:</b><%=nomenAry[0][i].getSymbol()%>&nbsp;
                    <b>nm:</b><%=nomenAry[0][i].getName()%>&nbsp;
                    <b>desc:</b><%=nomenAry[0][i].getDescription()%>&nbsp;
                    <b>date:</b><%=nomenAry[0][i].getEvent_date()%></td>
      <td><b><font color="##FF00FF">new</font></b></td>
      </tr>
<%    nomen_cp +=nomenAry[0][i].getNomen_event_key()+"#"; 
    }
  }
 }
%>
<input type=hidden name="nomen del" value="<%=nomen_del%>">
<input type=hidden name="nomen new" value="<%=nomen_cp%>">
<!-- External Databse section -->
<%int len15 = xdbAry[1].length;
  int len16 = xdbAry[0].length;
  String xdb_del = "";
  String xdb_cp = "";
  if(len15 > 0 || len16 > 0)  {
%>
  <tr><td colspan=3><b>EXTERNAL DATABASE</b></td></tr>
<%}
 if(len15 > 0 ) {
  for(int i=0;i<xdbAry[1].length;i++) {
    String xdb_kd = request.getParameter("xdb_kd_"+i);
%>
    <tr>
    <td><%=xdbAry[1][i].getAcc_id()%></td>
    <td><%=xdbAry[1][i].getXdb_name()%></td>
<%
    if(xdb_kd.equals("del")) {
      xdb_del +=xdbAry[1][i].getAcc_xdb_key()+"#";
%>
      <td><b><font color="#FF0000">delete</font></b></td>
      </tr>
<%  } else {  %>
      <td>keep</td>
      </tr>
<%  }
  } // end for
 }
%>
<%if(len16 > 0 ) {
  for(int i=0;i<xdbAry[0].length;i++) {
    String xdb_c = request.getParameter("xdb_c_"+i);
    if(xdb_c !=null && xdb_c.equals("ON"))  {
%>
      <tr>
      <td><%=xdbAry[0][i].getAcc_id()%></td>
      <td><%=xdbAry[0][i].getXdb_name()%></td>
      <td><b><font color="##FF00FF">new</font></b></td>
      </tr>
<%    xdb_cp +=xdbAry[0][i].getAcc_xdb_key()+"#";
    }
  }
 }
%> 
<input type=hidden name="xdb del" value="<%=xdb_del%>">
<input type=hidden name="xdb new" value="<%=xdb_cp%>">
<!-- Strain section -->
<%int len17 = strainAry[1].length;
  int len18 = strainAry[0].length;
  String strain_del = "";
  String strain_cp = "";
  if(len17 > 0 || len18 > 0)  {
%>
  <tr><td colspan=3><b>STRAIN</b></td></tr>
<%}
 if(len17 > 0 ) {
  for(int i=0;i<strainAry[1].length;i++) {
    String strain_kd = request.getParameter("strain_kd_"+i);
%>
    <tr>
    <td colspan=2><%=strainAry[1][i].getStrain_symbol()%></td>
<%
    if(strain_kd.equals("del")) {
      strain_del +=strainAry[1][i].getStrain_key()+"#";
%>
      <td><b><font color="#FF0000">delete</font></b></td>
      </tr>
<%  } else {  %>
      <td>keep</td>
      </tr>
<%  }
  } // end for
 }
%>
<%if(len18 > 0 ) {
  for(int i=0;i<strainAry[0].length;i++) {
    String strain_c = request.getParameter("strain_c_"+i);
    if(strain_c !=null && strain_c.equals("ON"))  {
%>
      <tr>
      <td colspan=2><%=strainAry[0][i].getStrain_symbol()%></td>
      <td><b><font color="##FF00FF">new</font></b></td>
      </tr>
<%    strain_cp +=strainAry[0][i].getStrain_key()+"#";
    }
  }
 }
%>
<input type=hidden name="strain del" value="<%=strain_del%>">
<input type=hidden name="strain new" value="<%=strain_cp%>">
<!--  SSLP section -->
<%int len21 = sslpAry[1].length;
  int len22 = sslpAry[0].length;
  String sslp_del = "";
  String sslp_cp = "";
  if(len21 > 0 || len22 > 0)  {
%>
  <tr><td colspan=3><b>SSLP</b></td></tr>
<%}
 if(len21 > 0 ) {
  for(int i=0;i<sslpAry[1].length;i++) {
    String sslp_kd = request.getParameter("sslp_kd_"+i);
%>
    <tr>
    <td colspan=2><%=sslpAry[1][i].getRgd_name()%></td>
<%
    if(sslp_kd.equals("del")) {
      sslp_del +=sslpAry[1][i].getSslp_key()+"#";
%>
      <td><b><font color="#FF0000">delete</font></b></td>
      </tr>
<%  } else {  %>
      <td>keep</td>
      </tr>
<%  }
  } // end for
 }
%>
<%if(len22 > 0 ) {
  for(int i=0;i<sslpAry[0].length;i++) {
    String sslp_c = request.getParameter("sslp_c_"+i);
    if(sslp_c !=null && sslp_c.equals("ON"))  {
%>
      <tr>
      <td colspan=2><%=sslpAry[0][i].getRgd_name()%></td>
      <td><b><font color="##FF00FF">new</font></b></td>
      </tr>
<%    sslp_cp +=sslpAry[0][i].getSslp_key()+"#";  
    }
  }
 }
%>
<input type=hidden name="sslp del" value="<%=sslp_del%>">
<input type=hidden name="sslp new" value="<%=sslp_cp%>">
<!-- EST section -->
<%int len23 = estAry[1].length;
  int len24 = estAry[0].length;
  String est_del = "";
  String est_cp = "";
  if(len23 > 0 || len24 > 0)  {
%>
  <tr><td colspan=3><b>EST</b></td></tr>
<%}
 if(len23 > 0 ) {
  for(int i=0;i<estAry[1].length;i++) {
    String est_kd = request.getParameter("est_kd_"+i);
%>
    <tr>
    <td colspan=2><%=estAry[1][i].getRgd_est_name()%></td>
<%
    if(est_kd.equals("del")) {
      est_del +=estAry[1][i].getEst_key()+"#";
%>
      <td><b><font color="#FF0000">delete</font></b></td>
      </tr>
<%  } else {  %>
      <td>keep</td>
      </tr>
<%  }
  } // end for
 }
%>
<%if(len24 > 0 ) {
  for(int i=0;i<estAry[0].length;i++) {
    String est_c = request.getParameter("est_c_"+i);
    if(est_c !=null && est_c.equals("ON"))  {
%>
      <tr>
      <td colspan=2><%=estAry[0][i].getRgd_est_name()%></td>
      <td><b><font color="##FF00FF">new</font></b></td>
      </tr>
<%    est_cp +=estAry[0][i].getEst_key()+"#";  
    }
  }
 }
%>
<input type=hidden name="est del" value="<%=est_del%>">
<input type=hidden name="est new" value="<%=est_cp%>">
<!-- QTL section -->
<%int len25 = qtlAry[1].length;
  int len26 = qtlAry[0].length;
  String qtl_del = "";
  String qtl_cp = "";
  if(len25 > 0 || len26 > 0)  {
%>
  <tr><td colspan=3><b>QTL</b></td></tr>
<%}
 if(len25 > 0 ) {
  for(int i=0;i<qtlAry[1].length;i++) {
    String qtl_kd = request.getParameter("qtl_kd_"+i);
%>
    <tr>
    <td colspan=2><%=qtlAry[1][i].getQtl_symbol()%></td>
<%
    if(qtl_kd.equals("del")) {
      qtl_del +=qtlAry[1][i].getQtl_key()+"#";
%>
      <td><b><font color="#FF0000">delete</font></b></td>
      </tr>
<%  } else {  %>
      <td>keep</td>
      </tr>
<%  }
  } // end for
 }
%>
<%if(len26 > 0 ) {
  for(int i=0;i<qtlAry[0].length;i++) {
    String qtl_c = request.getParameter("qtl_c_"+i);
    if(qtl_c !=null && qtl_c.equals("ON"))  {
%>
      <tr>
      <td colspan=2><%=qtlAry[0][i].getQtl_symbol()%></td>
      <td><b><font color="##FF00FF">new</font></b></td>
      </tr>
<%    qtl_cp +=qtlAry[0][i].getQtl_key()+"#";   
    }
  }
 }
%>
<input type=hidden name="qtl del" value="<%=qtl_del%>">
<input type=hidden name="qtl new" value="<%=qtl_cp%>">
<!-- Maps Data section -->
<%int len27 = mapsAry[1].length;
  int len28 = mapsAry[0].length;
  String maps_del = "";
  String maps_cp = "";
  if(len27 > 0 || len28 > 0)  {
%>
  <tr><td colspan=3><b>MAPS DATA</b></td></tr>
<%}
 if(len27 > 0 ) {
  for(int i=0;i<mapsAry[1].length;i++) {
    String maps_kd = request.getParameter("maps_kd_"+i);
%>
    <tr>
    <td colspan=2><b>chr:</b><%=mapsAry[1][i].getChromosome()%>&nbsp;
                 <b>band:</b><%=mapsAry[1][i].getFish_band()%>&nbsp;
                 <b>pos:</b><%=mapsAry[1][i].getAbs_position()%>&nbsp;
                 <b>map:</b><%=mapsAry[1][i].getMap_name()%></td>
<%
    if(maps_kd.equals("del")) {
      maps_del +=mapsAry[1][i].getMaps_data_key()+"#"; 
%>
      <td><b><font color="#FF0000">delete</font></b></td>
      </tr>
<%  } else {  %>
      <td>keep</td>
      </tr>
<%  }
  } // end for
 }
%>
<%if(len28 > 0 ) {
  for(int i=0;i<mapsAry[0].length;i++) {
    String maps_c = request.getParameter("maps_c_"+i);
    if(maps_c !=null && maps_c.equals("ON"))  {
%>
      <tr>
      <td colspan=2><b>chr:</b><%=mapsAry[0][i].getChromosome()%>&nbsp;
                 <b>band:</b><%=mapsAry[0][i].getFish_band()%>&nbsp;
                 <b>pos:</b><%=mapsAry[0][i].getAbs_position()%>&nbsp;
                 <b>map:</b><%=mapsAry[0][i].getMap_name()%></td>
      <td><b><font color="##FF00FF">new</font></b></td>
      </tr>
<%    maps_cp +=mapsAry[0][i].getMaps_data_key()+"#";
    }
  }
 }
%>
<input type=hidden name="maps del" value="<%=maps_del%>">
<input type=hidden name="maps new" value="<%=maps_cp%>">
<!-- Phenotype section -->
<%int len31 = pheAry[1].length;
  int len32 = pheAry[0].length;
  String phe_del = "";
  String phe_cp = "";
  if(len31 > 0 || len32 > 0)  {
%>
  <tr><td colspan=3><b>PHENOTYPE</b></td></tr>
<%}
 if(len31 > 0 ) {
  for(int i=0;i<pheAry[1].length;i++) {
    String phe_kd = request.getParameter("maps_kd_"+i);
%>
    <tr>
    <td></td><%=pheAry[1][i].getPhe_symbol()%></td>
    <td></td><%=pheAry[1][i].getPhe_desc()%></td>
<%
    if(phe_kd.equals("del")) {
      phe_del +=pheAry[1][i].getPhe_key()+"#";
%>
      <td><b><font color="#FF0000">delete</font></b></td>
      </tr>
<%  } else {  %>
      <td>keep</td>
      </tr>
<%  }
  } // end for
 }
%>
<%if(len32 > 0 ) {
  for(int i=0;i<pheAry[0].length;i++) {
    String phe_c = request.getParameter("phe_c_"+i);
    if(phe_c !=null && phe_c.equals("ON"))  {
%>
      <tr>
      <td></td><%=pheAry[0][i].getPhe_symbol()%></td>
      <td></td><%=pheAry[0][i].getPhe_desc()%></td>
      <td><b><font color="##FF00FF">new</font></b></td>
      </tr>
<%    phe_cp +=pheAry[0][i].getPhe_key()+"#";  
    }
  }
 }
%>
<input type=hidden name="phe del" value="<%=phe_del%>">
<input type=hidden name="phe new" value="<%=phe_cp%>">
    <TR bgcolor="#FFFFFF" bordercolor="#FFFFFF"> 
			<TD colspan=4><CENTER><input type="submit" value="Load Data"></CENTER></TD>
		</TR>
	 </table>
</FORM>

<%-- } end of if(username!=null)--%>
<jsp:include page="footerarea.jsp" flush="true" />

