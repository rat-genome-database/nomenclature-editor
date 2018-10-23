<% 

    String wwwroot1=request.getParameter("wwwroot"); 

    String url8=request.getParameter("headfootroot")+"common/table-end.jsp";
    String url9=request.getParameter("headfootroot")+"common/contentareas.jsp";
    String url10=request.getParameter("headfootroot")+"common/footer.jsp";
%>

<jsp:include page="<%=url8%>" flush="true" >
	<jsp:param name="wwwroot" value="<%=wwwroot1%>" />
</jsp:include>
<jsp:include page="<%=url9%>" flush="true" >
	<jsp:param name="wwwroot" value="<%=wwwroot1%>" />
</jsp:include>
<jsp:include page="<%=url10%>" flush="true" >
	<jsp:param name="wwwroot" value="<%=wwwroot1%>" />
</jsp:include>


