<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>海运整箱附加费列表</title>
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
		var title = "禁用海运整箱附加费";
		var message = "确认禁用该海运整箱附加费？";
		if (0 == status) {
			title = "启用海运整箱附加费";
			message = "确认启用该海运整箱附加费？";
		}
		SunivoUtil.createModal(title, message, function() {
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

	// 附加费导入
	function addationQuoteImport() {
		window.open("${ctx}/lgsquoteimport/surchargeUploadSection/3");
	}

	$(document).ready(function() {
		$("#addationQuoteImport").click(function() {
			SunivoUtil.createRemoteModal("上传报价", "${ctx}/lgsquoteimport/surchargeUploadSection/3", {}, function() {
				validValue = $('form', '#modal_body').valid();
				var fileStr = $("#file").val();
				if (null == fileStr || "" == fileStr || undefined == fileStr) {
					//alert("请选择文件!");	
					$("#quote_message").text($("#quote_message").text() + ",请选择文件!");
					return false;
				}
				$("#quote_message").text("请上传excel文件");
				var fileType = fileStr.substring(fileStr.lastIndexOf(".") + 1);
				if ("xls" != fileType && "xlsx" != fileType) {
					//alert("上传文件类型错误x!");
					$("#quote_message").text($("#quote_message").text() + ",上传文件类型错误!");
					return false;
				}
				$("#quote_message").text("请上传excel文件");
				if (validValue) {
					//开始发送数据
					//alert('开始发送数据');

					$.ajaxFileUpload({
						url : '${ctx}/lgsquoteimport/fclSurchargeUploadDealSection/3',
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
	<!-- 流式布局，页面上部空出50px-->
	<div class="row-fluid sunivoPage">
		<!-- 页面内容置中，左右各留span1 -->
		<div class="span10 offset1">
			<div id="message"></div>
			<sunivo:flushMessage />
			<sunivo:token />
			<!-- 页头  begin -->
			<div class="row-fluid">
				<div class="sunivoTitle span12">
					<div class="span8">
						<h1 class="pageTitle">海运整箱附加费列表</h1>
					</div>
					<!-- <div class="span5">
						<span> 共计 <font class="statistics">10</font>个样例： <font
							class="statistics">6</font>个列表， <font class="statistics">4</font>个表单
						</span>

					</div> -->
					<div class="span4" align="right">
						<span> <a id='' class="pull-right i icon-download icon-2x "
							title="附加费报价模板下载"
							href='${ctx}/lgsquoteimport/download/template_addation_quote'
							style="margin-right: 10px;"></a><i
							class="pull-right icon-upload icon-2x pointer"
							id="addationQuoteImport" title="附加费导入"
							style="margin-right: 20px;"></i> <a
							href="${ctx}/lgsaddationquoteinfo?action=create"
							class="pull-right icon-plus icon-2x pointer i" title="新增"
							style="margin-right: 20px;"></a>
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
						<li class="active">海运整箱附加费列表</li>
					</ul>
				</div>
			</div>
			<!-- 面包屑 end -->

			<!-- 水平表单 begin -->
			<form id="filterForm" class="form-horizontal"
				action="${ctx}/lgsaddationquoteinfo" method="GET">
				<div class="sunivoFilterForm">
					<div class="row-fluid">
						<div class="span12">
							<div class="span11 filterCondition">
								<sunivo:shipPortSelect name="search_EQ_shipmentPortId"
									value="${param['search_EQ_shipmentPortId']}" span="span2"
									placeHolderMessageCode="起运港" />
								<sunivo:shippinglineSelect name="search_EQ_routeTypeId"
									value="${param['search_EQ_routeTypeId']}" span="span2"
									placeHolderMessageCode="航线" />
								<sunivo:disabledFlagSelect name="search_EQ_status"
									value="${param['search_EQ_status']}" span="span2"
									placeHolderMessageCode="状态" />
								<sunivo:feeNameSelect name="search_EQ_prdQuoteId"
									value="${param['search_EQ_prdQuoteId']}" span="span2"
									placeHolderMessageCode="费用名称" importExportFlag="1"
									originalId="11000150" />

							</div>
							<div class="span1 filterAction">&nbsp;</div>
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
								<div class="span6" style="float: right">&nbsp;</div>
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
				<c:forEach items="${vos}" var="vo">
					<div class="row-fluid">
						<div class="span12">
							<!-- 最左列，通常放入可唯一识别当前记录的字段，比如客户名，如没有，可放入ID -->
							<div class="number span2">
								<span> <a title="详情"
									href="${ctx}/lgsaddationquoteinfo/${vo.fclQsurchargeEntity.id}">${vo.fclQsurchargeEntity.id}</a>
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
													value="${vo.addationQuoteInfoEntity.shipmentPortId}" />
											</dd>
											<dt>航线：</dt>
											<dd>
												<sunivo:shippinglineView
													value="${vo.addationQuoteInfoEntity.routeTypeId}" />
											</dd>
											<dt>生效时间：</dt>
											<dd>
												<fmt:formatDate value="${vo.fclQsurchargeEntity.execDate }"
													pattern="yyyy-MM-dd" />
											</dd>
											<dt>失效时间：</dt>
											<dd>
												<fmt:formatDate
													value="${vo.fclQsurchargeEntity.expiryDate }"
													pattern="yyyy-MM-dd" />
											</dd>
										</dl>
									</div>
									<!-- 第二 列 -->
									<div class="span4">
										<dl class="dl-horizontal">
											<dt>每票单价：</dt>
											<dd>
												<c:if
													test="${vo.fclQsurchargeEntity.nonContainerCost ne null}">
													<sunivo:moneyFormatView
														money="${vo.fclQsurchargeEntity.nonContainerCost }" />
													<sunivo:currencyView showType="symbol"
														value="${vo.quoteEntity.currencyId}" />
												</c:if>
											</dd>
											<dt>20GP单价：</dt>
											<dd>
												<c:if test="${vo.fclQsurchargeEntity.cost20gp ne null}">
													<sunivo:moneyFormatView
														money="${vo.fclQsurchargeEntity.cost20gp }" />
													<sunivo:currencyView showType="symbol"
														value="${vo.quoteEntity.currencyId}" />
												</c:if>
											</dd>
											<dt>40GP单价：</dt>
											<dd>
												<c:if test="${vo.fclQsurchargeEntity.cost40gp ne null}">
													<sunivo:moneyFormatView
														money="${vo.fclQsurchargeEntity.cost40gp }" />
													<sunivo:currencyView showType="symbol"
														value="${vo.quoteEntity.currencyId}" />
												</c:if>
											</dd>
											<dt>40HQ单价：</dt>
											<dd>
												<c:if test="${vo.fclQsurchargeEntity.cost40hq ne null}">
													<sunivo:moneyFormatView
														money="${vo.fclQsurchargeEntity.cost40hq }" />
													<sunivo:currencyView showType="symbol"
														value="${vo.quoteEntity.currencyId}" />
												</c:if>
											</dd>
										</dl>
									</div>
									<!-- 第三 列 -->
									<div class="span4">
										<dl class="dl-horizontal">
											<dt>费用名称：</dt>
											<dd>${vo.quoteEntity.name}</dd>
											<dt>状态：</dt>
											<dd>
												<sunivo:disabledFlagView
													value="${vo.fclQsurchargeEntity.status }" />
											</dd>
											<dt>更新人：</dt>
											<dd>${vo.fclQsurchargeEntity.updateUsername }</dd>
											<dt>更新时间：</dt>
											<dd>
												<fmt:formatDate
													value="${vo.fclQsurchargeEntity.updateDatetime }"
													pattern="yyyy-MM-dd HH:mm:ss" />
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
								<span> <c:choose>
										<c:when test="${0 == vo.fclQsurchargeEntity.status }">
											<!-- 当前为启用，可禁用 -->
											<i class="pull-left icon-lock pointer"
												style="margin-left: 15px;"
												onclick="changeStatus('${vo.fclQsurchargeEntity.id}', 1);"
												title="禁用"></i>
										</c:when>
										<c:when test="${1 == vo.fclQsurchargeEntity.status }">
											<!-- 当前为禁用，可启用 -->
											<i class="pull-left icon-unlock pointer"
												style="margin-left: 15px;"
												onclick="changeStatus('${vo.fclQsurchargeEntity.id}', 0);"
												title="启用"></i>
										</c:when>
									</c:choose> <i
									onclick="window.location='${ctx}/lgsaddationquoteinfo/${vo.fclQsurchargeEntity.id}?action=edit'"
									class="pull-left icon-edit pointer" style="margin-left: 15px;"
									title="编辑"></i><i
									onclick="window.location='${ctx}/lgsaddationquoteinfo/${vo.fclQsurchargeEntity.id}?action=delete'"
									class="pull-left icon-minus pointer" style="margin-left: 15px;"
									title="删除"></i>
								</span>
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