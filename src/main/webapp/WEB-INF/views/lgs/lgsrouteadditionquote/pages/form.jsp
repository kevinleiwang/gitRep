<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<c:choose>
	<c:when test="${action=='edit'}">
		<c:set var="title" value="报价按航线加成编辑" />
	</c:when>
	<c:when test="${action=='create'}">
		<c:set var="title" value="报价按航线加成新增" />
	</c:when>
	<c:otherwise>
		<c:set var="title" value="报价按航线加成详情" />
	</c:otherwise>
</c:choose>
<title><c:out value="${title }" /></title>
</head>
<body>
	<!-- 流式布局，页面上部空出50px-->
	<div class="row-fluid sunivoPage">
		<form id="input_form" class="form-horizontal valid"
			action="${ctx}/lgsrouteadditionquote<c:if test="${action=='edit'}">/${entity.id}</c:if>"
			method="post">
			<input type="hidden" name="entity.createUserid" value="${entity.createUserid}">
			<input type="hidden" name="entity.createUsername" value="${entity.createUsername}">
			<input type="hidden" name="entity.createDatetimeStr" value="<f:formatDate value='${entity.createDatetime}' pattern='yyyy-MM-dd HH:mm:ss' />">
			<input type="hidden" name="entity.createIp" value="${entity.createIp}">
			<!-- 页面内容置中，左右各留span1 -->
			<div class="span10 offset1">
				<sunivo:flushMessage />
				<!-- 页头  begin -->
				<div class="row-fluid">
					<div class="span12 sunivoTitle">
						<div class="span10">
							<h1 class="pageTitle">
								<c:out value="${title }" />
							</h1>
						</div>
						<div class="span2" align="right">
							<c:choose>
								<c:when test="${action=='edit'}">
									<a href="#" class="icon-2x pointer icon-save i"
										style="margin-right: 20px;"
										onclick="$('#input_form').submit();"></a>
								</c:when>
								<c:when test="${action=='create'}">
									<a href="#" class="icon-2x pointer icon-save i"
										style="margin-right: 20px;"
										onclick="$('#input_form').submit();"></a>
								</c:when>
								<c:otherwise>
									<a href="${ctx}/lgsrouteadditionquote/${entity.id}?action=edit"
										class="icon-2x pointer icon-edit i"
										style="margin-right: 20px;"></a>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
				<!-- 页头  end -->
				<!-- 面包屑 begin -->
				<div class="row-fluid">
					<div class="span12">
						<ul class="breadcrumb">
							<li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
							<li><a href="${ctx}/lgsrouteadditionquote">报价按航线加成列表</a> <span
								class="divider">/</span></li>
							<li class="active"><c:out value="${title }" /></li>
						</ul>
					</div>
				</div>
				<!-- 面包屑 end -->
				<input name="entity.id" id="entity.id" value="${entity.id}"
					type="hidden" />
				<div class="sunivoBorder">
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>基本信息</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">进出口&nbsp;: </label>
							<div class="controls">
								<c:choose>
									<c:when test="${action=='create'}">
										<sunivo:importExportFlagView value="1" />
										<input type="hidden" name="entity.importExportFlag"
											id="entity.importExportFlag" value="1">
									</c:when>
									<c:otherwise>
										<sunivo:importExportFlagView
											value="${entity.importExportFlag}" />
										<input type="hidden" name="entity.importExportFlag"
											id="entity.importExportFlag"
											value="${entity.importExportFlag}">
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<%--
									<div class="span6 control-group">
										<label class="control-label">运输类型<font color="red">*</font>:
										</label>
										<div class="controls">
											<c:choose>
												<c:when test="${action=='create' || action=='edit'}">
													<sunivo:transportTypeFlagSelect name="entity.transportType"
														clazz="required" value="${entity.transportType}"
														span="span10" />
													<font color="red"><form:errors
															path="lgsRouteAdditionQuoteVo.entity.transportType" /></font>
												</c:when>
												<c:otherwise>
													<span class="inline"><sunivo:transportTypeFlagView
															value="${entity.transportType}" />&nbsp;</span>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									 --%>
						<div class="span6 control-group">
							<label class="control-label">航线类型<c:choose>
									<c:when test="${action=='create' || action=='edit'}">
										<font color="red">*</font>
									</c:when>
								</c:choose>:
							</label>
							<div class="controls">
								<c:choose>
									<c:when test="${action=='create' || action=='edit'}">
										<sunivo:shippinglineSelect name="entity.routeTypeId"
											value="${entity.routeTypeId}" clazz="required"
											placeHolderMessageCode="航线类型" span="span10" />
										<font color="red"><form:errors
												path="lgsRouteAdditionQuoteVo.entity.routeTypeId" /></font>
									</c:when>
									<c:otherwise>
										<span class="inline"><sunivo:shippinglineView
												value="${entity.routeTypeId}" />&nbsp;</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">状态<c:choose>
									<c:when test="${action=='create' || action=='edit'}">
										<font color="red">*</font>
									</c:when>
								</c:choose>:
							</label>

							<div class="controls">
								<c:choose>
									<c:when test="${action=='create' || action=='edit'}">
										<sunivo:disabledFlagSelect name="entity.status"
											value="${entity.status }" span="span10" clazz="required"
											placeHolderMessageCode="状态" />
										<font color="red"><form:errors
												path="lgsRouteAdditionQuoteVo.entity.status" /></font>
									</c:when>
									<c:otherwise>
										<span class="inline"><sunivo:disabledFlagView
												value="${entity.status }" />&nbsp;</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="span6 control-group">
							<input type="hidden" id="entity.disabled"
								name="entity.disabled" value="0"> <input
								type="hidden" id="entity.transportType"
								name="entity.transportType" value="1"> &nbsp;
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">生效日期<c:choose>
									<c:when test="${action=='create' || action=='edit'}">
										<font color="red">*</font>
									</c:when>
								</c:choose>:
							</label>

							<div class="controls">
								<c:choose>
									<c:when test="${action=='create' || action=='edit'}">
										<div class="span10 input-append date datetime-picker"
											data-date-minView="month" data-date-format="yyyy-mm-dd">
											<input class="span* required" type="text"
												value="<fmt:formatDate value='${entity.execDate}' pattern='yyyy-MM-dd' />"
												id="entity.execDateStr" name="entity.execDateStr" readonly
												placeholder="生效日期"> <span class="add-on"><i
												class="icon-remove"></i></span> <span class="add-on"><i
												class="icon-calendar"></i></span>
										</div>
										<font color="red"><form:errors
												path="lgsRouteAdditionQuoteVo.entity.execDate" /></font>
									</c:when>
									<c:otherwise>
										<span class="inline"><fmt:formatDate
												value='${entity.execDate}' pattern='yyyy-MM-dd' />&nbsp;</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">失效日期<c:choose>
									<c:when test="${action=='create' || action=='edit'}">
										<font color="red">*</font>
									</c:when>
								</c:choose>:
							</label>

							<div class="controls">
								<c:choose>
									<c:when test="${action=='create' || action=='edit'}">
										<div class="span10 input-append date datetime-picker"
											data-date-minView="month" data-date-format="yyyy-mm-dd">
											<input class="span* required" type="text"
												value="<fmt:formatDate value='${entity.expiryDate}' pattern='yyyy-MM-dd' />"
												id="entity.expiryDateStr" name="entity.expiryDateStr"
												readonly placeholder="失效日期" dateGte="#entity\.execDateStr">
											<span class="add-on"><i class="icon-remove"></i></span> <span
												class="add-on"><i class="icon-calendar"></i></span>
										</div>
										<font color="red"><form:errors
												path="lgsRouteAdditionQuoteVo.entity.expiryDate" /></font>
									</c:when>
									<c:otherwise>
										<span class="inline"><fmt:formatDate
												value='${entity.expiryDate}' pattern='yyyy-MM-dd' />&nbsp;</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>价格计算</h5>
					</div>
					<!-- 片段头 end -->
					<div>
						<table class="table table-hover">
							<thead>
								<tr>
									<th class="span2">费用类型</th>
									<th class="span5">销售价计算公式</th>
									<th class="span5">折扣价计算公式</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>海运运费</td>
									<td><c:choose>
											<c:when test="${action=='create' || action=='edit'}">
											成本价*(<input type="text" id="entity.fclPriceAddPercent"
													name="entity.fclPriceAddPercent"
													value="<sunivo:numberFormatView
															value='${entity.fclPriceAddPercent}' />"
													class="span3 required positiveNumber"
													placeholder="销售价加成百分比" />
											%)+<input type="text" id="entity.fclPriceAddValue"
													name="entity.fclPriceAddValue"
													value="<sunivo:numberFormatView
															value='${entity.fclPriceAddValue}' />"
													class="span3 required number" placeholder="销售价加成值" />
												<font color="red"><form:errors
														path="lgsRouteAdditionQuoteVo.entity.fclPriceAddPercent" />
													<form:errors
														path="lgsRouteAdditionQuoteVo.entity.fclPriceAddValue" /></font>
											</c:when>
											<c:otherwise>
												<span class="inline">成本价*(<sunivo:numberFormatView
														value="${entity.fclPriceAddPercent}" /><span
													class="add-on">%</span>)+(<sunivo:numberFormatView
														value="${entity.fclPriceAddValue}" />)&nbsp;
												</span>
											</c:otherwise>
										</c:choose></td>
									<td><c:choose>
											<c:when test="${action=='create' || action=='edit'}">
										销售价*(<input type="text" id="entity.fclDiscountAddPercent"
													name="entity.fclDiscountAddPercent"
													value="<sunivo:numberFormatView
															value='${entity.fclDiscountAddPercent}' />"
													class="span3 required positiveNumber"
													placeholder="折扣价加成百分比" />
											%)
											<font color="red"><form:errors
														path="lgsRouteAdditionQuoteVo.entity.fclDiscountAddPercent" /></font>
											</c:when>
											<c:otherwise>
												<span class="inline">销售价*(<sunivo:numberFormatView
														value="${entity.fclDiscountAddPercent}" /><span
													class="add-on">%</span>)&nbsp;
												</span>
											</c:otherwise>
										</c:choose></td>
								</tr>
								<tr>
									<td>本地费用</td>
									<td><c:choose>
											<c:when test="${action=='create' || action=='edit'}">成本价*(<input
													type="text" id="entity.portPriceAddPercent"
													name="entity.portPriceAddPercent"
													value="<sunivo:numberFormatView
															value='${entity.portPriceAddPercent}' />"
													class="span3 required positiveNumber"
													placeholder="销售价加成百分比" />
											%)+<input type="text" id="entity.portPriceAddValue"
													name="entity.portPriceAddValue"
													value="<sunivo:numberFormatView
															value='${entity.portPriceAddValue}' />"
													class="span3 required number" placeholder="销售价加成值" />
												<font color="red"><form:errors
														path="lgsRouteAdditionQuoteVo.entity.portPriceAddPercent" />
													<form:errors
														path="lgsRouteAdditionQuoteVo.entity.portPriceAddValue" /></font>
											</c:when>
											<c:otherwise>
												<span class="inline">成本价*(<sunivo:numberFormatView
														value="${entity.portPriceAddPercent}" /><span
													class="add-on">%</span>)+(<sunivo:numberFormatView
														value="${entity.portPriceAddValue}" />)&nbsp;
												</span>
											</c:otherwise>
										</c:choose></td>
									<td><c:choose>
											<c:when test="${action=='create' || action=='edit'}">销售价*(<input
													type="text" id="entity.portDiscountAddPercent"
													name="entity.portDiscountAddPercent"
													value="<sunivo:numberFormatView
															value='${entity.portDiscountAddPercent}' />"
													class="span3 required positiveNumber"
													placeholder="折扣价加成百分比" />
											%)
											<font color="red"><form:errors
														path="lgsRouteAdditionQuoteVo.entity.portDiscountAddPercent" /></font>
											</c:when>
											<c:otherwise>
												<span class="inline">销售价*(<sunivo:numberFormatView
														value="${entity.portDiscountAddPercent}" /><span
													class="add-on">%</span>)&nbsp;
												</span>
											</c:otherwise>
										</c:choose></td>
								</tr>
								<tr>
									<td>附加费用</td>
									<td><c:choose>
											<c:when test="${action=='create' || action=='edit'}">成本价*(<input
													type="text" id="entity.addationPriceAddPercent"
													name="entity.addationPriceAddPercent"
													value="<sunivo:numberFormatView
															value='${entity.addationPriceAddPercent}' />"
													class="span3 required positiveNumber"
													placeholder="销售价加成百分比" />
											%)+<input type="text" id="entity.addationPriceAddValue"
													name="entity.addationPriceAddValue"
													value="<sunivo:numberFormatView
															value='${entity.addationPriceAddValue}' />"
													class="span3 required number" placeholder="销售价加成值" />
												<font color="red"><form:errors
														path="lgsRouteAdditionQuoteVo.entity.addationPriceAddPercent" />
													<form:errors
														path="lgsRouteAdditionQuoteVo.entity.addationPriceAddValue" /></font>
											</c:when>
											<c:otherwise>
												<span class="inline">成本价*(<sunivo:numberFormatView
														value="${entity.addationPriceAddPercent}" /><span
													class="add-on">%</span>)+(<sunivo:numberFormatView
														value="${entity.addationPriceAddValue}" />)&nbsp;
												</span>
											</c:otherwise>
										</c:choose></td>
									<td><c:choose>
											<c:when test="${action=='create' || action=='edit'}">销售价*(<input
													type="text" id="entity.addationDiscountAddPercent"
													name="entity.addationDiscountAddPercent"
													value="<sunivo:numberFormatView
															value='${entity.addationDiscountAddPercent}' />"
													class="span3 required positiveNumber"
													placeholder="折扣价加成百分比" />
											%)
											<font color="red"><form:errors
														path="lgsRouteAdditionQuoteVo.entity.addationDiscountAddPercent" /></font>
											</c:when>
											<c:otherwise>
												<span class="inline">销售价*(<sunivo:numberFormatView
														value="${entity.addationDiscountAddPercent}" /><span
													class="add-on">%</span>)&nbsp;
												</span>
											</c:otherwise>
										</c:choose></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>

</html>