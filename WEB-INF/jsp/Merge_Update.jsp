<%-- *********************
Program Name - Merge_Update.jsp
Programmer -  jiali chen

Description - This program will merge two genes and Create new associations.
Modification log: none

***********************--%>
<%@ page language="java" import="online.*, common.*, java.net.*, java.text.*,java.lang.*,java.util.*,javax.servlet.*,javax.servlet.http.*" %>
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

<jsp:useBean id="gene" scope="session" class="online.Gene" />
<jsp:useBean id="alias" scope="session" class="online.Alias" />
<jsp:useBean id="dtset" scope="session" class="online.Data_set" />
<%
  // initialize db handler via Servlet Context
  ServletContext context = request.getSession(true).getServletContext();
  DatabaseObj dbObj = (DatabaseObj)context.getAttribute("DEVHDL");
  if(dbObj == null) {
   dbObj = new DatabaseObj("dev_1");
   context.setAttribute("DEVHDL",dbObj);
  }
  gene.setContext(context);
  dtset.setContext(context);
  alias.setContext(context);
  
  int user_key = Integer.parseInt((String)session.getAttribute("user_key"));
  String data_obj = (String)session.getAttribute("data_obj");

  // define variables 
  boolean success = true;
  boolean a_s = true;
  boolean a_n = true;

  String updt_sql = "";
  String old_record = "";
  String err_msg = "";
  
  // retrieve vals from beans
  Gene[] geneAry = dtset.getGene();
  int gene_key = geneAry[1].getGene_key();
  int rgdid = geneAry[1].getRgd_id();
  String old_prod = geneAry[1].getProduct();
  String old_func = geneAry[1].getFunction();
  String old_desc = geneAry[1].getGene_desc();
  String old_type = geneAry[1].getGene_type_lc();
  // used for creating aliases
  int rgdid_one = geneAry[0].getRgd_id();
  String symbol_one = geneAry[0].getGene_symbol();
  String name_one = geneAry[0].getFull_name();
  
  String symbol_alias = (String)session.getAttribute("symbol_alias");
  String name_alias = (String)session.getAttribute("name_alias");


  // get vals from previous screen
  String prod = request.getParameter("Product");
  String func = request.getParameter("Function");
  String desc = request.getParameter("Description");

  // get hidden values
  String type = request.getParameter("newType");
  String ref_d_str = request.getParameter("ref del");
  String ref_n_str = request.getParameter("ref new");  
  String alias_d_str = request.getParameter("alias del");
  String alias_n_str = request.getParameter("alias new");
  String hmlg_d_str = request.getParameter("hmlg del");
  String hmlg_n_str = request.getParameter("hmlg new");
  String maps_d_str = request.getParameter("maps del");
  String maps_n_str = request.getParameter("maps new"); 
  String nomen_d_str = request.getParameter("nomen del");
  String nomen_n_str = request.getParameter("nomen new");
  String note_d_str = request.getParameter("note del");
  String note_n_str = request.getParameter("note new");
  String qtl_d_str = request.getParameter("qtl del");
  String qtl_n_str = request.getParameter("qtl new");
  String seq_d_str = request.getParameter("seq del");
  String seq_n_str = request.getParameter("seq new");
  String sslp_d_str = request.getParameter("sslp del");
  String sslp_n_str = request.getParameter("sslp new");
  String strain_d_str = request.getParameter("strain del");
  String strain_n_str = request.getParameter("strain new");
  String xdb_d_str = request.getParameter("xdb del");
  String xdb_n_str = request.getParameter("xdb new");
  String phe_d_str = request.getParameter("phe del");
  String phe_n_str = request.getParameter("phe new");
  String ref_err   = "";
  String alias_err = "";
  String hmlg_err  = "";
  String maps_err  = "";
  String nomen_err = "";
  String note_err  = "";
  String phe_err   = "";
  String qtl_err   = "";
  String seq_err   = "";
  String sslp_err  = "";
  String strain_err= "";
  String xdb_err   = "";

  if(prod!=null && old_prod !=null) {
     prod = prod.trim();
     //if(!prod.equalsIgnoreCase(old_prod)) {     
     if(!prod.equals(old_prod)) {
       updt_sql = "PRODUCT='" + formatTicks(prod)+"'";
       if(!old_prod.equals(""))  {
        old_record = "PRODUCT==" + old_prod;
       }
     }
  }
  else if(prod!=null && old_prod == null) {
     prod = prod.trim();
     updt_sql = "PRODUCT='" + formatTicks(prod)+"'";
  }
  else {
     updt_sql = "PRODUCT=''";
     if(old_prod !=null && !old_prod.equals(""))  {
       old_record = "PRODUCT==" + old_prod;
     }    
  }
  
  if(func!=null && old_func !=null) {
     func = func.trim();
     //if(!func.equalsIgnoreCase(old_func)) {
     if(!func.equals(old_func)) {
       updt_sql += ",FUNCTION='" + formatTicks(func)+"'";
       if(!old_func.equals(""))  {
          old_record += "::FUNCTION==" + old_func;
       }
     }
  }
  else if(func!=null && old_func == null ) {
     func = func.trim();
     updt_sql += ",FUNCTION='" + formatTicks(func)+"'";
  }
  else {
     updt_sql += ",FUNCTION=''";
     if(old_func !=null && !old_func.equals(""))  {
       old_record += "::FUNCTION==" + old_func;
     }     
  }
  
  if(desc!=null && old_desc !=null) {
     desc = desc.trim();
     //if(!desc.equalsIgnoreCase(old_desc)) {
     if(!desc.equals(old_desc)) {
       updt_sql += ",GENE_DESC='" + formatTicks(desc)+"'";
       if(!old_desc.equals(""))  {
         old_record += "::GENE_DESC==" + old_desc;
       }
     }
  }
  else if(desc != null && old_desc ==null) {
     desc = desc.trim();
     updt_sql += ",GENE_DESC='" + formatTicks(desc)+"'";
  }
  else {
     updt_sql += ",GENE_DESC=''";
     if(old_desc !=null && !old_desc.equals(""))  {
       old_record += "::GENE_DESC==" + old_desc;
     }
  }
  
  if(type!=null && old_type != null) {
     if(!type.equalsIgnoreCase(old_type)) {
        updt_sql += ",GENE_TYPE_LC='" +type+"'";
        if(!old_type.equals(""))  {
          old_record += "::GENE_TYPE_LC==" + old_type;
        }
     }
  }
  else if(type!=null && old_type == null) {
    updt_sql += ",GENE_TYPE_LC='" +type+"'";
  }
  else {
     updt_sql += ",GENE_TYPE_LC=''";
     if(old_type !=null && !old_type.equals(""))  {
       old_record += "::GENE_TYPE_LC==" + old_type;
     }     
  }

  // trim out comma if needed
  if(updt_sql.indexOf(',') == 0) {
     updt_sql = updt_sql.substring(1);
  }

  // trim out :: if needed
  if(old_record.indexOf(':') == 0) {
     old_record = old_record.substring(2);
  }
