<%@include file="/WEB-INF/common/layouts/common.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<!-- 设置后台传过来的值 -->
<c:set var="orderBasicInfo" value="${resultMap.orderBasicInfo}" />
<c:set var="lgsInquiryEntity" value="${resultMap.lgsInquiryEntity}" />
<c:set var="orderTradeInfo" value="${resultMap.orderTradeInfo}" />
<c:set var="ordPhysicalProductInfo" value="${resultMap.ordPhysicalProductInfo}" />
	
<!-- 修改开始 -->
<!-- 流式布局，页面上部空出50px-->	
<div class="row-fluid sunivoPage" >

		<!-- 水平表单 begin -->
		<form id="input_form" class="form-horizontal">
			<!-- 页面内容置中，左右各留span1 -->
			<div class="span10 offset1">
				<sunivo:flushMessage/>
				<!-- 页头  begin -->
				<div class="row-fluid">
					<div class="span12 sunivoTitle">
						<div class="span6">
							<h1 class="pageTitle">询价详情</h1>
						</div>
						<%-- <div class="span6" align="right">
							<i title="编辑" class="pull-right icon-edit icon-2x pointer" style="margin-right: 15px;" onclick="window.location='${ctx}/lgsadvantagerouteset/${entity.id}?action=edit'"></i>
						</div> --%>
					</div>
				</div>
				<!-- 页头  end -->
				<!-- 面包屑 begin -->
				<div class="row-fluid">
					<div class="span12">
						<ul class="breadcrumb">
							<li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
							<li><a href="${ctx}/lgsinquiry/">询价列表</a> <span
								class="divider">/</span></li>
							<li class="active">询价详情</li>
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
							<label class="control-label">订单编号:</label>
							<div class="controls">
							${orderBasicInfo.orderCode}
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">询单类型:</label>
							<div class="controls">
								<c:if test="${lgsInquiryEntity.inquiryType eq '1'}">
									海整询价		
								</c:if>
								<c:if test="${lgsInquiryEntity.inquiryType eq '2'}">
									海拼询价		
								</c:if>
								<c:if test="${lgsInquiryEntity.inquiryType eq '3'}">
									集卡询价		
								</c:if>
								<c:if test="${lgsInquiryEntity.inquiryType eq '4'}">
									空运询价		
								</c:if>
								<c:if test="${lgsInquiryEntity.inquiryType eq '5'}">
									零担询价		
								</c:if>
							</div>
						</div>
					</div>
					
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">询单编号:</label>
							<div class="controls">
							${lgsInquiryEntity.inquiryCode}
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">询价时间:</label>
							<div class="controls">
								<fmt:formatDate value="${lgsInquiryEntity.inquiryTime}" pattern="yyyy-MM-dd HH:mm:ss" />
							</div>
						</div>
					</div>
					
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">询单状态:</label>
							<div class="controls">
								<c:if test="${lgsInquiryEntity.inquiryStatus eq '1'}">
									未分配	
								</c:if>
								<c:if test="${lgsInquiryEntity.inquiryStatus eq '2'}">
									报价中	
								</c:if>
								<c:if test="${lgsInquiryEntity.inquiryStatus eq '3'}">
									已报价	
								</c:if>
								<c:if test="${lgsInquiryEntity.inquiryStatus eq '4'}">
									已成交	
								</c:if>
								<c:if test="${lgsInquiryEntity.inquiryStatus eq '5'}">
									已过期	
								</c:if>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">有效期至:</label>
							<div class="controls">
								<fmt:formatDate value="${lgsInquiryEntity.expiryDate}" pattern="yyyy-MM-dd HH:mm:ss" />
							</div>
						</div>
					</div>
					
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">委托方:</label>
							<div class="controls">
								${orderBasicInfo.baileName}
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">客服:</label>
							<div class="controls">
								${orderBasicInfo.customServiceName}
							</div>
						</div>
					</div>
					
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">客户代表:</label>
							<div class="controls">
								${orderBasicInfo.customDelegateName}
							</div>
						</div>
						<%-- <div class="span6 control-group">
							<label class="control-label">客服:</label>
							<div class="controls">
								${orderBasicInfo.customServiceName}
							</div>
						</div> --%>
					</div>


					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>贸易信息</h5>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">合同买方:</label>
							<div class="controls">
								${orderTradeInfo.buyer}
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">合同卖方:</label>
							<div class="controls">
								${orderTradeInfo.seller}
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">起运港:</label>
							<div class="controls">
								${orderTradeInfo.shipmentPortName}
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">目的港:</label>
							<div class="controls">
								${orderTradeInfo.reachPortName}
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">贸易条款:</label>
							<div class="controls">
								${orderTradeInfo.tradeItemName}
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">支付方式:</label>
							<div class="controls">
								<c:if test="${orderTradeInfo.paymentScaleM != null}">
									  ${orderTradeInfo.paymentScaleM}%${orderTradeInfo.paymentMName} &nbsp;
									  </c:if>
									   <c:if test="${orderTradeInfo.paymentScaleS != null}">
									  ${orderTradeInfo.paymentScaleS}%
									  </c:if>
									  <c:if test="${orderTradeInfo.paymentSName != null}">
									  ${orderTradeInfo.paymentSName}&nbsp;
									  </c:if>
									  <c:if test="${orderTradeInfo.periodAccount != null}">
									  ${orderTradeInfo.periodAccount}DS
								</c:if>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">国际运输投保:</label>
							<div class="controls">
								 <c:if test="${'true' eq orderTradeInfo.trafficInsurance}">
									<c:out value="是" />
								  </c:if> <c:if test="${'false' eq orderTradeInfo.trafficInsurance}">
									<c:out value="否" />
								  </c:if>
							</div>
						</div>
						<div class="span6 control-group">
								<c:choose>
									<c:when test="${lgsInquiryEntity.inquiryType eq '2' || lgsInquiryEntity.inquiryType eq '4'}">
										<label FOR="" class="control-label">货物体积/重量：</label>
										<div class="controls">
											<!-- 出口海拼  -->
											<c:if test="${resultMap.ordTSED01LO0120130604E005.totalBulk!=null}">
												<fmt:formatNumber value="${resultMap.ordTSED01LO0120130604E005.totalBulk}" pattern="###,###,###.000"></fmt:formatNumber>
												<sunivo:unitView value="${resultMap.ordTSED01LO0120130604E005.totalBulkUnit}"/>/
											</c:if>
											<c:if test="${resultMap.ordTSED01LO0120130604E005.totalWeight!=null}">
												<fmt:formatNumber value="${resultMap.ordTSED01LO0120130604E005.totalWeight}" pattern="###,###,###.000"></fmt:formatNumber>
												<%-- ${ordTSED01LO0120130604E005.totalWeight} --%>
												<sunivo:unitView value="${resultMap.ordTSED01LO0120130604E005.totalWeightUnit}"/>
											</c:if>
											<!--进口海拼  -->
											<c:if test="${resultMap.ordTSED01LO0120130604I005.totalBulk!=null}">
												<fmt:formatNumber value="${resultMap.ordTSED01LO0120130604I005.totalBulk}" pattern="###,###,###.000"></fmt:formatNumber>
												<sunivo:unitView value="${resultMap.ordTSED01LO0120130604I005.totalBulkUnit}"/>/
											</c:if>
											<c:if test="${resultMap.ordTSED01LO0120130604I005.totalWeight!=null}">
												<fmt:formatNumber value="${resultMap.ordTSED01LO0120130604I005.totalWeight}" pattern="###,###,###.000"></fmt:formatNumber>
												<%-- ${ordTSED01LO0120130604E005.totalWeight} --%>
												<sunivo:unitView value="${resultMap.ordTSED01LO0120130604I005.totalWeightUnit}"/>
											</c:if>
											<!--出口空运  -->
											<c:if test="${resultMap.ordTSED01LO0120130604E008.totalBulk!=null}">
												<fmt:formatNumber value="${resultMap.ordTSED01LO0120130604E008.totalBulk}" pattern="###,###,###.000"></fmt:formatNumber>
												<sunivo:unitView value="${resultMap.ordTSED01LO0120130604E008.totalBulkUnit}"/>/
											</c:if>
											<c:if test="${resultMap.ordTSED01LO0120130604E008.totalWeight!=null}">
												<fmt:formatNumber value="${resultMap.ordTSED01LO0120130604E008.totalWeight}" pattern="###,###,###.000"></fmt:formatNumber>
												<%-- ${ordTSED01LO0120130604E005.totalWeight} --%>
												<sunivo:unitView value="${resultMap.ordTSED01LO0120130604E008.totalWeightUnit}"/>
											</c:if>
											<!--进口空运  -->
											<c:if test="${resultMap.ordTSED01LO0120130604I008.totalBulk!=null}">
												<fmt:formatNumber value="${resultMap.ordTSED01LO0120130604I008.totalBulk}" pattern="###,###,###.000"></fmt:formatNumber>
												<sunivo:unitView value="${resultMap.ordTSED01LO0120130604I008.totalBulkUnit}"/>/
											</c:if>
											<c:if test="${resultMap.ordTSED01LO0120130604I008.totalWeight!=null}">
												<fmt:formatNumber value="${resultMap.ordTSED01LO0120130604I008.totalWeight}" pattern="###,###,###.000"></fmt:formatNumber>
												<%-- ${ordTSED01LO0120130604E005.totalWeight} --%>
												<sunivo:unitView value="${resultMap.ordTSED01LO0120130604I008.totalWeightUnit}"/>
											</c:if>
										</div>
									</c:when>
									<c:otherwise>
										<label for="" class="control-label">箱型箱量：</label>
										<div class="controls">
											<span>
												<c:forEach items="${resultMap.fclTSED01LO0120130604E001}" var="fclentity" varStatus="abc">
													<c:if test="${null ne fclentity.containerTypeId && '' ne fclentity.containerTypeId}">
														<sunivo:containersizeView value="${fclentity.containerTypeId}"/> *
													</c:if>
													<c:if test="${null eq fclentity.containerTypeId || '' eq fclentity.containerTypeId}">
														&nbsp;
													</c:if>  
													<c:if test="${null ne fclentity.containerQty && '' ne fclentity.containerQty}">
														<c:out value="${fclentity.containerQty}" />
													</c:if>
													<c:if test="${null eq fclentity.containerQty || '' eq fclentity.containerQty}">
														&nbsp;
													</c:if>
												</c:forEach>
												<c:forEach items="${resultMap.fclTSED01LO0120130604I001}" var="fclentity" varStatus="abc">
													<c:if test="${null ne fclentity.containerTypeId && '' ne fclentity.containerTypeId}">
														<sunivo:containersizeView value="${fclentity.containerTypeId}" />
													</c:if>
													<c:if test="${null eq fclentity.containerTypeId || '' eq fclentity.containerTypeId}">
														&nbsp;
													</c:if>  
													<c:if test="${null ne fclentity.containerQty && '' ne fclentity.containerQty}">
														<c:out value="${fclentity.containerQty}" />
													</c:if>
													<c:if test="${null eq fclentity.containerQty || '' eq fclentity.containerQty}">
														&nbsp;
													</c:if>
												</c:forEach>
									 		</span>
										</div>
									</c:otherwise>
								</c:choose> 
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">目标价:</label>
							<div class="controls">
								<sunivo:moneyFormatView money="${lgsInquiryEntity.goalfreightTotal}" /><sunivo:currencyView value="${lgsInquiryEntity.inquirycurrency}" showType="symbol" />
							</div>
						</div>
						<div class="span6 control-group">
							<c:if test="${lgsInquiryEntity.inquiryType ne '2' && lgsInquiryEntity.inquiryType ne '4'}">
								<label for="" class="control-label">单柜装载量：</label>
								<div class="controls">
									<span>
									<!-- 出口海整 -->
									<c:forEach items="${resultMap.fclTSED01LO0120130604E001}" var="fclentity" varStatus="abc">
										<c:if test="${null ne fclentity.containerCapacity && '' ne fclentity.containerCapacity}">
											<fmt:formatNumber value="${fclentity.containerCapacity}" pattern="###,###,###.000"></fmt:formatNumber>
										</c:if>
										<c:if test="${null eq fclentity.containerCapacity || '' eq fclentity.containerCapacity}">
											&nbsp;
										</c:if>
									</c:forEach>
									<!-- 进口海整 -->
									<c:forEach items="${resultMap.fclTSED01LO0120130604I001}" var="fclentity" varStatus="abc">
										<c:if test="${null ne fclentity.containerCapacity && '' ne fclentity.containerCapacity}">
											<fmt:formatNumber value="${fclentity.containerCapacity}" pattern="###,###,###.000"></fmt:formatNumber>
										</c:if>
										<c:if test="${null eq fclentity.containerCapacity || '' eq fclentity.containerCapacity}">
											&nbsp;
										</c:if>
									</c:forEach>
									</span>
								</div>
							</c:if>
						</div>
					</div>
					<!-- 片段头 end -->
					
					
				</div>
			</div>
		
		<!-- 水平表单 end -->


	</form>
