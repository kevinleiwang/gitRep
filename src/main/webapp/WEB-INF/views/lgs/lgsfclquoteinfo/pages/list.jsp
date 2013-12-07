<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>海运整箱报价信息列表</title>

<script type="text/javascript">
	function fclQuoteImport() {
		window.open("${ctx}/lgsquoteimport/surchargeUploadSection/1");
	}

	$(document).ready(function() {
		$("#fclQuoteImport").click(function() {
			SunivoUtil.createRemoteModal("上传报价", "${ctx}/lgsquoteimport/surchargeUploadSection/1", {}, function() {
				validValue = $('form', '#modal_body').valid();
				var fileStr = $("#file").val();
				if (null == fileStr || "" == fileStr || undefined == fileStr) {
					//alert("请选择文件!");	
					$("#quote_message").text("请选择文件!");
					return false;
				}
				$("#quote_message").text("请上传excel文件");
				var fileType = fileStr.substring(fileStr.lastIndexOf(".") + 1);
				if ("xls" != fileType && "xlsx" != fileType) {
					//alert("上传文件类型错误x!");
					$("#quote_message").text("上传文件类型错误!");
					return false;
				}
				$("#quote_message").text("请上传excel文件");
				if (validValue) {
					//开始发送数据
					//alert('开始发送数据');

					$.ajaxFileUpload({
						url : '${ctx}/lgsquoteimport/fclSurchargeUploadDealSection/1',
						type : 'POST',
						data : {
							"token" : $("#token").val()
						},
						fileElementId : 'file',
						dataType : 'text',
						success : function(data, status) {
							if (data == "批量报价成功") {
								$("#describe").val("批量报价成功\r\n");
								$("#file").val("");
								$("#modal_ok_btn").hide();
							} else if (data == "请不要重复提交表单") {
								$("#describe").val("请不要重复提交\r\n" + $("#describe").val());
								$("#file").val("");
								$("#modal_ok_btn").hide();
							} else {
								var nowDate = new Date();
								var nowTimeStr = nowDate.getFullYear() + "-" + nowDate.getMonth() + "-" + nowDate.getDate() + " " + nowDate.getHours() + ":" + nowDate.getMinutes() + ":" + nowDate.getSeconds();
								$("#file").val("");
								$("#describe").val("批量报价未被全部导入数据库，详情请下载结果文件\r\n" + $("#describe").val());
								$("#describe").after("<br/><a id='resultUrl' href='${ctx}/lgsquoteimport/download/"+data+"'>下载</a>(" + nowTimeStr + ")");
								$("#modal_ok_btn").hide();
							}
						},
						error : function(data, status, e) {
							alert("系统错误");
						}
					});
				}
				return false;
			}, "导入");
		});
	});