//System.out.println("updt==" +updt_sql);
//System.out.println("old==" +old_record);
  // do update on gene object first
  if(!updt_sql.equals("")) {
    gene.log.setData_obj(data_obj);
    gene.log.setUser_key(user_key);
    success = gene.updateGenes(gene_key, updt_sql, old_record);
  }
  // create new alias entry
  String symbol_type = "old_gene_symbol";
  //a_s = alias.createAlias(rgdid_one,symbol_one,symbol_type);
  if(symbol_alias!=null && symbol_alias.equals("ON")) {
    a_s = alias.createAlias(rgdid,symbol_one,symbol_type);
  }
  String name_type = "old_gene_name";
  //a_n = alias.createAlias(rgdid_one,name_one,name_type);
  if(name_alias!=null && name_alias.equals("ON")) {
    a_n = alias.createAlias(rgdid,name_one,name_type);
  }
  
  // for creating log records
  dtset.log.setData_obj(data_obj);
  dtset.log.setUser_key(user_key);

  // start to do associations
  if((ref_d_str!=null && !ref_d_str.equals("")) || (ref_n_str!=null && !ref_n_str.equals(""))) {
      //ref_err = dtset.merge_references(ref_n_str,ref_d_str);
  }
  if((alias_d_str!=null && !alias_d_str.equals("")) || (alias_n_str!=null && !alias_n_str.equals(""))) {
      alias_err = dtset.merge_aliases(alias_n_str,alias_d_str);
  }
  if((hmlg_d_str!=null&&!hmlg_d_str.equals("")) || (hmlg_n_str!=null&&!hmlg_n_str.equals(""))) {
      hmlg_err = dtset.merge_hmlgs(hmlg_n_str,hmlg_d_str);
  }
  if((maps_d_str!=null&&!maps_d_str.equals("")) || (maps_n_str!=null&&!maps_n_str.equals(""))) {
      maps_err = dtset.merge_maps(maps_n_str,maps_d_str);
  }
  if((nomen_d_str!=null &&!nomen_d_str.equals("")) || (nomen_n_str!=null&&!nomen_n_str.equals(""))) {
      nomen_err = dtset.merge_nomen(nomen_n_str,nomen_d_str);
  }
  if((note_d_str!=null&&!note_d_str.equals("")) || (note_n_str!=null&&!note_n_str.equals(""))) {
      note_err = dtset.merge_notes(note_n_str,note_d_str);
  }
  if((phe_d_str!=null&&!phe_d_str.equals("")) || (phe_n_str!=null&&!phe_n_str.equals(""))) {
      phe_err = dtset.merge_phenotypes(phe_n_str,phe_d_str);
  }
  if((qtl_d_str!=null&&!qtl_d_str.equals("")) || (qtl_n_str!=null&&!qtl_n_str.equals(""))) {
      qtl_err = dtset.merge_qtls(qtl_n_str,qtl_d_str);
  }
  if((seq_d_str!=null&&!seq_d_str.equals("")) || (seq_n_str!=null&&!seq_n_str.equals(""))) {
      seq_err = dtset.merge_sequences(seq_n_str,seq_d_str);
  }
  if((sslp_d_str!=null&&!sslp_d_str.equals("")) || (sslp_n_str!=null&&!sslp_n_str.equals(""))) {
      sslp_err = dtset.merge_sslps(sslp_n_str,sslp_d_str);
  }
  if((strain_d_str!=null&&!strain_d_str.equals("")) || (strain_n_str!=null&&!strain_n_str.equals(""))) {
      strain_err = dtset.merge_strains(strain_n_str,strain_d_str);
  }
  if((xdb_d_str!=null&&!xdb_d_str.equals("")) || (xdb_n_str!=null&&!xdb_n_str.equals(""))) {
      xdb_err = dtset.merge_xdbs(xdb_n_str,xdb_d_str);
  }

  // form error message here
  if(!success) {
     err_msg = "Error occurred while updating Gene Attibutes";
  }
  if(!a_s) {
     err_msg = "Error occurred while creating an Aliases(old_gene_symbol)";
  }
  if(!a_n) {
     err_msg = "Error occurred while creating an Aliases(old_gene_name)";
  } 
