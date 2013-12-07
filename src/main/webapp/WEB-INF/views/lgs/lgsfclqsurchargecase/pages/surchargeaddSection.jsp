<body>

<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" import="java.util.Date"%>
<script type="text/javascript">

$(function(){
	/* $('#modal_body').attr("id","modal_body11");
	Sunivo.initContext("#inquiry_quote_add_form"); */
});

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

 

//å¼ºå¶ä¿çä¸¤ä½å°æ°

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
/* $('#expiryDate').datetimepicker({

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
<div class="row${fluid}">
   <form id="inquiry_quote_add_form" name="inquiry_quote_add_form" class="valid"
		action="${ctx}/lgsfclqsurchargecase/addListSection" method="POST">
		<sunivo:flushMessage />
		<table class="table table-bordered table-striped table_vam" id="dt_gal">
		<tr> 
			<td  style="width:120;"><!-- <g:logisticsCompanySelect  cusLogisticType="01" name="carrier" required="true"/> -->
			船公司：<sunivo:logisticsCompanySelect clazz="required nochosen" cusLogisticType="01" span="span9" name="carrier" />
			</td>
			<td>价格有效期：<%-- <div id="expiryDate" class="input-append date datetime-picker">
							<input type="text" id="expiryDate" class="m-wrap m-ctrl-medium required cdatetime" 
								data-format="yyyy-MM-dd hh:mm:ss" name="expiryDate" 
								value="<fmt:formatDate value='${expiryDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" />
							<span class="add-on"> <i data-time-icon="icon-time" data-date-icon="icon-calendar"> </i></span>
	                     </div> --%>
	                            <div class="input-append date datetime-picker" date-format="yyyy-mm-dd hh:ii:mm" id="expiryDate"
	                            			date-startDate="<fmt:formatDate value='<%=nowDate %>' pattern='yyyy-MM-dd HH:mm:ss'/>" 
	                            			date-minView="hour" date-endDate="">
											<input class="m-wrap" type="text" 
												value="<fmt:formatDate value='${expiryDate}' pattern='yyyy-MM-dd HH:mm:ss'/> "
												id="expiryDate" name="expiryDate"  style="height: 20px"  readonly="readonly">
											<span class="add-on"><i class="icon-remove"></i></span>
											<span class="add-on"><i class="icon-calendar"></i></span>
								</div>
	        </td>
		</tr>
		<tr> 
			<td>
			船程：<input type="text" name="estimatedRange" value="" class="span9" /></br>
			航线：<sunivo:shippinglineSelect name="lineTypeId" clazz="required nochosen" span="span9" />
			</td>
			<td>航期:<select name="estimatedSalingdateValues" style="width:150px" multiple="multiple"
					class="chosen-with-diselect span6" data-placeholder="请选择航期" >
						<option value="星期一">星期一</option>
						<option value="星期二">星期二</option>
						<option value="星期三">星期三</option>
						<option value="星期四">星期四</option>
						<option value="星期五">星期五</option>
						<option value="星期六">星期六</option>
						<option value="星期日">星期日</option>
					</select>
					</td>
		</tr> 
		</table>
		<table class="table table-bordered table-striped table_vam" id="dt_gal">
			<thead>
				<tr>
					<th>费用项目</th>
					<th width="80px;">单位</th>
					<th width="80px;">币种</th>
					<th>是否ALL-IN</th>
					<th>每票</th>
					<th>20Gp</th>
					<th>40Gp</th>
					<th>40HQ</th>
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
					<td nowrap="nowrap">
						<%-- <g:unitView value="${prdQuote.unitId}" /> --%>
						<sunivo:unitView value="${prdQuote.unitId}"/>
					</td>
					<td nowrap="nowrap">
						<%-- <g:currencyView value="${prdQuote.currencyId}"/> --%>
						<sunivo:currencyView showType="cn" value="${prdQuote.currencyId}"/>
					</td>
					<td nowrap="nowrap" width="30">
						<select id="entities[${status.index}].ifAllin" name="entities[${status.index}].ifAllin" class="nochosen" style="width: 60px;">
							<option value="0">否</option>
							<option value="1">是</option>
						</select>
					</td>
					
					<td nowrap="nowrap">
						<input <c:if test="${'5' ne prdQuote.unitId}">onclick="inputMoney(this);" onblur="checkMoney(this);"</c:if>
						   type="text" value="" id="entities[${status.index}].nonContainerCost" name="entities[${status.index}].nonContainerCost" style="width: 30px; height: 20px; " <c:if test="${'5' eq prdQuote.unitId}">readonly="readonly"</c:if>  />
					</td>
					<td nowrap="nowrap">
						<input <c:if test="${'5' eq prdQuote.unitId}">onclick="inputMoney(this);" onblur="checkMoney(this);"</c:if>
								type="text" value="" id="entities[${status.index}].cost20Gp" name="entities[${status.index}].cost20Gp" style="width: 30px; height: 20px;" <c:if test="${'5' ne prdQuote.unitId}">readonly="readonly"</c:if>  />
					</td>
					<td nowrap="nowrap">
						<input <c:if test="${'5' eq prdQuote.unitId}">onclick="inputMoney(this);" onblur="checkMoney(this);"</c:if>
								type="text" value="" id="entities[${status.index}].cost40Gp" name="entities[${status.index}].cost40Gp" style="width: 30px; height: 20px;" <c:if test="${'5' ne prdQuote.unitId}">readonly="readonly"</c:if>  />
					</td>
					<td nowrap="nowrap">
						<input <c:if test="${'5' eq prdQuote.unitId}">onclick="inputMoney(this);" onblur="checkMoney(this);"</c:if>
						 		type="text" value="" id="entities[${status.index}].cost40Hq" name="entities[${status.index}].cost40Hq" style="width: 30px; height: 20px;" <c:if test="${'5' ne prdQuote.unitId}">readonly="readonly"</c:if> />
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
</div>
</body>