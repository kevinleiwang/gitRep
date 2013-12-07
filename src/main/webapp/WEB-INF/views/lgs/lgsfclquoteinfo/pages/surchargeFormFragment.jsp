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
							value="<fmt:formatDate value='${surchargeEntity.execDate}' pattern='yyyy-MM-dd' />"
							id="fclQsurchargeEntities.execDateStr"
							name="fclQsurchargeEntities.execDateStr" readonly
							placeholder="生效日期"> <span class="add-on"><i
							class="icon-remove"></i></span> <span class="add-on"><i
							class="icon-calendar"></i></span>
					</div>
					<font color="red"><form:errors
							path="lgsFclQuoteInfoVo.surchargeEntity.execDate" /></font>
				</c:when>
				<c:otherwise>
					<span class="inline"><fmt:formatDate
							value='${surchargeEntity.execDate}' pattern='yyyy-MM-dd' />&nbsp;</span>
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
							value="<fmt:formatDate value='${surchargeEntity.expiryDate}' pattern='yyyy-MM-dd' />"
							id="fclQsurchargeEntities.expiryDateStr"
							name="fclQsurchargeEntities.expiryDateStr" readonly
							placeholder="失效日期" dateGte="#fclQsurchargeEntities\.execDateStr">
						<span class="add-on"><i class="icon-remove"></i></span> <span
							class="add-on"><i class="icon-calendar"></i></span>
					</div>
					<font color="red"><form:errors
							path="lgsFclQuoteInfoVo.surchargeEntity.expiryDate" /></font>
				</c:when>
				<c:otherwise>
					<span class="inline"><fmt:formatDate
							value='${surchargeEntity.expiryDate}' pattern='yyyy-MM-dd' />&nbsp;</span>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
<c:choose>
	<c:when test="${null != surchargeEntity.createUsername}">
		<div class="row-fluid">
			<div class="span6 control-group">
				<label class="control-label">创建人&nbsp;:</label>

				<div class="controls">
					<span class="inline">${surchargeEntity.createUsername}&nbsp;</span>
					<input type="hidden" name="surchargeEntity.createUsername"
						value="${surchargeEntity.createUsername}">
				</div>
			</div>
			<div class="span6 control-group">
				<label class="control-label">创建时间&nbsp;:</label>

				<div class="controls">
					<span class="inline"><fmt:formatDate
							value="${surchargeEntity.createDatetime}"
							pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;</span>
				</div>
			</div>
		</div>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${null != surchargeEntity.updateUsername}">
		<div class="row-fluid">
			<div class="span6 control-group">
				<label class="control-label">修改人&nbsp;:</label>

				<div class="controls">
					<span class="inline">${surchargeEntity.updateUsername}&nbsp;</span>
				</div>
			</div>
			<div class="span6 control-group">
				<label class="control-label">修改时间&nbsp;:</label>
				<div class="controls">
					<span class="inline"><fmt:formatDate
							value="${surchargeEntity.updateDatetime}"
							pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;</span>
				</div>
			</div>
		</div>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>
<div class="row-fluid">
	<div class="span6 control-group">
         <label title="是否all-in" class="control-label">是否all-in：</label>
         <div class="controls">
         <span class="inline" >
         	<select name="fclQuoteEntity.ifAllIn" id="fclQuoteEntity.ifAllIn">
         		<option value="1" <c:if test="${entity.ifAllIn eq 1}">selected="selected"</c:if>>是</option>
         		<option value="0" <c:if test="${entity.ifAllIn eq 0}">selected="selected"</c:if>>否</option>
         	</select>
         </div>
    </div>
	<div class="span6 control-group">
		<label class="control-label">状态&nbsp;:</label>
		<div class="controls">
			<input type="hidden" id="fclQsurchargeEntities.status"
				name="fclQsurchargeEntities.status"
				value="${surchargeEntity.status}">
			<sunivo:disabledFlagView value="${surchargeEntity.status}" />
		</div>
	</div>
