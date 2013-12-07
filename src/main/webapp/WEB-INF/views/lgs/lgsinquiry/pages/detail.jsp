<%@include file="/WEB-INF/common/layouts/common.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>询单详情</title>
<script type="text/javascript">
    function deleteData(id){
    	if(confirm("是否确定将序号为:"+id+"的数据删除?")){ 
    	$.ajax({
    		type : "GET",
    		url :  "${ctx}/lgsinquiry/delete?id="+id,
    		success : function(result) {
    			window.location.href = window.location.href;
    			window.location.reload();
    		},
    		error : function(XMLHttpRequest, textStatus, errorThrown) {
    			alert("Status: " + textStatus);
    		}
    	});
    	}
    }
    // 报价Js
    function quote(id){
    	if(confirm("确定提交序号为:"+id+"的报价方案?")){
    		//设定需要提交的list
    		
    		// var lgsFclQsurchargeCaseVoList = [];
    		//或者海整的报价
			var lgsFclQsurchargeCaseVo = {};
			lgsFclQsurchargeCaseVo = {"entities[0].quoteId": id,
    				"entities[0].price20Gp":$("#price20Gp_"+id).val(),
    				"entities[0].price40Gp":$("#price40Gp_"+id).val(),
    				"entities[0].price40Hq":$("#price40Hq_"+id).val()	    				
    				};
			// lgsFclQsurchargeCaseVoList.push(lgsFclQsurchargeCaseVo);
			//获取附加费的报价
    		/* $("input[name='mobile']").each(function(){
    			
    		}); */
    		
    		
	    	$.ajax({
	    		type : "POST",
	    		url :  "${ctx}/lgsfclqsurchargecase/add",
	    		data : lgsFclQsurchargeCaseVo,
	    		dataType:"json",
	    		async : false,
	    		success : function(result) {
	    			
	    		}
	    	});

			window.location.href = window.location.href;
			window.location.reload();
    	}
    }
</script>
</head>
<body>

<div class="row${fluid} list-maxwidth">
	<%-- <sunivo:headerline pageTitle="询价列表">
	</sunivo:headerline> --%>
	<div id="ordDetailViewSection" class="span12" style="margin-left:0px;"></div>
	
	<div id="quoteList"  class="span12" style="margin-left:0px;"></div>

	<script type="text/javascript">
	    
		var inquiryId = ${lgsInquiryEntity.id};
		var inquiryType = ${lgsInquiryEntity.inquiryType};
		if(inquiryType == 1){//海整报价
			$("#quoteList").load("${ctx}/lgsfclquoteinfocase/selectSection",{"inquiryId":inquiryId});
		} else if(inquiryType == 2){//海拼报价
			$("#quoteList").load("${ctx}/lgslclquoteinfocase/selectSection",{"inquiryId":inquiryId});
		} else if(inquiryType == 3) {//集卡报价
			$("#quoteList").load("${ctx}/lgsstruckquoteinfocase/selectSection",{"inquiryId":inquiryId});
		} else if (inquiryType == 4) {//空运报价
			$("#quoteList").load("${ctx}/lgsairquoteinfocase/selectSection",{"inquiryId":inquiryId});
		} else if (inquiryType == 5) {//零担报价
			$("#quoteList").load("${ctx}/lgsbreakstruckquoteinfocase/selectSection",{"inquiryId":inquiryId});
		} else {
			$("#quoteList").load("${ctx}/lgsfclquoteinfocase/selectSection",{"inquiryId":inquiryId});
		}
		
		//
		var orderId = ${lgsInquiryEntity.orderId};
		$("#ordDetailViewSection").load("${ctx}/lgsinquiry/ordDetailViewSection",{"inquiryId":inquiryId});
		
	</script>
</div>	
</body>
</html>