%>

<%if(!err_msg.equals("")) { %>
  <p><b><font color="##FF0000"><%=err_msg%></font></b>
<%}else if(!ref_err.equals("")) { %>
  <p><b><font color="##FF0000"><%=ref_err%></font></b>
<%} else if(!alias_err.equals("")) { %>
  <p><b><font color="##FF00FF"><%=alias_err%></font></b>
<%} else if(!hmlg_err.equals("")) { %>
  <p><b><font color="##FF0000"><%=hmlg_err%></font></b>
<%} else if(!maps_err.equals("")) { %>
  <p><b><font color="##FF0000"><%=maps_err%></font></b>
<%} else if(!nomen_err.equals("")) { %>
  <p><b><font color="##FF0000"><%=nomen_err%></font></b>
<%} else if(!note_err.equals("")) { %>
  <p><b><font color="##FF0000"><%=note_err%></font></b>
<%} else if(!phe_err.equals("")) { %>
  <p><b><font color="##FF0000"><%=phe_err%></font></b>
<%} else if(!qtl_err.equals("")) { %>
  <p><b><font color="##FF0000"><%=qtl_err%></font></b>
<%} else if(!seq_err.equals("")) { %>
  <p><b><font color="##FF0000"><%=seq_err%></font></b>
<%} else if(!sslp_err.equals("")) { %>
  <p><b><font color="##FF0000"><%=sslp_err%></font></b>
<%} else if(!strain_err.equals("")) { %>
  <p><b><font color="##FF0000"><%=strain_err%></font></b>
<%} else if(!xdb_err.equals("")) { %>
  <p><b><font color="#FF0000"><%=xdb_err%></font></b>
<%} else {%>
  <jsp:include page="Nomen_Event.jsp" flush="true" />
<%}%>
<%-- } end of if(username!=null)--%>
<jsp:include page="footerarea.jsp" flush="true" />
