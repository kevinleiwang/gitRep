<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>优势航线新增</title>
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
<script type="text/javascript">
	$(function(){
		function checkPortRepeat(element){
			var shipmentPortId = $("select[name='entity\\.shipmentPortId']").val();
			var destPortId = $("select[name='entity\\.destinationPortId']").val();
			if(shipmentPortId == destPortId && destPortId != ''){
				//alert("不能相同啊");
				SunivoUtil.showAlertMessage("#message","起运港和目的港不能相同，请重新选择！",5);
				element.val('');
				element.trigger("chosen:updated.chosen");	 
			}
		}
		
		
		$("select[name='entity\\.shipmentPortId']").chosen().change(function(){
			checkPortRepeat($(this));
		});
		$("select[name='entity\\.destinationPortId']").chosen().change(function(){
			checkPortRepeat($(this));
		});
	});
</script>
	<!-- 流式布局，页面上部空出50px-->
	<div class="row-fluid sunivoPage">
		<!-- 水平表单 begin -->
		<form id="input_form" class="form-horizontal valid" action="${ctx}/lgsadvantagerouteset" method="post">
			<!-- 页面内容置中，左右各留span1 -->
			<div class="span10 offset1">
				<div id="message"></div>
				<sunivo:flushMessage/>
				<!-- 页头  begin -->
				<div class="row-fluid">
					<div class="span12 sunivoTitle">
						<div class="span6">
							<h1 class="pageTitle">优势航线新增</h1>
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
							<li class="active">优势航线新增</li>
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
								<sunivo:shipPortSelect span="span10" clazz="required" value="${entity.shipmentPortId }" name="entity.shipmentPortId"   placeHolderMessageCode="起运港"/>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" >目的港:</label>
							<div class="controls">
								<sunivo:shipPortSelect span="span10" value="${entity.destinationPortId }" name="entity.destinationPortId" placeHolderMessageCode="目的港"/>
							</div>
						</div>
					</div>

					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" >船公司:</label>
							<div class="controls">
								<sunivo:logisticsCompanySelect span="span10" value="${entity.agentId }" name="entity.agentId" placeHolderMessageCode="船公司" cusLogisticType="01" />
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" >航线类型<font style="color:red;">*</font>:</label>
							<div class="controls">
								<sunivo:shippinglineSelect span="span10" clazz="required" value="${entity.routeTypeId }" name="entity.routeTypeId" placeHolderMessageCode="航线类型"/>
							</div>
						</div>
					</div>

					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" >生效日期<font style="color:red;">*</font>:</label>
							<div class="controls">
								<div class="span10 input-append date datetime-picker"
									data-date-minView="month" data-date-format="yyyy-mm-dd">
									<input class="span* required" type="text" id="entity.execDate" name="entity.execDate" value="<f:formatDate value='${entity.execDate}' pattern='yyyy-MM-dd' />"
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
									<input class="span* required" type="text"  id="entity.expiryDate" name="entity.expiryDate" value="<f:formatDate value='${entity.expiryDate}' pattern='yyyy-MM-dd' />"
										readonly placeholder="失效日期"> <span class="add-on"><i
										class="icon-remove"></i></span> <span class="add-on"><i
										class="icon-calendar"></i></span>
								</div>
							</div>
						</div>
					</div>
					
				<!-- 	<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" >状态:</label>
							<div class="controls">
								<select class="span10"  id="entity.disabled" name="entity.disabled">
									<option value="0" >有效</option>
									<option value="1" >无效</option>
								</select>
							</div>
						</div>
						<div class="span6 control-group">
							
						</div>
					</div> -->
					<!-- 状态默认为无效 -->
					<input type="hidden" value="2" name="entity.disabled">
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>备注</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span12 control-group">
							<label class="control-label">备注:</label>
							<div class="controls">
								<textarea class="span12" name="entity.remark" id="entity.remark" rows="6" maxlength="300" value="${entity.remark }"
									placeholder="备注"></textarea>
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