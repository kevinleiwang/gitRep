<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>海运整箱本地费编辑</title>
<script type="text/javascript">
String.prototype.trim=function(){
    return this.replace(/(^\s*)|(\s*$)/g, "");
 }
 String.prototype.ltrim=function(){
    return this.replace(/(^\s*)/g,"");
 }
 String.prototype.rtrim=function(){
    return this.replace(/(\s*$)/g,"");
 }
 
//金额小数点后的位数限制
var moneyAfterPointNum = 2;
//金额小数点前的位数限制
var moneyBeforePointNum = 10;
/**
* money小数点后的位数是否超过限制
*/
function isPointOverLimit(value){
	 if(value!=null && value!=''){     
      var decimalIndex=value.indexOf('.');     
      if(decimalIndex=='-1'){     
          return false;     
      }else{     
          var decimalPart=value.substring(decimalIndex+1,value.length);
          if(decimalPart.length > moneyAfterPointNum){   
              return true;     
          }else{     
             return false;     
          }     
      }     
  }     
  return false;     
}
/**
* money小数点前的位数是否超过限制
*/
function isIntegerOverLimit(value){
	 if(value!=null && value!=''){     
      var decimalIndex=value.indexOf('.');     
      if(decimalIndex=='-1'){ // 没有小数位
     	 if(value.length > moneyBeforePointNum){
     		 return true;
     	 } else{
 	         return false;     
	     }
      }else{     
          var integerPart=value.substring(0,decimalIndex);
          if(integerPart.length > moneyBeforePointNum){   
              return true;     
          }else{     
             return false;     
          }     
      }     
  }     
  return false;     
}

/**
 * type 1：成本价
 * type 2：销售价
 * type 3：折扣价
 */
function checkMoney(type,nonContainerCost,cost20gp,cost40gp,cost40hq){

	var success = "";
	var name = '成本价';
	if(type == '2'){
		name = '销售价';
	}
	if(type == '3'){
		name = '折扣价';
	}
	
	if(!nonContainerCost){
		nonContainerCost = "";
	}
	if(!cost20gp){
		cost20gp = "";
	}
	if(!cost40gp){
		cost40gp = "";
	}
	if(!cost40hq){
		cost40hq = "";
	}

	// 判断金额的小数位数
	if(isIntegerOverLimit(nonContainerCost.trim()) == true){
		success += "<li>[每票"+name+"]：整数位数超过十位</li>";
	}
	if(isPointOverLimit(nonContainerCost.trim()) == true){
		success += "<li>[每票"+name+"]：小数位数超过两位</li>";
	}
	if(isIntegerOverLimit(cost20gp.trim()) == true){
		success += "<li>[20'GP"+name+"]：整数位数超过十位</li>";
	}
	if(isPointOverLimit(cost20gp.trim()) == true){
		success += "<li>[20'GP"+name+"]：小数位数超过两位</li>";
	}
	if(isIntegerOverLimit(cost40gp.trim()) == true){
		success += "<li>[40'GP"+name+"]：整数位数超过十位</li>";
	}
	if(isPointOverLimit(cost40gp.trim()) == true){
		success += "<li>[40'GP"+name+"]：小数位数超过两位</li>";
	}
	if(isIntegerOverLimit(cost40hq.trim()) == true){
		success += "<li>[40'HQ"+name+"]：整数位数超过十位</li>";
	}
	if(isPointOverLimit(cost40hq.trim()) == true){
		success += "<li>[40'HQ"+name+"]：小数位数超过两位</li>";
	}
	
	if(success == ''){
		success = 'success';
	}
	return success;
}

