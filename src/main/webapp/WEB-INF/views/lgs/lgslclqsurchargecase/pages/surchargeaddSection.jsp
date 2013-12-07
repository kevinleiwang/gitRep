
<body>
<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" import="java.util.Date"%>
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

/* 	$('#expiryDate').datetimepicker({

	  format: 'yyyy-MM-dd HH:mm:ss',
	  language: 'en',
	  pickDate: true,
	  pickTime: true,
	  hourStep: 1,
	  minuteStep: 15,
	  secondStep: 30,
	  inputMask: true
	}); */

</script>
<style>
.modal{
	width:580px;
}
</style>
<% Date nowDate = new Date(); %>
   <form id="inquiry_quote_add_form" name="inquiry_quote_add_form" action="${ctx}/lgslclqsurchargecase/addListSection" method="POST">
		<sunivo:flushMessage />
		<table class="table table-bordered table-striped table_vam" id="dt_gal">
		<tr> 
			<td><span style="line-height:44px;">船公司：</span>
			<!-- <g:logisticsCompanySelect  cusLogisticType="03" name="carrier" style="width:150px;" required="true"/> -->
				<sunivo:logisticsCompanySelect cusLogisticType="03" clazz="nochosen" name="carrier" style="width:150px;"  />
			</td> 
			<td><span style="line-height:44px;">价格有效期：</span><%-- <div id="expiryDate" class="input-append date datetime-picker">
							<input type="text" id="expiryDate" class="m-wrap m-ctrl-medium required cdatetime" 
								data-format="yyyy-MM-dd hh:mm:ss" name="expiryDate" 
								value="<fmt:formatDate value='${expiryDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" />
							<span class="add-on"> <i data-time-icon="icon-time" data-date-icon="icon-calendar"> </i></span>
	                     </div> --%>
							<div class="input-append date datetime-picker" date-format="yyyy-mm-dd hh:ii:mm" id="expiryDate"
	                            			date-startDate="<fmt:formatDate value='<%=nowDate %>' pattern='yyyy-MM-dd HH:mm:ss'/>" 
	                            			date-minView="hour" date-endDate="" style="margin:0px;">
											<input class="m-wrap" type="text" 
												value="<fmt:formatDate value='${expiryDate}' pattern='yyyy-MM-dd HH:mm:ss'/> "
												id="expiryDate" name="expiryDate" style="width:120px; height: 20px; "  readonly="readonly"  />
											<span class="add-on"><i class="icon-remove"></i></span>
											<span class="add-on"><i class="icon-calendar"></i></span>
							</div>	                     
	        </td>
		</tr>
		</table>
		
		<table class="table table-bordered table-striped table_vam" id="dt_gal">
			<thead>
				<tr>
					<th>费用项目</th>
					<!-- <th>进出口</th> -->
					<th width="80px;">单位</th>
					<th width="80px;">币种</th>
					<th>是否发货人承担</th>
					<th>每票</th>
					<th>体积单价</th>
					<th>重量单价</th>
				</tr>
			</thead>  
					<tbody>
				<c:forEach items="${prdQuoteList}" var="prdQuote" varStatus="status" >
				<tr>
					<input type="text" value="${quoteId}" style="display:none" id="entities[${status.index}].quoteId" name="entities[${status.index}].quoteId">
					<input type="text" value="${prdQuote.id}" style="display:none" id="entities[${status.index}].quoteidiD" name="entities[${status.index}].quoteidiD"/>
					<input type="text" value="${prdQuote.feeId}" style="display:none" id="entities[${status.index}].costId" name="entities[${status.index}].costId"/>
					<input type="text" value="${prdQuote.unitId}" style="display:none" id="entities[${status.index}].unitId" name="entities[${status.index}].unitId"/>
					<input type="text" value="${prdQuote.currencyId}" style="display:none" id="entities[${status.index}].currencyid" name="entities[${status.index}].currencyid"/>
					
					<td nowrap="nowrap">
						<c:if test="${null ne prdQuote.name && '' ne prdQuote.name}">
							<c:out value="${prdQuote.name}"/>
						</c:if>
					</td>
					<%-- <td nowrap="nowrap">
						<c:if test="${null ne prdQuote.tradeId && '' ne prdQuote.tradeId}">
							<c:choose>
								<c:when test="${1 eq prdQuote.tradeId }">出口</c:when>
								<c:when test="${2 eq prdQuote.tradeId }">进口</c:when>
								<c:otherwise>转口</c:otherwise>
							</c:choose>
						</c:if>
					</td> --%>
					<td nowrap="nowrap">
						<%-- <g:unitView value="${prdQuote.unitId}" /> --%>
						<sunivo:unitView value="${prdQuote.unitId}"/>
					</td>
					<td nowrap="nowrap">
						<%-- <g:currencyView value="${prdQuote.currencyId}"/> --%>
						<sunivo:currencyView showType="cn" value="${prdQuote.currencyId}"/>
					</td>
					<td nowrap="nowrap" width="30">
						<select id="entities[${status.index}].ifConsignorBear" class="nochosen" name="entities[${status.index}].ifConsignorBear" style="width: 60px;">
							<option value="1">是</option>
							<option value="0" selected="selected">否</option>
						</select>
					</td>
					
					<td nowrap="nowrap">
						<input <c:if test="${'1' eq prdQuote.unitId}"> onclick="inputMoney(this);" onblur="checkMoney(this);"</c:if> <c:if test="${'1' ne prdQuote.unitId}">readonly="readonly"</c:if> type="text" value="" id="entities[${status.index}].otherCost" name="entities[${status.index}].otherCost" style="width: 30px; height: 20px; "/>
					</td>
					<td nowrap="nowrap">
						<input <c:if test="${'1' ne prdQuote.unitId}"> onclick="inputMoney(this);" onblur="checkMoney(this);"</c:if> <c:if test="${'1' eq prdQuote.unitId}">readonly="readonly"</c:if> type="text" value="" id="entities[${status.index}].volumeCost" name="entities[${status.index}].volumeCost" style="width: 30px; height: 20px; "/>
					</td>
					<td nowrap="nowrap">
						<input <c:if test="${'1' ne prdQuote.unitId}"> onclick="inputMoney(this);" onblur="checkMoney(this);"</c:if> <c:if test="${'1' eq prdQuote.unitId}">readonly="readonly"</c:if> type="text" value="" id="entities[${status.index}].weightCost" name="entities[${status.index}].weightCost" style="width: 30px; height: 20px; "/>
					</td>
				
				</tr>
				
				<c:if test="${status.last}">
					<input type="text" id="prdQuoteCntNum" value="${status.count}" style="display:none;"/>
				</c:if>
				</c:forEach>
				
			</tbody>
		</table>
		<!-- <table border="1" id="dataTable"> -->
	</form>
</body>