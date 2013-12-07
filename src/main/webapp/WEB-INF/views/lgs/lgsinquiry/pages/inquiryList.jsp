<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>询价列表</title>
<script type="text/javascript">
<%--
	$(document).ready(
					function() {
						$("#deleteObj").click(function() {
							SunivoUtil.createModal("删除#One-Object#", //标题
							$("#popDivSection").html(),//弹出框内容
							function() {
								console.log("在这儿，提交数据");
								return true;
							}, //回调函数
							"确认");//确认按钮上面的文本
						});

						$("#assignAgent")
								.click(
										function() {
											//获取已选择的选单标号
											var selVal = [];
											$("input[name='row_sel_inquiry']:checkbox:checked").each(
												function() {
													selVal.push($(this).val());
												});
											if (selVal != null && selVal.length > 0) {
												var inquiryIdStr = selVal.join(",");
												createRemoteModal(
														"分配供应商",
														"${ctx}/lgsinquiry/assignAgentSection?inquiryIdStr=" + inquiryIdStr,
														{},
														function() {
															validValue = $('form','#modal_body').valid();
															if (validValue) {
																var selVal = [];
																var rightSel = $("#selectR");
																rightSel.find("option").each(function() {
																	selVal.push(this.value);
																});
																selVals = selVal.join(",");
																//selVals = rightSel.val();
																if (selVals == "") {
																	alert("没有选择任何供应商!");
																} else {
																	$
																			.ajax({
																				type : "POST",
																				url : "${ctx}/lgsinquiry/updateagency",
																				data : {
																					"ids" : $(
																							"#inquiryIdStr")
																							.val(),
																					"agencyForInquiry" : selVals
																				},
																				success : function(
																						result) {
																					window.location.href = window.location.href;
																					window.location
																							.reload();
																					$(
																							"input[name='row_sel_inquiry']")
																							.each(
																									function() {
																										$(
																												this)
																												.attr(
																														"checked",
																														false);
																									})
																				},
																				error : function(
																						XMLHttpRequest,
																						textStatus,
																						errorThrown) {
																					alert("Status: "
																							+ textStatus);
																					window.location
																							.reload();
																					$(
																							"input[name='row_sel_inquiry']")
																							.each(
																									function() {
																										$(
																												this)
																												.attr(
																														"checked",
																														false);
																									})
																				}
																			});
																}
															}
															return false;
														}, "分配供应商");
											} else {
												alert("请选择询价单!");
											}
										});
					});
--%>


	$(document).ready(function () {
	    $("#assignAgent").click(function () {
	    	//获取已选择的选单标号
	    	var selVal = [];
	    	$("input[name='row_sel_inquiry']:checkbox:checked").each(function(){
	    		selVal.push($(this).val());
	    	});
	    	if(selVal != null  && selVal.length > 0){
	        	var inquiryIdStr = selVal.join(",");
	        	SunivoUtil.createRemoteModal("分配供应商", "${ctx}/lgsinquiry/assignAgentSection?inquiryIdStr="+inquiryIdStr, {},
	                    function () {
	            			//$("#modal_ok_btn").attr("disabled", true);
	                        validValue = $('form', '#modal_body').valid();
	                        if (validValue) {
	                        	var selVal = [];
	                        	var rightSel = $("#selectR");
	                 		    rightSel.find("option").each(function(){
	                 		    	selVal.push(this.value);
	                 		    });
	                 		  selVals = selVal.join(",");
	                 		  //selVals = rightSel.val();
	                 		  if(selVals==""){
		                 		   //alert("没有选择任何供应商!");
		              	    		SunivoUtil
		            				.showAlertMessage(
		            						$("#assignAgentMessage"),
		            						"请选择需要分配的询单!！",
		            						"warn");
	                 		  }else{
	                 			  $.ajax({
	                 		    		type : "POST",
	                 		    		url :  "${ctx}/lgsinquiry/updateagency",
	                 		    		data : {"ids":$("#inquiryIdStr").val(),
	                 		    			    "agencyForInquiry":selVals
	                 		    			    },
	                 		    		success : function(result) {
	                 		    			window.location.href = window.location.href;
	                 		    			window.location.reload();
	                 		    			$("input[name='row_sel_inquiry']").each(function(){
	                 		    				$(this).attr("checked",false);
	                 		    			})
	                 		    		},
	                 		    		error : function(XMLHttpRequest, textStatus, errorThrown) {
	                 		    			alert("Status: " + textStatus);
	                 		    			window.location.reload();
	                 		    			$("input[name='row_sel_inquiry']").each(function(){
	                 		    				$(this).attr("checked",false);
	                 		    			})
	                 		    		}
	                 		    	});
	                 		  }
	                        }
	                        //$.ajaxStop(function (){$("#modal_ok_btn").attr("disabled", false);});
	                        return false;
	                    }, "分配供应商"
	            );
	    	} else {
	    		
	    		SunivoUtil
				.showAlertMessage(
						$("#message"),
						"请选择需要分配的询单!！",
						"warn");
	    	}
	    });
	}) 


	function searchByStatus(statue) {
		window.location.href = "${ctx}/lgsinquiry/inquiryList?inquiryStatusStr="+ statue;
	}
