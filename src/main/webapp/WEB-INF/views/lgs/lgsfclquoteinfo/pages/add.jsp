<%@include file="/WEB-INF/common/layouts/common.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" import="java.util.Date"%>
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
function checkTime()
{
	for (var i = 0; i < 5; i++)
	{
		var expiryDateName = "fclEntities["+i+"].fclQsurchargeEntities.expiryDateStr";
		var execDateName = "fclEntities["+i+"].fclQsurchargeEntities.execDateStr";
		var expiryTime = $.trim($("input[name='"+expiryDateName+"']").val());
 		var execTime = $.trim($("input[name='"+execDateName+ "']").val());
        /*if (undefined == expiryTime || "" == expiryTime || null == expiryTime
				|| undefined == execTime || "" == execTime || null == execTime)
		{
			alert("生效时间和失效时间必须填写"); 
			return false;
		} */
		var execDate = new Date(execTime.replace(/\-/g,"/"));
		var expiryDate = new Date(expiryTime.replace(/\-/g,"/"));
		if (Date.parse(execDate) > Date.parse(expiryDate))
		{
			SunivoUtil
			.showAlertMessage(
					$("#message"),
					"失效时间必须大于生效时间",
					"warn");
			return false;
		}	
	}
	return true;
} 
    
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
    	SunivoUtil
		.showAlertMessage(
				$("#message"),
				"金额超出范围！",
				"warn");
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

function check(){
	    var shipmentPort = $(":input[name='shipmentPortId']").val();
	    var carrierId = $(":input[name='carrierId']").val();
	    var routeTypeId = $(":input[name='routeTypeId']").val();
	//对报价项进行校验
    	if (null == carrierId || "" == carrierId || undefined == carrierId)
    	{
    		SunivoUtil
			.showAlertMessage(
					$("#message"),
					"货代公司必须填写！",
					"warn");
    		return false;
    	}
    	if (null == routeTypeId || "" == routeTypeId || undefined == routeTypeId)
    	{
    		SunivoUtil
			.showAlertMessage(
					$("#message"),
					"航线类型必须填写！",
					"warn");
    		return false;
    	}
		if (null == shipmentPort || "" == shipmentPort || undefined == shipmentPort)
    	{
    		SunivoUtil
			.showAlertMessage(
					$("#message"),
					"起始港港口必须填写！",
					"warn");
    		return false;
    	}
    	
	for(var i=0;i<5;i++){
		// 根据tag_value判断该条记录目的港和船公司是否选择  如果选择了   则3种报价不能全部为空
		var portname = "fclEntities[" + i + "].fclQuoteEntity.destinationPortId";
	    var portVal = $("select[name='"+portname+"']").val();
	    var agentname = "fclEntities[" +i +"].fclQuoteEntity.agentId";
	    var agentVal =  $("select[name='"+agentname+"']").val();
	    var execDateName = "fclEntities["+i+"].fclQsurchargeEntities.execDateStr";
	    var execDateVal = $("input[name='"+execDateName+ "']").val();
	    var expiryDateName = "fclEntities["+i+"].fclQsurchargeEntities.expiryDateStr";
	    var expiryDateVal = $("input[name='"+expiryDateName+ "']").val();
	    	var checkName = "fclEntities["+i+"].fclQsurchargeEntities.";
	    	var val20gp = $("input[name='"+checkName+ "cost20gp']").val();
	    	var val40gp = $("input[name='"+checkName+ "cost40gp']").val();
	    	var val40hq = $("input[name='"+checkName+ "cost40hq']").val();
	    if(portVal != null && portVal != "" && agentVal != null && agentVal != ""){
	    	if((val20gp == null || val20gp <= 0) && (val40gp == null || val40gp <= 0) && (val40hq == null || val40hq <= 0)){
	    		SunivoUtil
				.showAlertMessage(
						$("#message"),
						"已选择目的港和船公司的记录报价必须填写一项",
						"warn");
	    		return false;
	    	}
	    	
	    	if(execDateVal == null || execDateVal == "" || execDateVal == undefined){
	    		SunivoUtil
				.showAlertMessage(
						$("#message"),
						"已选择目的港和船公司的记录生效时间必填",
						"warn");
	    		return false;
	    	}
	    	if(expiryDateVal == null || expiryDateVal == "" || expiryDateVal == undefined){
	    		SunivoUtil
				.showAlertMessage(
						$("#message"),
						"已选择目的港和船公司的记录失效时间必填",
						"warn");
	    		return false;
	    	}
	    	
	    }
		if ((portVal == null || portVal == "") && (agentVal != null && agentVal != ""))
		{
			SunivoUtil
			.showAlertMessage(
					$("#message"),
					"已填写报价列表信息中缺少目的港信息",
					"warn");
			return false;
		}
		
		if ((portVal != null && portVal != "") && (agentVal == null || agentVal == ""))
		{
			SunivoUtil
			.showAlertMessage(
					$("#message"),
					"已填写报价列表信息中缺少船公司信息",
					"warn");
			return false;
		}
    	if (!((val20gp == null || val20gp <= 0) && (val40gp == null || val40gp <= 0) && (val40hq == null || val40hq <= 0)) || (null != execDateVal && "" != execDateVal) || (null !== expiryDateVal && "" != expiryDateVal))
    	{
    		if ((portVal != null || portVal != "") && (agentVal == null && agentVal == ""))
    		{
    			SunivoUtil
    			.showAlertMessage(
    					$("#message"),
    					"已填写报价列表信息中缺少目的港和船公司信息",
    					"warn");
    			return false;
    		}
    	}
	    
	}
	var flag = false;
	for (var i = 0; i < 5; i++)
	{
		var portname = "fclEntities[" + i + "].fclQuoteEntity.destinationPortId";
	    var portVal = $("select[name='"+portname+"']").val();
	    if (null != portVal && "" != portVal && undefined != portVal)
	    {
			flag = true;
			break;
	    }
	}
	if (!flag)
	{
		SunivoUtil
		.showAlertMessage(
				$("#message"),
				"新增海运整箱报价信息列表中没有填写信息",
				"warn");
		return false;
	}	
	
	return true;
}

