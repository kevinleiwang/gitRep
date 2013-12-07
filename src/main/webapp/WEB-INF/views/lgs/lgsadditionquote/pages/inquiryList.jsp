<%@include file="/WEB-INF/common/layouts/common.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>询单加成列表</title>


<script type="text/javascript">
 $(document).ready(function () {
        $("i[name='inquiryAdditionEdit']").click(function () {
        	var click_url = $(this).attr("click_url");
        	var inquiryId = $(this).attr("tag_value");
        	if(click_url != null  && click_url.length > 0){
        		SunivoUtil.createRemoteModal("编辑加成信息", click_url, {},
	                    function () {
	                        validValue = $('form', '#modal_body').valid();
	                        if (validValue && checkTime()) {
	                 			$.ajax({
	                 		    		type : "POST",
	                 		    		url :  "${ctx}/lgsadditionquote/updateLgsAdditionQuoteSection/"+inquiryId,
	                 		    		data :$('#inquiry_addition_edit_form').serialize(),
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
        
        $("i[name='inquiryAdditionShow']").click(function () {
        	var click_url = $(this).attr("click_url");
        	var inquiryId = $(this).attr("tag_value");
        	if(click_url != null  && click_url.length > 0){
        		SunivoUtil.createRemoteModal("加成信息显示", click_url, {},
	                    function () {
	                        //validValue = $('form', '#modal_body').valid();
	                       	
	                        return true;
	                    }, ""
	            );
        	} else {
        		alert("数据错误，请刷新页面!");
        	}
        });
 })
 
 function checkTime()
 {	
	 var execTime = $.trim($("#entity\\.execDateStr").val());
	 var expiryTime = $.trim($("#entity\\.expiryDateStr").val());
	 if (undefined == execTime || "" == execTime || null == execTime 
			 || undefined == expiryTime || "" == expiryTime || null == expiryTime)
	 {
		alert("生效时间和失效时间必须填写"); 
		return false;	 
	 }
	 var execDate = new Date(execTime.replace(/\-/g,"/"));
	 var expiryDate = new Date(expiryTime.replace(/\-/g,"/"));
	 if (Date.parse(execDate) >= Date.parse(expiryDate))
	 {
		 alert("失效时间必须大于生效时间");
		 return false;
	 }	 
	 return true;
 }
 </script>
</head>
<body>

<!-- 流式布局，页面上部空出50px-->
<div class="row-fluid sunivoPage">
 <!-- 页面内容置中，左右各留span1 -->
<div class="span10 offset1">
	<sunivo:flushMessage />
	<div id="message"></div>
    <!-- 页头  begin -->
	<div class="row-fluid">
		<div class="sunivoTitle span12">
			<div class="span3">
				<h1 class="pageTitle">询单加成列表</h1>
			</div>
			<div class="span5"></div>
			<div class="span4" align="right">
				<span> 
				</span>
			</div>
		</div>
	</div>
	<!-- 页头  end -->
	<!-- 面包屑 begin -->
	<div class="row-fluid">
		<div class="span12">
			<ul class="breadcrumb">
				<li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
				<li class="active">询单加成列表</li>
			</ul>
		</div>
	</div>
	<!-- 面包屑 end -->
	
	<form id="filterForm" class="form-inline filterForm" action="${ctx}/lgsadditionquote/inquiryList" method="get">
	<div class="sunivoFilterForm">
		<div class="row-fluid">
			<div class="span12">
				<div class="span11 filterCondition">
					<input type="text" name="search_LIKE_inquiryCode" value="${param['search_LIKE_inquiryCode']}" 
						class="span2" placeholder="询单编号" style="width:230px;">
					<input type="text" name="search_LIKE_orderCode" value="${param['search_LIKE_orderCode']}" 
						class="span2"  placeholder="订单编号" style="width:230px;">
                </div>
                <div class="span1 filterAction">
                    <i class="pull-right icon-search icon-2x pointer"
									style="margin-right: 15px;" onclick="$('#filterForm').submit();"></i>
                </div>
	            
	        </div>
	    </div>
	  </div>
	 </form>
	    
	    
	    <!-- 数据列表 -->
        <div class="sunivoList">
        <c:forEach items="${lgsInquirysVo}" var="lgsInquiryVo">
        <c:set var="lgsInquiry" value="${lgsInquiryVo.entity}"></c:set>
         <div class="row-fluid">
						<div class="span12">
							<div class="row-fluid pull-left">
								<!-- 最左列，通常放入可唯一识别当前记录的字段，比如客户名，如没有，可放入ID -->
								<div class="number span2">
									<span>
										 <a href="${ctx}/lgsinquiry/detail?id=${lgsInquiry.id}"><c:out value="${lgsInquiry.id}" /></a>
									</span>
								</div>
								<!-- 记录要展示的数据，此处按列排，不是按行排 -->
								<div class="content span9">
									<div class="row-fluid">
										<!-- 第一列 -->
										<div class="span4">
											<dl class="dl-horizontal">
												<dt>订单编号：</dt>
												<dd>
													<c:if test="${null ne lgsInquiryVo.orderCode && '' ne lgsInquiryVo.orderCode}">
														<c:out value="${lgsInquiryVo.orderCode}" />
													</c:if>
													<c:if test="${null eq lgsInquiryVo.orderCode || '' eq lgsInquiryVo.orderCode}">
														&nbsp;
													</c:if>
												</dd>
												<dt>询单状态：</dt>
												<dd>
													<c:if test="${lgsInquiry.inquiryStatus eq '1'}">
														未分配	
													</c:if>
													<c:if test="${lgsInquiry.inquiryStatus eq '2'}">
														报价中	
													</c:if>
													<c:if test="${lgsInquiry.inquiryStatus eq '3'}">
														已报价	
													</c:if>
													<c:if test="${lgsInquiry.inquiryStatus eq '4'}">
														已成交	
													</c:if>
													<c:if test="${lgsInquiry.inquiryStatus eq '5'}">
														已过期	
													</c:if>
													<%-- <g:inquiryStatusView value="${lgsInquiry.inquiryStatus}"/> --%>
													<c:if test="${null eq lgsInquiry.inquiryStatus || '' eq lgsInquiry.inquiryStatus}">
														&nbsp;
													</c:if>
												</dd>
												<dt>询单类型：</dt>
												<dd>
													<c:if test="${lgsInquiry.inquiryType eq '1'}">
														海整询价		
													</c:if>
													<c:if test="${lgsInquiry.inquiryType eq '2'}">
														海拼询价		
													</c:if>
													<c:if test="${lgsInquiry.inquiryType eq '3'}">
														集卡询价		
													</c:if>
													<c:if test="${lgsInquiry.inquiryType eq '4'}">
														空运询价		
													</c:if>
													<c:if test="${lgsInquiry.inquiryType eq '5'}">
														零担询价		
													</c:if>
													<c:if test="${null eq lgsInquiry.inquiryType || '' eq lgsInquiry.inquiryType}">
														&nbsp;
													</c:if>
												</dd>
											</dl>
										</div>
										<!-- 第二列 -->
										<div class="span4">
											<dl class="dl-horizontal">
												<dt>询价时间：</dt>
												<dd>
													<c:if test="${null ne lgsInquiry.inquiryTime && '' ne lgsInquiry.inquiryTime}">
														<fmt:formatDate value='${lgsInquiry.inquiryTime}' pattern='yyyy-MM-dd HH:mm:ss' />
													</c:if>
													<c:if test="${null eq lgsInquiry.inquiryTime || '' eq lgsInquiry.inquiryTime}">
														&nbsp;
													</c:if>
												</dd>
												
												<dt>有效截止日期：</dt>
												<dd>
													<c:if test="${null ne lgsInquiry.expiryDate && '' ne lgsInquiry.expiryDate}">
														<fmt:formatDate value='${lgsInquiry.expiryDate}' pattern='yyyy-MM-dd' />
													</c:if>
													<c:if test="${null eq lgsInquiry.expiryDate || '' eq lgsInquiry.expiryDate}">
														&nbsp;
													</c:if>
												</dd>
												<dt><span title="销售价加成公式">销售价加成公式：</span>

												</dt>
												<dd>
													<c:if test="${null ne lgsInquiryVo.addationid && '' ne lgsInquiryVo.addationid}">
														成本价*<sunivo:moneyFormatView money="${lgsInquiryVo.priceAddPercent}"/>%
														<%-- <c:choose>
														<c:when test="${lgsInquiryVo.priceAddValue > 0}" >
														+++
														</c:when>
														<c:otherwise>
														--
														</c:otherwise>
														</c:choose> --%>
														<c:if test="${lgsInquiryVo.priceAddValue >= 0}" >
														+
														</c:if>
														<sunivo:moneyFormatView money="${lgsInquiryVo.priceAddValue}"/>
														
													</c:if>
													<c:if test="${null eq lgsInquiryVo.addationid || '' eq lgsInquiryVo.addationid}">
														&nbsp;
													</c:if>
												</dd>
											</dl>
										</div>
										<!-- 第三列 -->
										<div class="span4">
											<dl class="dl-horizontal">
												<dt>目标总价：</dt>
												<dd>
													<c:if test="${null ne lgsInquiry.goalfreightTotal && '' ne lgsInquiry.goalfreightTotal}">
														<sunivo:moneyFormatView money="${lgsInquiry.goalfreightTotal}"/>
														<sunivo:currencyView showType="symbol" value="${lgsInquiry.inquirycurrency}"/>
													</c:if>
													<c:if test="${null eq lgsInquiry.goalfreightTotal || '' eq lgsInquiry.goalfreightTotal}">
														&nbsp;
													</c:if>
												</dd>
												<dt>询单编号：</dt>
												<dd>
													<c:if test="${null ne lgsInquiry.inquiryCode && '' ne lgsInquiry.inquiryCode}">
														<c:out value="${lgsInquiry.inquiryCode}" />
													</c:if>
													<c:if test="${null eq lgsInquiry.inquiryCode || '' eq lgsInquiry.inquiryCode}">
														&nbsp;
													</c:if>
												</dd>
												<dt><span title="折扣价加成公式">折扣价加成公式：</span></dt>
												<dd>
													<c:if test="${null ne lgsInquiryVo.addationid && '' ne lgsInquiryVo.addationid}">
														销售价*<sunivo:moneyFormatView money="${lgsInquiryVo.discountAddPercent}"/>%
													</c:if>
													<c:if test="${null eq lgsInquiryVo.addationid || '' eq lgsInquiryVo.addationid}">
														&nbsp;
													</c:if>
												</dd>
											</dl>
										</div>
									</div>
								</div>

								<!-- 操作按钮 -->
								<div class="span1 action">
									<span  style="text-align: left ! important;">
										<c:choose>
											<c:when test="${lgsInquiry.inquiryStatus eq '4' || lgsInquiry.inquiryStatus eq '5'}">
												<i class="icon-eye-open pointer pull-left" style="margin-left: 15px;" tag_value="${lgsInquiry.id}" name="inquiryAdditionShow" click_url="${ctx}/lgsadditionquote/showSection/${lgsInquiry.id}"></i>
										    </c:when>
											<c:otherwise>
												<i class="icon-edit pointer pull-left" style="margin-left: 15px;" name="inquiryAdditionEdit" tag_value="${lgsInquiry.id}"
													click_url="${ctx}/lgsadditionquote/editSection/${lgsInquiry.id}?action=edit"></i>&nbsp;&nbsp;
												<i class="icon-eye-open pointer" style="margin-left: 15px;" tag_value="${lgsInquiry.id}" name="inquiryAdditionShow" click_url="${ctx}/lgsadditionquote/showSection/${lgsInquiry.id}"></i>
											</c:otherwise>
										</c:choose>										
									</span>
								</div>

							</div>
						</div>
					</div>
				</c:forEach>
		</div>
    <!-- 分页 -->
	<div class="row-fluid">
		<sunivo:pagination page="${page}" />
	</div>
</div>
</div>
</body>
</html>
