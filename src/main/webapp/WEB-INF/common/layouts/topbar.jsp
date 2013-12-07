<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<!-- HEADER START -->
<div class="navbar navbar-inverse navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container${fluid}">
			<div class="row${fluid}">
				<div class="span10 offset1">
					<a href="${ctx}" class="brand"> <i class="icon-flag"
						style="vertical-align: middle;"></i> Sunivo Lgs
					</a>
					<div class="nav-collapse collapse">
						<ul class="nav" role="menu" aria-labelledby="dLabel">

							<li><a href="${ctx}/">首页</a></li>
							<!-- <li><a href="${ctx}/sample/listSample2">样例</a></li> -->
							<li class="dropdown">
								<a href="#" data-toggle="dropdown"> 
									<span>海运整箱管理</span> 
									<i class="icon-angle-down"></i>
								</a>
								<ul class="dropdown-menu">
									<li class="divider"></li>
									<li><a href="${ctx}/lgsfclquoteinfo?search_EQ_status=0" title="海运费" ><i class="icon-money"></i>&nbsp;海运费管理</a></li>
									<li><a href="${ctx}/lgsport?search_EQ_status=0" title="本地费"><i class="icon-money"></i>&nbsp;本地费管理</a></li>
									<li><a href="${ctx}/lgsaddationquoteinfo?search_EQ_status=0" title="附加费"><i class="icon-money"></i>&nbsp;附加费管理</a></li>
									<li class="divider"></li>
									<li><a href="${ctx}/lgsadvantagerouteset?search_EQ_disabled=0" title="优势航线"><i class="icon-tasks"></i>&nbsp;优势航线管理</a></li>
								</ul></li> 
							<%-- <li><a href="${ctx}/lgsinquiry/">物流询价管理</a></li> --%>
							<li class="dropdown">
								<a href="#" data-toggle="dropdown"> 
									<span>销售价制作</span> 
									<i class="icon-angle-down"></i>
								</a>
								<ul class="dropdown-menu">
									<li class="divider"></li>
									<li><a href="${ctx}/lgsrouteadditionquote?search_EQ_status=0" tittle="按航线销售价制作"><i class="icon-cogs"></i>&nbsp;按航线销售价制作</a></li>
									<%-- <li><a href="${ctx}/lgsadditionquote/inquiryList" tittle="按票销售价制作"><i class="icon-cog"></i>&nbsp;按票销售价制作</a></li> --%>
								</ul>
							</li>
							<%-- <li class="dropdown"><a href="#" data-toggle="dropdown"> 
									<span>海整费用</span> <i class="icon-angle-down"></i>
							</a>
								<ul class="dropdown-menu">
									<li class="divider"></li>
									<li><a href="${ctx}/lgsfclquoteinfo" title="海运费"><i class="icon-money"></i>&nbsp;海运费</a></li>
									<li><a href="${ctx}/lgsport/" title="本地费"><i class="icon-money"></i>&nbsp;本地费</a></li>
									<li><a href="${ctx}/lgsaddationquoteinfo/" title="附加费"><i class="icon-money"></i>&nbsp;附加费</a></li>
									<li class="divider"></li>
									<li><a href="${ctx}/lgsrouteadditionquote/" title="销售价制作"><i class="icon-money"></i>&nbsp;销售价制作</a></li>
								</ul></li>  --%>
						</ul>
						<ul class="nav pull-right">
							<li class="dropdown pull-right"><a href="#"
								data-toggle="dropdown" style="padding: 8px 15px;"> <span
									class="message" title="<sunivo:username />"><sunivo:username /></span>
									<i class="icon-angle-down"></i>
							</a>
								<ul class="dropdown-menu">
									<%-- <li><a href="#" id="userProfile"><i class="icon-cog"></i>&nbsp;个人中心</a></li> --%>
									<li><a href="${ctx}/logout"><i class="icon-off"></i>&nbsp;退出</a></li>
								</ul></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$("#userProfile")
								.click(
										function() {
											SunivoUtil
													.createRemoteModal(
															"个人中心",
															"${ctx}/commons/userProfileSection",
															{},
															function() {
																var validateValue = $(
																		"#changePasswordForm")
																		.valid();
																if (validateValue) {
																	var oldPassword = $(
																			"#oldPassword")
																			.val();
																	var password = $(
																			"#password")
																			.val();
																	var confirmPassword = $(
																			"#confirmPassword")
																			.val();
																	$
																			.ajax({
																				url : "${ctx}/commons/changePassword",
																				data : {
																					"oldPassword" : oldPassword,
																					"password" : password,
																					"confirmPassword" : confirmPassword
																				},
																				dataType : "json",
																				type : "GET",
																				contentType : "text/html; charset=UTF-8",
																				error : function() {
																					console
																							.log("error");
																				},
																				success : function(
																						data) {
																					var status = data.status;
																					var message = data.message;
																					// 修改成功，关闭对话框
																					if (0 == status) {

																						$(
																								"#modal_dialog")
																								.modal(
																										"hide");
																					} else {
																						// 弹出消息
																						SunivoUtil
																								.showAlertMessage(
																										$("#userProfileMessage"),
																										message,
																										"error");
																					}
																				},
																			});
																	return false;
																} else {
																	return false;
																}
															}, "修改密码");
										});
					});
</script>
<!-- HEADER END -->