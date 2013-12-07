<%@include file="/WEB-INF/common/layouts/common.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<body>
   <form id="inquiry_quote_sub_view_form" name="inquiry_quote_sub_view_form"
		action="${ctx}/lgsfclquoteinfocase/select" method="POST">
		<table class="table table-bordered table-striped table_vam" id="dt_gal">
			<thead>
				<tr>
					<th width="30">费用项目</th>
					<th width="20">单位</th>
					<th width="20">币种</th>
					<th width="20">是否ALL-IN</th>
					<th width="20">每票</th>
					<th width="20">20′</th>
					<th width="20">40′</th>
					<th width="20">40HQ</th>
				</tr>
			</thead>
					<tbody>
				<c:forEach items="${quoteInfoCaseSubVoList}" var="fclQuoteInfoCaseVo">
				<c:set value="${fclQuoteInfoCaseVo.entity}" var="entity"></c:set>
				<tr>					
					<td nowrap="nowrap">
						<c:if test="${null ne fclQuoteInfoCaseVo.quoteName && '' ne fclQuoteInfoCaseVo.quoteName}">
							<c:out value="${fclQuoteInfoCaseVo.quoteName}" />
						</c:if>
						<c:if test="${null eq fclQuoteInfoCaseVo.quoteName || '' eq fclQuoteInfoCaseVo.quoteName}">
							&nbsp;
						</c:if>
					</td>
					<td nowrap="nowrap">
						<%-- <g:unitView value="${entity.unitId}" /> --%>
						<sunivo:unitView value="${entity.unitId}"/>
					</td>
					<td nowrap="nowrap">
						<%-- <g:currencyView value="${entity.currencyid}"/> --%>
						<sunivo:currencyView showType="cn" value="${entity.currencyid}"/>
					</td>
					<td nowrap="nowrap">
						<c:choose>
						<c:when test="${null ne entity.ifAllin && entity.ifAllin}">
							是
						</c:when>
						<c:otherwise>
							否
						</c:otherwise>
						</c:choose>
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${entity.nonContainerCost ne null && '' ne entity.nonContainerCost}">
								<%-- <g:moneyView money="${entity.nonContainerCost}" /> 
								<g:currencyViewCRM showType="symbol" value="${entity.currencyid}"/> --%>
								<sunivo:moneyFormatView money="${entity.nonContainerCost}"/>
								<sunivo:currencyView showType="symbol" value="${entity.currencyid}"/>
							</c:when>
							<c:otherwise></c:otherwise>							
						</c:choose>
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${entity.cost20Gp ne null && '' ne entity.cost20Gp}">
								<%-- <g:moneyView money="${entity.cost20Gp}" /> 
								<g:currencyViewCRM showType="symbol" value="${entity.currencyid}"/> --%>
								<sunivo:moneyFormatView money="${entity.cost20Gp}"/>
								<sunivo:currencyView showType="symbol" value="${entity.currencyid}"/>
							</c:when>
							<c:otherwise></c:otherwise>							
						</c:choose>
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${entity.cost40Gp ne null && '' ne entity.cost40Gp}">
								<%-- <g:moneyView money="${entity.cost40Gp}" />
								<g:currencyViewCRM showType="symbol" value="${entity.currencyid}"/> --%>
								<sunivo:moneyFormatView money="${entity.cost40Gp}"/>
								<sunivo:currencyView showType="symbol" value="${entity.currencyid}"/>
							</c:when>
							<c:otherwise></c:otherwise>							
						</c:choose>
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${entity.cost40Hq ne null && '' ne entity.cost40Hq}">
								<%-- <g:moneyView money="${entity.cost40Hq}" />
								<g:currencyViewCRM showType="symbol" value="${entity.currencyid}"/> --%>
								<sunivo:moneyFormatView money="${entity.cost40Hq}"/>
								<sunivo:currencyView showType="symbol" value="${entity.currencyid}"/>
							</c:when>
							<c:otherwise></c:otherwise>							
						</c:choose>
					</td>
				
				</tr>
				</c:forEach>
				
				<!-- 展示本地费列表 -->
				<c:forEach items="${portQsurchargeList}" var="portQsurchargeVo">
				<c:set value="${portQsurchargeVo.entity}" var="entity"></c:set>
				<c:set value="${portQsurchargeVo.prdQuoteEntity}" var="prdEntity"></c:set>
				<tr>					
					<td nowrap="nowrap">
						<c:if test="${null ne prdEntity.name && '' ne prdEntity.name}">
							<c:out value="${prdEntity.name}" />
						</c:if>
						<c:if test="${null eq prdEntity.name || '' eq prdEntity.name}">
							&nbsp;
						</c:if>
					</td>
					<td nowrap="nowrap">
						<%-- <g:unitView value="${entity.unitId}" /> --%>
						<sunivo:unitView value="${prdEntity.unitId}"/>
					</td>
					<td nowrap="nowrap">
						<%-- <g:currencyView value="${entity.currencyid}"/> --%>
						<sunivo:currencyView showType="cn" value="${prdEntity.currencyId}"/>
					</td>
					<td nowrap="nowrap">
						<%-- <c:choose>
						<c:when test="${null ne entity.ifAllin && entity.ifAllin}">
							是
						</c:when>
						<c:otherwise>
							否
						</c:otherwise>
						</c:choose> --%>
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${entity.nonContainerCost ne null && '' ne entity.nonContainerCost}">
								<%-- <g:moneyView money="${entity.nonContainerCost}" /> 
								<g:currencyViewCRM showType="symbol" value="${entity.currencyid}"/> --%>
								<sunivo:moneyFormatView money="${entity.nonContainerCost}"/>
								<sunivo:currencyView showType="symbol" value="${prdEntity.currencyId}"/>
							</c:when>
							<c:otherwise></c:otherwise>							
						</c:choose>
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${entity.cost20gp ne null && '' ne entity.cost20gp}">
								<%-- <g:moneyView money="${entity.cost20Gp}" /> 
								<g:currencyViewCRM showType="symbol" value="${entity.currencyid}"/> --%>
								<sunivo:moneyFormatView money="${entity.cost20gp}"/>
								<sunivo:currencyView showType="symbol" value="${prdEntity.currencyId}"/>
							</c:when>
							<c:otherwise></c:otherwise>							
						</c:choose>
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${entity.cost40gp ne null && '' ne entity.cost40gp}">
								<%-- <g:moneyView money="${entity.cost40Gp}" />
								<g:currencyViewCRM showType="symbol" value="${entity.currencyid}"/> --%>
								<sunivo:moneyFormatView money="${entity.cost40gp}"/>
								<sunivo:currencyView showType="symbol" value="${prdEntity.currencyId}"/>
							</c:when>
							<c:otherwise></c:otherwise>							
						</c:choose>
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${entity.cost40hq ne null && '' ne entity.cost40hq}">
								<%-- <g:moneyView money="${entity.cost40Hq}" />
								<g:currencyViewCRM showType="symbol" value="${entity.currencyid}"/> --%>
								<sunivo:moneyFormatView money="${entity.cost40hq}"/>
								<sunivo:currencyView showType="symbol" value="${prdEntity.currencyId}"/>
							</c:when>
							<c:otherwise></c:otherwise>							
						</c:choose>
					</td>
				
				</tr>
				</c:forEach>
				
			</tbody>
		</table>
		<!-- <table border="1" id="dataTable"> -->
	</form>
