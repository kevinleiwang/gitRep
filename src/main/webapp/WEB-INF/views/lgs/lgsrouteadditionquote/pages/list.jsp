<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>报价按航线加成列表</title>
</head>
<body>
<script type="text/javascript">
	function deleteOne(id){
		SunivoUtil.createModal("确认删除", "确认删除此航线加成？", function() {
			var url = '${ctx}/lgsrouteadditionquote/'+id+'?action=delete';
			//alert(url);
			window.location=url;
			return true;
		}, "确定");
	}
</script>
	<!-- 流式布局，页面上部空出50px-->
	<div class="row-fluid sunivoPage">
		<!-- 页面内容置中，左右各留span1 -->
		<div class="span10 offset1">
			<sunivo:flushMessage />
			<!-- 页头  begin -->
			<div class="row-fluid">
				<div class="sunivoTitle span12">
					<div class="span8">
						<h1 class="pageTitle">报价按航线加成列表</h1>
					</div>
					<div class="span4" align="right">
						<span> <a href="${ctx}/lgsrouteadditionquote?action=create"
							class="pull-right icon-plus icon-2x pointer i"
							style="margin-right: 10px;"></a>
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
						<li class="active">报价按航线加成列表</li>
					</ul>
				</div>
			</div>
			<!-- 面包屑 end -->

			<!-- 水平表单 begin -->
			<form id="filterForm" class="form-inline filterForm"
				action="${ctx}/lgsrouteadditionquote" method="GET">
				<div class="sunivoFilterForm">
					<div class="row-fluid">
						<div class="span12">
							<div class="span11 filterCondition">
								<span> <sunivo:importExportFlagSelect
										name="importExportFlag" value="1" placeHolderMessageCode="进出口"
										span="span2" disabled="true" /> <input type="hidden"
									name="search_EQ_importExportFlag"
									id="search_EQ_importExportFlag" value="1"> <sunivo:shippinglineSelect
										name="search_EQ_routeTypeId"
										value="${param['search_EQ_routeTypeId']}"
										placeHolderMessageCode="航线类型" span="span2" /> <input
									type="hidden" id="search_EQ_transportType"
									name="search_EQ_transportType" value="1"> <sunivo:disabledFlagSelect
										name="search_EQ_status" value="${param['search_EQ_status']}"
										placeHolderMessageCode="状态" span="span2" />
								</span>
							</div>
							<div class="span1 filterAction">
								<span> <i class="pull-right icon-search icon-2x pointer"
									style="margin-right: 10px;"
									onclick="$('#filterForm').submit();"></i>
								</span>
							</div>
						</div>
					</div>
				</div>
			</form>
			<!-- 水平表单 end -->
			<div class="sunivoList">
				<!-- FOR begin-->
				<c:forEach items="${lgsRouteAdditionQuotes}"
					var="lgsRouteAdditionQuote">
					<div class="row-fluid">
						<div class="span12">
							<!-- 最左列，通常放入可唯一识别当前记录的字段，比如客户名，如没有，可放入ID -->
							<div class="number span2">
								<span> <a
									href="${ctx}/lgsrouteadditionquote/${lgsRouteAdditionQuote.id}">${lgsRouteAdditionQuote.id}</a>
								</span>
							</div>
							<!-- 记录要展示的数据，此处按列排，不是按行排 -->
							<div class="content span9">
								<div class="row-fluid">
									<!-- 第一 列 -->
									<div class="span4">
										<dl class="dl-horizontal">
											<dt>进出口：</dt>
											<dd>
												<sunivo:importExportFlagView
													value="${lgsRouteAdditionQuote.importExportFlag}" />
											</dd>
											<dt>航线类型：</dt>
											<dd>
												<sunivo:shippinglineView
													value="${lgsRouteAdditionQuote.routeTypeId}" />
											</dd>
											<dt>状态：</dt>
											<dd>
												<sunivo:disabledFlagView
													value="${lgsRouteAdditionQuote.status }" />
											</dd>
											<dt>&nbsp;</dt>
											<dd>&nbsp;</dd>
										</dl>
									</div>
									<!-- 第二 列 -->
									<div class="span4">
										<dl class="dl-horizontal">
											<dt title="海运运费销售价计算公式">海运运费销售价计算公式：</dt>
											<dd
												title="成本价*(<sunivo:numberFormatView value="${lgsRouteAdditionQuote.fclPriceAddPercent}" />%)+(<sunivo:numberFormatView value="${lgsRouteAdditionQuote.fclPriceAddValue}" />)">
												成本价*(
												<sunivo:numberFormatView
													value="${lgsRouteAdditionQuote.fclPriceAddPercent}" />
												%)
												<c:if test="${lgsRouteAdditionQuote.fclPriceAddValue >= 0}" >
												+
												</c:if>
												<sunivo:numberFormatView
													value="${lgsRouteAdditionQuote.fclPriceAddValue}" />
											</dd>
											<dt title="海运运费折扣价计算公式">海运运费折扣价计算公式：</dt>
											<dd
												title="销售价*(<sunivo:numberFormatView value="${lgsRouteAdditionQuote.fclDiscountAddPercent}" />%)">
												销售价*(
												<sunivo:numberFormatView
													value="${lgsRouteAdditionQuote.fclDiscountAddPercent}" />
												%)
											</dd>
											<dt title="本地费用销售价计算公式">本地费用销售价计算公式：</dt>
											<dd
												title="成本价*(<sunivo:numberFormatView value="${lgsRouteAdditionQuote.portPriceAddPercent}" />%)+(<sunivo:numberFormatView value="${lgsRouteAdditionQuote.portPriceAddValue}" />)">
												成本价*(
												<sunivo:numberFormatView
													value="${lgsRouteAdditionQuote.portPriceAddPercent}" />
												%)
												<c:if test="${lgsRouteAdditionQuote.portPriceAddValue >= 0}" >
												+
												</c:if>
												<sunivo:numberFormatView
													value="${lgsRouteAdditionQuote.portPriceAddValue}" />
											</dd>
											<dt title="本地费用折扣价计算公式">本地费用折扣价计算公式：</dt>
											<dd
												title="销售价*(<sunivo:numberFormatView value="${lgsRouteAdditionQuote.portDiscountAddPercent}" />%)">
												销售价*(
												<sunivo:numberFormatView
													value="${lgsRouteAdditionQuote.portDiscountAddPercent}" />
												%)
											</dd>
										</dl>
									</div>
									<!-- 第三 列 -->
									<div class="span4">
										<dl class="dl-horizontal">
											<dt title="附加费用销售价计算公式">附加费用销售价计算公式：</dt>
											<dd
												title="成本价*(<sunivo:numberFormatView value="${lgsRouteAdditionQuote.addationPriceAddPercent}" />%)+(<sunivo:numberFormatView value="${lgsRouteAdditionQuote.addationPriceAddValue}" />)">
												成本价*(
												<sunivo:numberFormatView
													value="${lgsRouteAdditionQuote.addationPriceAddPercent}" />
												%)
												<c:if test="${lgsRouteAdditionQuote.addationPriceAddValue >= 0}" >
												+
												</c:if>
												<sunivo:numberFormatView
													value="${lgsRouteAdditionQuote.addationPriceAddValue}" />
											</dd>
											<dt title="附加费用折扣价计算公式">附加费用折扣价计算公式：</dt>
											<dd
												title="销售价*(<sunivo:numberFormatView value="${lgsRouteAdditionQuote.addationDiscountAddPercent}" />%)">
												销售价*(
												(<sunivo:numberFormatView
													value="${lgsRouteAdditionQuote.addationDiscountAddPercent}" />)
												%)
											</dd>
											<dt>更新人：</dt>
											<dd>${lgsRouteAdditionQuote.updateUsername}</dd>
											<dt>更新时间：</dt>
											<dd>
												<fmt:formatDate
													value="${lgsRouteAdditionQuote.updateDatetime}"
													pattern='yyyy-MM-dd HH:mm:ss' />
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
								<span> <i
									onclick="window.location='${ctx}/lgsrouteadditionquote/${lgsRouteAdditionQuote.id}?action=edit'"
									class="pull-left icon-edit pointer" style="margin-left: 15px;"
									title="编辑"></i> <i
									onclick="javascript:deleteOne('${lgsRouteAdditionQuote.id}');"
									class="pull-left icon-minus pointer" style="margin-left: 15px;"
									title="删除"> </i></span>
							</div>
						</div>
					</div>
					<!-- FOR end-->
				</c:forEach>
			</div>
			<!-- 分页 -->
			<div class="row-fluid">
				<div class="span12">
					<sunivo:pagination page="${page }" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>