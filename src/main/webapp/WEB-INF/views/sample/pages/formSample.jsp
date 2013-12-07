<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>sunivo form sample</title>
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
							<h1 class="pageTitle">表单样例</h1>
						</div>
						<div class="span6" align="right">
							<i class="pull-right icon-minus icon-2x pointer" style="margin-right: 15px;"></i> 
							<i class="pull-right icon-save icon-2x pointer" style="margin-right: 20px;"></i> 
							<i class="pull-right icon-edit icon-2x pointer" style="margin-right: 20px;"></i> 
							<i class="pull-right icon-plus icon-2x pointer" style="margin-right: 20px;"></i>
							<!-- <a href="#" class="btn btn-info pull-righ">按钮</a> 
							<a href="#" class="btn btn-info pull-righ disabled">禁用按钮</a> -->
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
							<li class="active">表单样例</li>
						</ul>
					</div>
				</div>
				<!-- 面包屑 end -->
				<div class="sunivoBorder">
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>输入框</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="input1">普通文本</label>
							<div class="controls">
								<input type="text" class="span10" id="input1" placeholder="普通文本">
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="input2">必填项<span
								style="color: red;">*</span></label>
							<div class="controls">
								<input type="text" class="span10" required id="input2"
									placeholder="必填项">
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="appendedInput">小尾巴</label>
							<div class="controls">
								<div class="span10 input-append">
									<input class="span*" type="text" id="appendedInput"
										placeholder="小尾巴"> <span class="add-on">.00</span>
								</div>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="appendedInput2">小尾巴2</label>
							<div class="controls">
								<div class="span10 input-append">
									<input class="span*" type="text" id="appendedInput2"
										placeholder="小尾巴2"> <span class="add-on">人民币</span>
								</div>
							</div>
						</div>
					</div>
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>基本校验</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="inputEmail">邮箱</label>
							<div class="controls">
								<input class="span10" type="email" required
									placeholder="example@example.com">
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="inputPassword">被禁用的输入框</label>
							<div class="controls">
								<input class="span10" id="disabledInput" type="text"
									placeholder="被禁用的输入框" disabled>
							</div>
						</div>
						</div>
						<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="inputURL">URL</label>
							<div class="controls">
								<input class="span10" type="url" 
									placeholder="http://">
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="inputNumber">number</label>
							<div class="controls">
								<input class="span10" type="number" 
									placeholder="">
							</div>
						</div>
					</div>
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5 >文本域</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="testarea1">文本域</label>
							<div class="controls">
								<textarea class="span10" id="testarea1" rows="3"
									placeholder="根据您实际的情况设置rows"></textarea>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label" for="testarea2">文本域</label>
							<div class="controls">
								<textarea class="span10" id="testarea2" rows="3"
									placeholder="根据您实际的情况设置rows"></textarea>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span12 control-group">
							<label class="control-label" for="testarea3">文本域</label>
							<div class="controls">
								<textarea class="span12" id="testarea3" rows="3"
									placeholder="根据您实际的情况设置rows"></textarea>
							</div>
						</div>
					</div>
					<!-- 片段头 begin -->
					<div class="sectionTitle">
						<h5>日期/时间</h5>
					</div>
					<!-- 片段头 end -->
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="inputDate">日期</label>
							<div class="controls">
								<div class="span10 input-append date datetime-picker"
									data-date-minView="month">
									<input class="span*" type="text" value="" id="inputDate"
										readonly placeholder="日期"> <span class="add-on"><i
										class="icon-remove"></i></span> <span class="add-on"><i
										class="icon-calendar"></i></span>
								</div>
							</div>
						</div>

						<div class="span6 control-group">
							<label class="control-label" for="inputDate">时间</label>
							<div class="controls">
								<div class="span10 input-append date datetime-picker">
									<input class="span*" type="text" value="" id="inputDate"
										readonly placeholder="时间"> <span class="add-on"><i
										class="icon-remove"></i></span> <span class="add-on"><i
										class="icon-calendar"></i></span>
								</div>
							</div>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label" for="inputDate">到某一时间截止</label>
							<div class="controls">
								<div class="span10 input-append date datetime-picker"
									data-date-minView="month" date-endDate="2014-01-01 00:00:00">
									<input class="span*" type="text" value="" id="inputDate"
										readonly placeholder="只能选2014-01-01 00:00:00之前的时间"> <span
										class="add-on"><i class="icon-remove"></i></span> <span
										class="add-on"><i class="icon-calendar"></i></span>
								</div>
							</div>
						</div>

						<div class="span6 control-group">
							<label class="control-label" for="inputDate">从某一时间开始</label>
							<div class="controls">
								<div class="span10 input-append date datetime-picker"
									date-startDate="2014-01-01 00:00:00">
									<input class="span*" type="text" value="" id="inputDate"
										readonly placeholder="只能选2014-01-01 00:00:00之后的时间"> <span
										class="add-on"><i class="icon-remove"></i></span> <span
										class="add-on"><i class="icon-calendar"></i></span>
								</div>
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