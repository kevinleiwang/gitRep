<%@ include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<div class="row-fluid">
	<div class="span6 control-group">
		<label class="control-label">生效日期 <c:choose>
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
							value="<fmt:formatDate value='${vo.fclQsurchargeEntity.execDate}' pattern='yyyy-MM-dd' />"
							id="fclQsurchargeEntity.execDateStr"
							name="fclQsurchargeEntity.execDateStr" readonly
							placeholder="生效日期"> <span class="add-on"><i
							class="icon-remove"></i></span> <span class="add-on"><i
							class="icon-calendar"></i></span>
					</div>
					<font color="red"><form:errors
							path="lgsRouteAdditionQuoteVo.fclQsurchargeEntity.execDate" /></font>
				</c:when>
				<c:otherwise>
					<span class="inline"><fmt:formatDate
							value='${vo.fclQsurchargeEntity.execDate}' pattern='yyyy-MM-dd' />&nbsp;</span>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="span6 control-group">
		<label class="control-label">失效日期 <c:choose>
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
							value="<fmt:formatDate value='${vo.fclQsurchargeEntity.expiryDate}' pattern='yyyy-MM-dd' />"
							id="fclQsurchargeEntity.expiryDateStr"
							name="fclQsurchargeEntity.expiryDateStr" readonly
							placeholder="失效日期" dateGte="#fclQsurchargeEntity\.execDateStr">
						<span class="add-on"><i class="icon-remove"></i></span> <span
							class="add-on"><i class="icon-calendar"></i></span>
					</div>
					<font color="red"><form:errors
							path="lgsRouteAdditionQuoteVo.fclQsurchargeEntity.expiryDate" /></font>
				</c:when>
				<c:otherwise>
					<span class="inline"><fmt:formatDate
							value='${vo.fclQsurchargeEntity.expiryDate}' pattern='yyyy-MM-dd' />&nbsp;</span>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
<div class="row-fluid">
	<div class="span6 control-group">
		<label class="control-label"
			for="addationQuoteInfoEntity.importExportFlag">进出口&nbsp;: </label>

		<div class="controls">
			<c:choose>
				<c:when test="${action=='create'}">
					<input type="hidden"
						name="addationQuoteInfoEntity.importExportFlag"
						id="addationQuoteInfoEntity.importExportFlag" value="1">
					<sunivo:importExportFlagView value="1" />
				</c:when>
				<c:otherwise>
					<input type="hidden"
						name="addationQuoteInfoEntity.importExportFlag"
						id="addationQuoteInfoEntity.importExportFlag"
						value="${vo.addationQuoteInfoEntity.importExportFlag}">
					<sunivo:importExportFlagView
						value="${vo.addationQuoteInfoEntity.importExportFlag}" />
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="span6 control-group">
		<label class="control-label">状态&nbsp;:</label>

		<div class="controls">
			<input type="hidden" id="fclQsurchargeEntity.status"
				name="fclQsurchargeEntity.status"
				value="${vo.fclQsurchargeEntity.status}">
			<sunivo:disabledFlagView value="${vo.fclQsurchargeEntity.status}" />
		</div>
	</div>
</div>
<c:choose>
	<c:when test="${null != vo.fclQsurchargeEntity.createUsername}">
		<div class="row-fluid">
			<div class="span6 control-group">
				<label class="control-label">创建人&nbsp;:</label>

				<div class="controls">
					<span class="inline">${vo.fclQsurchargeEntity.createUsername}&nbsp;</span>
					<input type="hidden" name="fclQsurchargeEntity.createUsername"
						value="${vo.fclQsurchargeEntity.createUsername}">
				</div>
			</div>
			<div class="span6 control-group">
				<label class="control-label">创建时间&nbsp;:</label>

				<div class="controls">
					<span class="inline"><fmt:formatDate
							value="${vo.fclQsurchargeEntity.createDatetime}"
							pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;</span> <input type="hidden"
						name="fclQsurchargeEntity.createDatetimeStr"
						value="<fmt:formatDate
							value="${vo.fclQsurchargeEntity.createDatetime}"
							pattern="yyyy-MM-dd HH:mm:ss" />">
				</div>
			</div>
		</div>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${null != vo.fclQsurchargeEntity.updateUsername}">
		<div class="row-fluid">
			<div class="span6 control-group">
				<label class="control-label">修改人&nbsp;:</label>

				<div class="controls">
					<span class="inline">${vo.fclQsurchargeEntity.updateUsername}&nbsp;</span>
				</div>
			</div>
			<div class="span6 control-group">
				<label class="control-label">修改时间&nbsp;:</label>
				<div class="controls">
					<span class="inline"><fmt:formatDate
							value="${vo.fclQsurchargeEntity.updateDatetime}"
							pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;</span>
				</div>
			</div>
		</div>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>
<!-- 片段头 begin -->
<div class="sectionTitle">
	<h5>报价信息</h5>
