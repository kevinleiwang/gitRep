<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>优势航线编辑</title>
<script type="text/javascript">
	$(document).ready(
		function(){
			$("#saveButton").click(
				function (){
						$('#input_form').submit();
				}		
			);
		}		
	);
</script>
</head>
<body>
	<!-- 流式布局，页面上部空出50px-->
	<div class="row-fluid sunivoPage">
		<!-- 水平表单 begin -->
		<form id="input_form" class="form-horizontal valid" action="${ctx}/lgsadvantagerouteset/${entity.id}" method="post">
			<!-- 页面内容置中，左右各留span1 -->
			<div class="span10 offset1">
				<div id="message"></div>
				<sunivo:flushMessage/>
				<!-- 页头  begin -->
				<div class="row-fluid">
					<div class="span12 sunivoTitle">
						<div class="span6">
							<h1 class="pageTitle">优势航线编辑</h1>
						</div>
						<div class="span6" align="right"> 
							<i title="保存" class="pull-right icon-save icon-2x pointer" id="saveButton" style="margin-right: 15px;" ></i>
						</div>
					</div>
				</div>
				<!-- 页头  end -->
				<!-- 面包屑 begin -->
				<div class="row-fluid">
					<div class="span12">
						<ul class="breadcrumb">
							<li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
							<li><a href="${ctx}/lgsadvantagerouteset/">优势航线列表</a> <span
								class="divider">/</span></li>
							<li class="active">优势航线编辑</li>
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
							<label class="control-label" >起运港<font style="color:red;">*</font>:</label>
							<div class="controls">
								<sunivo:shipPortSelect span="span10" name="entity.shipmentPortId" required="true" value="${entity.shipmentPortId}" placeHolderMessageCode="起运港"/>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" >目的港:</label>
							<div class="controls">
								<sunivo:shipPortSelect span="span10" name="entity.destinationPortId" value="${entity.destinationPortId}" placeHolderMessageCode="目的港"/>
							</div>
						</div>
					</div>

					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" >船公司:</label>
							<div class="controls">
								<sunivo:logisticsCompanySelect span="span10" name="entity.agentId" value="${entity.agentId}" placeHolderMessageCode="船公司" cusLogisticType="01" />
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" >航线类型<font style="color:red;">*</font>:</label>
							<div class="controls">
								<sunivo:shippinglineSelect span="span10" clazz="required"  name="entity.routeTypeId" value="${entity.routeTypeId}" placeHolderMessageCode="航线类型"/>
							</div>
						</div>
					</div>

					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" >生效日期<font style="color:red;">*</font>:</label>
							<div class="controls">
								<div class="span10 input-append date datetime-picker"
									data-date-minView="month" data-date-format="yyyy-mm-dd">
									<input class="span* required" type="text" id="entity.execDate" value="<f:formatDate value='${entity.execDate}' pattern='yyyy-MM-dd' />" name="entity.execDate"
										readonly placeholder="生效日期"> <span class="add-on"><i
										class="icon-remove"></i></span> <span class="add-on"><i
										class="icon-calendar"></i></span>
								</div>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" >失效日期<font style="color:red;">*</font>:</label>
							<div class="controls">
								<div class="span10 input-append date datetime-picker"
									data-date-minView="month" data-date-format="yyyy-mm-dd">
									<input class="span* required" type="text" id="entity.expiryDate"  value="<f:formatDate value='${entity.expiryDate}' pattern='yyyy-MM-dd' />" name="entity.expiryDate"
										readonly placeholder="失效日期"> <span class="add-on"><i
										class="icon-remove"></i></span> <span class="add-on"><i
										class="icon-calendar"></i></span>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" >状态:</label>
							<div class="controls">
								<select class="span10" name="entity.disabled" value="${entity.disabled}" >
										<option value="0" >有效</option>
										<option value="1" >无效</option>
									</select>
							</div>
						</div>
						<div class="span6 control-group">
							
						</div>
					</div>
					
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>备注</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span12 control-group">
							<label class="control-label">备注:</label>
							<div class="controls">
								<textarea class="span12" name="entity.remark" id="entity.remark" rows="6" maxlength="300"
									placeholder="备注">${entity.remark}</textarea>
									<span class="label label-warning pull-right">备注最多输入300个字符</span>
							</div>
						</div>
					</div>
					<input type="hidden" name="entity.id" value="${entity.id}">
					<input type="hidden" name="entity.createUserid" value="${entity.createUserid}">
					<input type="hidden" name="entity.createUsername" value="${entity.createUsername}">
					<input type="hidden" name="entity.createDatetimeStr" value="<f:formatDate value='${entity.createDatetime}' pattern='yyyy-MM-dd HH:mm:ss' />">
					<input type="hidden" name="entity.createIp" value="${entity.createIp}">
					<input type="hidden" name="entity.updateUserid" value="${entity.updateUserid}">
					<input type="hidden" name="entity.updateUsername" value="${entity.updateUsername}">
					<input type="hidden" name="entity.updateDatetimeStr" value="<f:formatDate value='${entity.updateDatetime}' pattern='yyyy-MM-dd HH:mm:ss' />">
					<input type="hidden" name="entity.updateIp" value="${entity.updateIp}">
				</div>
			</div>
		</form>
		<!-- 水平表单 end -->
	</div>

</body>
</html>