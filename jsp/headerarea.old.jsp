<%@ page import="java.io.*, java.util.*"%>
<link rel=stylesheet type="text/css" href="http://<%=request.getServerName()%>/common/style/rgd_styles.css">
<% 
  String wwwroot = null;
  String headfootroot=null;
  String property_path="T://jiali//RGD//curation//doc//rgd_config.properties";
  //String property_path="/rsch_oracle/home/roracle/product/ias/j2ee/admin/rgd_config.properties";
  
  Properties toolProperty=new Properties();
  toolProperty.load(new FileInputStream(property_path));  
  wwwroot=toolProperty.getProperty("WWW_ROOT");
  headfootroot=toolProperty.getProperty("HEAD_FOOT_ROOT");
  
  String url1=headfootroot+"common/body.jsp";
  String url2=headfootroot+"common/header.jsp";
  String url3=headfootroot+"common/contentareas.jsp";
  String url4=headfootroot+"common/data-menu.jsp";
  String url5=headfootroot+"common/table-begin.jsp";
  String url6=headfootroot+"common/links.jsp";
  String url7=headfootroot+"common/table-middle.jsp";  
%>

<jsp:include page="<%=url1%>" flush="true" >
  <jsp:param name="wwwroot" value="<%=wwwroot%>" />
</jsp:include>
<jsp:include page="<%=url2%>" flush="true" >
	<jsp:param name="wwwroot" value="<%=wwwroot%>" />
</jsp:include>
<jsp:include page="<%=url3%>" flush="true" >
	<jsp:param name="wwwroot" value="<%=wwwroot%>" />
</jsp:include>
<jsp:include page="<%=url4%>" flush="true" >
	<jsp:param name="wwwroot" value="<%=wwwroot%>" />
</jsp:include>
<jsp:include page="<%=url5%>" flush="true" >
	<jsp:param name="wwwroot" value="<%=wwwroot%>" />
</jsp:include>
<jsp:include page="<%=url6%>" flush="true" >
	<jsp:param name="wwwroot" value="<%=wwwroot%>" />
</jsp:include>
<jsp:include page="<%=url7%>" flush="true" >
	<jsp:param name="wwwroot" value="<%=wwwroot%>" />
</jsp:include>
