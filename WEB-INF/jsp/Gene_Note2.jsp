<%@ page language="java" import="online.* , manager.*, common.*,java.net.*, java.text.*" %>
<%@ include file="/template/header.jsp"%>
<%@ include file="/template/curation_lib.jsp"%>

<%
String username = (String)session.getAttribute("username");
String user_group = (String)session.getAttribute("user_group");
//System.out.println("username--gene note2"+username);
if(username!=null) { %>

  <jsp:include page="user_menu.jsp"  flush="true">
    <jsp:param name="highlighted" value="No2"/>
    <jsp:param name="user_group" value="<%=user_group%>"/>
    <jsp:param name="username" value="<%=username%>"/>
  </jsp:include>

<jsp:useBean id="gene" scope="session" class="online.Gene" /> 
<jsp:useBean id="note" scope="page" class="online.Note" /> 
<%
  int rgd_id;
  String full_name, gene_symbol_lc, notes, public_y_n, notes_type_name_lc;
  String condition = null;
  
  // initialize db handler via Servlet Context
  ServletContext context = request.getSession(true).getServletContext();
  DatabaseObj dbObj = (DatabaseObj)context.getAttribute("DEVHDL");
  if(dbObj == null) {
   dbObj = new DatabaseObj("dev_1");
   context.setAttribute("DEVHDL",dbObj);
  }
  gene.setContext(context);
  note.setContext(context);


  boolean getNote = false, createNote = false, updateNote = false;
  String data_obj = (String)session.getAttribute("data_obj");
  int user_key = Integer.parseInt((String)session.getAttribute("user_key"));
  String[] note_types = note.getNote_types();
  notes_type_name_lc = request.getParameter("notes_type");

    //System.out.println("notes type   "+notes_type_name_lc); 
    //System.out.println("get_value2"+request.getParameter("get_value2")); 
    //System.out.println("get_value3"+request.getParameter("get_value3"));

  if (request.getParameter("get_value1") != null ) {
    rgd_id = Integer.parseInt(request.getParameter("rgd_id"));
    //gene.setRgd_id(rgd_id);
    condition = " WHERE rgd_id=" + rgd_id;
    getNote = gene.searchNotes(condition);
  }
  else if (request.getParameter("get_value2") != null ) {
    gene_symbol_lc = request.getParameter("gene_symbol_lc");
    //gene.setGene_symbol_lc(gene_symbol_lc);
    condition = " WHERE gene_symbol_lc='" + gene_symbol_lc + "'";
    getNote = gene.searchNotes(condition);
  }
  else if (request.getParameter("get_value3") != null ) {
    full_name = request.getParameter("full_name");
    //gene.setFull_name(full_name);
    condition = " WHERE full_name='" + full_name + "'";
    getNote = gene.searchNotes(condition);
  }

  if (request.getParameter("Submit_create") != null) {
    rgd_id = Integer.parseInt(request.getParameter("rgd_id"));
    notes_type_name_lc = request.getParameter("notes_type");
    notes = request.getParameter("notes");
    public_y_n = request.getParameter("public_flag");
    note.log.setData_obj(data_obj);
    note.log.setUser_key(user_key);
    note.setRgd_id(rgd_id);
    note.setNotes_type_name_lc(notes_type_name_lc);
    note.setNotes(notes);
    note.setPublic_y_n(public_y_n);
    createNote = note.createNote();
    condition = " WHERE rgd_id=" + rgd_id;
    getNote = gene.searchNotes(condition);
  }
  else if (request.getParameter("Submit_edit") != null) {
    rgd_id = Integer.parseInt(request.getParameter("rgd_id"));
    notes_type_name_lc = request.getParameter("notes_type");
    String[] notes_array = request.getParameterValues("notes");
    String[] note_key_string = request.getParameterValues("note_key");
    String public_y_n_array[] = new String[notes_array.length];
    note.log.setData_obj(data_obj);
    note.log.setUser_key(user_key);
    for (int i=0; i < notes_array.length; i++) {
    //System.out.println("notes [" + i + notes_array[i]);
      public_y_n_array[i] = 
        request.getParameter("public_flag"+Integer.parseInt(note_key_string[i]));
      note.setRgd_id(rgd_id);
      note.setNotes_type_name_lc(notes_type_name_lc);
      note.setNotes(notes_array[i]);
      note.setPublic_y_n(public_y_n_array[i]);
      //System.out.println("public type =" + public_y_n_array[i]);
      updateNote = note.updateNote(Integer.parseInt(note_key_string[i]));
    }
    condition = " WHERE rgd_id=" + rgd_id;
    getNote = gene.searchNotes(condition);
  }    
%>

  <FORM name="Form1" method="post" action="Gene_Note2.jsp">
  <CENTER>
    <TABLE width=571 border="0"  cellpadding=2 cellspacing=0 bgcolor="#CCCCCC">
			<TR bgcolor="#99CCFF" bordercolor="#99CCFF"> 
			  <TD colspan=3 align=center><b><FONT size="4" face="Geneva, Arial, Helvetica, san-serif">Genes 
				Information</FONT></b></TD>
          </TR>
          <tr bgcolor="#CCCCCC"> 
            <td colspan=3 align=center></td>
          </tr>
          <TR> 
            <TD><b>Gene Rgd_id</b></TD>
            <TD><input type=text name=rgd_id size=30 value="<%=gene.getRgd_id()%>"></TD>
            <TD><input type=submit name="get_value1" value="Get Info" onClick=check_field("rgd_id");></TD>
          </TR>
          <TR> 
            <TD><b>Gene Symbol</b></TD>
            <TD><input type=text name=gene_symbol_lc size=30 value="<%=gene.getGene_symbol_lc()%>"></TD>
            <TD><input type=submit name="get_value2" value="Get Info" onClick=check_field("gene_symbol_lc");></TD>
          </TR>
          <TR> 
            <TD><b>Full Name</b></TD>
            <TD><input type=text name=full_name size=30 value="<%=gene.getFull_name()%>"></TD>
            <TD><input type=submit name="get_value3" value="Get Info" onClick=check_field("full_name");></TD>
          </TR>
            <!--<TD> 
            <TD> 
            <TD> -->
          <TR> 
            <TD width="127"><b>Note Types</b></TD>
            <TD><% if ((request.getParameter("Create") != null)||
                   (request.getParameter("Edit") != null)) { %>
                <select name="notes_type" size="1">
                  <option value="">-- select one --</option>
            <%  for(int i = 0; i < note_types.length; i++ ) { %>              
                  <option value="<%=note_types[i]%>" 
                    <%= isSelected(request, "notes_type", note_types[i])%>>
                    -- <%=note_types[i]%> --</option>
            <% } %>  
                </select>                               
            <% } else { %>
                <select name="notes_type" size="1">
                  <option value="">-- select one --</option>
            <%  for(int i = 0; i < note_types.length; i++ ) { %>              
                  <option value="<%=note_types[i]%>" >-- <%=note_types[i]%> --</option>
            <% } %>
                </select>
            <% } %> 
            </TD>
            <TD><input type=submit name="Create" value="Create" onClick=To_create();>
                <input type=submit name="Edit" value="Edit" onClick=To_edit();>
            </TD>
          </TR>
          <tr><td>&nbsp;</td></tr>
<!--          <tr> 
            <td colspan=3 align=center height="20"></td>
          </tr> 
-->          
          <tr> 
            <td align=center height="38" colspan=3> 

   <% //===============================
        if ((request.getParameter("get_value1") != null) ||
            (request.getParameter("get_value2") != null) ||
            (request.getParameter("get_value3") != null) ||
            (request.getParameter("Submit_create") != null) ||
            (request.getParameter("Submit_edit") != null)) {
   %>
        <table width="100%" border="1" cellspacing="0" cellpadding="0">
          <% if (getNote) { %>        
				  <tr bgcolor="#99CCFF" align="center"> 
            <td><font size="2"><b>Note Key</b></font></td>
            <td><font size="2"><b>Types</b></font></td>
            <td><font size="2"><b>Notes</b></font></td>
          </tr>
          <% Note[] Notes = gene.getNote();
             for (int i = 0; i < Notes.length; i++) { 

             %>
                <tr BGCOLOR="#FFFFFF"> 
                  <td WIDTH="16%"> 
                    <center>
                      <font COLOR="#000000"><%=Notes[i].getNote_key()%></font> 
                    </center>
                  </td>
                  <td WIDTH="31%"><font COLOR="#000000"><%=Notes[i].getNotes_type_name_lc()%></font></td>
                  <td WIDTH="53%"><font COLOR="#000000"><%=Notes[i].getNotes()%></font></td>
                </tr>
            <% } 
           } else { %>
                <tr BGCOLOR="#FFFFFF"> 
                  <td WIDTH="100%" colspan=3> 
                    <center>
                      <FONT color="#FF0000">Sorry, no such gene found in the RGD databse! </FONT> 
                    </center>
                  </td>
                </tr>
           <% } %>
        </table>
  <%}%>



<%  //===========================================================          
  if (request.getParameter("Create") != null ) {
%>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			  <tr> 
				  <td><textarea name="notes" rows=6 cols=45 wrap='virtual'></textarea></td>
				  <td><div align="center"><B>Public</B>
					  <input type=radio name="public_flag" value="Y" >Yes 
					  <input type=radio name="public_flag" value="N" CHECKED>No <br></div>
				  </td>
			  </tr>
        <tr><td>&nbsp;</td></tr>
			  <tr> 
				 <td COLSPAN="3" align=center><input TYPE="submit" NAME="Submit_create" VALUE="Create Note"></td>
			  </tr>
			</table>
<%  }
    else if (request.getParameter("Edit") != null ) {
%>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
<%
        Note[] notes_ = gene.getNote();
        int notes_num = 0;
        for (int i = 0; i < notes_.length; i++) {
          note = notes_[i];
          if (note.getNotes_type_name_lc().equals(notes_type_name_lc)){
          notes_num +=1;
%>
          <tr>
             <td><input type="hidden" name="note_key" value="<%=note.getNote_key()%>">
              	<textarea name="notes" rows=5 cols=45 wrap='virtual'><%=note.getNotes()%></textarea>
             </td>
          	 <td><div align="left"><B>Public</B> 
                 <input type=radio name="public_flag<%=note.getNote_key()%>" value=Y 
                        <%= isChecked("Y", note.getPublic_y_n())%>>Yes  
                 <input type=radio name="public_flag<%=note.getNote_key()%>" value=N 
                        <%= isChecked("N", note.getPublic_y_n())%>>No<BR><br>
                        <B>Delete </B> 
					       <input type="radio" name="public_flag<%=note.getNote_key()%>" value="">
				         </div>
             </td>
          </tr>
            <%}
          } %>

          <%if (notes_num == 0) { %>
          <tr><td colspan=2 bgcolor="#FFFFFF"><font color="#FF0000">Sorry, no notes to edit on the <%=notes_type_name_lc%>
              type!</font>
          </td></tr>
          <%}else { %>
          <tr><td>&nbsp;</td></tr>
          <tr>
            <td COLSPAN="3" align=center><input TYPE="submit" NAME="Submit_edit" VALUE="Update Note"></td>
          </tr>        
          <% } %>
      </table>
<%  }
%>
      
      </td></tr>
     </TABLE></CENTER>
  </FORM> 
      
<%} else { %>
    <h2>Sorry, the Browser cannot get your username! </h2>
<% } %>
    <jsp:include page="footerarea.jsp" flush="true"/>


