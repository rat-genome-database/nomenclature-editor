<%-- *********************
Program Name - Nomen.jsp
Programmer -  jiali chen
Creation Date - 07/05/2002

$Header: /var/lib/cvsroot/Development/RGD/curationTools/nomenclature/jsp/Nomen.jsp,v 1.2 2007/09/10 18:36:00 jdepons Exp $
$Revision: 1.2 $
$Date: 2007/09/10 18:36:00 $

Description - This program allows user to select an EVENT from EVENT list they want to work on.
upon the submmission, different interfaces are displayed for user to proceed process.

Modification log:
 4/27/07 - Updated for port to tomcat by George Kowalski

***********************--%>
<%@ page language="java" import="online.*, common.*, java.net.*, java.text.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ include file="curation_lib.jsp"%>
<%@ include file="headerarea.jsp"%>
<SCRIPT>
function submit_info(event) {

   if (1==0) { 
   //if(document.myForm.obj_list.selectedIndex <= 0 )  {
   //   alert("Please select object");
   //   return;
   }
//   else if(document.myForm.event_list.selectedIndex <= 0) {  
//      alert("Please select event you want to create");
//      return;
//   }
   else {
//    var event=document.myForm.event_list.options[document.myForm.event_list.selectedIndex].value;
      var object=document.myForm.obj_list.options[document.myForm.obj_list.selectedIndex].value;

      if(event == "editCurrent") {
        if(document.myForm.gene_symbol.value == '' && document.myForm.rgd_id.value == '') {
            alert("Please enter either Gene Symbol or Rgd ID");
            return;
        }
        // all required fields have been entered
        else {
          var symbol =document.myForm.gene_symbol.value;
          var rgdid =document.myForm.rgd_id.value;
          if(rgdid) {
            if(isNaN(rgdid) == true) {
              alert("Rgd ID must be numeric.");
              return;             
            }
            else {
              window.location.href = "Edit_Object.jsp?EVENT="+event+"&OBJECT="+object+"&RGDID="+rgdid;
            }
          }
          else {
            window.location.href = "Edit_Object.jsp?EVENT="+event+"&OBJECT="+object+"&SYMBOL="+symbol;
          }
        }
      }
      else if(event == "merge") {
        if((document.myForm.gene_symbol_one.value=='' && document.myForm.rgd_id_one.value=='')||
           (document.myForm.gene_symbol_two.value=='' && document.myForm.rgd_id_two.value=='')) {
           alert("Please enter either a pair of Gene Symbols or Rgd IDs");
           return;
        }
        else if(document.myForm.gene_symbol_one.value && document.myForm.gene_symbol_two.value=='') {
           alert("Please enter a pair of Gene Symbols");
           return;
        }
        else if(document.myForm.rgd_id_one.value && document.myForm.rgd_id_two.value=='') {
           alert("Please enter a pair of Rgd Ids");
           return;
        }
        // all required fields have been entered
        else {     
           var sym1 =document.myForm.gene_symbol_one.value;
           var sym2 =document.myForm.gene_symbol_two.value;
           var id1 =document.myForm.rgd_id_one.value; 
           var id2 =document.myForm.rgd_id_two.value;
           if(sym1 && sym2)  {
             window.location.href = "Merge_Edit_Obj.jsp?EVENT="+event+"&OBJECT="+object+"&SYMONE="+sym1+"&SYMTWO="+sym2;
           }
           else {
             if( ((isNaN(id1))==true || (isNaN(id2)) == true) ) {
                alert("Rgd ID must be numeric.");
                return;
             }
             else  {          
               window.location.href = "Merge_Edit_Obj.jsp?EVENT="+event+"&OBJECT="+object+"&RGDONE="+id1+"&RGDTWO="+id2;
             }
           }
        }
      }      
   }
}


function create_history() {
   var oldid = document.myForm.old_rgd_id.value;
   var newid = document.myForm.new_rgd_id.value;

   if(oldid && newid) {
     if((isNaN(oldid))==false && (isNaN(newid)) == false) {
       window.location.href = "Retirement.jsp?OLDRGD="+oldid+"&NEWRGD="+newid;
     }
     else {
       alert("RGD ID must be numeric.");
       return;
     }
   }
   else {
      alert("RGD ID cannot be blank");
      return;
   }  
}

</SCRIPT>

