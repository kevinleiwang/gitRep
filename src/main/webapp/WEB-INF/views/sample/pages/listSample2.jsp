<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>sunivo list sample</title>
<script type="text/javascript">
	$(document).ready(function() {
		$("#deleteObj").click(function() {
			SunivoUtil.createModal("删除#One-Object#", //标题
			$("#popDivSection").html(),//弹出框内容
			function() {
				console.log("在这儿，提交数据");
				return true;
			}, //回调函数
			"确认");//确认按钮上面的文本
		});
	});
</script>
</head>
<body>
	<!-- 流式布局，页面上部空出50px-->
	<div class="row-fluid sunivoPage">
		<!-- 页面内容置中，左右各留span1 -->
		<div class="span10 offset1">
			<!-- 页头  begin -->
			<div class="row-fluid">
				<div class="sunivoTitle span12">
					<div class="span2">
						<h1 class="pageTitle">列表样例</h1>
					</div>
					<div class="span6">
						<span> 共计 <font class="statistics">10</font>个样例： <font
							class="statistics">6</font>个列表， <font class="statistics">4</font>个表单
						</span>

					</div>
					<div class="span4" align="right">
						<span> <i class="pull-right icon-plus icon-2x pointer"
							style="margin-right: 10px;"></i>
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
						<li class="active">列表样例</li>
					</ul>
				</div>
			</div>
			<!-- 面包屑 end -->

			<!-- 水平表单 begin -->
			<form class="form-horizontal">

				<div class="sunivoFilterForm">
					<div class="row-fluid">
						<div class="span12">
							<div class="span11 filterCondition">
								<span> <input type="text" class="span2"
									placeholder="检索条件"> <input type="text" class="span2"
									placeholder="检索条件"> <input type="text" class="span2"
									placeholder="检索条件"> <input type="text" class="span2"
									placeholder="检索条件"> <input type="text" class="span2"
									placeholder="检索条件"> <input type="text" class="span2"
									placeholder="检索条件"> <input type="text" class="span2"
									placeholder="检索条件"> <input type="text" class="span2"
									placeholder="检索条件"> <input type="text" class="span2"
									placeholder="检索条件">
								</span>
							</div>
							<div class="span1 filterAction">
								<span> <i class="pull-right icon-search icon-2x pointer"
									style="margin-right: 10px;"></i>
								</span>
							</div>

						</div>
					</div>
				</div>
			</form>
			<!-- 水平表单 end -->
			<!-- 片段头 begin -->
			<div class="sectionTitle">
				<h5>我的样例</h5>
			</div>
			<!-- 片段头 end -->
			<div>
				<table class="table table-hover">
					<!-- 标题可根据实际需要决定要不要 -->
					<!-- <caption >标题</caption> -->
					<!-- 表头可根据实际需要决定要不要 -->
					<thead>
						<tr>
							<th>样例名称</th>
							<th>样例链接</th>
							<th>样例描述</th>
							<th>样例作者</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>菜单代码样例</td>
							<td><a href="${ctx}/sample/menuSample">${ctx}/sample/menuSample</a></td>
							<td>提供一级，二级，三级菜单代码样例</td>
							<td>wanglei</td>
						</tr>
						<tr>
							<td>列表样例</td>
							<td><a href="${ctx}/sample/listSample">${ctx}/sample/listSample</a></td>
							<td>标准列表页面，若采用此页面，请严格按照此页面的标准（包括删除方法）</td>
							<td>wanglei</td>
						</tr>
						<tr>
							<td>列表样例2</td>
							<td><a href="${ctx}/sample/listSample2">${ctx}/sample/listSample2</a></td>
							<td>列表页面2，其实也就是本页面，主要用于详情页面下面的附属信息展示</td>
							<td>wanglei</td>
						</tr>
						<tr>
							<td>表单样例</td>
							<td><a href="${ctx}/sample/formSample">${ctx}/sample/formSample</a></td>
							<td>此表单主要提供变淡页面的基本样式和基本的标签</td>
							<td>wanglei</td>
						</tr>
						<tr>
							<td>HESSIAN样例</td>
							<td><a href="${ctx}/sample/hessionSample">${ctx}/sample/hessionSample</a></td>
							<td>提供hession的用法</td>
							<td>nirui & tianlijia</td>
						</tr>
						<tr>
							<td>警告弹窗样例</td>
							<td><a href="${ctx}/sample/alertMessage">${ctx}/sample/alertMessage</a></td>
							<td>提供后端警告信息展示的用法</td>
							<td>chengjianfang</td>
						</tr>
						<tr>
							<td>手工警告弹窗样例</td>
							<td><a href="#">点击菜单"人名"中的个人中心,分别输入111,222,333提交时可以看到</a></td>
							<td>提供JS将警告信息写入页面元素的用法</td>
							<td>chengjianfang</td>
						</tr>
						<tr>
							<td>模态弹窗样例</td>
							<td><a href="${ctx}/sample/modelPop">${ctx}/sample/modelPop</a></td>
							<td>提供模态弹窗的用法(加载本地DIV,加载远程页面,展示本地DIV)</td>
							<td>chengjianfang</td>
						</tr>
						<tr>
							<td>选择开关样例</td>
							<td><a href="${ctx}/sample/switchSample">${ctx}/sample/switchSample</a></td>
							<td>提供选择开关的样例，<font color="red">目前无法让复选框同样被修改，需要进一步处理</font></td>
							<td>chengjianfang</td>
						</tr>
						<tr>
							<td>自定义标签样例</td>
							<td><a href="${ctx}/sample/tagsSample">${ctx}/sample/tagsSample</a></td>
							<td>提供下拉列表、单选框、展示等自定义标签的样例</td>
							<td>chengjianfang</td>
						</tr>
						
					</tbody>
				</table>
			</div>
		</div>


	</div>
	<div id="popDivSection" class="modal hide fade">
		您确认删除#One-Object#？</div>
</body>
</html>
