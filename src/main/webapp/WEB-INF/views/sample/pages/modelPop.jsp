<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>sunivo model pop sample</title>
<script type="text/javascript">
	$(document).ready(
			function() {
				var $popDivSection = $("#popDivSection");
				$("#pop").click(
						function() {
							SunivoUtil.createRemoteModal("测试弹窗",
									"${ctx}/sample/testPopSection", {},
									function() {
										return true;
									}, "OK", "", "点我就取消了", "btn-danger");
						});
				$("#popDiv").click(
						function() {
							$popDivSection.load("${ctx}/sample/testPopSection",
									{}, function() {
										var $this = $(this);
										Sunivo.initContext($this);
										$this.modal("show");
									}, "OK");
						});
				$("#popLocal").click(
						function() {
							SunivoUtil.createModal("测试弹出本地DIV", $(
									"#popDivSection").html(), function() {
								console.log("提交数据");
								return true;
							}, "OK", "btn-inverse");
						});
				
				$("#popValidate").click(
						function() {
							SunivoUtil.createRemoteModal("弹窗验证提交",
									"${ctx}/sample/testPopValidateSection", {},
									function() {
										var validValue = $('#testForm').valid();
										console.log('验证结果='+validValue);
										return false;
									}, "OK", "", "点我就取消了", "btn-danger");
						});
			});
</script>
</head>
<body>
	<!-- 流式布局，页面上部空出50px-->
	<div class="container-fluid" style="margin-top: 50px;">
		<div class="row-fluid">
			<!-- 水平表单 begin -->
			<form class="form-horizontal">
				<!-- 页面内容置中，左右各留span1 -->
				<div class="span10 offset1">
					<!-- 页头  begin -->
					<div class="row-fluid">
						<div class="span12">
							<div class="span6">
								<h3 style="color: #3CA2E3;">模态框样例</h3>
							</div>
							<div class="span6" align="right"></div>
						</div>
					</div>
					<!-- 页头  end -->
					<!-- 面包屑 begin -->
					<div class="row-fluid">
						<div class="span12">
							<ul class="breadcrumb">
								<li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
								<li><a href="${ctx}/sample/listSample2">样例</a> <span
									class="divider">/</span></li>
								<li class="active">模态框样例</li>
							</ul>
						</div>
					</div>
					<!-- 面包屑 end -->
					<div
						style="border-style: none solid solid; border-width: 0 1px 1px; border-color: #E2E2E2;">
						<div class="row-fluid">
							<div class="span12 control-group">
								<div class="portlet box grey">
									<div class="portlet-title">
										<h4>明细列表</h4>
										<div class="tools">
											<a href="#" id="pop">弹窗(加载远程页面)</a>&nbsp;&nbsp;&nbsp;&nbsp;<a
												href="#" id="popDiv">DIV弹窗(加载远程页面)</a> 
												<a href="#" id="popLocal">弹出本地弹窗</a> 
												<a href="#" id="popValidate">弹窗验证提交</a>
												<a class="collapse"
												href="javascript:;"></a>
										</div>
									</div>
									<div id="detail_list_container"
										class="portlet-body lazy-section"
										base-url="${ctx}/sample/testPopSection"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
			<!-- 水平表单 end -->
		</div>
	</div>
	<div id="popDivSection" class="modal hide fade" aria-hidden="true"
		style="width: 450px;" role="dialog" aria-labelledby="modal_title"></div>
</body>
</html>