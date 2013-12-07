<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
<c:choose>
	<c:when test="${action=='edit'}">
		<c:set var="title" value="海运整箱附加费编辑" />
	</c:when>
	<c:when test="${action=='create'}">
		<c:set var="title" value="海运整箱附加费新增" />
	</c:when>
	<c:otherwise>
		<c:set var="title" value="海运整箱附加费详情" />
	</c:otherwise>
</c:choose>
<title><c:out value="${title }" /></title>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$("#fclQsurchargeEntity\\.prdQuoteId")
								.change(
										function() {
											var $selectedOption = $("#fclQsurchargeEntity\\.prdQuoteId option:selected");
											var unitName = $selectedOption
													.attr("unitName");
											var currencyName = $selectedOption
													.attr("currencyName");
											$("#unitName").text(
													unitName ? unitName : "");
											$("#currencyName").text(
													currencyName ? currencyName
															: "");

											//如果是票则隐藏柜的价格，如果单位是柜则隐藏票的价格
											if (unitName == '票') {
												$(
														"input[name='fclQsurchargeEntity\\.nonContainerCost']")
														.attr("disabled", false);
												$(
														"input[name='fclQsurchargeEntity\\.cost20gp']")
														.attr("disabled", true);
												$(
														"input[name='fclQsurchargeEntity\\.cost40gp']")
														.attr("disabled", true);
												$(
														"input[name='fclQsurchargeEntity\\.cost40hq']")
														.attr("disabled", true);
											} else if (unitName == '柜') {
												$(
														"input[name='fclQsurchargeEntity\\.nonContainerCost']")
														.attr("disabled", true);
												$(
														"input[name='fclQsurchargeEntity\\.cost20gp']")
														.attr("disabled", false);
												$(
														"input[name='fclQsurchargeEntity\\.cost40gp']")
														.attr("disabled", false);
												$(
														"input[name='fclQsurchargeEntity\\.cost40hq']")
														.attr("disabled", false);
											}
										});
						$("#addationQuoteInfoEntity\\.importExportFlag")
								.change(
										function() {
											var importExportFlag = $(this)
													.val();
											console.log(importExportFlag);
											// 获取新数据
											$
													.ajax({
														url : ctx
																+ "/lgsaddationquoteinfo/listFeeName",
														type : "POST",
														cache : false,
														dataType : "json",
														data : {
															"importExportFlag" : importExportFlag,
															"originalId" : 11000150
														},
														success : function(data) {
															var $cascadeSelect = $("#fclQsurchargeEntity\\.prdQuoteId");
															// 清空options
															$cascadeSelect
																	.empty();
															// 拼接一个空的options
															$cascadeSelect
																	.append("<option value=\"\"></option>");
															// 拼接options
															for (var i = 0; i < data.length; i++) {
																var item = data[i];
																$cascadeSelect
																		.append("<option value=\"" 
												+ item.id 
												+ "\" unitName=\""
												+ item.unitName
												+"\" currencyName=\""
												+ item.currencyName
												+"\">"
																				+ item.name
																				+ "</option>");
															}
															// 刷新chosen
															$cascadeSelect
																	.trigger("chosen:updated.chosen");
														}
													});
										});
						// 加载完成主动调用费用名称选中操作
						$("#fclQsurchargeEntity\\.prdQuoteId").change();
						// 金额小数点后的位数限制
						var moneyAfterPointNum = 2;
						//金额小数点前的位数限制
						var moneyBeforePointNum = 10;
						/**
						 * money小数点后的位数是否超过限制
						 */
						isPointOverLimit = function(value) {
							if (value != null && value != '') {
								var decimalIndex = value.indexOf('.');
								if (decimalIndex == '-1') {
									return false;
								} else {
									var decimalPart = value.substring(
											decimalIndex + 1, value.length);
									if (decimalPart.length > moneyAfterPointNum) {
										return true;
									} else {
										return false;
									}
								}
							}
							return false;
						};
						/**
						 * money小数点前的位数是否超过限制
						 */
						isIntegerOverLimit = function(value) {
							if (value != null && value != '') {
								var decimalIndex = value.indexOf('.');
								if (decimalIndex == '-1') { // 没有小数位
									if (value.length > moneyBeforePointNum) {
										return true;
									} else {
										return false;
									}
								} else {
									var integerPart = value.substring(0,
											decimalIndex);
									if (integerPart.length > moneyBeforePointNum) {
										return true;
									} else {
										return false;
									}
								}
							}
							return false;
						};
						// 验证成本价填写是否符合规则
						checkSubmit = function() {
							var validValue = $('#input_form').valid();
							if (!validValue) {
								return false;
							}
							var nonContainerCost = $(
									"input[name='fclQsurchargeEntity.nonContainerCost']")
									.val();
							var cost20gp = $(
									"input[name='fclQsurchargeEntity.cost20gp']")
									.val();
							var cost40gp = $(
									"input[name='fclQsurchargeEntity.cost40gp']")
									.val();
							var cost40hq = $(
									"input[name='fclQsurchargeEntity.cost40hq']")
									.val();
							var $selectedOption = $("#fclQsurchargeEntity\\.prdQuoteId option:selected");
							var unitName = $selectedOption.attr("unitName");
							if (null == unitName || "" == unitName) {
								unitName = $("#unitName").text();
							}
							unitName = $.trim(unitName);
							if (unitName == '票') {
								if (nonContainerCost.trim() == '') {
									SunivoUtil
											.showAlertMessage(
													$("#message"),
													"<li>费用单位是票，每票成本价必须填写</li>",
													"warn");
									return false;
								}
							} else if (unitName == '柜') {
								if (cost20gp.trim() == ''
										&& cost40gp.trim() == ''
										&& cost40hq.trim() == '') {
									SunivoUtil
											.showAlertMessage(
													$("#message"),
													"<li>费用单位是柜，(20'GP，40'GP，40'HQ)成本价至少填写一项</li>",
													"warn");
									return false;
								}
							}
							var success = checkCostMoney(nonContainerCost,
									cost20gp, cost40gp, cost40hq);
							if ("" == success) {
								$('#input_form').submit();
								return true;
							} else {
								SunivoUtil.showAlertMessage($("#message"),
										success, "warn");
								return false;
							}
						};
						// 检查成本价格式
						checkCostMoney = function(nonContainerCost, cost20gp,
								cost40gp, cost40hq) {
							var success = "";
							// 判断金额的小数位数
							if (isIntegerOverLimit(nonContainerCost.trim()) == true) {
								success += "<li>[每票成本价]：整数位数超过十位</li>";
							}
							if (isPointOverLimit(nonContainerCost.trim()) == true) {
								success += "<li>[每票成本价]：小数位数超过两位</li>";
							}
							if (isIntegerOverLimit(cost20gp.trim()) == true) {
								success += "<li>[20'GP成本价]：整数位数超过十位</li>";
							}
							if (isPointOverLimit(cost20gp.trim()) == true) {
								success += "<li>[20'GP成本价]：小数位数超过两位</li>";
							}
							if (isIntegerOverLimit(cost40gp.trim()) == true) {
								success += "<li>[40'GP成本价]：整数位数超过十位</li>";
							}
							if (isPointOverLimit(cost40gp.trim()) == true) {
								success += "<li>[40'GP成本价]：小数位数超过两位</li>";
							}
							if (isIntegerOverLimit(cost40hq.trim()) == true) {
								success += "<li>[40'HQ成本价]：整数位数超过十位</li>";
							}
							if (isPointOverLimit(cost40hq.trim()) == true) {
								success += "<li>[40'HQ成本价]：小数位数超过两位</li>";
							}
							return success;
						};
					});

	//java代码不好控制，用js控制
	$(function() {
		var unitId = $("#unitName").text();
		if(unitId == null || unitId == "" || unitId == undefined){
			unitId = $("#unitNameTmp").text();
		}
		if (unitId != '票') {//柜
			$("#fclQsurchargeEntity\\.nonContainerCost").attr("disabled", true);
			$("#fclQsurchargeEntity\\.nonContainerPrice")
					.attr("disabled", true);
			$("#fclQsurchargeEntity\\.nonContainerDiscount").attr("disabled",
					true);

			$("#fclQsurchargeEntity\\.cost20gp").attr("disabled", false);
			$("#fclQsurchargeEntity\\.price20gp").attr("disabled", false);
			$("#fclQsurchargeEntity\\.discount20gp").attr("disabled", false);
			$("#entity\\.cost40gp").attr("disabled", false);
			$("#entity\\.price40gp").attr("disabled", false);
			$("#entity\\.discount40gp").attr("disabled", false);
			$("#fclQsurchargeEntity\\.cost40hq").attr("disabled", false);
			$("#fclQsurchargeEntity\\.price40hq").attr("disabled", false);
			$("#fclQsurchargeEntity\\.discount40hq").attr("disabled", false);
		} else {//票
			$("#fclQsurchargeEntity\\.nonContainerCost")
					.attr("disabled", false);
			$("#fclQsurchargeEntity\\.nonContainerPrice").attr("disabled",
					false);
			$("#fclQsurchargeEntity\\.nonContainerDiscount").attr("disabled",
					false);

			$("#fclQsurchargeEntity\\.cost20gp").attr("disabled", true);
			$("#fclQsurchargeEntity\\.price20gp").attr("disabled", true);
			$("#fclQsurchargeEntity\\.discount20gp").attr("disabled", true);
			$("#entity\\.cost40gp").attr("disabled", true);
			$("#entity\\.price40gp").attr("disabled", true);
			$("#entity\\.discount40gp").attr("disabled", true);
			$("#fclQsurchargeEntity\\.cost40hq").attr("disabled", true);
			$("#fclQsurchargeEntity\\.price40hq").attr("disabled", true);
			$("#fclQsurchargeEntity\\.discount40hq").attr("disabled", true);
		}
	});
