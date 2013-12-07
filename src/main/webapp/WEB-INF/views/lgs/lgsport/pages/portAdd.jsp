<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>海运整箱本地费新增</title>
<script type="text/javascript">
	String.prototype.trim = function() {
		return this.replace(/(^\s*)|(\s*$)/g, "");
	}
	String.prototype.ltrim = function() {
		return this.replace(/(^\s*)/g, "");
	}
	String.prototype.rtrim = function() {
		return this.replace(/(\s*$)/g, "");
	}

	$(document)
			.ready(
					function() {
						$("#fclQentity\\.prdQuoteId")
								.change(
										function() {
											var $selectedOption = $("#fclQentity\\.prdQuoteId option:selected");
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
											if(unitName == '票'){
												$('#prdQuoteId4').attr("disabled",false);
												$('#gp20').attr("disabled",true);
												$('#gp40').attr("disabled",true);
												$('#hq40').attr("disabled",true);
											}else if(unitName == '柜'){
												$('#prdQuoteId4').attr("disabled",true);
												$('#gp20').attr("disabled",false);
												$('#gp40').attr("disabled",false);
												$('#hq40').attr("disabled",false);									
											}
										});
						$("#entity\\.importExportFlag")
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
															"originalId" : 11000149
														},
														success : function(data) {
															var $cascadeSelect = $("#fclQentity\\.prdQuoteId");
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
					});

	// 金额小数点后的位数限制
	var moneyAfterPointNum = 2;
	//金额小数点前的位数限制
	var moneyBeforePointNum = 10;
	/**
	 * money小数点后的位数是否超过限制
	 */
	function isPointOverLimit(value) {
		if (value != null && value != '') {
			var decimalIndex = value.indexOf('.');
			if (decimalIndex == '-1') {
				return false;
			} else {
				var decimalPart = value.substring(decimalIndex + 1,
						value.length);
				if (decimalPart.length > moneyAfterPointNum) {
					return true;
				} else {
					return false;
				}
			}
		}
		return false;
	}
	/**
	 * money小数点前的位数是否超过限制
	 */
	function isIntegerOverLimit(value) {
		if (value != null && value != '') {
			var decimalIndex = value.indexOf('.');
			if (decimalIndex == '-1') { // 没有小数位
				if (value.length > moneyBeforePointNum) {
					return true;
				} else {
					return false;
				}
			} else {
				var integerPart = value.substring(0, decimalIndex);
				if (integerPart.length > moneyBeforePointNum) {
					return true;
				} else {
					return false;
				}
			}
		}
		return false;
	}

	function checkCostMoney(nonContainerCost, cost20gp, cost40gp, cost40hq) {
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

		if (success == '') {
			success = 'success';
		}
		return success;
	}
	function portAddFormSubmit() {

		var validValue = $('#portAddForm').valid();
		if (!validValue) {
			return;
		}

		// 备注信息校验
		var remark = $("#remark").val();
		var remarkLength = remark.length;
		if (remarkLength > 300) {
			SunivoUtil.showAlertMessage($("#message"), "<li>[备注]：备注长度为"
					+ remarkLength + "，不能超过300个字符</li>", "warn");
			return false;
		}

		var nonContainerCost = $("input[name='fclQentity.nonContainerCost']")
				.val();
		var cost20gp = $("input[name='fclQentity.cost20gp']").val();
		var cost40gp = $("input[name='fclQentity.cost40gp']").val();
		var cost40hq = $("input[name='fclQentity.cost40hq']").val();

		if ($("#unitName").text() == '票') {
			if (nonContainerCost.trim() == '') {
				SunivoUtil.showAlertMessage($("#message"),
						"<li>费用单位是票，每票成本价必须填写</li>", "warn");
				return false;
			}
		} else if ($("#unitName").text() == '柜') {
			if (cost20gp.trim() == '' && cost40gp.trim() == ''
					&& cost40hq.trim() == '') {
				SunivoUtil.showAlertMessage($("#message"),
						"<li>费用单位是柜，(20'GP，40'GP，40'HQ)成本价至少填写一项</li>", "warn");
				return false;
			}
		}

		var success = checkCostMoney(nonContainerCost, cost20gp, cost40gp,
				cost40hq);
		if (success != 'success') {
			SunivoUtil.showAlertMessage($("#message"), success, "warn");
			return false;
		}

		$('#portAddForm').submit();
	}