</div>
<!-- 片段头 end -->
<div class="row-fluid">
	<div class="span12 control-group">
		<div class="row-fluid">
			<div class="span12">
				<div class="portlet box grey">
					<div class="portlet-body form">
						<input name="fclQsurchargeEntity.id" id="fclQsurchargeEntity.id"
							type="hidden" value="${vo.fclQsurchargeEntity.id}" /> <input
							id="fclQsurchargeEntity.quoteType"
							name="fclQsurchargeEntity.quoteType" type="hidden"
							value="${vo.fclQsurchargeEntity.quoteType}" /> <input
							id="fclQsurchargeEntity.quoteId"
							name="fclQsurchargeEntity.quoteId" type="hidden"
							value="${vo.fclQsurchargeEntity.quoteId}" />
						<c:choose>
							<c:when test="${action=='create'}">
								<div class="row-fluid">
									<div class="span6 control-group">
										<label class="control-label" for="prdQuoteId4">每票:</label>
										<div class="controls">
											<input type="text"
												name="fclQsurchargeEntity.nonContainerCost"
												id="fclQsurchargeEntity.nonContainerCost"
												value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.nonContainerCost }"/>'
												class="positiveNumber span10" placeholder="每票成本报价">
										</div>
									</div>
									<div class="span6 control-group">
										<label class="control-label" for="gp20">20GP:</label>
										<div class="controls">
											<input type="text" name="fclQsurchargeEntity.cost20gp"
												id="fclQsurchargeEntity.cost20gp"
												value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.cost20gp }" />'
												class="positiveNumber span10" placeholder="20' GP成本报价">
										</div>
									</div>
								</div>
								<div class="row-fluid">
									<div class="span6 control-group">
										<label class="control-label" for="gp40">40GP:</label>
										<div class="controls">
											<input type="text" name="fclQsurchargeEntity.cost40gp"
												id="entity.cost40gp"
												value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.cost40gp }" />'
												class="positiveNumber span10" placeholder="40' GP成本报价">
										</div>
									</div>
									<div class="span6 control-group">
										<label class="control-label" for="hq40">40HQ:</label>
										<div class="controls">
											<input type="text" name="fclQsurchargeEntity.cost40hq"
												id="fclQsurchargeEntity.cost40hq"
												value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.cost40hq }" />'
												class="positiveNumber span10" placeholder="40' HQ成本报价">
										</div>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="row-fluid">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>&nbsp;</th>
												<th>成本报价</th>
												<th>销售价</th>
												<th>折扣价</th>
												<th>最终销售报价</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>每票</td>
												<td><c:choose>
														<c:when test="${action=='edit'}">
															<input type="text"
																name="fclQsurchargeEntity.nonContainerCost"
																id="fclQsurchargeEntity.nonContainerCost"
																value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.nonContainerCost }"/>'
																class="positiveNumber" placeholder="每票成本报价">
														</c:when>
														<c:otherwise>
															<sunivo:moneyFormatView
																money="${vo.fclQsurchargeEntity.nonContainerCost }" />
														</c:otherwise>
													</c:choose></td>
												<td><c:choose>
														<c:when test="${action=='edit'}">
															<input type="text"
																name="fclQsurchargeEntity.nonContainerPrice"
																id="fclQsurchargeEntity.nonContainerPrice"
																value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.nonContainerPrice }" />'
																class="positiveNumber" placeholder="每票销售价">
														</c:when>
														<c:otherwise>
															<sunivo:moneyFormatView
																money="${vo.fclQsurchargeEntity.nonContainerPrice }" />
														</c:otherwise>
													</c:choose></td>
												<td><c:choose>
														<c:when test="${action=='edit'}">
															<input type="text"
																name="fclQsurchargeEntity.nonContainerDiscount"
																id="fclQsurchargeEntity.nonContainerDiscount"
																value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.nonContainerDiscount }" />'
																class="positiveNumber" placeholder="每票折扣价">
														</c:when>
														<c:otherwise>
															<sunivo:moneyFormatView
																money="${vo.fclQsurchargeEntity.nonContainerDiscount }" />
														</c:otherwise>
													</c:choose></td>
												<td><sunivo:moneyFormatView
														money="${vo.fclQsurchargeEntity.nonContainerDiscount }" /></td>
											</tr>
											<tr>
												<td>20GP</td>
												<td><c:choose>
														<c:when test="${action=='edit'}">
															<input type="text" name="fclQsurchargeEntity.cost20gp"
																id="fclQsurchargeEntity.cost20gp"
																value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.cost20gp }" />'
																class="positiveNumber" placeholder="20GP成本报价">
														</c:when>
														<c:otherwise>
															<sunivo:moneyFormatView
																money="${vo.fclQsurchargeEntity.cost20gp }" />
														</c:otherwise>
													</c:choose></td>
												<td><c:choose>
														<c:when test="${action=='edit'}">
															<input type="text" name="fclQsurchargeEntity.price20gp"
																id="fclQsurchargeEntity.price20gp"
																value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.price20gp }" />'
																class="positiveNumber" placeholder="20GP销售价">
														</c:when>
														<c:otherwise>
															<sunivo:moneyFormatView
																money="${vo.fclQsurchargeEntity.price20gp }" />
														</c:otherwise>
													</c:choose></td>
												<td><c:choose>
														<c:when test="${action=='edit'}">
															<input type="text"
																name="fclQsurchargeEntity.discount20gp"
																id="fclQsurchargeEntity.discount20gp"
																value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.discount20gp }" />'
																class="positiveNumber" placeholder="20GP折扣价">
														</c:when>
														<c:otherwise>
															<sunivo:moneyFormatView
																money="${vo.fclQsurchargeEntity.discount20gp }" />
														</c:otherwise>
													</c:choose></td>
												<td><sunivo:moneyFormatView
														money="${vo.fclQsurchargeEntity.discount20gp }" /></td>
											</tr>
											<tr>
												<td>40GP</td>
												<td><c:choose>
														<c:when test="${action=='edit'}">
															<input type="text" name="fclQsurchargeEntity.cost40gp"
																id="entity.cost40gp"
																value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.cost40gp }" />'
																class="positiveNumber" placeholder="40GP成本报价">
														</c:when>
														<c:otherwise>
															<sunivo:moneyFormatView
																money="${vo.fclQsurchargeEntity.cost40gp }" />
														</c:otherwise>
													</c:choose></td>
												<td><c:choose>
														<c:when test="${action=='edit'}">
															<input type="text" name="fclQsurchargeEntity.price40gp"
																id="entity.price40gp"
																value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.price40gp }" />'
																class="positiveNumber" placeholder="40GP销售价">
														</c:when>
														<c:otherwise>
															<sunivo:moneyFormatView
																money="${vo.fclQsurchargeEntity.price40gp }" />
														</c:otherwise>
													</c:choose></td>
												<td><c:choose>
														<c:when test="${action=='edit'}">
															<input type="text"
																name="fclQsurchargeEntity.discount40gp"
																id="entity.discount40gp"
																value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.discount40gp }" />'
																class="positiveNumber" placeholder="40GP折扣价">
														</c:when>
														<c:otherwise>
															<sunivo:moneyFormatView
																money="${vo.fclQsurchargeEntity.discount40gp }" />
														</c:otherwise>
													</c:choose></td>
												<td><sunivo:moneyFormatView
														money="${vo.fclQsurchargeEntity.discount40gp }" /></td>
											</tr>
											<tr>
												<td>40HQ</td>
												<td><c:choose>
														<c:when test="${action=='edit'}">
															<input type="text" name="fclQsurchargeEntity.cost40hq"
																id="fclQsurchargeEntity.cost40hq"
																value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.cost40hq }" />'
																class="positiveNumber" placeholder="40HQ成本报价">
														</c:when>
														<c:otherwise>
															<sunivo:moneyFormatView
																money="${vo.fclQsurchargeEntity.cost40hq }" />
														</c:otherwise>
													</c:choose></td>
												<td><c:choose>
														<c:when test="${action=='edit'}">
															<input type="text" name="fclQsurchargeEntity.price40hq"
																id="fclQsurchargeEntity.price40hq"
																value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.price40hq }" />'
																class="positiveNumber" placeholder="40HQ销售价">
														</c:when>
														<c:otherwise>
															<sunivo:moneyFormatView
																money="${vo.fclQsurchargeEntity.price40hq }" />
														</c:otherwise>
													</c:choose></td>
												<td><c:choose>
														<c:when test="${action=='edit'}">
															<input type="text"
																name="fclQsurchargeEntity.discount40hq"
																id="fclQsurchargeEntity.discount40hq"
																value='<sunivo:numberFormatView value="${vo.fclQsurchargeEntity.discount40hq }" />'
																class="positiveNumber" placeholder="40HQ折扣价">
														</c:when>
														<c:otherwise>
															<sunivo:moneyFormatView
																money="${vo.fclQsurchargeEntity.discount40hq }" />
														</c:otherwise>
													</c:choose></td>
												<td><sunivo:moneyFormatView
														money="${vo.fclQsurchargeEntity.discount40hq }" /></td>
											</tr>
										</tbody>
									</table>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<!-- 片段头 begin -->
				<div class="sectionTitle">
					<h5>备注信息</h5>
				</div>
				<!-- 片段头 end -->
				<div class="row-fluid">
					<div class="span12 control-group">
						<label class="control-label">备注:</label>
						<div class="controls" style="word-break: break-all;">
							<c:choose>
								<c:when test="${action=='create' || action=='edit'}">
									<textarea id="fclQsurchargeEntity.remark"
										name="fclQsurchargeEntity.remark" rows="6" cols=""
										class="span12" placeholder="备注" maxlength="300">${vo.fclQsurchargeEntity.remark}</textarea>
									<span class="label label-warning pull-right">备注最多输入300个字符</span>
								</c:when>
								<c:otherwise>
									<c:out value="${vo.fclQsurchargeEntity.remark}" />
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>