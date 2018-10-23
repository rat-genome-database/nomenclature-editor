<%-- *********************
Program Name - Nomen_Event.jsp
Programmer -  jiali chen
Creation Date - 07/10/2002
Description - This program generates nomen event screen.

Modification log: none
***********************--%>
<SCRIPT>
function check_field() {
   if(document.myForm.ref_key.value == '' ||document.myForm.ref_key.value == ' ')  {
      alert("Please Enter Ref Key");
      //document.myForm.ref_key.focus();
      return;
   }
   else if(isNaN(document.myForm.ref_key.value) == true) {
      alert("Ref Key must be numeric.");
      return;
   }
   if(document.myForm.nomen_status_type.selectedIndex <= 0) {  
      alert("Please select Nomen Status Type.");
      return;
   }
   if((document.myForm.new_desc.value==''||document.myForm.new_desc.value==' ') &&
      (document.myForm.description_list.selectedIndex <= 0)) {
      alert("Please select Description or enter new Description.");
      return;
   }
   document.myForm.submit();
}

</SCRIPT>

<%@ page language="java" import="online.*, common.*, manager.*,java.net.*, java.text.*"%>
<%@ include file="curation_lib.jsp"%>

<jsp:useBean id="gene" scope="session" class="online.Gene" />
<jsp:useBean id="nomen_event" scope="session" class="online.Nomen_event" />
<jsp:useBean id="dtset" scope="session" class="online.Data_set" />
<%
  String event = (String)session.getAttribute("event");
  // initialize db handler via Servlet Context
  ServletContext context = request.getSession(true).getServletContext();
  DatabaseObj dbObj = (DatabaseObj)context.getAttribute("DEVHDL");
  if(dbObj == null) {
   dbObj = new DatabaseObj("dev_1");
   context.setAttribute("DEVHDL",dbObj);
  }
  gene.setContext(context);
  nomen_event.setContext(context);

  int rgd_id = gene.getRgd_id();
  if(event.equals("merge")) {
     // coming from Merge screen
     Gene[] geneAry = dtset.getGene();
     //rgd_id = geneAry[0].getRgd_id();
     rgd_id = geneAry[1].getRgd_id();
  }
  String[] nomen_status_type = nomen_event.getNomen_status_types();  
// don't show desc for now
//  String[] type_desc = nomen_event.getDescriptions();
//  Date now = new Date();
//  String mydate = DateFormat.getDateInstance().format(now);

  Nomen_event[] nomenEvent = gene.searchNomen_event(rgd_id);
  int len = nomenEvent.length;
%>
  <FORM action="Create_Nomen.jsp" method=post name=myForm>
  <CENTER>
		 <table border="0" bgcolor="#FFFFFF" align="center">
			<TR BGCOLOR="#CCCCCC">
			  <TD colspan=2 bordercolor="#CCCCCC">
        rgd id: <%=rgd_id%><CENTER><b>Nomen Event Information</b></CENTER>
			  </TD>
			</TR>
      <TR><td colspan=2>&nbsp;</td></TR> 
<%
  // display status
  if(len > 0 ) {
%>
     <TR><TD colspan=2><table border="1" bgcolor="#FFFFFF" align="center">
     <tr><td><b>Nomen Status Type</b></td><td><b>Nomen Event Date</b></td></tr>
<%
     for (int i = 0; i < nomenEvent.length; i++) {
%>              
        <tr><td><font size=2><%=nomenEvent[i].getNomen_status_type()%></font></td>
          <td><font size=2><%=nomenEvent[i].getEvent_date()%></font></td></tr>
<%
   } //end of for
%>
    </table></TD></TR>
<%
  }  //end of if
%>
      <TR><td colspan=2>&nbsp;</td></TR>
      <TR>
        <td><b>Ref Key</b></td>
        <td><input type=text size=20 name=ref_key value=""></td>
      </TR> 
      <TR>
        <td><b>Status</b></td>
        <td><select name="nomen_status_type" size="1">
            <option value="">--select one from list--</option>
 <%   
    for(int i = 0; i < nomen_status_type.length; i++ ) { 
 %>              
      <option value="<%=nomen_status_type[i]%>"><%=nomen_status_type[i]%></option>
 <% } %>                   
          </select> </td>
      </TR>   
      <TR>
        <td><b>Description</b></td>
        <td><select name="description_list" size="1">
                  <option value="">--select from list or type below--</option>                
                  <option value="Symbol and Name updated">Symbol and Name updated</option>
                  <option value="Symbol updated">Symbol updated</option>
                  <option value="Name updated">Name updated</option>
                  <option value="Symbol and Name updated to reflect Human and Mouse nomenclature">Symbol and Name updated to reflect Human and Mouse nomenclature</option>
                  <option value="Symbol updated to reflect Human and Mouse nomenclature">Symbol updated to reflect Human and Mouse nomenclature</option>
                  <option value="Name updated to reflect Human and Mouse nomenclature">Name updated to reflect Human and Mouse nomenclature</option>
                  <option value="Symbol and Name withdrawn">Symbol and Name withdrawn</option>
                  <option value="Symbol withdrawn">Symbol withdrawn</option>
                  <option value="Name withdrawn">Name withdrawn</option>
                  <option value="Data Merged">Data Merged</option>
            </select></td>
      </TR>
      <TR>
        <td>&nbsp;</td>
        <td><textarea rows="3" cols="45" NAME="new_desc" wrap="virtual"></textarea></td>
      </TR>
      <TR>
        <td><b>Notes</b></td><td><input type="text" size=70 name="notes" value=""></td>
      </TR>
      <TR>
        <td><b>Event Date</b></td>
        <td><input type=text size=30 name=event_date value="<%=new java.util.Date().toString()%>"></td>
      </TR>
      <TR><td colspan=2>&nbsp;</td></TR>
      <TR><td colspan=2><input type="button" name="create" value="Create Nomen Event" onClick=check_field()></td></TR>
		  </table>
</CENTER>
</FORM>
