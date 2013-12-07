<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>sunivo menu sample</title>
</head>
<body>
		<div class="row-fluid sunivoPage">
			<!-- 水平表单 begin -->
			<form class="form-horizontal valid" name="saveSample" method="post">
				<!-- 页面内容置中，左右各留span1 -->
				<div class="span10 offset1">
					<!-- 页头  begin -->
					<div class="row-fluid">
						<div class="span12 sunivoTitle">
							<div class="span6">
								<h1 class="pageTitle">MENU样例</h1>
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
								<li><a href="${ctx}/sample/listSample2">样例列表</a> <span
									class="divider">/</span></li>
								<li class="active">MENU样例</li>
							</ul>
						</div>
					</div>
					<!-- 面包屑 end -->
					<div class="sunivoBorder">
						<!-- 片段头 begin -->
						<div class="sectionTitle">
							<h5>一级菜单：（将代码拷贝到topbar.jsp，格式化即可）</h5>
						</div>
						<!-- 片段头 end -->
						<div class="row-fluid">
							<div class="span12 control-group">
								<pre>&lt;li&gt;&lt;a href="${ctx}/"&gt;一级菜单名&lt;/a&gt;&lt;/li&gt;</pre>
							</div>
						</div>
						
						<!-- 片段头 begin -->
						<div class="sectionTitle">
							<h5>二级菜单：（将代码拷贝到topbar.jsp，格式化即可）</h5>
						</div>
						<!-- 片段头 end -->
						<div class="row-fluid">
							<div class="span12 control-group">
								<pre>
									&lt;li class="dropdown"&gt;
										&lt;a href="#" data-toggle="dropdown"&gt;
												&lt;span>一级菜单名&lt;/span&gt; 
												&lt;i class="icon-angle-down"&gt;&lt;/i&gt;
										&lt;/a&gt;
										&lt;ul class="dropdown-menu"&gt;
											&lt;li&gt;&lt;a href="${ctx}/" title="二级菜单名">二级菜单名&lt;/a&gt;&lt;/li&gt;
											&lt;li&gt;&lt;a href="${ctx}/" title="二级菜单名">二级菜单名&lt;/a&gt;&lt;/li&gt;
											&lt;li&gt;&lt;a href="${ctx}/" title="二级菜单名">二级菜单名&lt;/a&gt;&lt;/li&gt;
											&lt;li&gt;&lt;a href="${ctx}/" title="二级菜单名">二级菜单名&lt;/a&gt;&lt;/li&gt;
										&lt;/ul&gt;
									&lt;/li&gt;
								</pre>
							</div>
						</div>
						
						<!-- 片段头 begin -->
						<div class="sectionTitle">
							<h5>三级菜单：（将代码拷贝到topbar.jsp，格式化即可）</h5>
						</div>
						<!-- 片段头 end -->
						<div class="row-fluid">
							<div class="span12 control-group">
								<pre>
									&lt;li class="dropdown"&gt;
										&lt;a href="#" data-toggle="dropdown"&gt;
											&lt;span>一级菜单名&lt;/span&gt;
											&lt;i class="icon-angle-down"&gt;&lt;/i&gt;
										&lt;/a&gt;
										&lt;ul class="dropdown-menu"&gt;
											&lt;li class="dropdown-submenu"&gt;
											    &lt;a data-toggle="dropdown" href="#"&gt;二级菜单名&lt;/a&gt;
												&lt;ul class="dropdown-menu"&gt;
													&lt;li&gt;&lt;a href="${ctx}/" title="三级菜单名">三级菜单名&lt;/a&gt;&lt;/li&gt;
													&lt;li&gt;&lt;a href="${ctx}/" title="三级菜单名">三级菜单名&lt;/a&gt;&lt;/li&gt;
													&lt;li&gt;&lt;a href="${ctx}/" title="三级菜单名">三级菜单名&lt;/a&gt;&lt;/li&gt;
													&lt;li&gt;&lt;a href="${ctx}/" title="三级菜单名">三级菜单名&lt;/a&gt;&lt;/li&gt;
												&lt;/ul&gt;
											&lt;/li&gt;
										&lt;/ul&gt;
									&lt;/li&gt;
							</pre>
							</div>
						</div>
					</div>
 					<div id="error_message" ></div>
				</div>
			</form>
			 
			<!-- 水平表单 end -->
	</div>
</body>
</html>