<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>sunivo list sample</title>
<script type="text/javascript">
	$(document).ready(function() {
		$("#deleteObj").click(function() {
			SunivoUtil.createModal("删除#One-Object#", //标题
			/* $("#popDivSection").html(),//弹出框内容 */
			"您确认删除#One-Object#？",
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
					<div class="span3">
						<h1 class="pageTitle">列表样例</h1>
					</div>
					<div class="span5">
						<span> 共计 <font class="statistics">10</font>个样例： <font
							class="statistics">6</font>个列表， <font class="statistics">4</font>个表单
						</span>

					</div>
					<div class="span4" align="right">
						<span> <i class="pull-right icon-plus icon-2x pointer"
							style="margin-right: 15px;"></i>
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
						<li><a href="${ctx}/sample/listSample2">列表样例</a> <span class="divider">/</span></li>
						<li class="active">列表样例</li>
					</ul>
				</div>
			</div>
			<!-- 面包屑 end -->

			<!-- 水平表单 begin -->
			<form class="form-horizontal">

				<div class="sunivoFilterForm" >
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
									style="margin-right: 15px;"></i>
								</span>
							</div>

						</div>
					</div>
				</div>
			</form>
			<!-- 水平表单 end -->
			<div class="sunivoList">
				<!-- FOR begin-->
				<div class="row-fluid">
					<div class="span12">
						<!-- 最左列，通常放入可唯一识别当前记录的字段，比如客户名，如没有，可放入ID -->
						<div class="number span2">
							<span> <a href="#" title="标识：如姓名，公司名等可以说明一个个体的属性">标识：如姓名，公司名等可以说明一个个体的属性</a>
							</span>
						</div>
						<!-- 记录要展示的数据，此处按列排，不是按行排 -->
						<div class="content span9">
							<div class="row-fluid">
								<!-- 第一 列 -->
								<div class="span4">
									<dl class="dl-horizontal">
										<dt>key：</dt>
										<dd>value</dd>
										<dt>key：</dt>
										<dd>value</dd>
										<dt>key：</dt>
										<dd>value</dd>
										<dt>key：</dt>
										<dd>value</dd>
									</dl>
								</div>
								<!-- 第二 列 -->
								<div class="span4">
									<dl class="dl-horizontal">
										<dt>key：</dt>
										<dd>value</dd>
										<dt>key：</dt>
										<dd>value</dd>
										<dt>key：</dt>
										<dd>value</dd>
										<dt>key：</dt>
										<dd>value</dd>
									</dl>
								</div>
								<!-- 第三 列 -->
								<div class="span4">
									<dl class="dl-horizontal">
										<dt></dt>
										<dd></dd>
										<dt></dt>
										<dd></dd>
										<dt>创建人：</dt>
										<dd>王磊</dd>
										<dt>创建时间：</dt>
										<dd>2013-10-28 10:20:30</dd>
									</dl>
								</div>
							</div>
						</div>
						<!-- 操作按钮 
							说明：
							   按钮每行至多放三个，超过三个，请用<br>换行，间隔15px
							-->
						<div class="action span1">
							<span> 
								<i class="icon-retweet pointer pull-left" style="margin-left:15px;" title="提示" onclick=""></i> 
								<i class="icon-reply pointer pull-left" style="margin-left:15px;" title="提示" onclick=""></i>
								<i class="icon-phone pointer pull-left" style="margin-left:15px;" title="提示" onclick=""></i>
								<br> 
								<i class="icon-minus pointer pull-left" style="margin-left:15px;" title="删除" id="deleteObj"></i> 
								<i class="icon-edit pointer pull-left" style="margin-left:15px;" title="编辑" onclick=""></i>
							</span>

						</div>
					</div>
				</div>
				<!-- FOR end-->
			</div>
			<!-- 分页 -->
			<div class="row-fluid">
				<div class="span12">
					<div class="span4">
						<div style="margin-top: 8px;">显示1-10, 共285条</div>
					</div>
					<div class="span8">
						<div class="pagination pull-right">
							<ul>
								<li class='prev disabled'><a href='#'>←上一页</a></li>
								<li class="active"><a href='#'>1</a></li>
								<li class=""><a href='javascript:turn2Page(2);'>2</a></li>
								<li class=""><a href='javascript:turn2Page(3);'>3</a></li>
								<li class=""><a href='javascript:turn2Page(4);'>4</a></li>
								<li class=""><a href='javascript:turn2Page(5);'>5</a></li>
								<li class=""><a href='javascript:turn2Page(6);'>6</a></li>
								<li><a href='#'>...</a></li>
								<li><a href='javascript:turn2Page(29);'>29</a></li>
								<li class="next"><a href='javascript:turn2Page(2);'>下一页→</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>


	</div>
	<div id="popDivSection" class="modal hide fade">
		您确认删除#One-Object#？</div>
</body>
</html>
