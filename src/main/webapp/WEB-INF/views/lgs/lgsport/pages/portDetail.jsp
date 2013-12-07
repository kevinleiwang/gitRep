<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>海运整箱本地费详情</title>
<script type="text/javascript">
/**
 * portId 本地费表ID
 * quoteId 报价ID
 */
function portEdit(portId,quoteId) {
	//window.location.href = "${ctx}/lgsport/portEdit/"+portId+"/"+quoteId;
	window.location.href = "${ctx}/lgsport/portEdit/"+quoteId;
}
</script>
</head>
<body>
	<!-- 流式布局，页面上部空出50px-->
	<div class="row-fluid sunivoPage">
		<!-- 水平表单 begin -->
		<form class="form-horizontal">
			<input type="hidden" name="entity.id" value="${entity.id}" />
			<input type="hidden" name="fclQentity.id" value="${fclQentity.id}" />
			<input type="hidden" name="fclQentity.quoteId" value="${fclQentity.quoteId}" />
			
			<!-- 页面内容置中，左右各留span1 -->
			<div class="span10 offset1">
			
			
				<!-- 页头  begin -->
				<div class="row-fluid">
					<div class="span12 sunivoTitle">
						<div class="span6">
							<h1 class="pageTitle">海运整箱本地费详情</h1>
						</div>
						<div class="span6" align="right">
							<i class="pull-right icon-edit icon-2x pointer" title="编辑" 
								onclick="portEdit('${entity.id}','${fclQentity.id}');" style="margin-right: 20px;"></i> 
						</div>
					</div>
				</div>
				<!-- 页头  end -->
				
				
				<!-- 面包屑 begin -->
				<div class="row-fluid">
					<div class="span12">
						<ul class="breadcrumb">
							<li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
							<li><a href="${ctx}/lgsport?search_EQ_status=0">海运整箱本地费列表</a> <span
								class="divider">/</span></li>
							<li class="active">海运整箱本地费详情</li>
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
							<label class="control-label" for="shipmentPortId">起运港:</label>
							<div class="controls">
								<%-- <sunivo:shipPortSelect span="span10" clazz="required"
										name="entity.shipmentPortId"
										value="${entity.shipmentPortId}" /> --%>
								<sunivo:shipPortView value="${entity.shipmentPortId}"/>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="agentId">船公司:</label>
							<div class="controls">
								<%-- <sunivo:logisticsCompanySelect cusLogisticType="01" span="span10" 
										name="entity.agentId"
										value="${entity.agentId }" /> --%>
								<sunivo:customerView value="${entity.agentId }" />
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="prdQuoteId1">费用名称:</label>
							<div class="controls"><span class="span10">${prdQuoteEntity.name }</span>
								<%-- <div class="span10 input-append">
									<input class="span*" type="text" required id="prdQuoteId1" placeholder="关联PRD_QUOTE"
									name="fclQentity.prdQuoteId" value="${fclQentity.prdQuoteId}">
								</div> --%>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="prdQuoteId2">费用单位:</label>
							<div class="controls">
								<!-- <div class="span10 input-append">
									<input class="span*" type="text" readonly="readonly" >
								</div> -->
								<span class="span10">
									<sunivo:unitView value="${prdQuoteEntity.unitId }"/>
								</span>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="routeTypeId">航线:</label>
							<div class="controls">
									<%-- <sunivo:shippinglineSelect span="span10" 
										name="entity.routeTypeId"
										value="${entity.routeTypeId}" /> --%>
								<sunivo:shippinglineView value="${entity.routeTypeId}"/>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="">币种:</label>
							<div class="controls">
								<!-- <div class="span10 input-append">
									<input class="span*" type="text" readonly="readonly" >
								</div> -->
								<span class="span10"><sunivo:currencyView value="${prdQuoteEntity.currencyId }" showType="cn"/></span>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="appendedInput">生效日期:</label>
							<div class="controls"><fmt:formatDate value='${fclQentity.execDate}' pattern='yyyy-MM-dd' />
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="appendedInput2">失效日期:</label>
							<div class="controls"><fmt:formatDate value='${fclQentity.expiryDate}' pattern='yyyy-MM-dd' />
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="appendedInput">进出口:</label>
							<div class="controls">
								<%-- <sunivo:importExportFlagSelect
									name="entity.importExportFlag"
									value="${entity.importExportFlag}"
									span="span10" /> --%>
								<sunivo:importExportFlagView value="${entity.importExportFlag}"/>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="appendedInput2">状态:</label>
							<div class="controls">
								<sunivo:disabledFlagView value="${fclQentity.status }"  />
							</div>
						</div>
					</div>
					
					
					
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>报价信息</h5>
					</div>
					<!-- 片段头 end -->
					<div>
						<table class="table table-hover">
							<!-- 标题可根据实际需要决定要不要 -->
							<!-- <caption >标题</caption> -->
							<!-- 表头可根据实际需要决定要不要 -->
							<thead>
								<tr>
									<th>单位</th>
									<th>成本报价</th>
									<th>销售价</th>
									<th>折扣价</th>
									<th>最终销售价</th>
								</tr>
							</thead>
							<tbody>
							<c:choose>
							    <c:when test="${prdQuoteEntity.unitId ==1}">
								<tr>
									<td><span class="">每票</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.nonContainerCost }"/>&nbsp;</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.nonContainerPrice }"/>&nbsp;</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.nonContainerDiscount }"/>&nbsp;</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.nonContainerDiscount }"/>&nbsp;</span></td>
								</tr>
								</c:when>
								<c:otherwise>
								<tr>
									<td><span class="">20'GP</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.cost20gp }"/>&nbsp;</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.price20gp }"/>&nbsp;</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.discount20gp }"/>&nbsp;</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.discount20gp }"/>&nbsp;</span></td>
								</tr>
								<tr>
									<td><span class="">40'GP</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.cost40gp }"/>&nbsp;</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.price40gp }"/>&nbsp;</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.discount40gp }"/>&nbsp;</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.discount40gp }"/>&nbsp;</span></td>
								</tr>
								<tr>
									<td><span class="">40'HQ</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.cost40hq }"/>&nbsp;</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.price40hq }"/>&nbsp;</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.discount40hq }"/>&nbsp;</span></td>
									<td><span class="inline"><sunivo:moneyFormatView money="${fclQentity.discount40hq }"/>&nbsp;</span></td>
								</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
					</div>
					
					
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5 >备注</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span12 control-group">
							<div class="controls">${fclQentity.remark}</div>
						</div>
					</div>
					
					
					
				</div>
			</div>
		</form>
		<!-- 水平表单 end -->
	</div>

</body>
</html>