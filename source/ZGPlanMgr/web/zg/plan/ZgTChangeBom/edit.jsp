<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.boco.zg.plan.base.model.*"%>
<%@page import="cn.org.rapid_framework.page.*"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/commons/taglibs.jsp"%>
<%@ taglib uri="/framework/tag" prefix="fw"%>
<%
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<html>
	<head>
		<base href="<%=basePath%>" />
		<title><%=ZgTorderPlan.TABLE_ALIAS%> 维护</title>
		<%@ include file="/commons/meta.jsp"%>
		<%@ include file="/commons/jquery.jsp"%>
		<link href="${ctx}/widgets/extremecomponents/extremecomponents.css"
			type="text/css" rel="stylesheet" />
		<link type="text/css" href="${ctx}/resources/css/${_theme}/frame.css"
			rel="stylesheet" />
		<script type="text/javascript" src="${ctx}/dwr/interface/ZgTBomManagerDwrAction.js"></script>
		<style>
.extendTd {
	
}

.extendTd .extendBtn {
	height: 18px;
}

.extendTd .extendBtn img {
	cursor: pointer;
	width: 16px;
	height: 18px;
}

.extendTd .extendBtn label {
	height: 18px;
	line-height: 18px;
}

#matnrListDiv {
	width: 15%;
	height: 100%;
	float: left;
	text-align: center;
}

#matnrChildListDiv {
	width: 84%;
	height: 100%;
	float: left;
	overflow: auto
}

#matnrListDiv ul {
	border: 1px solid #d0e5f5;
	text-align: left;
}

#matnrListDiv ul li {
	cursor: pointer;
	font-size: 120%;
}

#matnrListDiv ul li:hover {
	color: red;
	font-weight: bold;
}

#matnrCode {
	font-size: 130%;
	font-weight: bold;
	background-color: #d0e5f5;
	line-height: 20px;
	color: #1d5987;
}
</style>
		<script type="text/javascript">
		$(function() {
			initAutoComplete("${ctx}/autoComplate/findRelationData.do");
			doLayout();
			$(window).bind("resize",doLayout);
			$("form:first").submit();
		});
		
		
		function doLayout() {
			var maxHeight = top.getContentHeight();
			document.getElementById("_orderPanel").style.height = maxHeight + 'px';
			var headTableH = document.getElementById("headTable").offsetHeight;
			var orderTableH= document.getElementById("orderTable").offsetHeight;
			var listFrameH = maxHeight - headTableH-orderTableH;
			document.getElementById("listFrame").style.height = listFrameH + 'px';
		}
		
		var orderID ="";
		
		
		function addStorage(){
			butsetDisable(true);
			var items=document.frames('listFrame').document.getElementsByName("items");
			if(items.length<=0){
				alert('请添加物料');
					butsetDisable(false);
				return;
			}
			var buildupSubmitParams=document.frames('listFrame').buildupSubmitParams();
			ZgTBomManagerDwrAction.saveChangOrderBom(buildupSubmitParams,function(data){
				if(data=="success") {
					var form=document.forms[0];
					 form.target="_self";
					form.action="${ctx}/zg/plan/ZgTBomManager/save.do?update=true";
					form.submit();
				}else {
					alert("系统繁忙，请稍后再试");
						butsetDisable(fasle);
				}
			});
			

		}
		
		function submitStorage(){
			butsetDisable(true);
			var items=document.frames('listFrame').document.getElementsByName("items");
			if(items.length<=0){
				alert('请添加物料');
					butsetDisable(fasle);
				return;
			}
			for(var i=0;i<items.length;i++){
			wait_back_num=document.frames('listFrame').document.getElementById('WAIT_BACK_NUM_'+i).value;
			if(wait_back_num==0){
			    alert('换料数量为0，请更改');
			    	butsetDisable(false);
				return;
			}
			}
			if(wait_back_num==0){
			    alert('换料数量为0，请更改');
			    	butsetDisable(false);
				return;
			}
			var buildupSubmitParams=document.frames('listFrame').buildupSubmitParams();
			ZgTBomManagerDwrAction.saveChangOrderBom(buildupSubmitParams,function(data){
				if(data=="success") {
					var form=document.forms[0];
					 form.target="_self";
					form.action="${ctx}/zg/plan/ZgTBomManager/submit.do?update=true";
					form.submit();
				}else {
					alert("系统繁忙，请稍后再试");
						butsetDisable(false);
				}
			});
		}
		
			function butsetDisable(state){
			var btns=document.getElementsByName("submitBtn");
			if(btns!=null){
				for(var v=0;v<btns.length;v++){
					btns[v].disabled = state;
				}
			}
			
		}
	</script>
	</head>
	<body>
		<%@ include file="/commons/messages.jsp"%>