</script>
</head>
<body>
	<div class="row-fluid sunivoPage">
		<div class="span10 offset1">
			<sunivo:token />
			<!-- 页头 -->
			<div class="sunivoTitle span12">
				<div class="span6">
					<h1 class="pageTitle">海运整箱海运费列表</h1>
				</div>
				<div class="span2"></div>
				<div class="span4" align="right">
					<span> <a id='' class="pull-right i icon-download icon-2x "
						title="海运费报价模板下载"
						href='${ctx}/lgsquoteimport/download/template_fcl_quote'
						style="margin-right: 10px;"></a> <i
						class="pull-right icon-upload icon-2x pointer" id="fclQuoteImport"
						title="海运费导入" style="margin-right: 20px;"></i> <i
						class="pull-right icon-plus icon-2x pointer"
						onclick="window.location.href='${ctx}/lgsfclquoteinfo/toAdd?addNum=5'"
						style="margin-right: 20px;"></i>
					</span>
				</div>
			</div>

			<!-- 面包屑 begin -->
			<div class="row-fluid">
				<div class="span12">
					<ul class="breadcrumb">
						<li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
						<li class="active">海运整箱海运费列表</li>
					</ul>
				</div>
			</div>
			<!-- 面包屑 end -->

			<!-- 检索条件 -->
			<!-- 水平表单 begin -->
			<form class="form-horizontal" action="${ctx}/lgsfclquoteinfo"
				method="get" id="filterForm">
				<div class="sunivoFilterForm">
					<div class="row-fluid">
						<div class="span12">
							<div class="span11 filterCondition">
								<span> <sunivo:logisticsCompanySelect span="span2"
										cusLogisticType="03" name="search_LIKE_carrierId"
										value="${param['search_LIKE_carrierId']}"
										placeHolderMessageCode="货代" /> <sunivo:logisticsCompanySelect
										span="span2" cusLogisticType="01" name="search_LIKE_agentId"
										value="${param['search_LIKE_agentId']}"
										placeHolderMessageCode="船公司" /> <sunivo:shipPortSelect
										span="span2" name="search_LIKE_shipmentPortId"
										placeHolderMessageCode="起运港"
										value="${param['search_LIKE_shipmentPortId']}" /> <!-- 起运港 -->
									<sunivo:shipPortSelect span="span2"
										name="search_LIKE_destinationPortId"
										placeHolderMessageCode="目的港"
										value="${param['search_LIKE_destinationPortId']}" /> <!-- 目的港 -->
									<sunivo:disabledFlagSelect span="span2" name="search_EQ_status"
										value="${param['search_EQ_status']}"
										placeHolderMessageCode="状态" />
								</span>
							</div>

						</div>
					</div>
					<div class="row-fluid">
						<div class="span12">
							<div class="span11 filterCondition">
								<div class="span3 input-append date datetime-picker"
									data-date-minView="month" data-date-format="yyyy-mm-dd"
									style="float: left; margin-left: 0px; height: 30px;">
									<input class="span10" type="text"
										value="${param['search_GTE_execDate']}" id="search_GT_execDate"
										name="search_GTE_execDate" readonly placeholder="生效日期(始)">
									<span class="add-on"><i class="icon-remove"></i></span> <span
										class="add-on"><i class="icon-calendar"></i></span>
								</div>

								<div class="span3 input-append date datetime-picker"
									data-date-minView="month" data-date-format="yyyy-mm-dd"
									style="float: left; margin-left: 5px; height: 30px;">
									<input class="span10" type="text"
										value="${param['search_LT_expiryDate']}"
										id="search_LT_expiryDate" name="search_LT_expiryDate" readonly
										placeholder="生效日期(止)"> <span class="add-on"><i
										class="icon-remove"></i></span> <span class="add-on"><i
										class="icon-calendar"></i></span>
								</div>

							</div>
							<div class="span1 filterAction">
								<span> <i class="pull-right icon-search icon-2x pointer"
									style="margin-right: 10px;"
									onclick="$('#filterForm').submit();"></i>
								</span>
							</div>
						</div>
					</div>

					<%-- 	    <div class="row-fluid">
			<div class="span12">
			
				<div class="span11 filterCondition">
					<span>
						<div class="span4 input-append date datetime-picker" data-date-minView="month" data-date-format="yyyy-mm-dd">
							<input class="span11" type="text" value="${param['search_GT_execDate']}"
								id="execDate" name="search_GT_execDate"
								readonly placeholder="生效日期(始)"><span class="add-on"><i
								class="icon-remove"></i></span><span class="add-on"><i
								class="icon-calendar"></i></span>
						</div>
						<div class="span4 input-append date datetime-picker" data-date-minView="month" data-date-format="yyyy-mm-dd">
							<input class="span11" type="text" value="${param['search_LT_execDate']}"
								id="execDate" name="search_LT_execDate"
								readonly placeholder="生效日期(止)"><span class="add-on"><i
								class="icon-remove"></i></span><span class="add-on"><i
								class="icon-calendar"></i>&nbsp;</span>
						</div>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<sunivo:disabledFlagSelect span="span2" name="search_EQ_status" value="${param['search_EQ_status']}" placeHolderMessageCode="状态"/>		
					</span>
				</div>
				<div class="span1 filterAction">
					<span> <i class="pull-right icon-search icon-2x pointer"
						style="margin-right: 10px;" onclick="$('#filterForm').submit();"></i>
					</span>
				</div>
			</div>
		</div> --%>
				</div>
			</form>

			<!-- 水平表单 end -->
			<div class="sunivoList">
				<!-- FOR begin-->
				<c:forEach items="${lgsAddationQuoteInfos}" var="lgsFclChargeInfoVo">
					<c:set value="${lgsFclChargeInfoVo}" var="entity"></c:set>
					<div class="row-fluid">
						<div class="span12">
							<!-- 最左列，通常放入可唯一识别当前记录的字段，比如客户名，如没有，可放入ID -->
							<div class="number span2">
								<span> <a title="详情"
									href="${ctx}/lgsfclquoteinfo/detail/${entity.id}"> <c:if
											test="${null ne entity.agentId && '' ne entity.agentId}">
											<sunivo:customerView value="${entity.agentId}" />
										</c:if> <c:if
											test="${null eq entity.agentId || '' eq entity.agentId}">
										&nbsp;
									</c:if>
								</a>
								</span>
							</div>
							<!-- 记录要展示的数据，此处按列排，不是按行排 -->
							<div class="content span9">
								<div class="row-fluid">
									<!-- 第一列 -->
									<div class="span3">
										<dl class="dl-horizontal">
											<dt>航线类型：</dt>
											<dd>
												<c:if
													test="${null ne entity.routeTypeId && '' ne entity.routeTypeId}">
													<sunivo:shippinglineView value="${entity.routeTypeId}" />
												</c:if>
												<c:if
													test="${null eq entity.routeTypeId || '' eq entity.routeTypeId}">
												&nbsp;
											</c:if>
											</dd>
											<dt>货代：</dt>
											<dd>
												<c:if
													test="${null ne entity.carrierId && '' ne entity.carrierId}">
													<sunivo:customerView value="${entity.carrierId}" />
												</c:if>
												<c:if
													test="${null eq entity.carrierId || '' eq entity.carrierId}">
												&nbsp;
											</c:if>
											</dd>
											<dt>起运港：</dt>
											<dd>
												<c:if
													test="${null ne entity.shipmentPortId && '' ne entity.shipmentPortId}">
													<sunivo:shipPortView value="${entity.shipmentPortId}" />
												</c:if>
												<c:if
													test="${null eq entity.shipmentPortId || '' eq entity.shipmentPortId}">
												&nbsp;
											</c:if>
											</dd>
											<dt>目的港：</dt>
											<dd>
												<c:if
													test="${null ne entity.destinationPortId && '' ne entity.destinationPortId}">
													<sunivo:shipPortView value="${entity.destinationPortId}" />
												</c:if>
												<c:if
													test="${null eq entity.destinationPortId || '' eq entity.destinationPortId}">
												&nbsp;
											</c:if>
											</dd>
										</dl>
									</div>
									<!-- 第二列 -->
									<div class="span3">
										<dl class="dl-horizontal">
											<dt>20'：</dt>
											<dd>
												<c:if
													test="${null ne entity.cost20gp && '' ne entity.cost20gp}">
													<sunivo:moneyFormatView money="${entity.cost20gp}" />
													<c:choose>
														<c:when test="${surchargeEntity.currencyid eq '3'}">￥</c:when>
														<c:when test="${surchargeEntity.currencyid eq '1'}">$</c:when>
														<c:otherwise>$</c:otherwise>
													</c:choose>
												</c:if>
												<c:if
													test="${null eq entity.cost20gp || '' eq entity.cost20gp}">
												&nbsp;
											</c:if>
											</dd>
											<dt>40'：</dt>
											<dd>
												<c:if
													test="${null ne entity.cost40gp && '' ne entity.cost40gp}">
													<sunivo:moneyFormatView money="${entity.cost40gp}" />
													<c:choose>
														<c:when test="${surchargeEntity.currencyid eq '3'}">￥</c:when>
														<c:when test="${surchargeEntity.currencyid eq '1'}">$</c:when>
														<c:otherwise>$</c:otherwise>
													</c:choose>
												</c:if>
												<c:if
													test="${null eq entity.cost40gp || '' eq entity.cost40gp}">
												&nbsp;
											</c:if>
											</dd>
											<dt>40HQ：</dt>
											<dd>
												<c:if
													test="${null ne entity.cost40hq && '' ne entity.cost40hq}">
													<sunivo:moneyFormatView money="${entity.cost40hq}" />
													<c:choose>
														<c:when test="${surchargeEntity.currencyid eq '3'}">￥</c:when>
														<c:when test="${surchargeEntity.currencyid eq '1'}">$</c:when>
														<c:otherwise>$</c:otherwise>
													</c:choose>
												</c:if>
												<c:if
													test="${null eq entity.cost40hq || '' eq entity.cost40hq}">
												&nbsp;
											</c:if>
											</dd>
											<dt>状态：</dt>
											<dd>
												<sunivo:disabledFlagView value="${entity.status}" />
											</dd>
										</dl>
									</div>
									<!-- 第三列 -->
									<div class="span3">
										<dl class="dl-horizontal">
											<dt>生效日期：</dt>
											<dd>
												<c:if
													test="${null ne entity.execDate && '' ne entity.execDate}">
													<fmt:formatDate value='${entity.execDate}'
														pattern='yyyy-MM-dd' />
												</c:if>
												<c:if
													test="${null eq entity.execDate || '' eq entity.execDate}">
												&nbsp;
											</c:if>
											</dd>
											<dt>失效日期：</dt>
											<dd>
												<c:if
													test="${null ne entity.expiryDate && '' ne entity.expiryDate}">
													<fmt:formatDate value='${entity.expiryDate}'
														pattern='yyyy-MM-dd' />
												</c:if>
												<c:if
													test="${null eq entity.expiryDate || '' eq entity.expiryDate}">
												&nbsp;
											</c:if>
											</dd>
											<dt>预计船期：</dt>
											<dd>
												<c:if
													test="${null ne entity.estimatedSalingdate && '' ne entity.estimatedSalingdate}">
													<c:out value="${entity.estimatedSalingdate}" />
												</c:if>
												<c:if
													test="${null eq entity.estimatedSalingdate || '' eq entity.estimatedSalingdate}">
												&nbsp;
											</c:if>
											</dd>
											<dt>预计航程：</dt>
											<dd>
												<c:if
													test="${null ne entity.estimatedRange && '' ne entity.estimatedRange}">
													<c:out value="${entity.estimatedRange}" />
												</c:if>
												<c:if
													test="${null eq entity.estimatedRange || '' eq entity.estimatedRange}">
												&nbsp;
											</c:if>
											</dd>
										</dl>
									</div>
									<!-- 第四列 -->
									<div class="span3">
										<dl class="dl-horizontal">
											<dt></dt>
											<dd></dd>
											<dt></dt>
											<dd></dd>
											<dt>更新人：</dt>
											<dd>
												<c:if
													test="${null ne entity.updateUsername && '' ne entity.updateUsername}">
													<c:out value="${entity.updateUsername}" />
												</c:if>
												<c:if
													test="${null eq entity.updateUsername || '' eq entity.updateUsername}">
												&nbsp;
											</c:if>
											</dd>
											<dt>更新日期：</dt>
											<dd>
												<c:if
													test="${null ne entity.updateDatetime && '' ne entity.updateDatetime}">
													<span
														title="<fmt:formatDate value='${entity.updateDatetime}' pattern='yyyy-MM-dd HH:mm:ss' />">
														<fmt:formatDate value='${entity.updateDatetime}'
															pattern='yyyy-MM-dd HH:mm:ss' />
													</span>
												</c:if>
												<c:if
													test="${null eq entity.updateDatetime || '' eq entity.updateDatetime}">
												&nbsp;
											</c:if>
											</dd>
										</dl>
									</div>
								</div>
							</div>

							<!-- 操作按钮 -->
							<div class="action span1">
								<span> <c:choose>
										<c:when test="${0 == entity.status }">
											<!-- 当前为启用，可禁用 -->
											<i class="pull-left icon-lock pointer"
												style="margin-left: 15px;"
												onclick="changeStatus('${entity.surchargeId}', 1);"
												title="禁用"></i>
										</c:when>
										<c:when test="${1 == entity.status }">
											<!-- 当前为禁用，可启用 -->
											<i class="pull-left icon-unlock pointer"
												style="margin-left: 15px;"
												onclick="changeStatus('${entity.surchargeId}', 0);"
												title="启用"></i>
										</c:when>
									</c:choose> <i
									onclick="window.location='${ctx}/lgsfclquoteinfo/${entity.id}?action=edit'"
									class="pull-left icon-edit pointer" style="margin-left: 15px;"
									title="编辑"></i> <i class="icon-eye-open pointer pull-left"
									title="报价预览" style="margin-left: 15px;"
									onclick="window.location='${ctx}/lgsfclquoteinfo/detail/${entity.id}'"></i>
								</span>
							</div>

						</div>
					</div>
				</c:forEach>
			</div>
			<div class="row-fluid">
				<sunivo:pagination page="${page}" />
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function changeStatus() {
			var id = arguments.length > 0 ? arguments[0] : null;
			if (null == id) {
				// ID不能为空
				return;
			}
			var status = arguments.length > 1 ? arguments[1] : null;
			if (null == status) {
				// status不能为空
				return;
			}
			SunivoUtil.createModal("确认修改状态", "确认修改状态？", function() {
				$.ajax({
					url : ctx + "/lgsaddationquoteinfo/changeStatus",
					type : "POST",
					cache : false,
					dataType : "json",
					data : {
						"id" : id,
						"status" : status
					},
					success : function(data) {
						// 修改成功
						if ("OK" == data.status) {
							window.location.reload();
						} else {
							SunivoUtil.showAlertMessage("#message", "修改失败", "error");
						}
					}
				});
				return true;
			}, "确定");
		}
	</script>
</body>
</html>