<!-- ======================================================================= -->
<%
String username = (String)session.getAttribute("username");
//System.out.println("username--nomen"+username);
String user_group = (String)session.getAttribute("user_group");
if(username!=null) {
%>
  <jsp:include page="user_menu.jsp"  flush="true">
    <jsp:param name="highlighted" value="No2"/>
    <jsp:param name="user_group" value="<%=user_group%>"/>
    <jsp:param name="username" value="<%=username%>"/>
  </jsp:include>

<%
String event = request.getParameter("event_list");
session.setAttribute("event", event);
//System.out.println("event_list" + event);
String object = request.getParameter("obj_list");
session.setAttribute("data_obj", object);

//String fid = request.getParameter("FormID");
//System.out.println("fid"+ fid);
//if(fid != null && fid.equals("next"))  {
%>

  <FORM name=myForm action=Nomen.jsp method=post>
    <CENTER>
    <TABLE border=0>
      <TBODY>
<%
    if(event == null) {
%>
        <TR>
          <TD>Select Event</TD>
          <TD align=left>
            <SELECT size=1 name=event_list onChange=javascript:document.myForm.submit();> 
            <OPTION value="">-- select one --</OPTION>
            <OPTION value="editCurrent" <%= isSelected(request, "event_list", "editCurrent")%>>-- Edit Current --</OPTION>
            <OPTION value="merge" <%= isSelected(request, "event_list", "merge")%>>-- Merge --</OPTION>
            <OPTION value="retirement" <%= isSelected(request, "event_list", "retirement")%>>-- Retirement --</OPTION>
            <!--<option value="split" <%= isSelected(request, "event_list", "split")%>>-- Split --</option>
            <option value="spliceVariant" <%= isSelected(request, "event_list", "spliceVariant")%>>-- Splice Variant --</option>
            <OPTION value="retirement" <%= isSelected(request, "event_list", "retirement")%>>-- Retirement --</OPTION>-->              
            </SELECT></TD>
        </TR>
<% }
if(event != null) {
  if(event.equals("editCurrent")) {
%>
   <TR>
			  <TD colspan=3 align=center><b>Edit Current Object</b></TD>
	 </TR>
   <tr><td>&nbsp;</td></tr> 
        <TR>
          <TD>Select Object</TD>
          <TD align=left>
            <SELECT size=1 name=obj_list> 
            <OPTION value="">-- select one --</OPTION>
            <OPTION value="genes" <%= isSelected(request, "obj_list", "genes")%>>-- Genes --</OPTION></SELECT></TD>
        </TR>       
        <TR>
          <TD>Enter Symbol</TD>
          <TD align=left> <input type=text name=gene_symbol value=""></TD>
        </TR>
        <TR>
          <TD>OR Rgd ID</TD>
          <TD align=left> <input type=text name=rgd_id value=""></TD>
        </TR>
      <TR>
        <TD>&nbsp;</TD>
        <TD>
				<INPUT type=button value="submit data" name=submit_btn onClick="submit_info('editCurrent');"></TD>
      </TR> 
<%
  }
  else if(event.equals("merge")) {
%>
   <TR>
			  <TD colspan=3 align=center><b>Merge Objects</b></TD>
	 </TR>
   <tr><td>&nbsp;</td></tr>   
        <TR>
          <TD>Select Object</TD>
          <TD align=left colspan=2>
            <SELECT size=1 name=obj_list> 
                <OPTION value="genes">-- Genes --</OPTION></SELECT></TD>            
            <!--
            <OPTION value="">-- select one --</OPTION>
            <OPTION value="genes" <%= isSelected(request, "obj_list", "genes")%>>-- Genes --</OPTION></SELECT></TD>
            -->
        </TR>

        <tr>
          <td>&nbsp;</td>
          <td><font color="FF0000" size=2><b>(merge from)</b></font></td>
          <td><font color="FF0000" size=2><b>(merge to)</b></font></td>
        </tr>
        
        <TR>
          <TD>Enter Symbols</TD>
          <TD align=left> <input type=text name=gene_symbol_one value=""></td>
          <td><input type=text name=gene_symbol_two value=""></TD>
        </TR>
        <TR>
          <TD>OR Rgd IDs</TD>
          <TD align=left> <input type=text name=rgd_id_one value=""></td>
          <td><input type=text name=rgd_id_two value=""></TD>
        </TR>
       <TR>
          <TD>&nbsp;</TD>
          <TD>
				  <INPUT type=button value="submit data" name=submit_btn onClick="submit_info('merge');"></TD>
       </TR> 
<%
  }
  else if(event.equals("retirement")) {
%>
   <TR>
			  <TD colspan=3 align=center><b>Create History Entry</b></TD>
	 </TR>
   <tr><td>&nbsp;</td></tr>   
   <TR><TD>Old&nbsp;RGD_ID</TD>
       <TD><INPUT TYPE="TEXT" SIZE="10" NAME="old_rgd_id" VALUE=""></TD>
       <td><font size=-1>RGD ID of object to be retired</font></TD>
   </TR>
   <TR><TD>New&nbsp;RGD_ID</TD>
       <TD><INPUT TYPE="TEXT" SIZE="10" NAME="new_rgd_id" VALUE=""></TD>
       <td><font size=-1>RGD ID(s) of new object(s). Comma separate new IDs if splitting.</font></td>
   </TR>
   <TR><TD>&nbsp;</TD><TD><input type="button"  value="Create History Entry" onClick=create_history();>
       </TD><td>&nbsp;</td>
   </TR>
   
<%
  }
 }
%>
      </TBODY></TABLE></CENTER>
  </FORM> 
<%} else { %>
   <h2>Sorry, the Browser cannot get your username! Try again!</h2>
<%}%>
<jsp:include page="footerarea.jsp" flush="true" />

