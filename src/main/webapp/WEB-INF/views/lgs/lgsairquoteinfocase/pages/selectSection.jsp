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
    			window.location.href = window.location.href;
    			window.location.reload();
    		}
    	});
    	}
    }
    $(document).ready(function () {
        $("a[name='inquiry_quote_add']").click(function () {
        	var quoteId = $(this).attr("tag_value");
        	SunivoUtil.createRemoteModal("新增报价", "${ctx}/lgsairqsurchargecase/surchargeaddSection?quoteId="+quoteId, {},
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
        	SunivoUtil.createRemoteModal("附加费查看", "${ctx}/lgsairqsurchargecase/surchargeviewSection?quoteId="+quoteId, {},
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

<div class="row-fluid sunivoPage" style="margin-bottom: 40px;">
	<form id="input_form" class="form-horizontal">
		<div class="span10 offset1">
			<div class="sunivoBorder">
			
			<div class="sectionTitle">
				<h5>报价列表</h5>
			</div>
			
		<div class="row-fluid" style=" border:1px solid #E2E2E2; ">
		<table class="table table-bordered table-striped table_vam" id="dt_gal">
			<thead>
				<tr>
					<th width="100">供应商</th>
					<th width="100">航空公司</th>
					<th width="100">单价</th>
					<th width="100">合计(本币)</th>
					<th width="100">合计(人民币)</th>
					<th width="100">回复时间</th>
					<th width="150">操作</th>
				</tr>
			</thead>
					<tbody>
				<c:forEach items="${airQuoteInfoCaseVoList}" var="airQuoteInfoCaseVo">
				<c:set value="${airQuoteInfoCaseVo.entity}" var="entity"></c:set>
				<c:set value="${airQuoteInfoCaseVo.surchargeEntity}" var="surcharge"></c:set>
				<tr>					
					<td nowrap="nowrap" title="${airQuoteInfoCaseVo.agentName}">
						<div  style="white-space:nowrap;text-overflow:ellipsis;overflow:hidden;width:100px;" >
							<c:out value="${airQuoteInfoCaseVo.agentName}" />
							<input type="text" value="${airQuoteInfoCaseVo.agentName}" id="agent_name_tag_${entity.id}" style="display:none;" />
						</div>
					</td>
					<c:if test="${null ne airQuoteInfoCaseVo.carrierName && '' ne airQuoteInfoCaseVo.carrierName}">
						<td nowrap="nowrap" title="${airQuoteInfoCaseVo.carrierName}">
							<div  style="white-space:nowrap;text-overflow:ellipsis;overflow:hidden;width:100px;">
								<c:out value="${airQuoteInfoCaseVo.carrierName}" />
								</div>
						</td>
					</c:if>
					<c:if test="${null eq airQuoteInfoCaseVo.carrierName || '' eq airQuoteInfoCaseVo.carrierName}">
						<td nowrap="nowrap">
							&nbsp;
						</td>
					</c:if>
					<c:choose>
						<c:when test="${surcharge.id == null || surcharge.id == 0}">
						<input type="text" value="${entity.id}" id="index_input_${entity.id}" style="display:none;">
						<td nowrap="nowrap">-</td>
						</c:when>
						<c:otherwise>
						<td nowrap="nowrap">
							<c:if test="${null ne surcharge.volumeCost && '' ne surcharge.volumeCost}">
								<%-- <g:moneyView money="${surcharge.volumeCost}"/>
								<g:currencyViewCRM showType="symbol" value="${surcharge.currencyid}"/> --%>
								<sunivo:moneyFormatView money="${surcharge.volumeCost}"  />
								<sunivo:currencyView showType="symbol" value="${surcharge.currencyid}"/>
							</c:if>
							<c:if test="${null eq surcharge.volumeCost || '' eq surcharge.volumeCost}">
								0
								<%-- <g:currencyViewCRM showType="symbol" value="${surcharge.currencyid}"/> --%>
								<sunivo:currencyView showType="symbol" value="${surcharge.currencyid}"/>
							</c:if>
						</td>
						</c:otherwise>
					</c:choose>
					
					<td nowrap="nowrap">
						<c:if test="${null ne airQuoteInfoCaseVo.priceAmountMy && '' ne airQuoteInfoCaseVo.priceAmountMy}">
							<c:out value="${airQuoteInfoCaseVo.priceAmountMy}" />
						</c:if>
						<c:if test="${null eq airQuoteInfoCaseVo.priceAmountMy || '' eq airQuoteInfoCaseVo.priceAmountMy}">
							&nbsp;
						</c:if>
					</td>
					<td nowrap="nowrap">
						<c:if test="${null ne airQuoteInfoCaseVo.priceAmountRmb && '' ne airQuoteInfoCaseVo.priceAmountRmb}">
							<%-- <g:moneyView money="${airQuoteInfoCaseVo.priceAmountRmb}"/> --%>
							<sunivo:moneyFormatView money="${airQuoteInfoCaseVo.priceAmountRmb}" />￥
						</c:if>
						<c:if test="${null eq airQuoteInfoCaseVo.priceAmountRmb || '' eq airQuoteInfoCaseVo.priceAmountRmb}">
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
						<c:when test="${surcharge.id ne null && surcharge.id ne 0 && airQuoteInfoCaseVo.ifSelectAble eq 1}">
							<a href="javascript:void(0)" title="选定" onclick="selectQuote(${entity.id},${inquiryId })">选定</a>&nbsp;&nbsp;&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							&nbsp;&nbsp;&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
					</c:if>
					<c:if  test="${inquiryStatus eq 4 && airQuoteInfoCaseVo.isSelectFlag eq 1}">
						已选定报价
					</c:if>
					</td>
				</tr>
				</c:forEach>
				
			</tbody>
		</table>		
        </div>
       </div>
       </div>
    </form>
</div>

<!-- 修改结束 -->
	
</body>
</html>
