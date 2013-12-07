<%@include file="/WEB-INF/common/layouts/common.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>${entity.id}</title>
</head>
<body>
<form id="input_form" class="form-horizontal valid"
      action="${ctx}/lgsfclqsurcharge<c:if test="${action=='edit'}">/${entity.id}</c:if>"
      method="post">
    <input name="id" id="id" value="${entity.id}" type="hidden"/>

    <div class="row${fluid}">
        <div class="span12">
            <h3 class="page-title">${entity.id}</h3>
        </div>
    </div>

    <div class="row${fluid}">
        <div class="span12">
            <div class="portlet-header">
                <div class="operation-btn pull-right">
                    <c:choose>
                        <c:when test="${action=='edit'}">
                            <button class="btn blue" type="submit"><i
                                    class="icon-save"></i>&nbsp;保存
                            </button>
                            <a href="${ctx}/lgsfclqsurcharge/${entity.id}" class="btn gray"><i
                                    class="icon-mail-reply"></i>&nbsp;取消</a>
                        </c:when>
                        <c:when test="${action=='create'}">
                            <button class="btn blue"><i class="icon-save"></i>&nbsp;保存</button>
                            <a href="${ctx}/lgsfclqsurcharge" class="btn gray"><i class="icon-mail-reply"></i>&nbsp;返回</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${ctx}/lgsfclqsurcharge/${entity.id}?action=edit" class="btn blue"><i
                                    class="icon-edit"></i>&nbsp;编辑</a>
                            <a href="${ctx}/lgsfclqsurcharge" class="btn gray"><i class="icon-mail-reply"></i>&nbsp;返回</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <sunivo:flushMessage/>
            <div class="portlet box grey">
                <div class="portlet-title">
                    <h4>海运整箱报价费用信息  包含本地费 附加费 海运费 三种费用详情信息详情</h4>
                </div>
                <div class="portlet-body form">
                    <input name="entity.id" type="hidden" value="${entity.id}"/>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">区分海运费、本地费、附加费    1-附加费  2-本地费   3-附加费:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.quoteType"
											name="entity.quoteType"
											value="${entity.quoteType}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.quoteType" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.quoteType}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">主表中的ID:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.quoteId"
											name="entity.quoteId"
											value="${entity.quoteId}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.quoteId" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.quoteId}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">prd_quote表中报价项id:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.prdQuoteId"
											name="entity.prdQuoteId"
											value="${entity.prdQuoteId}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.prdQuoteId" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.prdQuoteId}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">20'的成本价:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.cost20gp"
											name="entity.cost20gp"
											value="${entity.cost20gp}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.cost20gp" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.cost20gp}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">40'的成本价:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.cost40gp"
											name="entity.cost40gp"
											value="${entity.cost40gp}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.cost40gp" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.cost40gp}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">40HQ的成本价:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.cost40hq"
											name="entity.cost40hq"
											value="${entity.cost40hq}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.cost40hq" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.cost40hq}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">20':</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.price20gp"
											name="entity.price20gp"
											value="${entity.price20gp}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.price20gp" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.price20gp}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">40':</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.price40gp"
											name="entity.price40gp"
											value="${entity.price40gp}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.price40gp" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.price40gp}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">40HQ:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.price40hq"
											name="entity.price40hq"
											value="${entity.price40hq}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.price40hq" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.price40hq}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">20':</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.discount20gp"
											name="entity.discount20gp"
											value="${entity.discount20gp}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.discount20gp" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.discount20gp}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">40':</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.discount40gp"
											name="entity.discount40gp"
											value="${entity.discount40gp}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.discount40gp" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.discount40gp}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">40HQ:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.discount40hq"
											name="entity.discount40hq"
											value="${entity.discount40hq}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.discount40hq" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.discount40hq}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">按票按吨等计费方式的单价:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.nonContainerCost"
											name="entity.nonContainerCost"
											value="${entity.nonContainerCost}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.nonContainerCost" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.nonContainerCost}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">按票按吨等计费方式的销售单价:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.nonContainerPrice"
											name="entity.nonContainerPrice"
											value="${entity.nonContainerPrice}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.nonContainerPrice" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.nonContainerPrice}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">按票按吨等计费方式的折扣单价:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.nonContainerDiscount"
											name="entity.nonContainerDiscount"
											value="${entity.nonContainerDiscount}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.nonContainerDiscount" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.nonContainerDiscount}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">生效日期:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.execDateStr"
											name="entity.execDateStr"
											value="<fmt:formatDate value='${entity.execDate}' pattern='yyyy-MM-dd HH:mm:ss' />" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.execDate" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.execDate}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">失效日期:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.expiryDateStr"
											name="entity.expiryDateStr"
											value="<fmt:formatDate value='${entity.expiryDate}' pattern='yyyy-MM-dd HH:mm:ss' />" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.expiryDate" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.expiryDate}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">备注:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.remark"
											name="entity.remark"
											value="${entity.remark}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.remark" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.remark}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">0-启用  1-停用   2-已过期:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.status"
											name="entity.status"
											value="${entity.status}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.status" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.status}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">disabled:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.disabled"
											name="entity.disabled"
											value="${entity.disabled}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.disabled" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.disabled}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">createUserId:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.createUserId"
											name="entity.createUserId"
											value="${entity.createUserId}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.createUserId" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.createUserId}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">createUserName:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.createUserName"
											name="entity.createUserName"
											value="${entity.createUserName}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.createUserName" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.createUserName}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">createDatetime:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.createDatetimeStr"
											name="entity.createDatetimeStr"
											value="<fmt:formatDate value='${entity.createDatetime}' pattern='yyyy-MM-dd HH:mm:ss' />" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.createDatetime" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.createDatetime}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">createIp:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.createIp"
											name="entity.createIp"
											value="${entity.createIp}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.createIp" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.createIp}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">updateUserId:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.updateUserId"
											name="entity.updateUserId"
											value="${entity.updateUserId}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.updateUserId" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.updateUserId}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">updateUserName:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.updateUserName"
											name="entity.updateUserName"
											value="${entity.updateUserName}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.updateUserName" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.updateUserName}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">updateDatetime:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.updateDatetimeStr"
											name="entity.updateDatetimeStr"
											value="<fmt:formatDate value='${entity.updateDatetime}' pattern='yyyy-MM-dd HH:mm:ss' />" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.updateDatetime" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.updateDatetime}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">updateIp:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.updateIp"
											name="entity.updateIp"
											value="${entity.updateIp}" />
										<font color="red"><form:errors path="lgsFclQsurchargeVo.entity.updateIp" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.updateIp}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
                </div>
            </div>
        </div>
    </div>
</form>
</body>

</html>