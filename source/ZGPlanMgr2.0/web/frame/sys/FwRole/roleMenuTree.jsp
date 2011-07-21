<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-cn" lang="zh-cn">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
	<base href="<%=basePath%>" />
	<title>NavTree</title>
	<%@ include file="/commons/meta.jsp" %>
	<%@ include file="/commons/ext.jsp" %>
	<script type="text/javascript" src="${ctx}/explorer/tree/NavTreePanel.js"></script>
	<script src="${ctx}/dwr/interface/ExplorerTreeAction.js" type=""></script>
	<script type="text/javascript">
		var navTreePanel = null;
		Ext.onReady(function() {
			var navTreePanel = new DRM.NTTreePanel({
				region : 'center',
				width:200,
				templateId	:	'2',
				isInit		: true
			});
			navTreePanel.on("_click",function(orgArgs, extArgs){
				var orgId = orgArgs.node.attributes.cuid;
				top.bodyFrame.document.getElementById("employee").src = '${ctx}/frame/sys/FwEmployee/list.do?s_orgId='+orgId;
			});
			var viewport = new Ext.Viewport({
			    layout:"border",
			    items:[navTreePanel]
			});
		});
	</script>

  </head>
  
  <body>
	
  </body>
</html>
