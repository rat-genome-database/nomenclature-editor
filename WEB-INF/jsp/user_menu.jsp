<%@ page contentType="text/html;charset=windows-1252"%>
<%
  String user_group = request.getParameter("user_group");
  String username = request.getParameter("username");
%>

  <jsp:include page="middle.jsp"  flush="true">
    <jsp:param name="user_group" value="<%=user_group%>"/>
    <jsp:param name="title" value="Curation: Online"/>
    <jsp:param name="username" value="<%=username%>"/>
    <jsp:param name="func" value="curation"/>
  </jsp:include>
 



