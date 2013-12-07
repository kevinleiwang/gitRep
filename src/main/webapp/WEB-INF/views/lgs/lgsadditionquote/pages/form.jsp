
<html>
<head>


</head>
<body>
<%@include file="/WEB-INF/common/layouts/common.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" import="java.util.Date" %>
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

<% Date nowDate = new Date(); %>
<div class="row${fluid}">
<form id="inquiry_addition_edit_form" class="form-horizontal valid" 
      action="${ctx}/updateLgsAdditionQuoteSection<c:if test="${action=='edit'}">/${entity.id}</c:if>"
      method="post">
      <sunivo:token/>
    <input name="id" id="id" value="${entity.id}" type="hidden"/>
   <!-- 页面内容置中，左右各留span1 -->
	<div class="span12">
		<sunivo:flushMessage />
           <!-- 面包屑 end -->
		<div class="portlet box grey">
				<div class="portlet-body form">
                    <input name="entity.id" type="hidden" value="${entity.id}"/>
					<div class="row-fluid">
                        <div class="span4 control-group">
                            <label class="control-label">加成编号:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
                                    	<input type="text" id="entity.additionCode"
											name="entity.additionCode" style="display:none;"
											value="${entity.additionCode}" />
										<span class="inline">${entity.additionCode}&nbsp;</span>
										<font color="red"><form:errors path="lgsAdditionQuoteVo.entity.additionCode" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.additionCode}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span8 control-group">
                            <label class="control-label">询单ID:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.inquiryId"
											name="entity.inquiryId" style="display:none;"
											value="${entity.inquiryId}"/>
										<span class="inline">${entity.inquiryId}&nbsp;</span>
										<font color="red"><form:errors path="lgsAdditionQuoteVo.entity.inquiryId" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.inquiryId}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span12 control-group">
                            <label class="control-label">销售价加成公式:</label>
                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										成本价*<input span="span2" type="text" id="entity.priceAddPercent"  onclick="inputMoney(this);" onblur="checkMoney(this);"
											name="entity.priceAddPercent" style="width:50px;"
											value='<sunivo:numberFormatView value="${entity.priceAddPercent}"/>'/>%+
											<input  span="span2" onclick="inputMoney(this);" onblur="checkMoney(this);" type="text" id="entity.priceAddValue" style="width:50px;"
											name="entity.priceAddValue"
											value='<sunivo:numberFormatView value="${entity.priceAddValue}"/>'/>
										<font color="red"><form:errors path="lgsAdditionQuoteVo.entity.priceAddPercent" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">成本价*<sunivo:moneyFormatView money="${entity.priceAddPercent}"/>%+(<sunivo:moneyFormatView money="${entity.priceAddValue}" />)&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="row-fluid">
                         <div class="span12 control-group">
                            <label class="control-label">折扣价加成公式:</label>
                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										销售价*<input type="text" id="entity.discountAddPercent"  onclick="inputMoney(this);" onblur="checkMoney(this);"
											name="entity.discountAddPercent" style="width:50px;"
											value='<sunivo:numberFormatView value="${entity.discountAddPercent}"/>' />%
										<font color="red"><form:errors path="lgsAdditionQuoteVo.entity.discountAddPercent" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">销售价*<sunivo:moneyFormatView money="${entity.discountAddPercent}"/>%&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="control-group">
                            <label class="control-label">生效日期:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">                                    
<%--                                       <div id="execDate" class="input-append date datetime-picker">
										<input type="text" id="entity.execDateStr" class="m-wrap m-ctrl-medium required cdatetime" 
											data-format="yyyy-MM-dd hh:mm:ss" name="entity.execDateStr" 
											value="<fmt:formatDate value='${entity.execDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" />
										<span class="add-on"> <i data-time-icon="icon-time" data-date-icon="icon-calendar"> </i></span>
										<font color="red"><form:errors path="lgsRouteAdditionQuoteVo.entity.execDate" /></font>
	                            		</div> --%>
                            			<div class="input-append date datetime-picker" date-format="yyyy-mm-dd" id="execDate"
	                            			date-startDate="<fmt:formatDate value='<%=nowDate %>' pattern='yyyy-MM-dd'/>" 
	                            			date-minView="months" date-endDate="">
											<input class="m-wrap" type="text" 
												value="<fmt:formatDate value='${entity.execDate}' pattern='yyyy-MM-dd'/> "
												id="entity.execDateStr" name="entity.execDateStr"
												readonly>
											<span class="add-on"><i class="icon-remove"></i></span>
											<span class="add-on"><i class="icon-calendar"></i></span>
											<font color="red"><form:errors path="lgsRouteAdditionQuoteVo.entity.execDate" /></font>
										</div>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline"><fmt:formatDate value="${entity.execDate}" pattern="yyyy-MM-dd" />&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                     </div>
                    <div class="row-fluid">
                         <div class="control-group">
                            <label class="control-label">失效日期:</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
<%--                                    	 <div id="expiryDate" class="input-append date datetime-picker">
										<input type="text" id="entity.expiryDateStr" data-format="yyyy-MM-dd hh:mm:ss"
											name="entity.expiryDateStr" class="m-wrap m-ctrl-medium required cdatetime"
											value="<fmt:formatDate value='${entity.expiryDate}' pattern='yyyy-MM-dd HH:mm:ss' />" />
										<span class="add-on"> <i data-time-icon="icon-time" data-date-icon="icon-calendar"> </i></span>											
										<font color="red"><form:errors path="lgsRouteAdditionQuoteVo.entity.expiryDate" /></font>
                            		</div> --%>
                            		   <div class="input-append date datetime-picker" date-format="yyyy-mm-dd" id="expiryDate"
	                            			date-startDate="<fmt:formatDate value='<%=nowDate %>' pattern='yyyy-MM-dd'/>" 
	                            			date-minView="months" date-endDate="">
											<input class="m-wrap" type="text" 
												value="<fmt:formatDate value='${entity.expiryDate}' pattern='yyyy-MM-dd'/> "
												id="entity.expiryDateStr" name="entity.expiryDateStr"
												readonly>
											<span class="add-on"><i class="icon-remove"></i></span>
											<span class="add-on"><i class="icon-calendar"></i></span>
											<font color="red"><form:errors path="lgsRouteAdditionQuoteVo.entity.expiryDate" /></font>
										</div>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline"><fmt:formatDate value='${entity.expiryDate}' pattern='yyyy-MM-dd'/></span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					
					
                </div>
            </div>
</form>
</div>
</body>


</html>