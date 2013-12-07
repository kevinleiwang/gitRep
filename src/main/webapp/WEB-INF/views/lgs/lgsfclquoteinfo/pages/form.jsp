<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
<c:choose>
	<c:when test="${action=='edit'}">
		<c:set var="title" value="海运整箱海运费编辑" />
	</c:when>
	<c:when test="${action=='create'}">
		<c:set var="title" value="海运整箱海运费新增" />
	</c:when>
	<c:otherwise>
		<c:set var="title" value="海运整箱海运费详情" />
	</c:otherwise>
</c:choose>
<title><c:out value="${title }" /></title>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						
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
							var cost20gp = $(
									"input[name='fclQsurchargeEntities.cost20gp']")
									.val();
							var cost40gp = $(
									"input[name='fclQsurchargeEntities.cost40gp']")
									.val();
							var cost40hq = $(
									"input[name='fclQsurchargeEntities.cost40hq']")
									.val();							
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
							var success = checkCostMoney(
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
						checkCostMoney = function(cost20gp,
								cost40gp, cost40hq) {
							var success = "";
							// 判断金额的小数位数
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
</script>
</head>
<body>
	<div class="row-fluid sunivoPage">
		<!-- 水平表单 begin -->
		<form id="input_form" class="form-horizontal valid" name="input_form"
			method="post"
			action="${ctx}/lgsfclquoteinfo<c:if test="${action=='edit'}">/${entity.id}</c:if>">
			<!-- 页面内容置中，左右各留span1 -->
			<div class="span10 offset1">
				<div id="message"></div>
				<sunivo:flushMessage />
				<input type="hidden" name="fclQuoteEntity.id"
					id="entity.id"
					value="${entity.id}">
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
										href="${ctx}/lgsaddationquoteinfo/${ssurchargeEntity.id}?action=edit"
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
							<li><a href="${ctx}/lgsfclquoteinfo?search_EQ_status=0">海运整箱海运费列表</a> <span
								class="divider">/</span></li>
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
								for="entity.shipmentPortId">起运港<c:choose>
									<c:when test="${action=='create'}">
										<font color="red">*</font>
									</c:when>
								</c:choose>:
							</label>

							<div class="controls">
								<c:choose>
									<c:when test="${action=='create'}">
										<sunivo:shipPortSelect
											name="fclQuoteEntity.shipmentPortId"
											value="${entity.shipmentPortId}"
											span="span10" clazz="required" placeHolderMessageCode="起运港" />
										<font color="red"><form:errors
												path="lgsFclQuoteInfoAddVo.fclQuoteEntity.shipmentPortId" /></font>
									</c:when>
									<c:otherwise>
										<span class="inline"><sunivo:shipPortView
												value="${entity.shipmentPortId}" />&nbsp;</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label"
								for="entity.shipmentPortId">目的港<c:choose>
									<c:when test="${action=='create'}">
										<font color="red">*</font>
									</c:when>
								</c:choose>:
							</label>

							<div class="controls">
								<c:choose>
									<c:when test="${action=='create'}">
										<sunivo:shipPortSelect
											name="fclQuoteEntity.destinationPortId"
											value="${entity.destinationPortId}"
											span="span10" clazz="required" placeHolderMessageCode="目的港" />
										<font color="red"><form:errors
												path="lgsFclQuoteInfoAddVo.fclQuoteEntity.destinationPortId" /></font>
									</c:when>
									<c:otherwise>
										<span class="inline"><sunivo:shipPortView
												value="${entity.destinationPortId}" />&nbsp;</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label"
								for="fclQuoteEntity.agentId">船公司<c:choose>
									<c:when test="${action=='create'}">
										<font color="red">*</font>
									</c:when>
								</c:choose>:
							</label>

							<div class="controls">
								<c:choose>
									<c:when test="${action=='create'}">
										<sunivo:logisticsCompanySelect cusLogisticType="01"
											name="fclQuoteEntity.agentId"
											value="${entity.agentId }" span="span10"
											clazz="required" placeHolderMessageCode="船公司" />
										<font color="red"><form:errors
												path="lgsFclQuoteInfoVo.fclQuoteInfoEntity.agentId" /></font>
									</c:when>
									<c:otherwise>
										<span class="inline"><sunivo:customerView
												value="${entity.agentId}" />&nbsp;</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label"
								for="fclQuoteEntity.carrierId">货代公司<c:choose>
									<c:when test="${action=='create'}">
										<font color="red">*</font>
									</c:when>
								</c:choose>:
							</label>

							<div class="controls">
								<c:choose>
									<c:when test="${action=='create'}">
										<sunivo:logisticsCompanySelect cusLogisticType="01"
											name="fclQuoteEntity.carrierId"
											value="${entity.carrierId }" span="span10"
											clazz="required" placeHolderMessageCode="货代公司" />
										<font color="red"><form:errors
												path="lgsFclQuoteInfoVo.fclQuoteInfoEntity.carrierId" /></font>
									</c:when>
									<c:otherwise>
										<span class="inline"><sunivo:customerView
												value="${entity.carrierId}" />&nbsp;</span>
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
								<span class="inline">海运费</span>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">费用单位&nbsp;:</label>
							<div class="controls">
								<span class="inline">柜</span>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label"
								for="fclQuoteEntity.routeTypeId">航线<c:choose>
									<c:when test="${action=='create'}">
										<font color="red">*</font>
									</c:when>
								</c:choose>:
							</label>

							<div class="controls">
								<c:choose>
									<c:when test="${action=='create'}">
										<sunivo:shippinglineSelect
											name="fclQuoteEntity.routeTypeId"
											value="${entity.routeTypeId}"
											span="span10" clazz="required" placeHolderMessageCode="航线" />
										<font color="red"><form:errors
												path="lgsFclQuoteInfoVo.fclQuoteInfoEntity.routeTypeId" /></font>
									</c:when>
									<c:otherwise>
										<span class="inline"><sunivo:shippinglineView
												value="${entity.routeTypeId}" />&nbsp;</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">币种&nbsp;:</label>
							<div class="controls">
								<span class="inline">美元</span>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">预计航程:</label>
							<div class="controls" style="word-break: break-all;">
								<c:choose>
									<c:when test="${action=='create' || action=='edit'}">
										<input id="fclQuoteEntity.estimatedRange"
											name="fclQuoteEntity.estimatedRange" rows="6" cols=""
											class="span12" placeholder="预计航程" maxlength="300" value="${entity.estimatedRange}" />
										<span class="label label-warning pull-right"></span>
									</c:when>
									<c:otherwise>
										<c:out value="${entity.estimatedRange}" />
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">预计船期:</label>
							<div class="controls" style="word-break: break-all;">
								<c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<select data-placeholder="请选择" id="fclQuoteEntity.estimatedSalingdate" name="fclQuoteEntity.estimatedSalingdate" style="width:413px;" multiple="multiple" class="chosen-with-diselect span6">
											<option value="星期一" <c:forEach items="${entity.estimatedSalingdateValues}" var="estimatedSalingdate">
																	<c:if test="${estimatedSalingdate eq '星期一'}">
																	selected="selected"
																	</c:if> 
																 </c:forEach> >星期一</option>
											<option value="星期二" <c:forEach items="${entity.estimatedSalingdateValues}" var="estimatedSalingdate">
																	<c:if test="${estimatedSalingdate eq '星期二'}">
																	selected="selected"
																	</c:if> 
																 </c:forEach> >星期二</option>
											<option value="星期三" <c:forEach items="${entity.estimatedSalingdateValues}" var="estimatedSalingdate">
																	<c:if test="${estimatedSalingdate eq '星期三'}">
																	selected="selected"
																	</c:if> 
																 </c:forEach> >星期三</option>
											<option value="星期四" <c:forEach items="${entity.estimatedSalingdateValues}" var="estimatedSalingdate">
																	<c:if test="${estimatedSalingdate eq '星期四'}">
																	selected="selected"
																	</c:if> 
																 </c:forEach> >星期四</option>
											<option value="星期五" <c:forEach items="${entity.estimatedSalingdateValues}" var="estimatedSalingdate">
																	<c:if test="${estimatedSalingdate eq '星期五'}">
																	selected="selected"
																	</c:if> 
																 </c:forEach> >星期五</option>
											<option value="星期六" <c:forEach items="${entity.estimatedSalingdateValues}" var="estimatedSalingdate">
																	<c:if test="${estimatedSalingdate eq '星期六'}">
																	selected="selected"
																	</c:if> 
																 </c:forEach> >星期六</option>
											<option value="星期日" <c:forEach items="${entity.estimatedSalingdateValues}" var="estimatedSalingdate">
																	<c:if test="${estimatedSalingdate eq '星期日'}">
																	selected="selected"
																	</c:if> 
																 </c:forEach> >星期日</option>
										</select>
										<font color="red"><form:errors path="lgsFclQuoteInfoVo.entity.estimatedSalingdate" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.estimatedSalingdate}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
							</div>
						</div>
				    </div>
				    <div class="row-fluid">
                        <div class="span6 control-group">
                            <label title="是否为优势航线" class="control-label">是否为优势...：</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<select style="width:50px;" name="fclQuoteEntity.ifAdvantageResource">
											<option value="1" <c:if test="${entity.ifAdvantageResource eq 1}">selected="selected"</c:if> >是</option>
											<option value="0" <c:if test="${entity.ifAdvantageResource eq null || entity.ifAdvantageResource ne 1}">selected="selected"</c:if>>否</option>
									    </select>
										<font color="red"><form:errors path="entity.ifAdvantageResource" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline"><c:if test="${entity.ifAdvantageResource eq 1}">是</c:if>
                                        					<c:if test="${entity.ifAdvantageResource eq null || entity.ifAdvantageResource ne 1}" >否</c:if>&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">中转港：</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
                                    	<sunivo:shipPortSelect name="fclQuoteEntity.enterportId" value="${entity.enterportId}"/>
										<font color="red"><form:errors path="lgsFclQuoteInfoVo.entity.enterportId" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline"><sunivo:shipPortView value="${entity.enterportId}"/>&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<%@ include file="../../lgsfclquoteinfo/pages/surchargeFormFragment.jsp"%>
				</div>
			</div>
		</form>
		<!-- 水平表单 end -->
	</div>
</body>
</html>