<%@include file="/WEB-INF/common/layouts/common.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<html>
<body>
<%@include file="/WEB-INF/common/layouts/common.jsp" %>
<script type="text/javascript">
 function inputMoney(inputObj){

    if(inputObj.value == "0.00"){

        inputObj.value = "";    

    }

}

 

function checkMoney(inputObj){

    var number = inputObj.value;

    if(number == ""){

        inputObj.value = "0.00";

        return;

    }

    if(isNaN(number)){

        inputObj.value = "0.00";

        return;

    }

    inputObj.value = changeThreeDecimal(number);

    if(inputObj.value.length > 17){

        alert("金额超出范围！");

        inputObj.value = "0.00";

    }

}

 

//强制保留两位小数

function changeThreeDecimal(x){

    x = parseFloat(x);

    var f_x = Math.round(x * 100) / 100;

    var s_x = f_x.toString();

    var pos_decimal = s_x.indexOf('.');

    if(pos_decimal < 0){

        pos_decimal = s_x.length;

        s_x += '.';

    }

    while(s_x.length <= pos_decimal + 2){

        s_x += '0';

    }

    return s_x;

}
</script>
<form id="editproxsurchargeform" class="form-horizontal valid"
      action="${ctx}/lgsproxysurcharge/updateLgsProxySurchargeSection<c:if test="${action=='edit'}">/${entity.id}</c:if>"
      method="post">
    <input name="id" id="id" value="${entity.id}" type="hidden"/>
	<input name="entity.quoteidiD" id="entity.quoteidiD" value="${entity.quoteidiD}" type="hidden"/>
	<input name="entity.quoteId" id="entity.quoteId" value="${entity.quoteId}" type="hidden"/>
    <div class="row${fluid}">
        <div class="span12">
            
            <sunivo:flushMessage/>
            <div class="portlet box grey">
                
                <div class="portlet-body form">
                    <input name="entity.id" type="hidden" value="${entity.id}"/>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">费用名称:</label>
                            <g:prdQuoteView value="${entity.quoteidiD}"/>
                        </div>
                        <div class="span6 control-group">
                        <label class="control-label">是否启用:</label>
                         <c:choose>
                            <c:when test="${action=='create' || action=='edit'}">
                            
							<select id="ifAllIn" name="entity.ifAllIn" style="width: 60px;">
								<option value="1" <c:if test="${entity.ifAllIn eq true }">selected="selected"</c:if>>是</option>
								<option value="0" <c:if test="${entity.ifAllIn eq false }">selected="selected"</c:if>>否</option>
							</select>
							</c:when>
                            <c:otherwise>
                                <c:if test="${entity.ifAllIn eq true }">是</c:if>
                                <c:if test="${entity.ifAllIn eq false }">否</c:if>
                            </c:otherwise>
                        </c:choose>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">计价单位:</label>

                            <div class="controls">
	                        	<g:unitView value="${entity.unitId}"/>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">币种:</label>

                            <div class="controls">
                                <g:currencyView value="${entity.currencyId}"/>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">单价:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input onclick="inputMoney(this);" onblur="checkMoney(this);" type="text" id="entity.unitCost"
											name="entity.unitCost"
											value="${entity.unitCost}" style="width: 70px;"/>
										<font color="red"><form:errors path="lgsProxySurchargeVo.entity.unitCost" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline"><g:moneyView money="${entity.unitCost}" /></span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">折扣价:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input onclick="inputMoney(this);" onblur="checkMoney(this);" type="text" id="entity.unitDiscount"
											name="entity.unitDiscount"
											value="${entity.unitDiscount}" style="width: 70px;"/>
										<font color="red"><form:errors path="lgsProxySurchargeVo.entity.unitDiscount" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline"><g:moneyView money="${entity.unitDiscount}" /></span>
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