</script>

<style type="text/css">
  .modal{
  	width:660px;
  }
</style>
</head>
<body>
	<!-- 流式布局，页面上部空出50px-->
	<div class="row-fluid sunivoPage">
		<!-- 页面内容置中，左右各留span1 -->
		<div class="span10 offset1">
			<div id="message"></div>
			<!-- 页头  begin -->
			<div class="row-fluid">
				<div class="sunivoTitle span12">
					<div class="span2">
						<h1 class="pageTitle">询价列表</h1>
					</div>
					<div class="span6">
						<span>  <a onclick="searchByStatus(0);"
							class="pointer statistics">全部</a>&nbsp;&nbsp;|&nbsp; <a
							onclick="searchByStatus(1);" class="pointer statistics">未分配</a>&nbsp;&nbsp;|&nbsp;
							<a onclick="searchByStatus(2);" class="pointer statistics">报价中</a>&nbsp;&nbsp;|&nbsp;
							<a onclick="searchByStatus(3);" class="pointer statistics">已报价</a>&nbsp;&nbsp;|&nbsp;
							<a onclick="searchByStatus(4);" class="pointer statistics">已成交</a>&nbsp;&nbsp;|&nbsp;
							<a onclick="searchByStatus(5);" class="pointer statistics">已过期</a>


						</span>

					</div>
					<div class="span4" align="right">
						<span> 
							<i class="pull-right icon-crop icon-2x pointer" style="margin-right: 15px;" title="分配供应商" id="assignAgent"></i>
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
						<li class="active">询价列表</li>
					</ul>
				</div>
			</div>
			<!-- 面包屑 end -->

			<!-- 水平表单 begin -->
			<form id="filterForm" class="form-horizontal"
				action="${ctx}/lgsinquiry/select" method="get">
				<input type="hidden" name="inquiryStatusStr" value="${inquiryStatusStr}" />
				<div class="sunivoFilterForm">
					<div class="row-fluid">
						<div class="span12">
							<div class="span11 filterCondition">
								<span> <input type="text" class="span2"
									name="search_LIKE_orderCode"
									value="${searchParams.LIKE_orderCode}" placeholder="订单编号">
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
				<c:forEach items="${objectList}" var="obj">
				<c:set var="entity" value="${obj.entity}"  />
					<div class="row-fluid">
						<div class="span12">
							<!-- 最左列，通常放入可唯一识别当前记录的字段，比如客户名，如没有，可放入ID -->
							<div class="number span2">
								<span> 
								<a href="${ctx}/lgsinquiry/detail?id=${entity.id}" title="订单编号：${obj.orderCode}">${obj.orderCode}</a>
								</span>
							</div>
							<!-- 记录要展示的数据，此处按列排，不是按行排 -->
							<div class="content span9">
								<div class="row-fluid">
									<!-- 第一 列 -->
									<div class="span4">
										<dl class="dl-horizontal">
											<dt>委托方：</dt>
											<dd title="${obj.baileName}" >
												<%-- <c:out value="${obj.baileName}" /> --%>
												<sunivo:lengthLimter maxLen="13" value="${obj.baileName}"/>
											</dd>
											<dt>类型：</dt>
											<dd>
												<c:if test="${entity.inquiryType eq '1'}">
												海整询价		
											</c:if>
												<c:if test="${entity.inquiryType eq '2'}">
												海拼询价		
											</c:if>
												<c:if test="${entity.inquiryType eq '3'}">
												集卡询价		
											</c:if>
												<c:if test="${entity.inquiryType eq '4'}">
												空运询价		
											</c:if>
												<c:if test="${entity.inquiryType eq '5'}">
												零担询价		
											</c:if>
												<c:if
													test="${null eq entity.inquiryType || '' eq entity.inquiryType}">
												&nbsp;
											</c:if>
											</dd>
											<dt>运输路线：</dt>
											<dd>
												<c:out value="${obj.trainLineName}" />
											</dd>
											<dt>目标价：</dt>
											<dd>
											    <sunivo:moneyFormatView money="${entity.goalfreightTotal}"  />
											    <sunivo:currencyView showType="symbol" value="${entity.inquirycurrency}"/>
											</dd>
										</dl>
									</div>
									<!-- 第二 列 -->
									<div class="span4">
										<dl class="dl-horizontal">

											<dt>询价时间：</dt>
											<dd>
												<fmt:formatDate value='${entity.inquiryTime}'
													pattern='yyyy-MM-dd HH:mm:ss' />
											</dd>
											<dt>询单状态：</dt>
											<dd>
												<c:if test="${entity.inquiryStatus eq '1'}">
													未分配	
												</c:if>
												<c:if test="${entity.inquiryStatus eq '2'}">
													报价中	
												</c:if>
												<c:if test="${entity.inquiryStatus eq '3'}">
													已报价	
												</c:if>
												<c:if test="${entity.inquiryStatus eq '4'}">
													已成交	
												</c:if>
												<c:if test="${entity.inquiryStatus eq '5'}">
													已过期	
												</c:if>
												<c:if
													test="${null eq entity.inquiryStatus || '' eq entity.inquiryStatus}">
													&nbsp;
												</c:if>
											</dd>
											<dt>有效期：</dt>
											<dd>
												<fmt:formatDate value='${entity.expiryDate}'
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
											<dd>${entity.createUsername}</dd>
											<dt>创建时间：</dt>
											<dd>
												<fmt:formatDate value='${entity.createDatetime}'
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
								<span> <!-- 未分配时候显示分配按钮 --> 
									<label class="checkbox">
										<input type="checkbox" name="row_sel_inquiry" value="${entity.id}" id="row_sel_${entity.id}" style="<c:if test="${null ne entity.inquiryStatus && entity.inquiryStatus != 1}">display:none;</c:if>"   >
									</label> 
									<i title="详情" class="icon-eye-open pointer pull-left"  onclick="window.location='${ctx}/lgsinquiry/detail?id=${entity.id}'"> </i>
								</span>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<!-- 分页 -->
			<div class="row-fluid">
			     <sunivo:pagination page="${page}"/> 
				    <%--
					<div class="span12">
						<div class="span4">
							<div style="margin-top: 8px;">显示1-10, 共285条</div>
						</div>
						<div class="span8">
							<div class="pagination pull-right">
								<ul>
									<li class='prev disabled'><a href='#'>←上一页</a></li>
									<li class="active"><a href='#'>1</a></li>
									<li class=""><a href='javascript:turn2Page(2);'>2</a></li>
									<li class=""><a href='javascript:turn2Page(3);'>3</a></li>
									<li class=""><a href='javascript:turn2Page(4);'>4</a></li>
									<li class=""><a href='javascript:turn2Page(5);'>5</a></li>
									<li class=""><a href='javascript:turn2Page(6);'>6</a></li>
									<li><a href='#'>...</a></li>
									<li><a href='javascript:turn2Page(29);'>29</a></li>
									<li class="next"><a href='javascript:turn2Page(2);'>下一页→</a></li>
								</ul>
							</div>
						</div>
					</div>
					--%>
			</div>
		</div>
	</div>
	<div id="popDivSection" class="modal hide fade">
		您确认删除#One-Object#？</div>
</body>
</html>
