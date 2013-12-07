<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>sunivo alert message sample</title>
<script type="text/javascript">
	$(document).ready(function() {
		$(".btn").click(function() {
			var level = $(this).attr("data-level");
			var levelArg = "";
			if (level != undefined) {
				levelArg = "?levelStr=" + level;
			}
			window.location = "${ctx}/sample/alertMessage" + levelArg;
		});
	});
</script>
</head>
<body>
	<sunivo:flushMessage />
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
								<h3 style="color: #3CA2E3;">警告弹窗样例</h3>
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
								<li class="active">警告弹窗样例</li>
							</ul>
						</div>
					</div>
					<!-- 面包屑 end -->
					<div
						style="border-style: none solid solid; border-width: 0 1px 1px; border-color: #E2E2E2;">
						<div class="row-fluid">
							<div class="span12 control-group">
								<!-- data-level不是标准属性，用于演示时获取展示的消息级别 -->
								<button type="button" class="btn btn-default"
									data-level="default">默认(弹出默认消息)</button>
								<button type="button" class="btn btn-primary">主要(弹出简单消息)</button>
								<button type="button" class="btn btn-success"
									data-level="success">成功(弹出成功级别消息)</button>
								<button type="button" class="btn btn-info" data-level="info">信息(弹出信息级别消息)</button>
								<button type="button" class="btn btn-warning" data-level="warn">警告(弹出警告级别消息)</button>
								<button type="button" class="btn btn-danger" data-level="error">危险(弹出错误级别消息)</button>
								<button type="button" class="btn btn-link" data-level="all">连接(弹出多条信息级别消息)</button>
							</div>
						</div>
						<sunivo:flushMessage />
						<div class="row-fluid">
							<div class="span12 control-group">
								<font color="red">
									<h2 >说明：<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;凡是使用此框架的系统，不允许出现alert（）弹出信息，否则会导致系统整体风格一致性的破坏，谢谢合作。</h2>
								</font>
							</div>
						</div>
					</div>
				</div>
			</form>
			<!-- 水平表单 end -->
		</div>
	</div>
</body>
</html>