</div>



<div class="row-fluid sunivoPage"  >
	<form id="input_form" class="form-horizontal">
		<div class="span10 offset1">
			<div class="sunivoBorder">
				<div class="sectionTitle">
					<h5>订单实物产品</h5>
				</div>
				<div class="row-fluid" style=" border:1px solid #E2E2E2;  " >
			<table class="table table-hover">
					<thead>
						<tr>
							<th>产品名称</th>
							<th>HS编码</th>
							<th>危险品等级</th>
							<th>货值</th>
							<th>重量</th>
							<th>单位</th>
							<th>包装</th>
							<th>件数</th>
							<th>L</th>
							<th>W</th>
							<th>H</th>
							<th>体积</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${ordPhysicalProductInfo}"
							var="ordPhysicalProductInfo" varStatus="abc">
							<tr>
								<td nowrap="nowrap"><c:if
										test="${null ne ordPhysicalProductInfo.productName && '' ne ordPhysicalProductInfo.productName}">
										<c:out value="${ordPhysicalProductInfo.productName}" />
									</c:if> <c:if
										test="${null eq ordPhysicalProductInfo.productName || '' eq ordPhysicalProductInfo.productName}">
						&nbsp;
					</c:if></td>

								<td nowrap="nowrap"><c:if
										test="${null ne ordPhysicalProductInfo.hsCode && '' ne ordPhysicalProductInfo.hsCode}">
										<c:out value="${ordPhysicalProductInfo.hsCode}" />
									</c:if> <c:if
										test="${null eq ordPhysicalProductInfo.hsCode || '' eq ordPhysicalProductInfo.hsCode}">
						&nbsp;
					</c:if></td>
								<td nowrap="nowrap"><c:if
										test="${null ne ordPhysicalProductInfo.dangerousClassLevel && '' ne ordPhysicalProductInfo.dangerousClassLevel}">
										<c:out value="${ordPhysicalProductInfo.dangerousClassLevel}" />
									</c:if> <c:if
										test="${null eq ordPhysicalProductInfo.dangerousClassLevel || '' eq ordPhysicalProductInfo.dangerousClassLevel}">
						&nbsp;
					</c:if></td>
								<td nowrap="nowrap"><c:if
										test="${null ne ordPhysicalProductInfo.orderAmount && '' ne ordPhysicalProductInfo.orderAmount}">
										<c:out value="${ordPhysicalProductInfo.orderAmount}" />
									</c:if> <c:if
										test="${null eq ordPhysicalProductInfo.orderAmount || '' eq ordPhysicalProductInfo.orderAmount}">
						&nbsp;
					</c:if></td>
								<td nowrap="nowrap"><c:if
										test="${null ne ordPhysicalProductInfo.roughWeight && '' ne ordPhysicalProductInfo.roughWeight}">
										<fmt:formatNumber value="${ordPhysicalProductInfo.roughWeight}" pattern="###,###,###.000"></fmt:formatNumber>
									</c:if> <c:if
										test="${null eq ordPhysicalProductInfo.roughWeight || '' eq ordPhysicalProductInfo.roughWeight}">
						&nbsp;
					</c:if></td>
								<td nowrap="nowrap"><c:if
										test="${null ne ordPhysicalProductInfo.weightUnitName && '' ne ordPhysicalProductInfo.weightUnitName}">
										<c:out value="${ordPhysicalProductInfo.weightUnitName}" />
									</c:if> <c:if
										test="${null eq ordPhysicalProductInfo.weightUnitName || '' eq ordPhysicalProductInfo.weightUnitName}">
						&nbsp;
					</c:if></td>
								<td nowrap="nowrap"><c:if
										test="${null ne ordPhysicalProductInfo.orderPiecesName && '' ne ordPhysicalProductInfo.orderPiecesName}">
										<c:out value="${ordPhysicalProductInfo.orderPiecesName}" />
									</c:if> <c:if
										test="${null eq ordPhysicalProductInfo.orderPiecesName || '' eq ordPhysicalProductInfo.orderPiecesName}">
						&nbsp;
					</c:if></td>
								<td nowrap="nowrap"><c:if
										test="${null ne ordPhysicalProductInfo.orderPieces && '' ne ordPhysicalProductInfo.orderPieces}">
										<c:out value="${ordPhysicalProductInfo.orderPieces}" />
									</c:if> <c:if
										test="${null eq ordPhysicalProductInfo.orderPieces || '' eq ordPhysicalProductInfo.orderPieces}">
						&nbsp;
					</c:if></td>
								<td nowrap="nowrap"><c:if
										test="${null ne ordPhysicalProductInfo.pdtLong && '' ne ordPhysicalProductInfo.pdtLong}">
										<fmt:formatNumber value="${ordPhysicalProductInfo.pdtLong}" pattern="###,###,###.000"></fmt:formatNumber>
										
									</c:if> <c:if
										test="${null eq ordPhysicalProductInfo.pdtLong || '' eq ordPhysicalProductInfo.pdtLong}">
						&nbsp;
					</c:if></td>
								<td nowrap="nowrap"><c:if
										test="${null ne ordPhysicalProductInfo.pdtWide && '' ne ordPhysicalProductInfo.pdtWide}">
										<fmt:formatNumber value="${ordPhysicalProductInfo.pdtWide}" pattern="###,###,###.000"></fmt:formatNumber>
									</c:if> <c:if
										test="${null eq ordPhysicalProductInfo.pdtWide || '' eq ordPhysicalProductInfo.pdtWide}">
						&nbsp;
					</c:if></td>
								<td nowrap="nowrap"><c:if
										test="${null ne ordPhysicalProductInfo.pdtHigh && '' ne ordPhysicalProductInfo.pdtHigh}">
										<fmt:formatNumber value="${ordPhysicalProductInfo.pdtHigh}" pattern="###,###,###.000"></fmt:formatNumber>
									</c:if> <c:if
										test="${null eq ordPhysicalProductInfo.pdtHigh || '' eq ordPhysicalProductInfo.pdtHigh}">
						&nbsp;
					</c:if></td>
								<td nowrap="nowrap"><c:if
										test="${null ne ordPhysicalProductInfo.pdtVolume && '' ne ordPhysicalProductInfo.pdtVolume}">
										<fmt:formatNumber value="${ordPhysicalProductInfo.pdtVolume}" pattern="###,###,###.000"></fmt:formatNumber>
									</c:if> <c:if
										test="${null eq ordPhysicalProductInfo.pdtVolume || '' eq ordPhysicalProductInfo.pdtVolume}">
						&nbsp;
					</c:if></td>
							</tr>
						</c:forEach>

					</tbody>
				</table>		    
		 </div>				
			</div>
	    </div>
	</form>
</div>
</body>
</html>
