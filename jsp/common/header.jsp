<% 
	String wwwroot=request.getParameter("wwwroot");
%>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr align="left"> 
    <td width="10" valign="top" background='<%= wwwroot %>/common/images/header-bkgd.gif'><img src='<%= wwwroot %>/common/images/shim.gif' width="10" height="1"></td>
    <td width="220" valign="top" background='<%= wwwroot %>/common/images/header-bkgd.gif'><img src='<%= wwwroot %>/common/images/rgd-logo.gif' width="220" height="89" border="0" usemap="#Mapheader"></td>
    <td width="200" valign="top" background='<%= wwwroot %>/common/images/header-bkgd.gif'>

    <img src='<%= wwwroot %>/common/images/header-tool.gif' width="200" height="89" border="0"></td>
	
	<td width="100%" valign="top" background='<%= wwwroot %>/common/images/header-bkgd.gif'><img src='<%= wwwroot %>/common/images/shim.gif' width="100" height="1"></td>
    <td width="280" valign="middle" background='<%= wwwroot %>/common/images/header-bkgd.gif'> 
      <table border=0 cellpadding=2 cellspacing=1 width="280">
        <form method=post action='<%= wwwroot %>/tools/rgdsearchtools/query_summary.cgi'>
          <tr> 
            <td align="left"><p class="atitle">&nbsp;<br>
                Search <input type=text name=kw size=12 value=" * for wildcard">
                <input type=button value="GO" onClick="JavaScript:document.forms[0].submit()">
				<input type=hidden name=ot value=db checked>
              </p></td>
          </tr>
          <tr> 
            <td align="left"> <p><a href='<%= wwwroot %>/tools/rgdsearchtools/advance_search.cgi' class="atitle">Advanced Search</a> 
                &nbsp; </p></td>
          </tr>
        </form>
      </table></td>
    <td width="20" valign="top" background='<%= wwwroot %>/common/images/header-bkgd.gif'><img src='<%= wwwroot %>/common/images/shim.gif' width="20" height="1"></td>
  </tr>
</table>
<map name="Mapheader">
  <area shape="rect" coords="92,25,218,72" href='<%= wwwroot %>' alt="RGD Home">
</map>

