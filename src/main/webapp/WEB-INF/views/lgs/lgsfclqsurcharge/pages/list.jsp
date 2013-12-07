<%@include file="/WEB-INF/common/layouts/common.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息列表</title>
</head>
<body>
<div class="row${fluid}">
    <div class="span6">
        <h2 class="page-title">海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息列表</h2>
    </div>
    <div class="span6 header_buttons">
        <a href="${ctx}/lgsfclqsurcharge?action=create" class="btn blue pull-right"><i class="icon-plus"></i></a>
    </div>
</div>

<div class="page-container">
    <div class="row${fluid}">
        <div class="span12">
            <form id="filterForm" class="form-inline filterForm" action="${ctx}/lgsfclqsurcharge" method="get">
				<input type="text" name="search_LIKE_id" value="${param['search_LIKE_id']}" 
					class="m-wrap small" placeholder="id">
				<input type="text" name="search_LIKE_quoteType" value="${param['search_LIKE_quoteType']}" 
					class="m-wrap small" placeholder="区分海运费、本地费、附加费    1-附加费  2-本地费   3-附加费">
				<input type="text" name="search_LIKE_quoteId" value="${param['search_LIKE_quoteId']}" 
					class="m-wrap small" placeholder="主表中的ID">
				<input type="text" name="search_LIKE_prdQuoteId" value="${param['search_LIKE_prdQuoteId']}" 
					class="m-wrap small" placeholder="prd_quote表中报价项id">
                <div class="buttons pull-right">
                    <i class="icon-search icon-2x pointer" onclick="$('#filterForm').submit();"></i>
                </div>
	            </form>
        </div>
    </div>
    <table class="table table-striped table-advance table-hover">
        <thead>
        	<tr>
				<th width="100">id</th>
				<th width="100">区分海运费、本地费、附加费    1-附加费  2-本地费   3-附加费</th>
				<th width="100">主表中的ID</th>
				<th width="100">prd_quote表中报价项id</th>
				<th width="100">20'的成本价</th>
				<th width="100">40'的成本价</th>
				<th width="100">40HQ的成本价</th>
				<th width="100">20'</th>
				<th width="100">40'</th>
				<th width="100">40HQ</th>
				<th width="100">20'</th>
				<th width="100">40'</th>
				<th width="100">40HQ</th>
				<th width="100">按票按吨等计费方式的单价</th>
				<th width="100">按票按吨等计费方式的销售单价</th>
				<th width="100">按票按吨等计费方式的折扣单价</th>
				<th width="100">生效日期</th>
				<th width="100">失效日期</th>
				<th width="100">备注</th>
				<th width="100">0-启用  1-停用   2-已过期</th>
				<th width="100">disabled</th>
				<th width="100">createUserId</th>
				<th width="100">createUserName</th>
				<th width="100">createDatetime</th>
				<th width="100">createIp</th>
				<th width="100">updateUserId</th>
				<th width="100">updateUserName</th>
				<th width="100">updateDatetime</th>
				<th width="100">updateIp</th>
				<th width="150">操作</th>
			</tr>
        </thead>
        <c:forEach items="${lgsFclQsurcharges}" var="lgsFclQsurcharge">
            <tr>
				<td nowrap="nowrap">
				    <a href="${ctx}/lgsfclqsurcharge/${lgsFclQsurcharge.id}">						<c:if test="${null ne lgsFclQsurcharge.id && '' ne lgsFclQsurcharge.id}">
							<c:out value="${lgsFclQsurcharge.id}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.id || '' eq lgsFclQsurcharge.id}">
							&nbsp;
						</c:if>
