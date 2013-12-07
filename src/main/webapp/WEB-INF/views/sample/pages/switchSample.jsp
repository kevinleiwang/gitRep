<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>sunivo switch sample</title>
<script type="text/javascript">
	$(document).ready(function(){
		$(".make-switch").on("click", function(){
			console.log($("#check1").attr("checked"));
			console.log($("#check1").attr("checked"));
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
								<h3 style="color: #3CA2E3;">选择开关样例</h3>
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
								<li class="active">选择开关样例</li>
							</ul>
						</div>
					</div>
					<!-- 面包屑 end -->
					<div
						style="border-style: none solid solid; border-width: 0 1px 1px; border-color: #E2E2E2;">
						<div class="row-fluid">
							<div class="span12 control-group">
								<%-- data-on和data-off取值有permary,info,success,warning,danger,分别控制选中和未选中时样式 --%>
								<div class="make-switch" data-animated="false"
									data-on-label="选中" data-off-label="未选中" data-on="danger"
									data-off="success">
									<input id="check1" type="checkbox" checked />
								</div>
								<%-- data-on和data-off取值有permary,info,success,warning,danger,分别控制选中和未选中时样式 --%>
								<div class="make-switch" data-animated="false"
									data-on-label="选中" data-off-label="未选中" data-on="success"
									data-off="warning">
									<input id="check2" type="checkbox" checked disabled/>
								</div>
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