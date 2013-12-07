<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>优势航线列表</title>
</head>
<body>
	<!-- 流式布局，页面上部空出50px-->
	<div class="row-fluid sunivoPage">
		<!-- 页面内容置中，左右各留span1 -->
		<div class="span10 offset1">
			<sunivo:flushMessage />
			<div id="message"></div>
			<!-- 页头  begin -->
			<div class="row-fluid">
				<div class="sunivoTitle span12">
					<div class="span3">
						<h1 class="pageTitle">优势航线列表</h1>
					</div>
					<div class="span5"></div>
					<div class="span4" align="right">
						<span> 
							<a href="${ctx}/lgsadvantagerouteset?action=create" class="pull-right icon-plus icon-2x pointer i" style="margin-right: 10px;" title="新增优势航线"></a>
						</span>
					</div>
				</div>
			</div>
			<!-- 页头  end -->
			<!-- 面包屑 begin -->
			<div class="row-fluid">
				<div class="span12">
					<ul class="breadcrumb">
						<li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
						<li class="active">优势航线列表</li>
					</ul>
				</div>
			</div>
			<!-- 面包屑 end -->

			<!-- 水平表单 begin -->
			<form id="filterForm" class="form-horizontal"
				action="${ctx}/lgsadvantagerouteset" method="get">

				<div class="sunivoFilterForm">
					<div class="row-fluid">
						<div class="span12">
							<div class="span11 filterCondition">
								<span> 
								<sunivo:shipPortSelect span="span2" name="search_EQ_shipmentPortId" value="${param['search_EQ_shipmentPortId']}" placeHolderMessageCode="起运港" /> 
								<sunivo:shipPortSelect span="span2" name="search_EQ_destinationPortId" value="${param['search_EQ_destinationPortId']}" placeHolderMessageCode="目的港" /> 
								<sunivo:logisticsCompanySelect span="span2" name="search_EQ_agentId" value="${param['search_EQ_agentId']}" placeHolderMessageCode="船公司" cusLogisticType="01" />
								<sunivo:shippinglineSelect span="span2" name="search_EQ_routeTypeId" value="${param['search_EQ_routeTypeId']}" placeHolderMessageCode="航线类型"/>
								<sunivo:disabledFlag2Select span="span2" name="search_EQ_disabled" value="${param['search_EQ_disabled']}" placeHolderMessageCode="状态"/>
								<%-- <select class="span10" class="span2" name="search_EQ_disabled" value="${param['search_EQ_disabled']}" data-placeholder="状态">
									<option></option>
									<option value="0" >有效</option>
									<option value="1" >无效</option>
								</select> --%>
								</span>
							</div>
							<div class="span1 filterAction">
								<span> <i class="pull-right icon-search icon-2x pointer"
									style="margin-right: 15px;"
									onclick="$('#filterForm').submit();"></i>
								</span>
							</div>

						</div>
					</div>
				</div>
			</form>

			<!-- 水平表单 end -->
			<div class="sunivoList">
				<c:forEach items="${lgsAddationQuoteInfos}"
					var="entity">
					<div class="row-fluid">
						<div class="span12">
							<!-- 最左列，通常放入可唯一识别当前记录的字段，比如客户名，如没有，可放入ID -->
							<div class="number span2">
								<span> <a
									href="${ctx}/lgsadvantagerouteset/${entity.id}"
									title="查看航线详情"> <sunivo:shipPortView
											value="${entity.shipmentPortId}" /> <br>--&gt;<br>
										<sunivo:shipPortView
											value="${entity.destinationPortId}" />
								</a>
								</span>
							</div>
							<!-- 记录要展示的数据，此处按列排，不是按行排 -->
							<div class="content span9">
								<div class="row-fluid">
									<!-- 第一 列 -->
									<div class="span4">
										<dl class="dl-horizontal">
											<dt>起运港：</dt>
											<dd>
												<sunivo:shipPortView
													value="${entity.shipmentPortId}" />
											</dd>
											<dt>目的港：</dt>
											<dd>

												<sunivo:shipPortView
													value="${entity.destinationPortId}" />
											</dd>
											<dt>船公司：</dt>
											<dd>
												<sunivo:customerView value="${entity.agentId}" />
											</dd>
											<dt>航线类型：</dt>
											<dd>
												<sunivo:shippinglineView
													value="${entity.routeTypeId}" />
											</dd>
										</dl>
									</div>
									<!-- 第二 列 -->
									<div class="span4">
										<dl class="dl-horizontal">

											<dt>状态：</dt>
											<dd>
												<c:choose>
													<c:when test="${entity.disabled == 0}">有效</c:when>
													<c:when test="${entity.disabled == 2}">无效</c:when>
												</c:choose>
											</dd>
											<dt>生效日期：</dt>
											<dd>
												<f:formatDate value='${entity.execDate}'
													pattern='yyyy-MM-dd' />
											</dd>
											<dt>失效日期：</dt>
											<dd>
												<f:formatDate value='${entity.expiryDate}'
													pattern='yyyy-MM-dd' />
											</dd>
											<dt>&nbsp;</dt>
											<dd>&nbsp;</dd>
										</dl>
									</div>
									<!-- 第三 列 -->
									<div class="span4">
										<dl class="dl-horizontal">
											<dt></dt>
											<dd></dd>
											<dt></dt>
											<dd></dd>
											<dt>创建人：</dt>
											<dd>
												<c:out value="${entity.createUsername}" />
											</dd>
											<dt>创建时间：</dt>
											<dd>
												<f:formatDate value='${entity.createDatetime}' pattern='yyyy-MM-dd HH:mm:ss' />
											</dd>

										</dl>
									</div>
								</div>
							</div>
							<!-- 操作按钮 
							说明：
							   按钮每行至多放三个，超过三个，请用<br>换行
							-->
							<div class="action span1">
								<span> 
								    <!-- 屏蔽吧编辑功能  -->
									<%-- <i title="编辑" class="icon-edit pointer pull-left" style="margin-left:15px;" onclick="window.location='${ctx}/lgsadvantagerouteset/${entity.id}?action=edit'"></i> --%>
									<c:if test="${entity.disabled == 2}">
										<i title="删除" class="icon-minus pointer pull-left" style="margin-left:15px;" onclick="operateById('删除优势航线', '确定要删除该优势航线？','优势航线删除失败！','${entity.id}',1)"> </i>
									</c:if>
									
									<i title="详情" class="icon-eye-open pointer pull-left" style="margin-left:15px;" onclick="window.location='${ctx}/lgsadvantagerouteset/${entity.id}'"> </i>
									<c:choose>
										<c:when test="${entity.disabled == 0}">
											<i title="禁用" class="icon-lock pointer pull-left" style="margin-left:15px;" onclick="operateById('禁用优势航线', '确定要禁用该优势航线？','优势航线禁用失败！','${entity.id}',2)"> </i>
										</c:when>
										<c:when test="${entity.disabled == 2}">
											<i title="启用" class="icon-unlock pointer pull-left" style="margin-left:15px;" onclick="operateById('启用优势航线', '确定要启用该优势航线？','优势航线启用失败！','${entity.id}',0)"> </i>
										</c:when>
									</c:choose>
								</span>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<!-- 分页 -->
			<div class="row-fluid">
				<sunivo:pagination page="${page}" />
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var operateById = function(title,body,result,lgsadvantageroutesetId,statue) {
			SunivoUtil.createModal(title, body, function() {
				$.ajax({
					url : ctx + '/lgsadvantagerouteset/'
							+ lgsadvantageroutesetId+'/'+statue+'?action=edit&_='+new Date(),
					type : "POST",
					success : function(data) {
						if("10000"==data) {
								window.location.reload();
						}
						else {
							SunivoUtil.showAlertMessage(
									$("#message"),
									result,
									"error"); 
						}
					}
				});
			});
		};
	</script>
</body>
</html>

