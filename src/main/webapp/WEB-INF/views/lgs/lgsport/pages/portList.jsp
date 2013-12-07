<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>海运整箱本地费维护</title>
<script type="text/javascript">
	$(document).ready(function() {
		$("#portAdd").click(function() {
			window.location.href = "${ctx}/lgsport/portAdd";
		});

		$("#portQuoteImport").click(function() {

			SunivoUtil.createRemoteModal("上传报价", "${ctx}/lgsquoteimport/surchargeUploadSection/2", {}, function() {
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
						url : '${ctx}/lgsquoteimport/fclSurchargeUploadDealSection/2',
						type : 'POST',
						data : {
							"token" : $("#token").val()
						},
						fileElementId : 'file',
						dataType : 'text',
						success : function(data, status) {
							//data = data.substring(1,data.lastIndexOf("\""));
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

	/**
	 * portId 本地费表ID
	 * quoteId 报价ID
	 */
	function diabledPort(quoteId, status) {
		SunivoUtil.createModal("状态更新", //标题
		"您确认更新该条本地费记录的状态吗？", function() {
			$.ajax({
				url : '${ctx}/lgsport/modifyPortStatus/' + quoteId + "/" + status,
				type : 'get',
				success : function(msg) {
					//SunivoUtil.showAlertMessage($("#message"),"状态设置成功！","warn");
					window.location.reload();
				},
				error : function() {
					//alert('error');
					SunivoUtil.showAlertMessage($("#message"), "状态设置失败！", "error");
				}
			});
			return true;
		}, //回调函数
		"确认");//确认按钮上面的文本
	}
	function deletePort(quoteId) {
		SunivoUtil.createModal("本地费删除", "您确认删除该条本地费记录吗？", function() {
			$.ajax({
				url : '${ctx}/lgsport/deletePort/' + quoteId,
				type : 'get',
				success : function(msg) {
					window.location.reload();
				},
				error : function() {
					SunivoUtil.showAlertMessage($("#message"), "本地费删除失败！", "error");
				}
			});
			return true;
		}, //回调函数
		"确认");//确认按钮上面的文本
	}
	/**
	 * portId 本地费表ID
	 * quoteId 报价ID
	 */
	function portEdit(portId, quoteId) {
		window.location.href = "${ctx}/lgsport/portEdit/" + quoteId;
	}

	function portQuoteImport() {
		// window.location.href = "${ctx}/lgsport/surchargeUploadSection";
		window.open("${ctx}/lgsquoteimport/surchargeUploadSection/2");
	}
</script>
</head>
<body>
	<!-- 流式布局，页面上部空出50px-->
	<div class="row-fluid sunivoPage">
		<!-- 页面内容置中，左右各留span1 -->
		<div class="span10 offset1">
			<div id="message"></div>
			<sunivo:token />
			<!-- 页头  begin -->
			<div class="row-fluid">
				<div class="sunivoTitle span12">
					<div class="span5">
						<h1 class="pageTitle">海运整箱本地费列表</h1>
					</div>
					<div class="span5">
						<!-- <span> 共计 <font class="statistics">10</font>个样例： <font
							class="statistics">6</font>个列表， <font class="statistics">4</font>个表单
						</span> -->
					</div>
					<div class="span2" align="right">
						<span> <a id='' class="pull-right i icon-download icon-2x "
							title="本地费报价模板下载"
							href='${ctx}/lgsquoteimport/download/template_port_quote'
							style="margin-right: 10px;"></a> <i
							class="pull-right icon-upload icon-2x pointer"
							id="portQuoteImport" title="本地费导入" style="margin-right: 20px;"></i>
							<i class="pull-right icon-plus icon-2x pointer" id="portAdd"
							title="新增" style="margin-right: 20px;"></i>
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
						<li class="active">海运整箱本地费列表</li>
					</ul>
				</div>
			</div>
			<!-- 面包屑 end -->

			<!-- 水平表单 begin -->
			<form id="filterForm" class="form-horizontal" action="${ctx}/lgsport"
				method="get">

				<div class="sunivoFilterForm">
					<div class="row-fluid">
						<div class="span12">
							<div class="span11 filterCondition">
								<span> <sunivo:shipPortSelect span="span2"
										placeHolderMessageCode="起运港" name="search_EQ_shipmentPortId"
										value="${param['search_EQ_shipmentPortId']}" /> <sunivo:logisticsCompanySelect
										span="span2" cusLogisticType="01" placeHolderMessageCode="船公司"
										name="search_EQ_agentId" value="${param['search_EQ_agentId']}" />

									<sunivo:shippinglineSelect span="span2"
										placeHolderMessageCode="航线" name="search_EQ_routeTypeId"
										value="${param['search_EQ_routeTypeId']}" /> <sunivo:disabledFlagSelect
										name="search_EQ_status" clazz="span2"
										placeHolderMessageCode="状态"
										value="${param['search_EQ_status']}" /> <!-- <input type="text" class="span2" placeholder="费用名称select标签" name=""> -->
									<!-- 
									<select name="search_EQ_status" class="span2" >
										<option value="">全部</option>
										<option value="0">有效</option>
										<option value="1">失效</option>
									</select>
									 -->

								</span>
							</div>
							<!-- 							<div class="span1 filterAction">
								<span> <i class="pull-right icon-search icon-2x pointer"
									style="margin-right: 10px;" onclick="$('#filterForm').submit();"></i>
								</span>
							</div>
 -->
						</div>
					</div>
					<div class="row-fluid">
						<div class="span12">

							<div class="span11 filterCondition">
								<span> <%-- <div class="span3 input-append date datetime-picker" data-date-minView="month" data-date-format="yyyy-mm-dd">
										<input class="span10" type="text" value="${param['search_GT_execDateBegin']}"
											id="execDateBegin" name="search_GT_execDateBegin"
											readonly placeholder="生效日期(始)"><span class="add-on"><i
											class="icon-remove"></i></span><span class="add-on"><i
											class="icon-calendar"></i></span>
									</div>
									<div class="span3 input-append date datetime-picker" data-date-minView="month" data-date-format="yyyy-mm-dd">
										<input class="span10" type="text" value="${param['search_LT_execDateEnd']}"
											id="execDateEnd" name="search_LT_execDateEnd"
											readonly placeholder="生效日期(止)"><span class="add-on"><i
											class="icon-remove"></i></span><span class="add-on"><i
											class="icon-calendar"></i></span>
									</div> --%>
									<div class="span3 input-append date datetime-picker"
										data-date-minView="month" data-date-format="yyyy-mm-dd"
										style="float: left; margin-left: 0px; height: 30px;">
										<input class="span10" type="text"
											value="${param['search_GTE_execDateBegin']}"
											id="execDateBegin" name="search_GTE_execDateBegin" readonly
											placeholder="生效日期(始)"> <span class="add-on"><i
											class="icon-remove"></i></span> <span class="add-on"><i
											class="icon-calendar"></i></span>
									</div>
									<div class="span3 input-append date datetime-picker"
										data-date-minView="month" data-date-format="yyyy-mm-dd"
										style="float: left; margin-left: 5px; height: 30px;">
										<input class="span10" type="text"
											value="${param['search_LT_execDateEnd']}" id="execDateEnd"
											name="search_LT_execDateEnd" readonly placeholder="生效日期(止)">
										<span class="add-on"><i class="icon-remove"></i></span> <span
											class="add-on"><i class="icon-calendar"></i></span>
									</div>
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
				<!-- FOR -->
				<c:forEach items="${objectList}" var="obj">
					<div class="row-fluid">
						<div class="span12">
							<!-- 最左列，通常放入可唯一识别当前记录的字段，比如客户名，如没有，可放入ID -->
							<div class="number span2">
								<span> <a href="${ctx}/lgsport/portDetail/${obj.id }"
									title="详情">${obj.id }</a>
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
												<span class="inline"><sunivo:shipPortView
														value="${obj.shipmentPortId }" />&nbsp;</span>
											</dd>
											<dt>船公司：</dt>
											<dd>
												<span class="inline"><sunivo:customerView
														value="${obj.agentId }" />&nbsp;</span>
											</dd>

											<dt>生效日期：</dt>
											<dd>
												<fmt:formatDate value='${obj.execDate }'
													pattern='yyyy-MM-dd' />
											</dd>
											<dt>失效日期：</dt>
											<dd>
												<fmt:formatDate value='${obj.expiryDate }'
													pattern='yyyy-MM-dd' />
											</dd>
											<%-- 
										<dt>航线名称：</dt>
										<dd><span class="inline"><sunivo:shippinglineView
												value="${obj.routeTypeId }" />&nbsp;</span></dd>
										<dt>费用名称：</dt>
										<dd>${obj.prdQuoteId }</dd> 
										--%>
										</dl>
									</div>
									<!-- 第二 列 -->
									<%-- 
								<div class="span3">
									<dl class="dl-horizontal">
										<dt>计价单位：</dt>
										<dd>${obj.prdQuoteId }</dd>
										<dt>币种：</dt>
										<dd>${obj.prdQuoteId }</dd>
										<dt>生效日期：</dt>
										<dd><fmt:formatDate value='${obj.execDate }' pattern='yyyy-MM-dd' /></dd>
										<dt>失效日期：</dt>
										<dd><fmt:formatDate value='${obj.expiryDate }' pattern='yyyy-MM-dd' /></dd>
									</dl>
								</div>
								 --%>
									<!-- 第三 列 -->
									<div class="span4">
										<dl class="dl-horizontal">
											<dt>每票单价：</dt>
											<dd>
												<c:if test="${obj.nonContainerCost ne null}">
													<sunivo:moneyFormatView money="${obj.nonContainerCost }" />￥
											</c:if>
											</dd>
											<dt>20GP单价：</dt>
											<dd>
												<c:if test="${obj.cost20gp ne null}">
													<sunivo:moneyFormatView money="${obj.cost20gp }" />￥
											</c:if>
											</dd>
											<dt>40GP单价：</dt>
											<dd>
												<c:if test="${obj.cost40gp ne null}">
													<sunivo:moneyFormatView money="${obj.cost40gp }" />￥
											</c:if>
											</dd>
											<dt>40HQ单价：</dt>
											<dd>
												<c:if test="${obj.cost40hq ne null}">
													<sunivo:moneyFormatView money="${obj.cost40hq }" />￥
											</c:if>
											</dd>
										</dl>
									</div>
									<!-- 第四 列 -->
									<div class="span4">
										<dl class="dl-horizontal">
											<dt>状态：</dt>
											<dd>
												<c:choose>
													<c:when test="${obj.status == 2}">已过期</c:when>
													<c:when test="${obj.status == 1}">停用</c:when>
													<c:otherwise>启用</c:otherwise>
												</c:choose>
											</dd>
											<dt>费用名称</dt>
											<dd>
												<sunivo:feeNameView value="${obj.prdQuoteId}" />
											</dd>
											<dt>创建人：</dt>
											<dd>${obj.createUserName }</dd>
											<dt>创建时间：</dt>
											<dd>
												<fmt:formatDate value='${obj.createDatetime }'
													pattern='yyyy-MM-dd HH:mm:ss' />
											</dd>
										</dl>
									</div>
								</div>
							</div>
							<!-- 操作按钮  说明： 按钮每行至多放三个，超过三个，请用<br>换行 -->
							<div class="action span1">
								<span> <c:choose>
										<c:when test="${0 == obj.status }">
											<!-- 当前为启用，可禁用 -->
											<i class="pull-left icon-lock pointer"
												style="margin-right: 20px;"
												onclick="diabledPort('${obj.id}','${obj.status}')"
												title="禁用"></i>
										</c:when>
										<c:when test="${1 == obj.status }">
											<!-- 当前为禁用，可启用 -->
											<i class="pull-left icon-unlock pointer"
												style="margin-right: 20px;"
												onclick="diabledPort('${obj.id}','${obj.status}')"
												title="启用"></i>
										</c:when>
									</c:choose> <i onclick="portEdit('${obj.portId}','${obj.id}');" title="编辑"
									class="pull-left icon-edit pointer" style="margin-right: 20px;"></i>
									<i class="icon-eye-open pointer pull-left" title="详情"
									onclick="window.location='${ctx}/lgsport/portDetail/${obj.id }'"
									style="margin-right: 20px;"></i> <i
									class="icon-minus pointer pull-left" title="删除"
									onclick="deletePort('${obj.id}')" style="margin-right: 95px;"></i>
								</span>
							</div>
						</div>
					</div>
				</c:forEach>
				<!-- end FOR -->
			</div>



			<!-- 分页 -->
			<div class="row-fluid">
				<sunivo:pagination page="${page}" />
			</div>
		</div>


	</div>

	<!-- 导入报价 -->
	<div id="popSurchargeUploadSection"></div>

</body>
</html>