function beforeSubmit(){
 	if(check() && checkTime() && checkReapet()){
		$.ajax({  
				url: "${ctx}/lgsfclquoteinfo/addList",  
				type:"POST",
				data:$('#input_form').serialize(),
				dataType: "html",
				success: function (data){
					if ('isReapet' == data)
					{
						SunivoUtil
						.showAlertMessage(
								$("#message"),
								"报价记录已存在！请检查航线、起运港、目的港、船公司、货代。",
								"warn");
					}
					else
					{
						window.location.href = "${ctx}/lgsfclquoteinfo";
					}	
				} ,
				error: function(XMLResponse){
				   	alert("保存失败！");
				}  
			});
		
	} 
}
function checkReapet()
{
	var countryId = $(":input[name$='.fclQuoteEntity.destinationPortId']");
	var botId = $(":input[name$='.fclQuoteEntity.agentId']");
	for (var i = 0; i < countryId.size(); i++)
	{
		if (null == $(countryId.get(i)).val() || "" == $(countryId.get(i)).val() || undefined == $(countryId.get(i)).val()
				|| null == $(botId.get(i)).val() || "" == $(botId.get(i)).val()
				|| undefined == $(botId.get(i)).val())
		{
			continue;
		}	
		for (var j = i + 1; j < 5; j++)
		{
			if (null == $(countryId.get(j)).val() || "" == $(countryId.get(j)).val() || undefined == $(countryId.get(j)).val()
					|| null == $(botId.get(j)).val() || "" == $(botId.get(j)).val()
					|| undefined == $(botId.get(j)).val())
			{
				continue;
			}
			if ($(countryId.get(i)).val() ==  $(countryId.get(j)).val() &&  $(botId.get(i)).val() ==  $(botId.get(j)).val())
			{
				SunivoUtil
				.showAlertMessage(
						$("#message"),
						"填写的航线报价存在重复！",
						"warn");
				return false;
			}	
		}
	}
	return true;
}
</script>
<title>新增海运整箱海运费报价信息</title>
</head>
<body>
<!-- 流式布局，页面上部空出50px-->
<div class="row-fluid sunivoPage">
	<form id="input_form" class="form-horizontal valid" action="${ctx}/lgsfclquoteinfo/addList" method="POST" modelAttribute="lgsFclChargeInfoVoArray">
		<!-- 页面内容置中，左右各留span1 -->
	<div class="span10 offset1">
		<sunivo:flushMessage />
		<div id="message"></div>
		<!-- 页头  begin -->
		<div class="row-fluid">
			<div class="span12 sunivoTitle">
				<div class="span6">
					<h1 class="pageTitle">海运整箱海运费新增</h1>
				</div>
				<div class="span6" align="right">
					<i class="pull-right icon-save icon-2x pointer" style="margin-right: 15px;"
					onclick="beforeSubmit();" title="确认提交"></i>
				</div>
			</div>
		</div>
		<!-- 页头  end -->
		<!-- 面包屑 begin -->
		<div class="row-fluid">
			<div class="span12">
				<ul class="breadcrumb">
					<li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
					<li><a href="${ctx}/lgsfclquoteinfo?search_EQ_status=0">海整报价海运费列表</a> <span
						class="divider">/</span></li>
					<li class="active">海运费新增</li>
				</ul>
			</div>
		</div>
		<!-- 面包屑 end -->
		<!-- 面包屑 end -->
		<div class="sunivoBorder">
			<!-- 片段头 begin -->
			<div class="sectionTitle">
				<h5>公共信息选择</h5>
			</div>
			<!-- 片段头 end -->
			<div class="row-fluid">
				<div class="span12">
					<div>
						<sunivo:logisticsCompanySelect cusLogisticType="03" name="carrierId" span="span3" clazz="required" placeHolderMessageCode="货代公司" />
						<sunivo:shippinglineSelect name="routeTypeId" clazz="required" span="span3" placeHolderMessageCode="航线类型"/> 
						<sunivo:shipPortSelect name="shipmentPortId" placeHolderMessageCode="起运港" span="span3" clazz="required" value="200000463"/>			        
					</div>
				</div>
			</div>
		</div>
		<div class="sectionTitle">
			<h5>报价详细</h5>
		</div>
		<!-- 片段头 end -->
		<div class="row-fluid">
			<div class="span12">
				<div class="span5">
					<div class="span1">序号 </div>
					<div class="span5">
						<div class="span6">目的港<font style="color:red;">*</font></div>
						<div class="span6">船公司<font style="color:red;">*</font></div>
					</div>
					<div class="span6">
						<div class="span3">20'</div>
						<div class="span3">40'</div>						
						<div class="span3">40HQ</div>
						<div class="span3">航程</div>
					</div>					
				</div>
				<div class="span1">班期</div>
				<div class="span1">中转港</div>
				<div class="span3">
					<div class="span6">生效日期<font style="color:red;">*</font></div>
					<div class="span6">失效日期<font style="color:red;">*</font></div>
				</div>
				<div class="span1">备注</div>
				<div class="span1">是否ALL-IN</div>
			</div>
			</div>
        
            <c:forEach items="${addList}" var="addList" varStatus="idxStatus">
           <div class="row-fluid">
            <div class="span12">
            	<div class="span5">
					<div class="span1">
						<input type="text" id="addIndex" name="addIndex[${idxStatus.index}]" value="${idxStatus.index}" style="display:none;"/>
						${idxStatus.count}
					</div>
					<div class="span5">
					<div class="span6">
						<sunivo:shipPortSelect style="width:100px;" name="fclEntities[${idxStatus.index}].fclQuoteEntity.destinationPortId"  placeHolderMessageCode="目的港"/>
					</div>
					<div class="span6">
						<sunivo:logisticsCompanySelect style="width:100px;" cusLogisticType="01" placeHolderMessageCode="船公司" name="fclEntities[${idxStatus.index}].fclQuoteEntity.agentId" />
					</div>
					</div>
					<div class="span6">
						<div class="span3">
							<input required="required"  class="span*" type="text" tag_val="${idxStatus.index}" name="fclEntities[${idxStatus.index}].fclQsurchargeEntities.cost20gp" value="0.00" onclick="inputMoney(this);" onblur="checkMoney(this);" />
						</div>
						<div class="span3">
							<input required="required" class="span*" type="text" tag_val="${idxStatus.index}" name="fclEntities[${idxStatus.index}].fclQsurchargeEntities.cost40gp" value="0.00"  onclick="inputMoney(this);" onblur="checkMoney(this);" />
						</div>
						<div class="span3">
							<input required="required" class="span*" type="text" tag_val="${idxStatus.index}" name="fclEntities[${idxStatus.index}].fclQsurchargeEntities.cost40hq" value="0.00" onclick="inputMoney(this);" onblur="checkMoney(this);" />
						</div>
						<div class="span3">
							<input type="text" class="span*" style="width:50px;" name="fclEntities[${idxStatus.index}].fclQuoteEntity.estimatedRange" value="" />
						</div>
					</div>
					
				</div>
				<div class="span1">
					<select style="width:80px;" name="fclEntities[${idxStatus.index}].fclQuoteEntity.estimatedSalingdate" multiple="multiple" data-placeholder="请选择">
						
						<option value="星期一">星期一</option>
						<option value="星期二">星期二</option>
						<option value="星期三">星期三</option>
						<option value="星期四">星期四</option>
						<option value="星期五">星期五</option>
						<option value="星期六">星期六</option>
						<option value="星期日">星期日</option>
					</select>
				</div>
				<div class="span1">
					<sunivo:shipPortSelect style="width:100px;" name="fclEntities[${idxStatus.index}].fclQuoteEntity.enterportId"/>
				</div>
				<div class="span3">
				<div class="span6">
					<div >
						<div class="span10 input-append date datetime-picker" data-date-minView="month" data-date-format="yyyy-mm-dd"
							date-startDate="${nowDate}" id="execDate${idxStatus.index}">
							<input class="span*" type="text" value="" id="fclEntities[${idxStatus.index}].fclQsurchargeEntities.execDateStr"
								name="fclEntities[${idxStatus.index}].fclQsurchargeEntities.execDateStr"
								readonly placeholder="生效日期"> <span
								class="add-on"><i class="icon-remove"></i></span> <span
								class="add-on"><i class="icon-calendar"></i></span>
						</div>
					</div>
				</div>
				<div class="span6">
					<div >
						<div class="span10 input-append date datetime-picker"
							date-startDate="${nowDate}" id="expiryDate${idxStatus.index}" data-date-minView="month" data-date-format="yyyy-mm-dd">
							<input class="span*" type="text" value="" 
												id="fclEntities[${idxStatus.index}].fclQsurchargeEntities.expiryDateStr" 
												name="fclEntities[${idxStatus.index}].fclQsurchargeEntities.expiryDateStr"
								readonly placeholder="失效日期"> <span
								class="add-on"><i class="icon-remove"></i></span> <span
								class="add-on"><i class="icon-calendar"></i></span>
						</div>
					</div>
				</div>
				</div>
				<div class="span1">
					<input type="text" tag_val="${idxStatus.index}" class="span*" name="fclEntities[${idxStatus.index}].fclQsurchargeEntities.remark" value=""   />
				</div>
				<div class="span1">
					<select name="fclEntities[${idxStatus.index}].fclQuoteEntity.ifAllIn" class="nochosen" style="width:50px;">
						<option value="0" selected="selected">否</option>
						<option value="1">是</option>
					</select>
				</div>
			</div>
			
			</div>
			</c:forEach>
		</div>
	</div>
	</form>
	</div>
</body>
</html>