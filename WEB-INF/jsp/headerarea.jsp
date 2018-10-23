<%@ page import="java.io.*, java.util.*" %>
<jsp:useBean id="prop" class="common.ChoosePropertyFile"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>	
  <meta name="keywords" content="rat genome database,rat genome,rgd">
  <meta name="description" content="the rat genome database contains rat genomic data such as genes,sslps,qtls,strains,rhmap,sequences and tools such as vcmap,genome scanner, rhmap server,metagene,and hosts rat comunity forum.">

  <meta name="author" content="rgd">
 <link rel="SHORTCUT ICON" href="/favicon.ico" />
 <link href="/common/style/rgd_styles.css" rel="stylesheet" type="text/css" />
	
<meta name="generator" content="WebGUI 7.4.8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<script type="text/javascript">
function getWebguiProperty (propName) {
var props = new Array();
props["extrasURL"] = "/extras/";
props["pageURL"] = "/wg/template";
return props[propName];
}
</script>

<meta http-equiv="Cache-Control" content="must-revalidate" />
	<title>Rat Genome Database</title>
	
</head>

<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-2739107-2";
urchinTracker();
</script>

<script type="text/javascript" src="/common/js/ddtabmenu.js">

/***********************************************
* DD Tab Menu script- � Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/

</script>

<script type="text/javascript" src="/common/js/rgdHomeFunctions.js">
</script>



<!-- CSS for Tab Menu #4 -->
<link rel="stylesheet" type="text/css" href="/common/style/ddcolortabs.css" />


<body>

<div id="wrapper">
<div id="main">
	<div class="top-bar">
<table width="100% border="1" class="headerTable"> <tr><td align="left" style="color:white;">&nbsp;&nbsp;&nbsp;

<!--
<img src="http://rgddev.mcw.edu/newSite/mostpopular.png">&nbsp;
		<a href="">Genes</a>&nbsp;|&nbsp;
		<a href="">Strains</a>&nbsp;|&nbsp;
		<a href="">QTLs</a>&nbsp;|&nbsp;
		<a href="">SSLPs</a>&nbsp;|&nbsp;
		<a href="">Reference</a>
-->
</td><td align="right" style="color:white;"><a href="/tu">Help</a>&nbsp;|&nbsp;
		<a href="ftp://rgd.mcw.edu/pub">FTP Download</a>&nbsp;|&nbsp;
		<a href="/wg/citing-rgd">Citing RGD</a>&nbsp;|&nbsp;
				<a href="/contact/index.shtml">Contact Us</a>&nbsp;&nbsp;&nbsp;
</td></tr></table>
	</div>


<!--
<table><tr><td>
       <a class="homeLink" href="/wg/home"><img border="0" src="/common/images/rgd_LOGO_blue_rgd_small.gif"></a>
       </td>
       </tr>
       </table>
-->
<table width="100%">
<tr>
	<td>
	<table><tr><td>
       <a class="homeLink" href="/wg/home"><img border="0" src="/common/images/rgd_LOGO_blue_rgd.gif"></a>
       </td>
       </tr>
       </table>

</td>
<td align="right">

      <div class="searchBorder">
      <table border=0 cellpadding=0 cellspacing=0 width="220">
        <form method="post" action='/generalSearch/RgdSearch.jsp' onSubmit="return verify(this);">     
          <tr> 
            <td class="atitle" align="right">                <input type=text name=searchKeyword size=12 value=" * for wildcard" onFocus="JavaScript:document.forms[0].searchKeyword.value=''" class="searchKeywordSmall">

                <input type="hidden" name="quickSearch" value=1>

              </td>
            <td><input type=submit value="Search" class="searchButtonSmall"> </td>
          </tr>
        </form>
      </table>
      </div>
</td>
<td>&nbsp;&nbsp;</td>
</tr>
</table>








<div id="ddtabs4" class="ddcolortabs">
<ul>
<li class="current" style="margin-left: 1px"><a href="/"  rel="ct1"><span>Home</span></a></li>
<li><a href="/data-entry.shtml" rel="ct2"><span>Data</span></a></li>
<li><a href="/tool-entry.shtml" rel="ct3"><span>Tools</span></a></li>
<li><a href="/dportal" rel="ct4"><span>Diseases</span></a></li>

<li><a href="javascript:void(0)" rel="ct5"><span>Genome</span></a></li>
<li><a href="/community-entry.shtml" rel="ct6"><span>Community</span></a></li>
</ul>
</div>
<div class="ddcolortabsline">&nbsp;</div>

<!--<div style="width:100%; height:5px; font-size:1px; background-color: #2865a3">&nbsp;</div>-->

<DIV class="tabcontainer">

<div id="ct1">
<div id="subnav">
     <ul>
<li class=first><a href="/about.shtml"  rel="ct1"><span>About Us</span></a></li>

<li><a href="http://labs.rgd.mcw.edu/files/Rat%20Genome%20Database%20Yearly%20Report%20Sept 2007.doc" rel="ct2"><span>Yearly Report</span></a></li>
     </ul>
</div>
</div>

<div id="ct2" class="tabcontent">
<div id="subnav">
     <ul>
     <li class=first><a href="/genes" rel="ct1"><span>Genes</span></a></li>
     <li><a href="/objectSearch/qtlQuery.jsp" rel="ct2"><span>QTLs</span></a></li>

     <li><a href="/strains" rel="ct3"><span>Strains</span></a></li>
     <li><a href="/objectSearch/sslpQuery.jsp" rel="ct4"><span>SSLPs</span></a></li>
     <li><a href="/maps" rel="ct3"><span>Maps</span></a></li>
     <li><a href="/gviewer/Gviewer.jsp" rel="ct5"><span>Ontologies</span></a></li>
     <li><a href="/sequences" rel="ct6"><span>Sequences</span></a></li>

     <li><a href="/references" rel="ct7"><span>References</span></a></li>
     <li><a href="ftp://rgd.mcw.edu/pub/" rel="ct7"><span>FTP Download</span></a></li>
     <li><a href="/registration-entry.shtml" rel="ct7"><span>Submit Data</span></a></li>
     </ul>
</div>
</div>

<div id="ct3" class="tabcontent">
<div id="subnav">
     <ul>

     <li class=first><a href="http://gray.hmgc.mcw.edu/mailman/listinfo/rat-forum" rel="ct1"><a href="/VCMAP" rel="ct1"><span>VCMap</span></a></li>
     <li><a href="http://biomart.mcw.edu/" rel="ct2"><span>BioMart</span></a></li>
     <li><a href="/gviewer/Gviewer.jsp" rel="ct3"><span>Ontology Search</span></a></li>
     <li><a href="/sequenceresources/gbrowse.shtml" rel="ct4"><span>Rat GBrowse</span></a></li>
     <li><a href="/sequenceresources/blast.shtml" rel="ct5"><span>BLAST</span></a></li>
     <li><a href="/sequenceresources/blat.shtml" rel="ct6"><span>BLAT</span></a></li>

     <li><a href="/ACPHAPLOTYPER" rel="ct7"><span>ACP Haplotyper</span></a></li>
     <li><a href="/tool-entry.shtml" rel="ct8"><span>More Tools...</span></a></li>
</div>
</div>

<div id="ct4" class="tabcontent">
<div id="subnav">
     <ul>
     <li class=first><a href="/dportal/cardiovascular/" rel="ct1"><span>Cardiovascular Disease Portal</span></a></li>
     <li><a href="/dportal/neurological" rel="ct2"><span>Neurological Disease Portal</span></a></li>

     <li><a href="/tools/diseases/disease_search.cgi" rel="ct3"><span>More Diseases...</span></a></li>
     </ul>
</div>
</div>

<div id="ct5" class="tabcontent">
<div id="subnav">
     <ul>
     <li class=first><a href="/sequenceresources/gbrowse.shtml" rel="ct1"><span>Rat GBrowse</span></a></li>
     <li ><a href="/gbreport/gbrowser_error_conflicts.shtml" rel="ct3"><span>Genome Conflicts</span></a></li>

     </ul>
</div>
</div>

<div id="ct6" class="tabcontent">
<div id="subnav">
     <ul>
     <li class=first><a href="/nomen/nomen.shtml" rel="ct1"><span>Nomenclature</span></a></li>
     <li ><a href="http://gray.hmgc.mcw.edu/mailman/listinfo/rat-forum" rel="ct1"><span>Rat Community Forum (RCF)</span></a></li>
     <li ><a href="http://labs.rgd.mcw.edu/" rel="ct2"><span>RGD Labs</span></a></li>

     <li ><a href="/registration-entry.shtml" rel="ct2"><span>Submit Data</span></a></li>
     </ul>
</div>
</div>


</DIV>

<script>

if (location.href.indexOf("http://rgd.mcw.edu") == -1 &&
	location.href.indexOf("http://www.rgd.mcw.edu") == -1 &&
    location.href.indexOf("http://osler") == -1 &&
    location.href.indexOf("http://horan") == -1 &&
    location.href.indexOf("http://preview.rgd.mcw.edu") == -1) {

	document.getElementById("curation-top").style.visibility='visible';
}

ddtabmenu.definemenu("ddtabs4", getTabIndex()) //initialize Tab Menu
</script>
	<div id="mainBody">
		<div id="contentArea" class="content-area">

			<div><a name="idP3NCutd0YL42RjiwRAMqwg" id="idP3NCutd0YL42RjiwRAMqwg"></a></div>







<div class="layoutColumnPadding">
