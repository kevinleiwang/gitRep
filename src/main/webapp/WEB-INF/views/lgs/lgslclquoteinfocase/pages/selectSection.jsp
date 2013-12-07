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
        	SunivoUtil.createRemoteModal("新增报价", "${ctx}/lgslclqsurchargecase/surchargeaddSection?quoteId="+quoteId, {},
                    function () {
                        validValue = $('form', '#modal_body').valid();
                        if (validValue && checkVal()) {
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
        	SunivoUtil.createRemoteModal("附加费查看", "${ctx}/lgslclqsurchargecase/surchargeviewSection?quoteId="+quoteId, {},
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

function checkVal(){
   	var prdQuoteNum = $("#prdQuoteCntNum").val();
   	if(prdQuoteNum != null && prdQuoteNum != ""){
   		for(var i=0;i<prdQuoteNum;i++){
   			//取得quoteID 
   			var quoteIdTagName = "entities["+i+"].quoteidiD";
   			var quoteId = $("input[name='"+ quoteIdTagName  +"']").val();
   			if(quoteId == 77 || quoteId == 111){
   				//对报价进行校验
   				var checkName = "entities["+i+"].";
   		    	var volumeCost = $("input[name='"+checkName+ "volumeCost']").val();
   		    	var weightCost = $("input[name='"+checkName+ "weightCost']").val();
   		    	if((volumeCost == null || volumeCost <= 0) && (weightCost == null || weightCost <= 0) ){
   		    		alert("海拼报价海运费必填");
   		    		return false;
   		    	}
   			}
   			if(quoteId == 78 || quoteId == 112){
   			//对报价进行校验
   				var checkName = "entities["+i+"].";
   		    	var volumeCost = $("input[name='"+checkName+ "volumeCost']").val();
   		    	var weightCost = $("input[name='"+checkName+ "weightCost']").val();
   		    	if((volumeCost == null || volumeCost <= 0) && (weightCost == null || weightCost <= 0) ){
   		    		alert("CISF报价项必填");
   		    		return false;
   		    	}
   			}
   			
   		}
   	}
 	return true;   	
 }
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
					<th width="100">船公司</th>
					<th width="100">体积单价</th>
					<th width="100">重量单价</th>
					<th width="100">其他费用</th>
					<th width="100">是否发货人承担</th>
					<th width="100">合计(本币)</th>
					<th width="100">合计(人民币)</th>
					<th width="100">回复时间</th>
					<th width="150">操作</th>
				</tr>
			</thead>
					<tbody>
				<c:forEach items="${lclQuoteInfoCaseVoList}" var="lclQuoteInfoCaseVo">
				<c:set value="${lclQuoteInfoCaseVo.entity}" var="entity"></c:set>
				<c:set value="${lclQuoteInfoCaseVo.surchargeEntity}" var="surcharge"></c:set>
				<tr>					
					<td nowrap="nowrap" title="${lclQuoteInfoCaseVo.agentName}">
						<div  style="white-space:nowrap;text-overflow:ellipsis;overflow:hidden;width:100px;">
							<c:out value="${lclQuoteInfoCaseVo.agentName}" />
							<input type="text" value="${lclQuoteInfoCaseVo.agentName}" id="agent_name_tag_${entity.id}" style="display:none;" />
						</div>
					</td>
					<c:if test="${null ne lclQuoteInfoCaseVo.carrierName && '' ne lclQuoteInfoCaseVo.carrierName}">
					<td nowrap="nowrap" title="${lclQuoteInfoCaseVo.carrierName}">
							<div style="white-space:nowrap;text-overflow:ellipsis;overflow:hidden;width:100px;">
								<c:out value="${lclQuoteInfoCaseVo.carrierName}" />
							</div>
					</td>
					</c:if>
					<c:if test="${null eq lclQuoteInfoCaseVo.carrierName || '' eq lclQuoteInfoCaseVo.carrierName}">
								<td nowrap="nowrap">
										&nbsp;
								</td>
						</c:if>
					<c:choose>
						<c:when test="${surcharge.id == null || surcharge.id == 0}">
						<input type="text" value="${entity.id}" id="index_input_${entity.id}" style="display:none;">
						<td nowrap="nowrap">-</td>
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
						<td nowrap="nowrap">
							<c:if test="${null ne surcharge.weightCost && '' ne surcharge.weightCost}">
								<%-- <g:moneyView money="${surcharge.weightCost}"/>
								<g:currencyViewCRM showType="symbol" value="${surcharge.currencyid}"/> --%>
								<sunivo:moneyFormatView money="${surcharge.weightCost}"  />
								<sunivo:currencyView showType="symbol" value="${surcharge.currencyid}"/>
							</c:if>
							<c:if test="${null eq surcharge.weightCost || '' eq surcharge.weightCost}">
								0
								<%-- <g:currencyViewCRM showType="symbol" value="${surcharge.currencyid}"/> --%>
								<sunivo:currencyView showType="symbol" value="${surcharge.currencyid}"/>
							</c:if>
						</td>
						</c:otherwise>
					</c:choose>
					<td nowrap="nowrap">
						<a href="javascript:void(0)" id="inquiry_quote_sub_view" name="inquiry_quote_sub_view" tag_value="${entity.id}" title="其它费用" >其它费用</a>
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${true eq surcharge.ifConsignorBear}">是</c:when>
							<c:otherwise>否</c:otherwise>
						</c:choose>
					</td>
					<td nowrap="nowrap">
						<c:if test="${null ne lclQuoteInfoCaseVo.priceAmountMy && '' ne lclQuoteInfoCaseVo.priceAmountMy}">
							<c:out value="${lclQuoteInfoCaseVo.priceAmountMy}" />
						</c:if>
						<c:if test="${null eq lclQuoteInfoCaseVo.priceAmountMy || '' eq lclQuoteInfoCaseVo.priceAmountMy}">
							&nbsp;
						</c:if>
					</td>
					<td nowrap="nowrap">
						<c:if test="${null ne lclQuoteInfoCaseVo.priceAmountRmb && '' ne lclQuoteInfoCaseVo.priceAmountRmb}">
							<%-- <g:moneyView money="${lclQuoteInfoCaseVo.priceAmountRmb}"/> --%>
							<sunivo:moneyFormatView money="${lclQuoteInfoCaseVo.priceAmountRmb}"  />￥
						</c:if>
						<c:if test="${null eq lclQuoteInfoCaseVo.priceAmountRmb || '' eq lclQuoteInfoCaseVo.priceAmountRmb}">
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
						<c:when test="${surcharge.id ne null && surcharge.id ne 0 && lclQuoteInfoCaseVo.ifSelectAble eq 1}">
							<a href="javascript:void(0)" title="选定" onclick="selectQuote(${entity.id},${inquiryId })">选定</a>&nbsp;&nbsp;&nbsp;&nbsp;
						</c:when>
						<c:otherwise>
							&nbsp;&nbsp;&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
					</c:if>
					<c:if test="${inquiryStatus eq 4 && lclQuoteInfoCaseVo.isSelectFlag eq 1}">
						已选定报价
					</c:if>
					</td>
				</tr>
				</c:forEach>
				<%-- <select   style="width: 60px;">
					<option value="1">是</option>
					<option value="0" selected="selected">否</option>
				</select>
				<sunivo:logisticsCompanySelect cusLogisticType="03" name="carrier" style="width:150px;" required="true" /> --%>
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
