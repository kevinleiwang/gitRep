<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>sunivo tags sample</title>
</head>
<body>
	<!-- 流式布局，页面上部空出50px-->
	<div class="row-fluid sunivoPage">
		<!-- 水平表单 begin -->
		<form class="form-horizontal">
			<!-- 页面内容置中，左右各留span1 -->
			<div class="span10 offset1">
				<!-- 页头  begin -->
				<div class="row-fluid">
					<div class="span12 sunivoTitle">
						<div class="span6">
							<h1 class="pageTitle">自定义标签样例</h1>
						</div>
						<div class="span6" align="right">
							
						</div>
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
							<li class="active">自定义标签样例</li>
						</ul>
					</div>
				</div>
				<!-- 面包屑 end -->
				<div class="sunivoBorder">
					
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5 >下拉列表自定义标签样例</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span12 control-group" >
							<div id="select_container" class="portlet-body lazy-section"
										base-url="${ctx}/sample/selectTagsSampleSection"></div>
						</div>
						
					</div>
					
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5 >单选按钮自定义标签样例</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span12 control-group" >
							<div id="radio_container" class="portlet-body lazy-section"
										base-url="${ctx}/sample/radioTagsSampleSection"></div>
						</div>
						
					</div>
					
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5 >展示自定义标签样例</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span12 control-group" >
							<div id="view_container" class="portlet-body lazy-section"
										base-url="${ctx}/sample/viewTagsSampleSection"></div>
						</div>
						
					</div>
					
					
				</div>
			</div>
		</form>
		<!-- 水平表单 end -->
	</div>

</body>
</html>