<div id="_orderPanel" style="height:100px">		
		<form action="${ctx}/zg/plan/ZgTBomManager/findBomListByPlanID.do?id=${model.cuid}" method="post" target="listFrame" >
			<input type="hidden" id="cuid" name="cuid" value="${model.cuid}" />
			<table id="headTable" width="100%" cellpadding="0" cellspacing="1"
				style="border: 1px solid #A8CFEB;">
				<thead>
					<tr>
						<td class="formToolbar">

							<div class="button" style="text-align: left;">
							  <c:if test="${model.state =='-8'}">
								<a href="javascript:addStorage()"  name="submitBtn" ><span><img src="<%=iconPath%>/icon_tool_049.gif" />保存</span></a>
								</c:if>
								<c:if test="${model.state =='-7'||model.state =='-8'}">
								<a href="javascript:submitStorage()"  name="submitBtn" ><span><img src="<%=iconPath%>/true.gif" />提交</span></a>
								</c:if>
								<a href="javascript:if(parent.doQuery)parent.doQuery()"  name="submitBtn" ><span><img src="<%=iconPath%>/ico_007.gif" />返回</span></a>
							</div>
						</td>
					</tr>
				</thead>
			</table>

			<table id="orderTable" class="formitem" width="100%" cellpadding="0" cellspacing="1"
				style="border-top: 1px solid #A8CFEB; margin-top: 3px;">
				<thead>
					<tr>
						<td class="title" colspan="10">
							<img src="${ctx }/resources/images/frame/ico_noexpand.gif"
								style="cursor: pointer" title="高级查询" alt="" id="img_1"
								border="0" onclick="changeV('1')" />
									<c:if test="${model.planType=='CHANGE'}">换料申请单</c:if>
								<c:if test="${model.planType=='BACK'}">退料申请单</c:if>
								<c:if test="${model.planType=='RENEW'}">退料申请单</c:if>：${model.cuid}
						</td>
					</tr>
				</thead>
				<tbody id="tbody_1" style="display: block">
					<tr>
						<td colspan="10"
							style="border: 1px solid #A8CFEB; border-width: 0 0 1px 0;">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="20"></td>
								</tr>
							</table>
						</td>
					</tr>
					
							<tr>
						<th>
							单据日期：
						</th>
						<td width="15%">
						
									<fmt:formatDate value="${model.create_date}" pattern="yyyy-MM-dd HH:mm:ss" />
						<input type="hidden" id="planType" name="planType"  value="${ model.planType}"/>
							</td>
			<th>
							订单号：
						</th>
						<td width="15%">
							${model.orderTaskId_related.value}
							<input type="hidden" id="orderId_value" name="orderTaskId" value="${model.orderTaskId }"/>
						</td>
						<th>
							物料等级：
						</th>
						<td width="12%">
						
							<input type="hidden" id="extend1"  name="extend1" value="${model.extend1}"/>
							${model.extend1}
						</td>
						</tr>
						<tr>	
						<th>
							生产厂：
						</th>
						<td width="5%">
						${model.plant}
						<input type="hidden"  readonly="true" name="plant" id="plant" value="${model.plant}"/>
						</td>
						<th>
							生产线：
						</th>
						<td width="5%">
						${orderTask.arbpl}
						<input type="hidden"  readonly="true" name="arbpl" id="arbpl" value="${orderTask.arbpl}"/>
						</td>

						<th>
							录单人：
						</th>
						<td width="15%">
							${operatorInfo.userName}
							<input type="hidden" id="userId" name="userId"
								value="${model.userId}" />
						</td>

					</tr>
					<tr>	
						<th>
							备注：
						</th>
						<td colspan="5">
						<textarea name="zbz" id="zbz" onpropertychange="if(value.length>85) value=value.substr(0,85)"
								 cols=100 rows=2>${model.zbz }</textarea>
						</td>
				
					</tr>
				</tbody>
			</table>
		</form>
			<iframe id="listFrame" src="" name="listFrame" frameborder="0" width="100%" height="100%" scrolling="no"></iframe>
		</div>
				
	  
	  
	

	</body>
</html>