</div>
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
						<input name="fclQsurchargeEntities.id" id="fclQsurchargeEntities.id"
							type="hidden" value="${surchargeEntity.id}" /> <input
							id="fclQsurchargeEntities.quoteType"
							name="fclQsurchargeEntities.quoteType" type="hidden"
							value="${surchargeEntity.quoteType}" /> <input
							id="fclQsurchargeEntities.quoteId"
							name="fclQsurchargeEntities.quoteId" type="hidden"
							value="${surchargeEntity.quoteId}" />
						<input id="fclQsurchargeEntities.prdQuoteId"
							name="fclQsurchargeEntities.prdQuoteId" type="hidden"
							value="${surchargeEntity.prdQuoteId}" />
						<input id="fclQsurchargeEntities.status"
							name="fclQsurchargeEntities.status" type="hidden"
							value="${surchargeEntity.status}" />
						<input id="fclQsurchargeEntities.disabled"
							name="fclQsurchargeEntities.disabled" type="hidden"
							value="${surchargeEntity.disabled}" />
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
										<td>20' GP</td>
										<td><c:choose>
												<c:when test="${action=='edit'}">
													<input type="text" name="fclQsurchargeEntities.cost20gp"
														id="fclQsurchargeEntities.cost20gp"
														value='<sunivo:numberFormatView value="${surchargeEntity.cost20gp }" />'
														class="positiveNumber" placeholder="20' GP成本报价">
												</c:when>
												<c:otherwise>
													<sunivo:moneyFormatView
														money="${surchargeEntity.cost20gp }" />
												</c:otherwise>
											</c:choose></td>
										<td><c:choose>
												<c:when test="${action=='edit'}">
													<input type="text" name="fclQsurchargeEntities.price20gp"
														id="fclQsurchargeEntities.price20gp"
														value='<sunivo:numberFormatView value="${surchargeEntity.price20gp }" />'
														class="positiveNumber" placeholder="20' GP销售价">
												</c:when>
												<c:otherwise>
													<sunivo:moneyFormatView
														money="${surchargeEntity.price20gp }" />
												</c:otherwise>
											</c:choose></td>
										<td><c:choose>
												<c:when test="${action=='edit'}">
													<input type="text"
														name="fclQsurchargeEntities.discount20gp"
														id="fclQsurchargeEntities.discount20gp"
														value='<sunivo:numberFormatView value="${surchargeEntity.discount20gp }" />'
														class="positiveNumber" placeholder="20' GP折扣价">
												</c:when>
												<c:otherwise>
													<sunivo:moneyFormatView
														money="${surchargeEntity.discount20gp }" />
												</c:otherwise>
											</c:choose></td>
										<td><sunivo:moneyFormatView
												money="${surchargeEntity.discount20gp }" /></td>
									</tr>
									<tr>
										<td>40' GP</td>
										<td><c:choose>
												<c:when test="${action=='edit'}">
													<input type="text" name="fclQsurchargeEntities.cost40gp"
														id="fclQsurchargeEntities.cost40gp"
														value='<sunivo:numberFormatView value="${surchargeEntity.cost40gp }" />'
														class="positiveNumber" placeholder="40' GP成本报价">
												</c:when>
												<c:otherwise>
													<sunivo:moneyFormatView
														money="${surchargeEntity.cost40gp }" />
												</c:otherwise>
											</c:choose></td>
										<td><c:choose>
												<c:when test="${action=='edit'}">
													<input type="text" name="fclQsurchargeEntities.price40gp"
														id="fclQsurchargeEntities.price40gp"
														value='<sunivo:numberFormatView value="${surchargeEntity.price40gp }" />'
														class="positiveNumber" placeholder="40' GP销售价">
												</c:when>
												<c:otherwise>
													<sunivo:moneyFormatView
														money="${surchargeEntity.price40gp }" />
												</c:otherwise>
											</c:choose></td>
										<td><c:choose>
												<c:when test="${action=='edit'}">
													<input type="text"
														name="fclQsurchargeEntities.discount40gp"
														id="fclQsurchargeEntities.discount40gp"
														value='<sunivo:numberFormatView value="${surchargeEntity.discount40gp }" />'
														class="positiveNumber" placeholder="40' GP折扣价">
												</c:when>
												<c:otherwise>
													<sunivo:moneyFormatView
														money="${surchargeEntity.discount40gp }" />
												</c:otherwise>
											</c:choose></td>
										<td><sunivo:moneyFormatView
												money="${surchargeEntity.discount40gp }" /></td>
									</tr>
									<tr>
										<td>40' HQ</td>
										<td><c:choose>
												<c:when test="${action=='edit'}">
													<input type="text" name="fclQsurchargeEntities.cost40hq"
														id="fclQsurchargeEntities.cost40hq"
														value='<sunivo:numberFormatView value="${surchargeEntity.cost40hq }" />'
														class="positiveNumber" placeholder="40' HQ成本报价">
												</c:when>
												<c:otherwise>
													<sunivo:moneyFormatView
														money="${surchargeEntity.cost40hq }" />
												</c:otherwise>
											</c:choose></td>
										<td><c:choose>
												<c:when test="${action=='edit'}">
													<input type="text" name="fclQsurchargeEntities.price40hq"
														id="fclQsurchargeEntities.price40hq"
														value='<sunivo:numberFormatView value="${surchargeEntity.price40hq }" />'
														class="positiveNumber" placeholder="40' HQ销售价">
												</c:when>
												<c:otherwise>
													<sunivo:moneyFormatView
														money="${surchargeEntity.price40hq }" />
												</c:otherwise>
											</c:choose></td>
										<td><c:choose>
												<c:when test="${action=='edit'}">
													<input type="text"
														name="fclQsurchargeEntities.discount40hq"
														id="fclQsurchargeEntities.discount40hq"
														value='<sunivo:numberFormatView value="${surchargeEntity.discount40hq }" />'
														class="positiveNumber" placeholder="40' HQ折扣价">
												</c:when>
												<c:otherwise>
													<sunivo:moneyFormatView
														money="${surchargeEntity.discount40hq }" />
												</c:otherwise>
											</c:choose></td>
										<td><sunivo:moneyFormatView
												money="${surchargeEntity.discount40hq }" /></td>
									</tr>
								</tbody>
							</table>
						</div>
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
									<textarea id="fclQsurchargeEntities.remark"
										name="fclQsurchargeEntities.remark" rows="6" cols=""
										class="span12" placeholder="备注" maxlength="300">${surchargeEntity.remark}</textarea>
									<span class="label label-warning pull-right">备注最多输入300个字符</span>
								</c:when>
								<c:otherwise>
									<c:out value="${surchargeEntity.remark}" />
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>