</script>
</head>
<body>
	<!-- 流式布局，页面上部空出50px-->
	<div class="row-fluid sunivoPage">
		<!-- 水平表单 begin -->
		<form class="form-horizontal valid" id="portAddForm"
			action="${ctx}/lgsport/portSave" method="post">
			<!-- 页面内容置中，左右各留span1 -->
			<div class="span10 offset1">
				<div id="message"></div>
				<sunivo:flushMessage />

				<!-- 页头  begin -->
				<div class="row-fluid">
					<div class="span12 sunivoTitle">
						<div class="span6">
							<h1 class="pageTitle">海运整箱本地费用新增</h1>
						</div>
						<div class="span6" align="right">
							<i class="pull-right icon-save icon-2x pointer"
								onclick="portAddFormSubmit();" style="margin-right: 20px;"></i>
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
							<li class="active">海运整箱本地费新增</li>
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
							<label class="control-label" for="shipmentPortId">起运港:<span
								style="color: red;">*</span></label>
							<div class="controls">
								<sunivo:shipPortSelect span="span10" clazz="required"
									name="entity.shipmentPortId" value="${entity.shipmentPortId}" />
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="agentId">船公司:<span
								style="color: red;">*</span></label>
							<div class="controls">
								<sunivo:logisticsCompanySelect cusLogisticType="01"
									span="span10" clazz="required" name="entity.agentId"
									value="${entity.agentId }" />
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="prdQuoteId1">费用名称:<span
								style="color: red;">*</span></label>
							<div class="controls" id="feeName">
								<%-- <div class="span10 input-append">
									<input class="span*" type="text" id="prdQuoteId1"
										placeholder="费用名称标签"
										name="fclQentity.prdQuoteId" value="${fclQentity.prdQuoteId}">
								</div> --%>
								<sunivo:feeNameSelect name="fclQentity.prdQuoteId"
									value="${fclQentity.prdQuoteId}" span="span10"
									placeHolderMessageCode="费用名称" clazz="required"
									importExportFlag="${entity.importExportFlag }"
									originalId="11000149" />
								<font color="red"><form:errors
										path="fclQentity.prdQuoteId" /></font>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="prdQuoteId2">费用单位:</label>
							<div class="controls">
								<!-- <div class="span10 input-append">
									<input class="span*" type="text" id="prdQuoteId2" readonly="readonly">
								</div> -->
								<span class="inline" id="unitName"></span>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="routeTypeId">航线:<span
								style="color: red;">*</span></label>
							<div class="controls">
								<sunivo:shippinglineSelect span="span10" clazz="required"
									name="entity.routeTypeId" value="${entity.routeTypeId}" />
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="prdQuoteId3">币种:</label>
							<div class="controls">
								<!-- <div class="span10 input-append">
									<input class="span*" type="text" id="prdQuoteId3" readonly="readonly">
								</div> -->
								<span class="inline" id="currencyName"></span>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="execDate">生效日期:<span
								style="color: red;">*</span></label>
							<div class="controls">
								<div class="span10 input-append date datetime-picker"
									data-date-minView="month" data-date-format="yyyy-mm-dd">
									<input class="span*" type="text" required id="execDate"
										name="fclQentity.execDate"
										value="<fmt:formatDate value='${fclQentity.execDate}' pattern='yyyy-MM-dd' />"
										readonly placeholder="生效日期"><span class="add-on"><i
										class="icon-remove"></i></span><span class="add-on"><i
										class="icon-calendar"></i></span>
								</div>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="expiryDate">失效日期:<span
								style="color: red;">*</span></label>
							<div class="controls">
								<div class="span10 input-append date datetime-picker"
									data-date-minView="month" data-date-format="yyyy-mm-dd">
									<input class="span*" type="text" required id="expiryDate"
										name="fclQentity.expiryDate"
										value="<fmt:formatDate value='${fclQentity.expiryDate}' pattern='yyyy-MM-dd' />"
										readonly placeholder="失效日期"><span class="add-on"><i
										class="icon-remove"></i></span><span class="add-on"><i
										class="icon-calendar"></i></span>
								</div>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="importExportFlag">进出口:<span
								style="color: red;">*</span></label>
							<div class="controls">
								<%-- <sunivo:importExportFlagSelect clazz="required" disabled="true"
									value="${entity.importExportFlag}" span="span10" /> --%>
								出口
								<input type="hidden" name="entity.importExportFlag"
									value="${entity.importExportFlag}">
							</div>
						</div>
						<div class="span6 control-group"></div>
					</div>

					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>成本报价</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="prdQuoteId4">每票:</label>
							<div class="controls">
								<input type="text" class="span10  positiveNumber" id="prdQuoteId4"
									placeholder="成本价" name="fclQentity.nonContainerCost"
									value="${fclQentity.nonContainerCost }">
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="gp20">20'GP:</label>
							<div class="controls">
								<input type="text" class="span10  positiveNumber" id="gp20"
									placeholder="成本价" name="fclQentity.cost20gp"
									value="${fclQentity.cost20gp}">
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="gp40">40'GP:</label>
							<div class="controls">
								<div class="span10 input-append">
									<input class="span*  positiveNumber" type="text" id="gp40"
										placeholder="成本价" name="fclQentity.cost40gp"
										value="${fclQentity.cost40gp}">
								</div>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="hq40">40'HQ:</label>
							<div class="controls">
								<div class="span10 input-append">
									<input class="span*  positiveNumber" type="text" id="hq40"
										placeholder="成本价" name="fclQentity.cost40hq"
										value="${fclQentity.cost40hq}">
								</div>
							</div>
						</div>
					</div>

					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>备注</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span12 control-group">
							<label class="control-label" for="remark">备注:</label>
							<div class="controls">
								<textarea class="span12" id="remark" rows="3" placeholder="备注信息"
									name="fclQentity.remark" value="${fclQentity.remark}"></textarea>
								<span class="label label-warning pull-right">备注最多输入300个字符</span>
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