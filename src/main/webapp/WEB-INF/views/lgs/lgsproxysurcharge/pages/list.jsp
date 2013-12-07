<%@include file="/WEB-INF/common/layouts/common.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>代理服务报价</title>
</head>
<body>

<div class="row-fluid sunivoPage">
 
    <div class="span10 offset1">
	<!-- 页头 -->
   	<div class="sunivoTitle span12">
   		<div class="span6">
			<h1 class="pageTitle">代理服务报价列表</h1>
		</div>
		<div class="span2">
		</div>
		<div class="span4" align="right">
		</div>
	</div>
	<!-- 面包屑 begin -->
	<div class="row-fluid">
		<div class="span12">
			<ul class="breadcrumb">
				<li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
				<li class="active">代理服务报价列表</li>
			</ul>
		</div>
	</div>
	<!-- 面包屑 end -->
	
	<!-- 水平表单 end -->
	<div class="sunivoList">
		
		<c:forEach items="${proxySurchargeList}" var="proxySurcharge" varStatus="abc">
		<c:set value="${proxySurcharge.entity }" var="entity"></c:set>
		<c:set value="${proxySurcharge.prdQuoteEntity }" var="prdQuoteEntity"></c:set>
		<div class="row-fluid">
			<div class="span12">
				<div class="row-fluid pull-left">
					<!-- 最左列，通常放入可唯一识别当前记录的字段，比如客户名，如没有，可放入ID -->
					<div class="number span2">
						<span>
							<a click_url="${ctx}/lgsproxysurcharge/showSection/${prdQuoteEntity.id}" tag_value="${prdQuoteEntity.id}" href="#" name="lgsproxysurchargeView"><c:out value="${prdQuoteEntity.name}" /></a>
						</span>
					</div>
					<!-- 记录要展示的数据，此处按列排，不是按行排 -->
					<div class="content span9">
						<div class="row-fluid">
							<!-- 第一列 -->
							<div class="span4">
								<dl class="dl-horizontal">
									<dt>序号:</dt>
									<dd>
										${abc.count}
									</dd>
									<dt>计价单位:</dt>
									<dd>
										<c:if test="${null ne prdQuoteEntity.unitId && '' ne prdQuoteEntity.unitId}">
											<g:unitView value="${prdQuoteEntity.unitId}"/>
										</c:if>
										<c:if test="${null eq prdQuoteEntity.unitId || '' eq prdQuoteEntity.unitId}">
											&nbsp;
										</c:if>
									</dd>
									<dt>币种:</dt>
									<dd>
										<c:if test="${null ne prdQuoteEntity.currencyId && '' ne prdQuoteEntity.currencyId}">
											<g:currencyView value="${prdQuoteEntity.currencyId}" />
										</c:if>
										<c:if test="${null eq prdQuoteEntity.currencyId || '' eq prdQuoteEntity.currencyId}">
											&nbsp;
										</c:if>
									</dd>
									<dt>贸易类型:</dt>
									<dd>
										<c:if test="${null ne prdQuoteEntity.tradeId && '' ne prdQuoteEntity.tradeId}">
											<c:choose>
												<c:when test="${1 eq prdQuoteEntity.tradeId}">出口</c:when>
												<c:when test="${2 eq prdQuoteEntity.tradeId}">进口</c:when>
												<c:otherwise>&nbsp;</c:otherwise>
											</c:choose>
										</c:if>
										<c:if test="${null eq prdQuoteEntity.tradeId || '' eq prdQuoteEntity.tradeId}">
											&nbsp;
										</c:if>
									</dd>
								</dl>
							</div>
							<!-- 第二列 -->
							<div class="span4">
								<dl class="dl-horizontal">
									<dt>折扣价</dt>
									<dd><c:if test="${null ne entity.unitDiscount && '' ne entity.unitDiscount}">
											<g:moneyView money="${entity.unitDiscount}"/>
										</c:if>
										<c:if test="${null eq entity.unitDiscount || '' eq entity.unitDiscount}">
											&nbsp;
										</c:if>
									</dd>
									<dt>单价:</dt>
									<dd>
										<c:if test="${null ne entity.unitCost && '' ne entity.unitCost}">
											<g:moneyView money="${entity.unitCost}"/>
										</c:if>
										<c:if test="${null eq entity.unitCost || '' eq entity.unitCost}">
											&nbsp;
										</c:if>
									</dd>
									
									<dt>是否启用:</dt>
									<dd>
										<c:choose>
											<c:when test="${entity.ifAllIn eq true}">是</c:when>
											<c:otherwise>否</c:otherwise>
										</c:choose>
									</dd>
								</dl>
							</div>
							
						</div>
					</div>

					<!-- 操作按钮 -->
					<div class="action span1">
						<span>  
							 <i class="icon-edit pointer" title="编辑报价" name="editproxsurcharge" tag_value="${prdQuoteEntity.id}"
								click_url="${ctx}/lgsproxysurcharge/editSection/${prdQuoteEntity.id}?action=edit"></i>
								&nbsp;&nbsp;
						</span>
					</div>

				</div>
			</div>
		</div>
		</c:forEach>
	</div>
</div>
</div>
<script type="text/javascript">
    var deleteById = function (lgsproxysurchargeId) {
        createModal("删除基础代理报价费用信息", "确定要删除该基础代理报价费用信息？", function () {
            $.ajax({
                url: '${ctx}/lgsproxysurcharge/' + lgsproxysurchargeId,
                type: "DELETE",
                dataType: "json",
                success: function () {
                    window.location.reload();
                }
            });
        });
    };
</script>

<script type="text/javascript">
 $(document).ready(function () {
	  $("i[name='editproxsurcharge']").click(function () {
      	var click_url = $(this).attr("click_url");
      	var quoteIDid = $(this).attr("tag_value");
      	if(click_url != null  && click_url.length > 0){
	            createRemoteModal("代理费管理", click_url, {},
	                    function () {
	                        validValue = $('form', '#modal_body').valid();
	                        if (validValue) {
	                 			$.ajax({
	                 		    		type : "POST",
	                 		    		url :  "${ctx}/lgsproxysurcharge/updateLgsProxySurchargeSection/"+quoteIDid,
	                 		    		data :$("#editproxsurchargeform").serialize(),
	                 		    		success : function(result) {
	                 		    			alert("保存成功");
	                 		    			window.location.href = window.location.href;
	                 		    			window.location.reload();
	                 		    		},
	                 		    		error : function(XMLHttpRequest, textStatus, errorThrown) {
	                 		    			//alert("Status: " + textStatus);
	                 		    			alert("保存成功");
	                 		    			window.location.href = window.location.href;
	                 		    			window.location.reload();
	                 		    		}
	                 		    	});
	                 		}
	                        return false;
	                    }, "保存"
	            );
      	} else {
      		alert("数据错误，请刷新页面!");
      	}
      });
	 
	 
	 $("a[name='lgsproxysurchargeView']").click(function () {
     	var click_url = $(this).attr("click_url");
     	var quoteIDid = $(this).attr("tag_value");
     	if(click_url != null  && click_url.length > 0){
	            createRemoteModal("代理费管理", click_url, {},
	                    function () {
	                        
	                    }, ""
	            );
     	} else {
     		alert("数据错误，请刷新页面!");
     	}
     	});
        
      
 })
 </script>
</body>
</html>