function portEditFormSubmit(){
	var validValue = $('#portEditForm').valid();
	if (!validValue){
		return;
	}

	// 备注信息校验
	var remark=$("#remark").val();
	var remarkLength=remark.length;
	if(remarkLength>300){
		SunivoUtil.showAlertMessage( $("#message"), "<li>[备注]：备注长度为"+remarkLength+"，不能超过300个字符</li>", "warn");
		return false;
	}

	var nonContainerCost = $("input[name='fclQentity.nonContainerCost']").val();
	var cost20gp = $("input[name='fclQentity.cost20gp']").val();
	var cost40gp = $("input[name='fclQentity.cost40gp']").val();
	var cost40hq = $("input[name='fclQentity.cost40hq']").val();
	/*
	if(nonContainerCost.trim()=='' && cost20gp.trim()=='' && cost40gp.trim()=='' && cost40hq.trim()==''){
		SunivoUtil.showAlertMessage( $("#message"), "<li>[成本价(每票，20'GP，40'GP，40'HQ)]：至少填写一项</li>", "warn");
		return false;
	}
	*/
	if(!nonContainerCost){
		nonContainerCost = "";
	}
	
	if($("#unitName").text() == '票'){
		if(nonContainerCost.trim()==''){
			SunivoUtil.showAlertMessage( $("#message"), "<li>费用单位是票，每票成本价必须填写</li>", "warn");
			return false;
		}
	}else if($("#unitName").text() == '柜'){
		if(cost20gp.trim()=='' && cost40gp.trim()=='' && cost40hq.trim()==''){
			SunivoUtil.showAlertMessage( $("#message"), "<li>费用单位是柜，(20'GP，40'GP，40'HQ)成本价至少填写一项</li>", "warn");
			return false;
		}
	}

	var success = checkMoney('1',nonContainerCost,cost20gp,cost40gp,cost40hq);
	if(success != 'success'){
		SunivoUtil.showAlertMessage( $("#message"), success, "warn");
		return false;
	}
	// 销售价判断
	var nonContainerPrice = $("input[name='fclQentity.nonContainerPrice']").val();
	var price20gp = $("input[name='fclQentity.price20gp']").val();
	var price40gp = $("input[name='fclQentity.price40gp']").val();
	var price40hq = $("input[name='fclQentity.price40hq']").val();
	/*
	if(nonContainerPrice.trim()=='' && price20gp.trim()=='' && price40gp.trim()=='' && price40hq.trim()==''){
		SunivoUtil.showAlertMessage( $("#message"), "<li>[销售价(每票，20'GP，40'GP，40'HQ)]：至少填写一项</li>", "warn");
		return false;
	}
	*/
	success = checkMoney('2',nonContainerPrice,price20gp,price40gp,price40hq);
	if(success != 'success'){
		SunivoUtil.showAlertMessage( $("#message"), success, "warn");
		return false;
	}
	// 折扣价判断
	var nonContainerDiscount = $("input[name='fclQentity.nonContainerDiscount']").val();
	var discount20gp = $("input[name='fclQentity.discount20gp']").val();
	var discount40gp = $("input[name='fclQentity.discount40gp']").val();
	var discount40hq = $("input[name='fclQentity.discount40hq']").val();
	/*
	if(nonContainerDiscount.trim()=='' && discount20gp.trim()=='' && discount40gp.trim()=='' && discount40hq.trim()==''){
		SunivoUtil.showAlertMessage( $("#message"), "<li>[折扣价(每票，20'GP，40'GP，40'HQ)]：至少填写一项</li>", "warn");
		return false;
	}
	*/
	success = checkMoney('3',nonContainerDiscount,discount20gp,discount40gp,discount40hq);
	if(success != 'success'){
		SunivoUtil.showAlertMessage( $("#message"), success, "warn");
		return false;
	}
	
	$('#portEditForm').submit();
}
</script>
</head>
<body>
	<!-- 流式布局，页面上部空出50px-->
	<div class="row-fluid sunivoPage">
		<!-- 水平表单 begin -->
		<form class="form-horizontal valid" id="portEditForm" action="${ctx}/lgsport/portUpdate" method="post">
			<input type="hidden" name="entity.id" value="${entity.id}" />
			<input type="hidden" name="fclQentity.id" value="${fclQentity.id}" />
			<input type="hidden" name="fclQentity.quoteId" value="${fclQentity.quoteId}" />
			<input type="hidden" name="fclQentity.prdQuoteId" value="${fclQentity.prdQuoteId}" />
			
			<!-- 页面内容置中，左右各留span1 -->
			<div class="span10 offset1">
				<div id="message"></div>
				<sunivo:flushMessage/>
			
				<!-- 页头  begin -->
				<div class="row-fluid">
					<div class="span12 sunivoTitle">
						<div class="span6">
							<h1 class="pageTitle">海运整箱本地费编辑</h1>
						</div>
						<div class="span6" align="right">
							<i class="pull-right icon-save icon-2x pointer" onclick="portEditFormSubmit();" style="margin-right: 20px;"></i> 
						</div>
					</div>
				</div>
				<!-- 页头  end -->
				
				
				<!-- 面包屑 begin -->
				<div class="row-fluid">
					<div class="span12">
						<ul class="breadcrumb">
							<li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
							<li><a href="${ctx}/lgsport?search_EQ_status=0">海运整箱本地费列表</a> <span
								class="divider">/</span></li>
							<li class="active">海运整箱本地费编辑</li>
						</ul>
					</div>
				</div>
				
				
				<!-- 面包屑 end -->
				<div class="sunivoBorder">
				
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>基本信息</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="shipmentPortId">起运港:</label>
							<div class="controls">
								<%-- <sunivo:shipPortSelect span="span10" clazz="required"
										name="entity.shipmentPortId"
										value="${entity.shipmentPortId}" /> --%>
								<sunivo:shipPortView value="${entity.shipmentPortId}"/>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="agentId">船公司:</label>
							<div class="controls">
								<%-- <sunivo:logisticsCompanySelect cusLogisticType="01" span="span10" 
										name="entity.agentId"
										value="${entity.agentId }" /> --%>
								<sunivo:customerView value="${entity.agentId }" />
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="prdQuoteId1">费用名称:</label>
							<div class="controls"><span class="span10">${prdQuoteEntity.name}</span>
								<%-- <div class="span10 input-append">
									<input class="span*" type="text" required id="prdQuoteId1" placeholder="关联PRD_QUOTE"
									name="fclQentity.prdQuoteId" value="${fclQentity.prdQuoteId}">
								</div> --%>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="prdQuoteId2">费用单位:</label>
							<div class="controls">
								<!-- <div class="span10 input-append">
									<input class="span*" type="text" readonly="readonly" >
								</div> -->
								<span class="span10" id="unitName"><sunivo:unitView value="${prdQuoteEntity.unitId }"/></span>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="routeTypeId">航线:</label>
							<div class="controls">
								<%-- <sunivo:shippinglineSelect span="span10" 
									name="entity.routeTypeId"
									value="${entity.routeTypeId}" /> --%>
								<sunivo:shippinglineView value="${entity.routeTypeId}"/>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="">币种:</label>
							<div class="controls">
								<!-- <div class="span10 input-append">
									<input class="span*" type="text" readonly="readonly" >
								</div> -->
								<span class="span10">
									<sunivo:currencyView value="${prdQuoteEntity.currencyId }" showType="cn"/>
								</span>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="appendedInput">生效日期:<span style="color: red;">*</span></label>
							<div class="controls">
								<div class="span10 input-append date datetime-picker" data-date-minView="month" data-date-format="yyyy-mm-dd">
										<input class="span*" type="text" id="execDate" required
											name="fclQentity.execDate" value="<fmt:formatDate value='${fclQentity.execDate}' pattern='yyyy-MM-dd' />"
											readonly placeholder="生效日期"><span class="add-on"><i
											class="icon-remove"></i></span><span class="add-on"><i
											class="icon-calendar"></i></span>
								</div>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="appendedInput2">失效日期:<span style="color: red;">*</span></label>
							<div class="controls">
								<div class="span10 input-append date datetime-picker" data-date-minView="month" data-date-format="yyyy-mm-dd">
										<input class="span*" type="text" id="expiryDate" required  
											name="fclQentity.expiryDate" value="<fmt:formatDate value='${fclQentity.expiryDate}' pattern='yyyy-MM-dd' />"
											readonly placeholder="失效日期"><span class="add-on"><i
											class="icon-remove"></i></span><span class="add-on"><i
											class="icon-calendar"></i></span>
								</div>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="appendedInput">进出口:</label>
							<div class="controls">
								<%-- <sunivo:importExportFlagSelect
									name="entity.importExportFlag"
									value="${entity.importExportFlag}"
									span="span10" /> --%>
								<sunivo:importExportFlagView value="${entity.importExportFlag}"/>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="appendedInput2">状态:</label>
							<div class="controls">
								<sunivo:disabledFlagView value="${fclQentity.status }" />
							</div>
						</div>
					</div>
					
					
					
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>报价信息</h5>
					</div>
					<!-- 片段头 end -->
					<div>
						<table class="table table-hover">
							<!-- 标题可根据实际需要决定要不要 -->
							<!-- <caption >标题</caption> -->
							<!-- 表头可根据实际需要决定要不要 -->
							<thead>
								<tr>
									<th>单位</th>
									<th title="至少填写一项">成本价<span style="color: red;">*</span></th>
									<th>销售价</th>
									<th>折扣价</th>
									<th>最终销售价</th>
								</tr>
							</thead>
							<tbody>
							<c:choose>
							    <c:when test="${prdQuoteEntity.unitId ==1}">
								<tr>
									<td><span class="">每票:</span></td>
									<td><input class="span* positiveNumber" type="text" id="" placeholder=""  
										name="fclQentity.nonContainerCost" value='<sunivo:numberFormatView value="${fclQentity.nonContainerCost }"/>'></td>
									<td><input class="span* positiveNumber" type="text" id="" placeholder=""  
										name="fclQentity.nonContainerPrice" value='<sunivo:numberFormatView value="${fclQentity.nonContainerPrice }"/>'></td>
									<td><input class="span* positiveNumber" type="text" id="" placeholder=""  
										name="fclQentity.nonContainerDiscount" value='<sunivo:numberFormatView value="${fclQentity.nonContainerDiscount }"/>'></td>
									<td><span class="inline"><sunivo:numberFormatView value="${fclQentity.nonContainerDiscount }"/>&nbsp;</span></td>
								</tr>
								</c:when>
								<c:otherwise>
								<tr>
									<td><span class="">20'GP:</span></td>
									<td><input class="span* positiveNumber" type="text" id="" placeholder=""  
										name="fclQentity.cost20gp" value='<sunivo:numberFormatView value="${fclQentity.cost20gp }"/>'></td>
									<td><input class="span* positiveNumber" type="text" id="" placeholder=""  
										name="fclQentity.price20gp" value='<sunivo:numberFormatView value="${fclQentity.price20gp }"/>'></td>
									<td><input class="span* positiveNumber" type="text" id="" placeholder=""  
										name="fclQentity.discount20gp" value='<sunivo:numberFormatView value="${fclQentity.discount20gp }"/>'></td>
									<td><span class="inline"><sunivo:numberFormatView value="${fclQentity.discount20gp }"/>&nbsp;</span></td>
								</tr>
								<tr>
									<td><span class="">40'GP:</span></td>
									<td><input class="span* positiveNumber" type="text" id="" placeholder=""  
										name="fclQentity.cost40gp" value='<sunivo:numberFormatView value="${fclQentity.cost40gp }"/>'></td>
									<td><input class="span* positiveNumber" type="text" id="" placeholder=""  
										name="fclQentity.price40gp" value='<sunivo:numberFormatView value="${fclQentity.price40gp }"/>'></td>
									<td><input class="span* positiveNumber" type="text" id="" placeholder=""  
										name="fclQentity.discount40gp" value='<sunivo:numberFormatView value="${fclQentity.discount40gp }"/>'></td>
									<td><span class="inline"><sunivo:numberFormatView value="${fclQentity.discount40gp }"/>&nbsp;</span></td>
								</tr>
								<tr>
									<td><span class="">40'HQ:</span></td>
									<td><input class="span* positiveNumber" type="text" id="" placeholder=""  
										name="fclQentity.cost40hq" value='<sunivo:numberFormatView value="${fclQentity.cost40hq }"/>'></td>
									<td><input class="span* positiveNumber" type="text" id="" placeholder=""  
										name="fclQentity.price40hq" value='<sunivo:numberFormatView value="${fclQentity.price40hq }"/>'></td>
									<td><input class="span* positiveNumber" type="text" id="" placeholder=""  
										name="fclQentity.discount40hq" value='<sunivo:numberFormatView value="${fclQentity.discount40hq }"/>'></td>
									<td><span class="inline"><sunivo:numberFormatView value="${fclQentity.discount40hq }"/>&nbsp;</span></td>
								</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
					</div>
					
					
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5 >备注</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span12 control-group">
							<label class="control-label" for="testarea3">备注:</label>
							<div class="controls">
								<textarea class="span12" id="remark" rows="3" placeholder="备注信息"
									name="fclQentity.remark">${fclQentity.remark}</textarea>
									<span class="label label-warning pull-right">备注最多输入300个字符</span>
							</div>
						</div>
					</div>
					
					
					
				</div>
			</div>
		</form>
		<!-- 水平表单 end -->
	</div>

</body>
</html>