</a>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.quoteType && '' ne lgsFclQsurcharge.quoteType}">
							<c:out value="${lgsFclQsurcharge.quoteType}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.quoteType || '' eq lgsFclQsurcharge.quoteType}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.quoteId && '' ne lgsFclQsurcharge.quoteId}">
							<c:out value="${lgsFclQsurcharge.quoteId}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.quoteId || '' eq lgsFclQsurcharge.quoteId}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.prdQuoteId && '' ne lgsFclQsurcharge.prdQuoteId}">
							<c:out value="${lgsFclQsurcharge.prdQuoteId}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.prdQuoteId || '' eq lgsFclQsurcharge.prdQuoteId}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.cost20gp && '' ne lgsFclQsurcharge.cost20gp}">
							<c:out value="${lgsFclQsurcharge.cost20gp}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.cost20gp || '' eq lgsFclQsurcharge.cost20gp}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.cost40gp && '' ne lgsFclQsurcharge.cost40gp}">
							<c:out value="${lgsFclQsurcharge.cost40gp}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.cost40gp || '' eq lgsFclQsurcharge.cost40gp}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.cost40hq && '' ne lgsFclQsurcharge.cost40hq}">
							<c:out value="${lgsFclQsurcharge.cost40hq}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.cost40hq || '' eq lgsFclQsurcharge.cost40hq}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.price20gp && '' ne lgsFclQsurcharge.price20gp}">
							<c:out value="${lgsFclQsurcharge.price20gp}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.price20gp || '' eq lgsFclQsurcharge.price20gp}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.price40gp && '' ne lgsFclQsurcharge.price40gp}">
							<c:out value="${lgsFclQsurcharge.price40gp}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.price40gp || '' eq lgsFclQsurcharge.price40gp}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.price40hq && '' ne lgsFclQsurcharge.price40hq}">
							<c:out value="${lgsFclQsurcharge.price40hq}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.price40hq || '' eq lgsFclQsurcharge.price40hq}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.discount20gp && '' ne lgsFclQsurcharge.discount20gp}">
							<c:out value="${lgsFclQsurcharge.discount20gp}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.discount20gp || '' eq lgsFclQsurcharge.discount20gp}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.discount40gp && '' ne lgsFclQsurcharge.discount40gp}">
							<c:out value="${lgsFclQsurcharge.discount40gp}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.discount40gp || '' eq lgsFclQsurcharge.discount40gp}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.discount40hq && '' ne lgsFclQsurcharge.discount40hq}">
							<c:out value="${lgsFclQsurcharge.discount40hq}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.discount40hq || '' eq lgsFclQsurcharge.discount40hq}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.nonContainerCost && '' ne lgsFclQsurcharge.nonContainerCost}">
							<c:out value="${lgsFclQsurcharge.nonContainerCost}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.nonContainerCost || '' eq lgsFclQsurcharge.nonContainerCost}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.nonContainerPrice && '' ne lgsFclQsurcharge.nonContainerPrice}">
							<c:out value="${lgsFclQsurcharge.nonContainerPrice}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.nonContainerPrice || '' eq lgsFclQsurcharge.nonContainerPrice}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.nonContainerDiscount && '' ne lgsFclQsurcharge.nonContainerDiscount}">
							<c:out value="${lgsFclQsurcharge.nonContainerDiscount}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.nonContainerDiscount || '' eq lgsFclQsurcharge.nonContainerDiscount}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.execDate && '' ne lgsFclQsurcharge.execDate}">
							<f:formatDate value='${lgsFclQsurcharge.execDate}' pattern='yyyy-MM-dd HH:mm:ss' />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.execDate || '' eq lgsFclQsurcharge.execDate}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.expiryDate && '' ne lgsFclQsurcharge.expiryDate}">
							<f:formatDate value='${lgsFclQsurcharge.expiryDate}' pattern='yyyy-MM-dd HH:mm:ss' />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.expiryDate || '' eq lgsFclQsurcharge.expiryDate}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.remark && '' ne lgsFclQsurcharge.remark}">
							<c:out value="${lgsFclQsurcharge.remark}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.remark || '' eq lgsFclQsurcharge.remark}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.status && '' ne lgsFclQsurcharge.status}">
							<c:out value="${lgsFclQsurcharge.status}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.status || '' eq lgsFclQsurcharge.status}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.disabled && '' ne lgsFclQsurcharge.disabled}">
							<c:out value="${lgsFclQsurcharge.disabled}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.disabled || '' eq lgsFclQsurcharge.disabled}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.createUserId && '' ne lgsFclQsurcharge.createUserId}">
							<c:out value="${lgsFclQsurcharge.createUserId}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.createUserId || '' eq lgsFclQsurcharge.createUserId}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.createUserName && '' ne lgsFclQsurcharge.createUserName}">
							<c:out value="${lgsFclQsurcharge.createUserName}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.createUserName || '' eq lgsFclQsurcharge.createUserName}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.createDatetime && '' ne lgsFclQsurcharge.createDatetime}">
							<f:formatDate value='${lgsFclQsurcharge.createDatetime}' pattern='yyyy-MM-dd HH:mm:ss' />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.createDatetime || '' eq lgsFclQsurcharge.createDatetime}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.createIp && '' ne lgsFclQsurcharge.createIp}">
							<c:out value="${lgsFclQsurcharge.createIp}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.createIp || '' eq lgsFclQsurcharge.createIp}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.updateUserId && '' ne lgsFclQsurcharge.updateUserId}">
							<c:out value="${lgsFclQsurcharge.updateUserId}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.updateUserId || '' eq lgsFclQsurcharge.updateUserId}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.updateUserName && '' ne lgsFclQsurcharge.updateUserName}">
							<c:out value="${lgsFclQsurcharge.updateUserName}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.updateUserName || '' eq lgsFclQsurcharge.updateUserName}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.updateDatetime && '' ne lgsFclQsurcharge.updateDatetime}">
							<f:formatDate value='${lgsFclQsurcharge.updateDatetime}' pattern='yyyy-MM-dd HH:mm:ss' />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.updateDatetime || '' eq lgsFclQsurcharge.updateDatetime}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
						<c:if test="${null ne lgsFclQsurcharge.updateIp && '' ne lgsFclQsurcharge.updateIp}">
							<c:out value="${lgsFclQsurcharge.updateIp}" />
						</c:if>
						<c:if test="${null eq lgsFclQsurcharge.updateIp || '' eq lgsFclQsurcharge.updateIp}">
							&nbsp;
						</c:if>
				</td>
				<td nowrap="nowrap">
                    <i class="icon-edit pointer icon-large"
						onclick="window.location='${ctx}/lgsfclqsurcharge/${lgsFclQsurcharge.id}?action=edit'"></i>
						&nbsp;&nbsp; <i
						title="删除"
						class="icon-minus pointer icon-large"
						onclick="deleteById('${lgsFclQsurcharge.id}')"> </i>
					</td>
			</tr>
        </c:forEach>
    </table>
    <div class="row${fluid}">
        <sunivo:pagination page="${page}"/>
    </div>
</div>
<script type="text/javascript">
    var deleteById = function (lgsfclqsurchargeId) {
        createModal("删除海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息", "确定要删除该海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息？", function () {
            $.ajax({
                url: '${ctx}/lgsfclqsurcharge/' + lgsfclqsurchargeId,
                type: "DELETE",
                dataType: "json",
                success: function () {
                    window.location.reload();
                }
            });
        });
    };
</script>
</body>
</html>
