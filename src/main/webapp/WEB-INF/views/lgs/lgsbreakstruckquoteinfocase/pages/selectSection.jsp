<%@include file="/WEB-INF/common/layouts/common.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


</head>
<body>
<script type="text/javascript">
    //选定报价方案JS
   function selectQuote(id,inquiryId){
	   var agentName = $("#agent_name_tag_"+id).val();
    	if(confirm("是否选定供应商:"+agentName+"的报价方案?")){
    		//var selectedQuotationId = $("#index_input_"+id).val();;
    	$.ajax({
    		type : "POST",
    		url :  "${ctx}/lgsinquiry/selectQuoteSection",
    		data : {"id":id,
    				"inquiryId":inquiryId,
    				"selectedQuotationId":id,
    				"inquiryStatus":4},
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
    $(document).ready(function () {
        $("a[name='inquiry_quote_add']").click(function () {
        	var quoteId = $(this).attr("tag_value");
        	SunivoUtil.createRemoteModal("新增报价", "${ctx}/lgsbreakstruckqsurchargecase/surchargeaddSection?quoteId="+quoteId, {},
                    function () {
                        validValue = $('form', '#modal_body').valid();
                        if (validValue) {
                            //开始发送数据
                            $.ajax
                            ({ //提交表单
                                url: $("#inquiry_quote_add_form").attr("action"), //获取提交到的页面
                                dataType: "html",
                                type: "POST",
                                //传送请求数据
                                data: $('#inquiry_quote_add_form').serialize(),
                                success: function () {
                                    // refreshSection($("#cusBankAccount_list_container"));
                                	alert("报价成功!");
                                    $('#modal_dialog').modal('hide');
                                    window.location.href = window.location.href;
                        			window.location.reload();
                                },
                                statusCode: {
                                    500: function (data) {
                                        resolveError($("#inquiry_quote_add_form"), data.responseText);
                                    }
                                }
                            });
                        }
                        return false;
                    }, "提交"
            );
        });
        
        $("a[name='inquiry_quote_sub_view']").click(function () {
        	var quoteId = $(this).attr("tag_value");
        	SunivoUtil.createRemoteModal("附加费查看", "${ctx}/lgsbreakstruckqsurchargecase/surchargeviewSection?quoteId="+quoteId, {},
                    function () {
                        /* validValue = $('form', '#modal_body').valid();
                        if (validValue) {
                            //开始发送数据
                            $.ajax
                            ({ //提交表单
                                url: $("#inquiry_quote_sub_view_form").attr("action"), //获取提交到的页面
                                dataType: "html",
                                type: "POST",
                                //传送请求数据
                                data: $('#inquiry_quote_sub_view_form').serialize(),
                                success: function () {
                                    // refreshSection($("#cusBankAccount_list_container"));
                                    $('#modal_dialog').modal('hide');
                                },
                                statusCode: {
                                    500: function (data) {
                                        resolveError($("#inquiry_quote_sub_view_form"), data.responseText);
                                    }
                                }
                            });
                        } */
                        return true;
                    }, ""
            );
        });
    })
</script>
	<div align="top" class="section" style="width: 1240px;">
		<div class="navbar section-title mg0">
			<div class="navbar-inner">
				<span class="brand">报价列表</span>
			</div>
		</div>
		<table class="table table-bordered table-striped table_vam" id="dt_gal">
			<thead>
				<tr>
					<th width="100">供应商</th>
					<th width="100">运输公司</th>
					<th width="100">总价</th>
					<th width="100">合计(本币)</th>
					<th width="100">合计(人民币)</th>
					<th width="100">回复时间</th>
					<th width="150">操作</th>
				</tr>
			</thead>
					<tbody>
				<c:forEach items="${breakstruckQuoteInfoCaseVoList}" var="breakstruckQuoteInfoCaseVo">
				<c:set value="${breakstruckQuoteInfoCaseVo.entity}" var="entity"></c:set>
				<c:set value="${breakstruckQuoteInfoCaseVo.surchargeEntity}" var="surcharge"></c:set>
				<tr>					
					<td nowrap="nowrap">
						<c:out value="${breakstruckQuoteInfoCaseVo.agentName}" />
						<input type="text" value="${breakstruckQuoteInfoCaseVo.agentName}" id="agent_name_tag_${entity.id}" style="display:none;" />				
					</td>
					<td nowrap="nowrap">
						<c:if test="${null ne breakstruckQuoteInfoCaseVo.carrierName && '' ne breakstruckQuoteInfoCaseVo.carrierName}">
							<c:out value="${breakstruckQuoteInfoCaseVo.carrierName}" />
						</c:if>
						<c:if test="${null eq breakstruckQuoteInfoCaseVo.carrierName || '' eq breakstruckQuoteInfoCaseVo.carrierName}">
							&nbsp;
						</c:if>
					</td>
					<c:choose>
						<c:when test="${surcharge.id == null || surcharge.id == 0}">
						<input type="text" value="${entity.id}" id="index_input_${entity.id}" style="display:none;">
						<td nowrap="nowrap">-</td>
						</c:when>
						<c:otherwise>
						<td nowrap="nowrap">
							<c:if test="${null ne surcharge.cost20Gp && '' ne surcharge.cost20Gp}">
								<%-- <g:moneyView money="${surcharge.cost20Gp}" />
								<g:currencyViewCRM showType="symbol" value="${surcharge.currencyid}"/> --%>
								<sunivo:moneyFormatView money="${surcharge.cost20Gp}"  />
								<sunivo:currencyView showType="symbol" value="${surcharge.currencyid}"/>
							</c:if>
							<c:if test="${null eq surcharge.cost20Gp || '' eq surcharge.cost20Gp}">
								0
								<%-- <g:currencyViewCRM showType="symbol" value="${surcharge.currencyid}"/> --%>
								<sunivo:currencyView showType="symbol" value="${surcharge.currencyid}"/>
							</c:if>
						</td>
						</c:otherwise>
					</c:choose>
					<td nowrap="nowrap">
						<c:if test="${null ne breakstruckQuoteInfoCaseVo.priceAmountMy && '' ne breakstruckQuoteInfoCaseVo.priceAmountMy}">
							<c:out value="${breakstruckQuoteInfoCaseVo.priceAmountMy}" />
						</c:if>
						<c:if test="${null eq breakstruckQuoteInfoCaseVo.priceAmountMy || '' eq breakstruckQuoteInfoCaseVo.priceAmountMy}">
							&nbsp;
						</c:if>
					</td>
					<td nowrap="nowrap">
						<c:if test="${null ne breakstruckQuoteInfoCaseVo.priceAmountRmb && '' ne breakstruckQuoteInfoCaseVo.priceAmountRmb}">
							<%-- <g:moneyView money="${breakstruckQuoteInfoCaseVo.priceAmountRmb}"/> --%>
							<sunivo:moneyFormatView money="${breakstruckQuoteInfoCaseVo.priceAmountRmb}"  />￥
						</c:if>
						<c:if test="${null eq breakstruckQuoteInfoCaseVo.priceAmountRmb || '' eq breakstruckQuoteInfoCaseVo.priceAmountRmb}">
							&nbsp;
						</c:if>
					</td>
					
					<td nowrap="nowrap">
						<c:if test="${null ne surcharge.updateDatetime && '' ne surcharge.updateDatetime}">
							<f:formatDate value='${surcharge.updateDatetime}' pattern='yyyy-MM-dd HH:mm:ss' />
						</c:if>
						<c:if test="${null eq surcharge.updateDatetime || '' eq surcharge.updateDatetime}">
							&nbsp;
						</c:if>
					</td>				
					<td nowrap="nowrap">
					<c:if  test="${inquiryStatus ne 4}">
					<c:choose>
						<c:when test="${surcharge.id eq null || surcharge.id eq 0}">
							<a href="javascript:void(0)" id="inquiry_quote_add" name="inquiry_quote_add" tag_value="${entity.id}" title="报价" >报价</a>
						</c:when>
						<c:when test="${surcharge.id ne null && surcharge.id ne 0 && breakstruckQuoteInfoCaseVo.ifSelectAble eq 1}">
							<a href="javascript:void(0)" title="选定" onclick="selectQuote(${entity.id},${inquiryId })">选定</a>&nbsp;&nbsp;&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							&nbsp;&nbsp;&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
					</c:if>
					<c:if  test="${inquiryStatus eq 4 && breakstruckQuoteInfoCaseVo.isSelectFlag eq 1}">
						已选定报价
					</c:if>
					</td>
				</tr>
				</c:forEach>
				
			</tbody>
		</table>
		
	</div>
	
</body>
</html>
