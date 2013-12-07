<%@include file="/WEB-INF/common/layouts/common.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<body>
   <form id="inquiry_quote_sub_view_form" name="inquiry_quote_sub_view_form"
		action="${ctx}/lgslclquoteinfocase/select" method="POST">
		<table class="table table-bordered table-striped table_vam" id="dt_gal">
			<thead>
				<tr>
					<th width="30">费用项目</th>
					<th width="20">单位</th>
					<th width="20">币种</th>
					<th width="20">是否发货人承担</th>
					<th width="20">每票</th>
					<th width="20">体积单价</th>
					<th width="20">重量单价</th>
				</tr>
			</thead>
					<tbody>
				<c:forEach items="${quoteInfoCaseSubVoList}" var="lclQuoteInfoCaseVo">
				<c:set value="${lclQuoteInfoCaseVo.entity}" var="entity"></c:set>
				<tr>					
					<td nowrap="nowrap">
						<c:if test="${null ne lclQuoteInfoCaseVo.quoteName && '' ne lclQuoteInfoCaseVo.quoteName}">
							<c:out value="${lclQuoteInfoCaseVo.quoteName}" />
						</c:if>
						<c:if test="${null eq lclQuoteInfoCaseVo.quoteName || '' eq lclQuoteInfoCaseVo.quoteName}">
							&nbsp;
						</c:if>
					</td>
					<td nowrap="nowrap">
						<sunivo:unitView value="${entity.unitId}" />
					</td>
					<td nowrap="nowrap">
						<%-- <g:currencyView value="${entity.currencyid}"/> --%>
						<sunivo:currencyView showType="cn" value="${entity.currencyid}"/>
					</td>
					<td nowrap="nowrap">
						<c:choose>
						<c:when test="${null ne entity.ifConsignorBear && entity.ifConsignorBear}">
							是
						</c:when>
						<c:otherwise>
							否
						</c:otherwise>
						</c:choose>
					</td>
					<td nowrap="nowrap">
						<c:choose>
						<c:when test="${entity.otherCost ne null && '' ne entity.otherCost}">
							<%-- <g:moneyView money="${entity.otherCost}" /> 
							<g:currencyViewCRM showType="symbol" value="${entity.currencyid}"/> --%>
							<sunivo:moneyFormatView money="${entity.otherCost}"  />
							<sunivo:currencyView showType="symbol" value="${entity.currencyid}"/>
						</c:when>
						<c:otherwise>
							&nbsp;
						</c:otherwise>
						</c:choose>
					</td>
					<td nowrap="nowrap">
						<c:choose>
						<c:when test="${entity.volumeCost ne null && '' ne entity.volumeCost}">
							<%-- <g:moneyView money="${entity.volumeCost}" /> 
							<g:currencyViewCRM showType="symbol" value="${entity.currencyid}"/> --%>
							<sunivo:moneyFormatView money="${entity.volumeCost}"  />
							<sunivo:currencyView showType="symbol" value="${entity.currencyid}"/>
						</c:when>
						<c:otherwise>
							&nbsp;
						</c:otherwise>
						</c:choose>
					</td>
					<td nowrap="nowrap">
						<c:choose>
						
						<c:when test="${entity.weightCost ne null && '' ne entity.weightCost}">
							<%-- <g:moneyView money="${entity.weightCost}" /> 
							<g:currencyViewCRM showType="symbol" value="${entity.currencyid}"/> --%>
							<sunivo:moneyFormatView money="${entity.weightCost}"  />
							<sunivo:currencyView showType="symbol" value="${entity.currencyid}"/>
						</c:when>
						<c:otherwise>
							&nbsp;
						</c:otherwise>
						</c:choose>
					</td>
				</tr>
				</c:forEach>
				
			</tbody>
		</table>
	</form>
