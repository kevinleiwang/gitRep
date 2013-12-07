<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>优势航线详情</title>
</head>
<body>
	<!-- 流式布局，页面上部空出50px-->
	<div class="row-fluid sunivoPage">
		<!-- 水平表单 begin -->
		<form id="input_form" class="form-horizontal">
			<!-- 页面内容置中，左右各留span1 -->
			<div class="span10 offset1">
				<sunivo:flushMessage/>
				<!-- 页头  begin -->
				<div class="row-fluid">
					<div class="span12 sunivoTitle">
						<div class="span6">
							<h1 class="pageTitle">优势航线详情</h1>
						</div>
						<div class="span6" align="right">
							<!-- 编辑功能屏蔽 -->
							<%-- <i title="编辑" class="pull-right icon-edit icon-2x pointer" style="margin-right: 15px;" onclick="window.location='${ctx}/lgsadvantagerouteset/${entity.id}?action=edit'"></i> --%>
						</div>
					</div>
				</div>
				<!-- 页头  end -->
				<!-- 面包屑 begin -->
				<div class="row-fluid">
					<div class="span12">
						<ul class="breadcrumb">
							<li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
							<li><a href="${ctx}/lgsadvantagerouteset/">优势航线列表</a> <span
								class="divider">/</span></li>
							<li class="active">优势航线详情</li>
						</ul>
					</div>
				</div>
				<!-- 面包屑 end -->
				<div class="sunivoBorder">
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>基本信息</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">起运港:</label>
							<div class="controls">
								<sunivo:shipPortView
									value="${entity.shipmentPortId}" />
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">目的港:</label>
							<div class="controls">
								<sunivo:shipPortView
									value="${entity.destinationPortId}" />
							</div>
						</div>
					</div>

					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">船公司:</label>
							<div class="controls" style="word-break:break-all;">
								<sunivo:customerView value="${entity.agentId}" />
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">航线类型:</label>
							<div class="controls">
								<sunivo:shippinglineView
									value="${entity.routeTypeId}" />
							</div>
						</div>
					</div>

					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">生效日期:</label>
							<div class="controls">
								<f:formatDate value='${entity.execDate}' pattern='yyyy-MM-dd' />
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">失效日期:</label>
							<div class="controls">
								<f:formatDate value='${entity.expiryDate}' pattern='yyyy-MM-dd' />
							</div>
						</div>
					</div>

					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">状态:</label>
							<div class="controls">
								<c:choose>
									<c:when test="${entity.disabled == 0}">有效</c:when>
									<c:when test="${entity.disabled == 2}">无效</c:when>
								</c:choose>
							</div>
						</div>
						<div class="span6 control-group"></div>
					</div>

					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>备注</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span12 control-group">
							<label class="control-label">备注:</label>
							<div class="controls" style="word-break:break-all;">
								<c:out value="${entity.remark }"></c:out>
							</div>
						</div>
					</div>
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>系統信息</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">创建人:</label>
							<div class="controls">
								<c:out value="${entity.createUsername}" />
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">创建时间:</label>
							<div class="controls">
								<f:formatDate value='${entity.createDatetime}' pattern='yyyy-MM-dd HH:mm:ss' />
							</div>
						</div>
					</div>
					
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">更新人:</label>
							<div class="controls">
								<c:out value="${entity.updateUsername}" />
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">更新时间:</label>
							<div class="controls">
								<f:formatDate value='${entity.updateDatetime}' pattern='yyyy-MM-dd HH:mm:ss' />
							</div>
						</div>
					</div>


				</div>
			</div>
		</form>
		<!-- 水平表单 end -->
	</div>

</body>
</html>