</script>
</head>
<body>
	<div class="row-fluid sunivoPage">
		<!-- 水平表单 begin -->
		<form id="input_form" class="form-horizontal valid" name="input_form"
			method="post"
			action="${ctx}/lgsaddationquoteinfo<c:if test="${action=='edit'}">/${vo.fclQsurchargeEntity.id}</c:if>">
			<!-- 页面内容置中，左右各留span1 -->
			<div class="span10 offset1">
				<div id="message"></div>
				<sunivo:flushMessage />
				<input type="hidden" name="addationQuoteInfoEntity.id"
					id="addationQuoteInfoEntity.id"
					value="${vo.addationQuoteInfoEntity.id}">
				<!-- 页头  begin -->
				<div class="row-fluid">
					<div class="span12 sunivoTitle">
						<div class="span6">
							<h1 class="pageTitle">
								<c:out value="${title }" />
							</h1>
						</div>
						<div class="span6" align="right">
							<c:choose>
								<c:when test="${action=='edit'}">
									<a href="#" class="pull-right icon-2x pointer icon-save i"
										style="margin-right: 20px;" onclick="return checkSubmit();"></a>
								</c:when>
								<c:when test="${action=='create'}">
									<a href="#" class="pull-right icon-2x pointer icon-save i"
										style="margin-right: 20px;" onclick="return checkSubmit();"></a>
								</c:when>
								<c:otherwise>
									<a
										href="${ctx}/lgsaddationquoteinfo/${vo.fclQsurchargeEntity.id}?action=edit"
										class="pull-right icon-edit icon-2x pointer i"
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
							<li><a href="${ctx}/lgsaddationquoteinfo?search_EQ_status=0">海运整箱附加费列表</a>
								<span class="divider">/</span></li>
							<li class="active"><c:out value="${title }" /></li>
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
							<label class="control-label"
								for="addationQuoteInfoEntity.shipmentPortId">起运港<c:choose>
									<c:when test="${action=='create'}">
										<font color="red">*</font>
									</c:when>
								</c:choose>:
							</label>

							<div class="controls">
								<c:choose>
									<c:when test="${action=='create'}">
										<sunivo:shipPortSelect
											name="addationQuoteInfoEntity.shipmentPortId"
											value="${vo.addationQuoteInfoEntity.shipmentPortId}"
											span="span10" clazz="required" placeHolderMessageCode="起运港" />
										<font color="red"><form:errors
												path="lgsAddationQuoteInfoVo.addationQuoteInfoEntity.shipmentPortId" /></font>
									</c:when>
									<c:otherwise>
										<span class="inline"><sunivo:shipPortView
												value="${vo.addationQuoteInfoEntity.shipmentPortId}" />&nbsp;</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label"
								for="addationQuoteInfoEntity.agentId">船公司&nbsp;: </label>

							<div class="controls">
								<c:choose>
									<c:when test="${action=='create'}">
										<sunivo:logisticsCompanySelect cusLogisticType="01"
											name="addationQuoteInfoEntity.agentId"
											value="${vo.addationQuoteInfoEntity.agentId }" span="span10"
											clazz="required" placeHolderMessageCode="船公司"
											defaultValue="-1" showAllOption="true"/>
									</c:when>
									<c:otherwise>
										<span class="inline"><sunivo:customerView
												value="${vo.addationQuoteInfoEntity.agentId}"
												defaultShowValue="全部" defaultValue="-1" />&nbsp;</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">费用名称<c:choose>
									<c:when test="${action=='create'}">
										<font color="red">*</font>
									</c:when>
								</c:choose>:
							</label>

							<div class="controls" id="feeName">
								<c:choose>
									<c:when test="${action=='create'}">
										<sunivo:feeNameSelect name="fclQsurchargeEntity.prdQuoteId"
											value="${vo.fclQsurchargeEntity.prdQuoteId}" span="span10"
											placeHolderMessageCode="费用名称" clazz="required"
											importExportFlag="1" originalId="11000150" />
										<font color="red"><form:errors
												path="vo.fclQsurchargeEntity.prdQuoteId" /></font>
									</c:when>
									<c:otherwise>
										<input type="hidden" id="fclQsurchargeEntity.prdQuoteId"
											name="fclQsurchargeEntity.prdQuoteId"
											value="${vo.quoteEntity.id}">
										<span class="inline">${vo.quoteEntity.name}&nbsp;</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">费用单位&nbsp;:</label>
							<div class="controls">
								<c:choose>
									<c:when test="${action=='create'}">
										<span class="inline" id="unitName"></span>
									</c:when>
									<c:otherwise>
										<span class="inline" id="unitNameTmp"><sunivo:unitView
												value="${vo.quoteEntity.unitId}" /> </span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label"
								for="addationQuoteInfoEntity.routeTypeId">航线<c:choose>
									<c:when test="${action=='create'}">
										<font color="red">*</font>
									</c:when>
								</c:choose>:
							</label>

							<div class="controls">
								<c:choose>
									<c:when test="${action=='create'}">
										<sunivo:shippinglineSelect
											name="addationQuoteInfoEntity.routeTypeId"
											value="${vo.addationQuoteInfoEntity.routeTypeId}"
											span="span10" clazz="required" placeHolderMessageCode="航线" />
										<font color="red"><form:errors
												path="lgsAddationQuoteInfoVo.addationQuoteInfoEntity.routeTypeId" /></font>
									</c:when>
									<c:otherwise>
										<span class="inline"><sunivo:shippinglineView
												value="${vo.addationQuoteInfoEntity.routeTypeId}" />&nbsp;</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">币种&nbsp;:</label>
							<div class="controls">
								<c:choose>
									<c:when test="${action=='create'}">
										<span class="inline" id="currencyName"></span>
									</c:when>
									<c:otherwise>
										<span class="inline"> <sunivo:currencyView
												showType="cn" value="${vo.quoteEntity.currencyId }" /></span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
					<%@ include file="../../lgsfclqsurcharge/pages/formFragment.jsp"%>
				</div>
			</div>
		</form>
		<!-- 水平表单 end -->
	</div>
</body>
</html>