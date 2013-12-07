<%@include file="/WEB-INF/common/layouts/common.jsp" %>
<%@ page language="java" pageEncoding="UTF-8" import="java.util.Date"%>
<html>
<head>
    <title>报价预览</title>
</head>
<body>
<% Date nowDate = new Date(); %>
<!-- 流式布局，页面上部空出50px-->
<div class="row-fluid sunivoPage">
<form id="input_form" class="form-horizontal valid"
      action="${ctx}/lgsfclquoteinfo<c:if test="${action=='edit'}">/${entity.id}</c:if>"
      method="post">
    <input name="id" id="id" value="${entity.id}" type="hidden"/>
    <div class="span10 offset1">
    	<sunivo:flushMessage/>
    	<div class="row-fluid">
        <div class="span12 sunivoTitle" >
        	<div class="span6">
				<h1 class="pageTitle">报价预览</h1>
			</div>
			<div class="span6" align="right">
            </div>
		</div>
		<!-- 面包屑 begin -->
		<div class="row-fluid">
			<div class="span12">
				<ul class="breadcrumb">
					<li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
					<li><a href="${ctx}/lgsfclquoteinfo?search_EQ_status=0">海运整箱报价列表</a> <span
						class="divider">/</span></li>
					<li class="active">报价预览</li>
				</ul>
			</div>
		</div>
		<!-- 面包屑 end -->
            <sunivo:flushMessage/>
            <!-- 面包屑 end -->
			<div class="sunivoBorder">
				<!-- 片段头 begin -->
				<div class="sectionTitle">
                    <h5>海运整箱报价基本信息</h5>
                </div>
                <div class="portlet-body form">
                    <input name="entity.id" type="hidden" value="${entity.id}"/>
					<div class="row-fluid">
						<div class="span6 control-group">
                            <label class="control-label">报价编号：</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.id"
											name="entity.id"
											value="${entity.id}" style="display:none"/>
										${entity.id}
										<font color="red"><form:errors path="lgsFclQuoteInfoVo.entity.id" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.id}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">航线类型：</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.routeTypeId"
											name="entity.routeTypeId"
											value="${entity.routeTypeId}" style="display:none;"/>
										 <sunivo:shippinglineView value="${entity.routeTypeId}"/>
										<font color="red"><form:errors path="lgsFclQuoteInfoVo.entity.routeTypeId" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline"><sunivo:shippinglineView value="${entity.routeTypeId}"/>&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">船公司：</label>
							<div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.agentId"
											name="entity.agentId"
											value="${entity.agentId}" style="display:none;"/>
										<sunivo:customerView value="${entity.agentId}"/>
										<font color="red"><form:errors path="entity.agentId" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline"><sunivo:customerView value="${entity.agentId}"/>&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">货代：</label>
							<div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.carrierId"
											name="entity.carrierId"
											value="${entity.carrierId}" style="display:none;"/>
										<sunivo:customerView value="${entity.carrierId}"/>
										<font color="red"><form:errors path="lgsFclQuoteInfoVo.entity.carrierId" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline"><sunivo:customerView value="${entity.carrierId}"/>&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">起运港：</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.shipmentPortId"
											name="entity.shipmentPortId"
											value="${entity.shipmentPortId}" style="display:none;"/>
										<sunivo:shipPortView value="${entity.shipmentPortId}"/>
										<font color="red"><form:errors path="lgsFclQuoteInfoVo.entity.shipmentPortId" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline"><sunivo:shipPortView value="${entity.shipmentPortId}"/>&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">目的港：</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.destinationPortId"
											name="entity.destinationPortId"
											value="${entity.destinationPortId}" style="display:none;"/>
										<sunivo:shipPortView value="${entity.destinationPortId}"/>
										<font color="red"><form:errors path="lgsFclQuoteInfoVo.entity.destinationPortId" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline"><sunivo:shipPortView value="${entity.destinationPortId}"/>&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">生效日期：</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
	                            		<div class="input-append date datetime-picker" date-format="yyyy-mm-dd" id="execDate"
	                            			date-startDate="<fmt:formatDate value='<%=nowDate %>' pattern='yyyy-MM-dd'/>" 
	                            			date-minView="months" date-endDate="">
											<input class="m-wrap" type="text" 
												value="<fmt:formatDate value='${lgsQuoteViewVo.execDate}' pattern='yyyy-MM-dd'/> "
												id="lgsQuoteViewVo.execDateStr" name="lgsQuoteViewVo.execDateStr" style="width:346px;"
												readonly>
											<span class="add-on"><i class="icon-remove"></i></span>
											<span class="add-on"><i class="icon-calendar"></i></span>
											<font color="red"><form:errors path="lgsQuoteViewVo.execDate" /></font>
										</div>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline"><fmt:formatDate value='${lgsQuoteViewVo.execDate}' pattern='yyyy-MM-dd'/>&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">失效日期：</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
                            			<div class="input-append date datetime-picker" date-format="yyyy-mm-dd" id="expiryDate"
	                            			date-startDate="<fmt:formatDate value='<%=nowDate %>' pattern='yyyy-MM-dd'/>" 
	                            			date-minView="months" date-endDate="">
											<input class="m-wrap" type="text" 
												value="<fmt:formatDate value='${entity.expiryDate}' pattern='yyyy-MM-dd'/> "
												id="entity.expiryDateStr" name="entity.expiryDateStr" style="width:346px;"
												readonly>
											<span class="add-on"><i class="icon-remove"></i></span>
											<span class="add-on"><i class="icon-calendar"></i></span>
											<font color="red"><form:errors path="lgsFclQuoteInfoVo.entity.expiryDate" /></font>
										</div>
										
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline"><fmt:formatDate value='${lgsQuoteViewVo.expiryDate}' pattern='yyyy-MM-dd' />&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">预计航程：</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.estimatedRange"
											name="entity.estimatedRange" style="width:400px;"
											value="${entity.estimatedRange}" class="number"/>
										<font color="red"><form:errors path="entity.estimatedRange" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.estimatedRange}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                       <div class="span6 control-group">
                            <label class="control-label">预计船期：</label>

                            <div class="controls">
                                <c:choose>
                                	
                                    <c:when test="${action=='create' || action=='edit'}">
										<select id="entity.estimatedSalingdate" name="entity.estimatedSalingdate" style="width:413px;" multiple="multiple" class="chosen-with-diselect span6">
											
											<option value="星期一" <c:forEach items="${entity.estimatedSalingdateValues}" var="estimatedSalingdate">
																	<c:if test="${estimatedSalingdate eq '星期一'}">
																	selected="selected"
																	</c:if> 
																 </c:forEach> >星期一</option>
											<option value="星期二" <c:forEach items="${entity.estimatedSalingdateValues}" var="estimatedSalingdate">
																	<c:if test="${estimatedSalingdate eq '星期二'}">
																	selected="selected"
																	</c:if> 
																 </c:forEach> >星期二</option>
											<option value="星期三" <c:forEach items="${entity.estimatedSalingdateValues}" var="estimatedSalingdate">
																	<c:if test="${estimatedSalingdate eq '星期三'}">
																	selected="selected"
																	</c:if> 
																 </c:forEach> >星期三</option>
											<option value="星期四" <c:forEach items="${entity.estimatedSalingdateValues}" var="estimatedSalingdate">
																	<c:if test="${estimatedSalingdate eq '星期四'}">
																	selected="selected"
																	</c:if> 
																 </c:forEach> >星期四</option>
											<option value="星期五" <c:forEach items="${entity.estimatedSalingdateValues}" var="estimatedSalingdate">
																	<c:if test="${estimatedSalingdate eq '星期五'}">
																	selected="selected"
																	</c:if> 
																 </c:forEach> >星期五</option>
											<option value="星期六" <c:forEach items="${entity.estimatedSalingdateValues}" var="estimatedSalingdate">
																	<c:if test="${estimatedSalingdate eq '星期六'}">
																	selected="selected"
																	</c:if> 
																 </c:forEach> >星期六</option>
											<option value="星期日" <c:forEach items="${entity.estimatedSalingdateValues}" var="estimatedSalingdate">
																	<c:if test="${estimatedSalingdate eq '星期日'}">
																	selected="selected"
																	</c:if> 
																 </c:forEach> >星期日</option>
										</select>
										<font color="red"><form:errors path="lgsFclQuoteInfoVo.entity.estimatedSalingdate" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.estimatedSalingdate}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">转运属性：</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<input type="text" id="entity.transpProperties"
											name="entity.transpProperties"
											value="${entity.transpProperties}" style="display:none;" />
										<c:out value="${entity.transpProperties}"></c:out>
										<font color="red"><form:errors path="lgsFclQuoteInfoVo.entity.transpProperties" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline">${entity.transpProperties}&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">中转港：</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
                                    	<sunivo:shipPortView value="${entity.enterportId}"/>
										<font color="red"><form:errors path="lgsFclQuoteInfoVo.entity.enterportId" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline"><sunivo:shipPortView value="${entity.enterportId}"/>&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
					</div>
					
					<div class="row-fluid">
                        <div class="span6 control-group">
                            <label title="是否为优势航线" class="control-label">是否为优势...：</label>

                            <div class="controls">
                                <c:choose>
                                    <c:when test="${action=='create' || action=='edit'}">
										<select style="width:50px;" name="entity.ifAdvantageResource">
											<option value="1" <c:if test="${entity.ifAdvantageResource eq 1}">selected="selected"</c:if> >是</option>
											<option value="0" <c:if test="${entity.ifAdvantageResource eq null || entity.ifAdvantageResource ne 1}">selected="selected"</c:if>>否</option>
									    </select>
										<font color="red"><form:errors path="entity.ifAdvantageResource" /></font>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline"><c:if test="${entity.ifAdvantageResource eq 1}">是</c:if>
                                        					<c:if test="${entity.ifAdvantageResource eq null || entity.ifAdvantageResource ne 1}" >否</c:if>&nbsp;</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label title="备注" class="control-label">备注：</label>

                            <div class="controls">
                                <span class="inline">${lgsQuoteViewVo.remark}</span>
                            </div>
                        </div>				
                </div>
                <div class="row-fluid">
                        <div class="span6 control-group">
                            <label title="是否all-in" class="control-label">是否all-in：</label>
                            <div class="controls">
                            <span class="inline"><c:if test="${entity.ifAllIn eq 1}">是</c:if>
                                        		 <c:if test="${entity.ifAllIn eq 0}">否</c:if>&nbsp;</span>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label title="状态" class="control-label">状态：</label>
                            <div class="controls">
                               <span class="inline">
                               	<sunivo:disabledFlagView value="${lgsQuoteViewVo.status}"/>
                               </span>
							</div>
                        </div>				
                </div>
                <div class="row-fluid">
                        <div class="span6 control-group">
                            <label class="control-label">创建人：</label>
                            <div class="controls">
                                <span class="inline"><c:out value="${lgsQuoteViewVo.createUsername}"></c:out></span>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">创建时间：</label>
                              <span class="inline"><fmt:formatDate value='${lgsQuoteViewVo.createDatetime}' pattern='yyyy-MM-dd HH:mm:ss' />&nbsp;</span>
                            </div>
                        </div>
                         <div class="row-fluid">
                 <div class="span6 control-group">
                            <label class="control-label">更新人：</label>
                            <div class="controls">
                                <span class="inline"><c:out value="${lgsQuoteViewVo.updateUsername}"></c:out></span>
                            </div>
                        </div>
                        <div class="span6 control-group">
                            <label class="control-label">更新时间：</label>
                              <span class="inline"><fmt:formatDate value='${lgsQuoteViewVo.updateDatetime}' pattern='yyyy-MM-dd HH:mm:ss' />&nbsp;</span>
                            </div>
                        </div>
					</div>
            </div>
            
            
       <!-- 面包屑 end -->
	   <div class="sunivoBorder">
	   <!-- 片段头 begin -->
		<div class="sectionTitle">
               <h5>费用详情</h5>
           </div>
           <div class="portlet-body form">
            <table class="table table-bordered table-striped table_vam" id="dt_gal">
			<thead>
				<tr>
					<th>费用项目</th>
					<th width="80px;">单位</th>
					<th width="80px;">币种</th>
					<th>非柜成本价</th>
					<th>20′成本价</th>
					<th>40′成本价</th>
					<th>40HQ成本价</th>
					<th>非柜折扣价</th>
					<th>20′折扣价</th>
					<th>40′折扣价</th>
					<th>40HQ折扣价</th>
				</tr>
			</thead>
					<tbody>
					
				<c:forEach items="${surchargeEntitys}" var="surchargeEntity" varStatus="status" >
				<c:set value="${surchargeEntity.entity }" var="surcharge" ></c:set>
				<c:set value="${surchargeEntity.prdQuoteEntity }" var="prdQuote" ></c:set>
				<tr>
					<td nowrap="nowrap">
						<c:if test="${null ne prdQuote.name && '' ne prdQuote.name}">
							<c:out value="${prdQuote.name}"/>
						</c:if>
					</td>
					<td nowrap="nowrap">
						<sunivo:unitView value="${prdQuote.unitId}" />
					</td>
					<td nowrap="nowrap">
						<sunivo:currencyView showType="cn" value="${prdQuote.currencyId}"/>
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${action=='edit'}">
								<c:if test="${null ne surcharge.nonContainerCost && '' ne surcharge.nonContainerCost}">
								<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="${surcharge.nonContainerCost}" id="entities[${status.index}].nonContainerCost" name="entities[${status.index}].nonContainerCost" style="width: 60px;" <c:if test="${'5' eq prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
								<c:if test="${null eq surcharge.nonContainerCost || '' eq surcharge.nonContainerCost}">
									<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="" id="entities[${status.index}].nonContainerCost" name="entities[${status.index}].nonContainerCost" style="width: 60px;" <c:if test="${'5' eq prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
							</c:when>
							<c:otherwise>
								<sunivo:moneyFormatView money="${surcharge.nonContainerCost}"/>
							</c:otherwise>
						</c:choose>						
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${action=='edit'}">
								<c:if test="${null ne surcharge.cost20gp && '' ne surcharge.cost20gp}">
									<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="${surcharge.cost20gp}" id="entities[${status.index}].cost20gp" name="entities[${status.index}].cost20gp" style="width: 60px;" <c:if test="${'5' ne prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
								<c:if test="${null eq surcharge.cost20gp || '' eq surcharge.cost20gp}">
									<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="" id="entities[${status.index}].cost20gp" name="entities[${status.index}].cost20gp" style="width: 60px;" <c:if test="${'5' ne prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
							</c:when>
							<c:otherwise>
								<sunivo:moneyFormatView money="${surcharge.cost20gp}"/>
							</c:otherwise>
						</c:choose>						
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${action=='edit'}">
								<c:if test="${null ne surcharge.cost40gp && '' ne surcharge.cost40gp}">
									<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="${surcharge.cost40gp}" id="entities[${status.index}].cost40gp" name="entities[${status.index}].cost40gp" style="width: 60px;" <c:if test="${'5' ne prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
								<c:if test="${null eq surcharge.cost40gp || '' eq surcharge.cost40gp}">
									<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="" id="entities[${status.index}].cost40gp" name="entities[${status.index}].cost40gp" style="width: 60px;" <c:if test="${'5' ne prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
							</c:when>
							<c:otherwise>
								<sunivo:moneyFormatView money="${surcharge.cost40gp}"/>
							</c:otherwise>
						</c:choose>
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${action=='edit'}">
								<c:if test="${null ne surcharge.cost40hq && '' ne surcharge.cost40hq}">
									<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="${surcharge.cost40hq}" id="entities[${status.index}].cost40hq" name="entities[${status.index}].cost40hq" style="width: 60px;" <c:if test="${'5' ne prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
								<c:if test="${null eq surcharge.cost40hq || '' eq surcharge.cost40Hq}">
									<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="" id="entities[${status.index}].cost40hq" name="entities[${status.index}].cost40hq" style="width: 60px;" <c:if test="${'5' ne prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
							</c:when>
							<c:otherwise>
								<sunivo:moneyFormatView money="${surcharge.cost40hq}"/>
							</c:otherwise>
						</c:choose>
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${action=='edit'}">
								<c:if test="${null ne surcharge.nonContainerDiscount && '' ne surcharge.nonContainerDiscount}">
								<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="${surcharge.nonContainerDiscount}" id="entities[${status.index}].nonContainerDiscount" name="entities[${status.index}].nonContainerDiscount" style="width: 60px;" <c:if test="${'5' eq prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
								<c:if test="${null eq surcharge.nonContainerDiscount || '' eq surcharge.nonContainerDiscount}">
									<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="" id="entities[${status.index}].nonContainerDiscount" name="entities[${status.index}].nonContainerDiscount" style="width: 60px;" <c:if test="${'5' eq prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
							</c:when>
							<c:otherwise>
								<sunivo:moneyFormatView money="${surcharge.nonContainerDiscount}"/>
							</c:otherwise>
						</c:choose>						
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${action=='edit'}">
								<c:if test="${null ne surcharge.discount20gp && '' ne surcharge.discount20gp}">
									<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="${surcharge.discount20gp}" id="entities[${status.index}].discount20gp" name="entities[${status.index}].discount20gp" style="width: 60px;" <c:if test="${'5' ne prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
								<c:if test="${null eq surcharge.discount20gp || '' eq surcharge.discount20gp}">
									<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="" id="entities[${status.index}].discount20gp" name="entities[${status.index}].discount20gp" style="width: 60px;" <c:if test="${'5' ne prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
							</c:when>
							<c:otherwise>
								<sunivo:moneyFormatView money="${surcharge.discount20gp}"/>
							</c:otherwise>
						</c:choose>						
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${action=='edit'}">
								<c:if test="${null ne surcharge.discount40gp && '' ne surcharge.discount40gp}">
									<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="${surcharge.discount40gp}" id="entities[${status.index}].discount40gp" name="entities[${status.index}].discount40gp" style="width: 60px;" <c:if test="${'5' ne prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
								<c:if test="${null eq surcharge.discount40gp || '' eq surcharge.discount40gp}">
									<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="" id="entities[${status.index}].discount40gp" name="entities[${status.index}].discount40gp" style="width: 60px;" <c:if test="${'5' ne prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
							</c:when>
							<c:otherwise>
								<sunivo:moneyFormatView money="${surcharge.discount40gp}"/>
							</c:otherwise>
						</c:choose>
					</td>
					<td nowrap="nowrap">
						<c:choose>
							<c:when test="${action=='edit'}">
								<c:if test="${null ne surcharge.discount40hq && '' ne surcharge.discount40hq}">
									<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="${surcharge.discount40hq}" id="entities[${status.index}].discount40hq" name="entities[${status.index}].discount40hq" style="width: 60px;" <c:if test="${'5' ne prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
								<c:if test="${null eq surcharge.discount40hq || '' eq surcharge.discount40hq}">
									<input onclick="inputMoney(this);" onblur="checkMoney(this);"
									       type="text" value="" id="entities[${status.index}].discount40hq" name="entities[${status.index}].discount40hq" style="width: 60px;" <c:if test="${'5' ne prdQuote.unitId}">readonly="readonly"</c:if> />
								</c:if>
							</c:when>
							<c:otherwise>
								<sunivo:moneyFormatView money="${surcharge.discount40hq}"/>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
				
			</tbody>
		</table>
	</div>
	</div>
	<!-- 面包屑 end -->
	<div class="sunivoBorder">
		<!-- 片段头 begin -->
		<div class="sectionTitle">
           <h5>预览合计</h5>
       </div>
       <div class="portlet-body form">
	 	<div class="row-fluid">
	 		 <div class="span2 control-group">
	 		 </div>
             <div class="span4 control-group">
                 <label class="control-label">成本价：</label>
                   	<c:if test="${null ne lgsQuoteViewVo.costMyCount}" >
                   		<span class="inline"><sunivo:moneyFormatView money="${lgsQuoteViewVo.costMyCount}"/>USD</span>
                   	</c:if>
                   	<c:if test="${null ne lgsQuoteViewVo.costRmbCount}" >
                   		<span class="inline">+<sunivo:moneyFormatView money="${lgsQuoteViewVo.costRmbCount}"/>RMB</span>
                   	</c:if>
                 </div>
             <div class="span4 control-group">
                 <label class="control-label">折扣价：</label>
                   	<c:if test="${null ne lgsQuoteViewVo.discountMyCount}" >
                   		<span class="inline"><sunivo:moneyFormatView money="${lgsQuoteViewVo.discountMyCount}"/>USD</span>
                   	</c:if>
                   	<c:if test="${null ne lgsQuoteViewVo.discountRmbCount}" >
                   		<span class="inline">+<sunivo:moneyFormatView money="${lgsQuoteViewVo.discountRmbCount}"/>RMB</span>
                   	</c:if>
             </div>
          </div>
        </div>
        </div>
		
        </div>
    </div>
</form>
</div>
</body>

</html>