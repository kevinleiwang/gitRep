<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>${entity.id}</title>
<script type="text/javascript">
	$(document).ready(
			function() {
				var $popDivSection = $("#popDivSection");
				$("#pop").click(
						function() {
							createRemoteModal("测试弹窗",
									"${ctx}/sample/testPopSection", {},
									function() {
										return true;
									}, "关闭");
						});
				$("#popDiv").click(
						function() {
							$popDivSection.load(
									"${ctx}/sample/testPopSection", {},
									function() {
										var $this = $(this);
										//Sunivo.initContext($this);
										$this.modal("show");
									}, "关闭");
						});
			});
</script>
</head>
<body>
	<form id="input_form" class="form-horizontal valid"
		action="${ctx}/sample<c:if test="${action=='edit'}">/${entity.id}</c:if>"
		method="post">
		<input name="id" id="id" value="${entity.id}" type="hidden" />
		<token:token />
		<div class="row${fluid}">
			<div class="span12">
				<h3 class="page-title">${entity.id}</h3>
			</div>
		</div>

		<div class="row${fluid}">
			<div class="span12">
				<div class="portlet-header">
					<div class="operation-btn pull-right">
						<c:choose>
							<c:when test="${action=='edit'}">
								<button class="btn blue" type="submit">
									<i class="icon-save"></i>&nbsp;保存
								</button>
								<a href="${ctx}/sample/${entity.id}" class="btn gray"><i
									class="icon-mail-reply"></i>&nbsp;取消</a>
							</c:when>
							<c:when test="${action=='create'}">
								<button class="btn blue">
									<i class="icon-save"></i>&nbsp;保存
								</button>
								<a href="${ctx}/sample" class="btn gray"><i
									class="icon-mail-reply"></i>&nbsp;返回</a>
							</c:when>
							<c:otherwise>
								<a href="${ctx}/sample/${entity.id}?action=edit"
									class="btn blue"><i class="icon-edit"></i>&nbsp;编辑</a>
								<a href="${ctx}/sample" class="btn gray"><i
									class="icon-mail-reply"></i>&nbsp;返回</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<sunivo:flushMessage />
				<div class="portlet box grey">
					<div class="portlet-title">
						<h4>
							用户表详情&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" id="pop">弹窗</a>&nbsp;&nbsp;&nbsp;&nbsp;<a
								href="#" id="popDiv">DIV弹窗</a>
						</h4>
					</div>
					<div class="portlet-body form">
						<input name="entity.id" type="hidden" value="${entity.id}" />
						<div class="row-fluid">
							<div class="span6 control-group">
								<label class="control-label">姓名:</label>

								<div class="controls">
									<c:choose>
										<c:when test="${action=='create' || action=='edit'}">
											<input type="text" id="entity.name" name="entity.name"
												value="${entity.name}" required="required"
												placeholder="模拟文本框空白时提示输入" />
											<font color="red"><form:errors
													path="testUserVo.entity.name" /></font>
										</c:when>
										<c:otherwise>
											<span class="inline">${entity.name}&nbsp;</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="span6 control-group">
								<label class="control-label">性别:</label>

								<div class="controls">
									<c:choose>
										<c:when test="${action=='create' || action=='edit'}">
											<sunivo:sexRadioTag required="true" name="entity.sex"
												value="${entity.sex}" />
											<font color="red"><form:errors
													path="testUserVo.entity.sex" /></font>
										</c:when>
										<c:otherwise>
											<span class="inline">${entity.sex.name}&nbsp;</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span6 control-group">
								<label class="control-label">生日:</label>

								<div class="controls">
								    <fmt:formatDate value="${entity.birthDay}" pattern="yyyy-MM-dd" var="birthDay" />
									<c:choose>
										<c:when test="${action=='create' || action=='edit'}">
											<div class="input-append date date-picker" data-date=""
												data-date-format="yyyy-mm-dd" data-date-viewmode="years"
												data-date-minviewmode="days">
												<input id="entity.birth_day" name="entity.birthDay"
													class="m-wrap m-ctrl-medium required cdate" size="16"
													type="text"
													value="${birthDay}" />
												<span class="add-on"><i class="icon-th"></i></span> <font
													color="red"><form:errors
														path="testUserVo.entity.birthDay" /></font>
											</div>
											<!-- 
											<div id="birth_day" class="input-append date datetime-picker">
												<input class="m-wrap m-ctrl-medium required cdatetime"
													data-format="yyyy-MM-dd hh:mm:ss" type="text"><span
													class="add-on"> <i data-time-icon="icon-time"
													data-date-icon="icon-calendar"> </i>
												</span>
											</div>
											 -->
										</c:when>
										<c:otherwise>
											<span class="inline">${birthDay}&nbsp;</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="span6 control-group">
								<label class="control-label">下拉列表枚举:</label>
								<div class="controls">
									<c:choose>
										<c:when test="${action=='create' || action=='edit'}">
											<sunivo:sexSelectTag style="width: 220px;" required="true"
												name="entity.sex.test" value="${entity.sex }"
												placeHolderMessageCode="模拟枚举类实现下拉列表" />
										</c:when>
										<c:otherwise>
											<span class="inline">${entity.sex.name}&nbsp;</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span6 control-group">
								<label class="control-label">身高:</label>

								<div class="controls">
									<c:choose>
										<c:when test="${action=='create' || action=='edit'}">
											<input type="text" id="entity.height" name="entity.height"
												value="${entity.height}" placeholder="单位为cm"
												required="required" class="positiveInteger" />
											<font color="red"><form:errors
													path="testUserVo.entity.height" /></font>
										</c:when>
										<c:otherwise>
											<span class="inline">${entity.height}&nbsp;</span>
										</c:otherwise>
									</c:choose>
									(cm)
								</div>
							</div>
							<div class="span6 control-group">
								<label class="control-label">体重:</label>

								<div class="controls">
									<c:choose>
										<c:when test="${action=='create' || action=='edit'}">
											<input type="text" id="entity.weight" name="entity.weight"
												value="${entity.weight}" placeholder="单位为kg"
												required="required" class="positiveNumber" />
											<font color="red"><form:errors
													path="testUserVo.entity.weight" /></font>
										</c:when>
										<c:otherwise>
											<span class="inline">${entity.weight}&nbsp;</span>
										</c:otherwise>
									</c:choose>
									(kg)
								</div>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span6 control-group">
								<label class="control-label">邮箱:</label>

								<div class="controls">
									<c:choose>
										<c:when test="${action=='create' || action=='edit'}">
											<input type="text" id="entity.email" name="entity.email"
												value="${entity.email}" required="required" class="email" />
											<font color="red"><form:errors
													path="testUserVo.entity.email" /></font>
										</c:when>
										<c:otherwise>
											<span class="inline">${entity.email}&nbsp;</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="span6 control-group">
								<label class="control-label">密码:</label>

								<div class="controls">
									<c:choose>
										<c:when test="${action=='create' || action=='edit'}">
											<input type="password" id="entity.password"
												name="entity.password" value="${entity.password}"
												class="required" minlength="6" maxlength="30" />
											<font color="red"><form:errors
													path="testUserVo.entity.password" /></font>
										</c:when>
										<c:otherwise>
											<span class="inline">${entity.password}&nbsp;</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span6 control-group">
								<label class="control-label">存款:</label>

								<div class="controls">
									<c:choose>
										<c:when test="${action=='create' || action=='edit'}">
											<input type="text" id="entity.deposit" name="entity.deposit"
												value="${entity.deposit}"
												class="required nonNegativeInteger" />
											<font color="red"><form:errors
													path="testUserVo.entity.deposit" /></font>
										</c:when>
										<c:otherwise>
											<span class="inline">${entity.deposit}&nbsp;</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="span6 control-group">
								<label class="control-label">备注:</label>

								<div class="controls">
									<c:choose>
										<c:when test="${action=='create' || action=='edit'}">
											<input type="text" id="entity.note" name="entity.note"
												value="${entity.note}" />
											<font color="red"><form:errors
													path="testUserVo.entity.note" /></font>
										</c:when>
										<c:otherwise>
											<span class="inline">${entity.note}&nbsp;</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span6 control-group">
								<label class="control-label">省份:</label>
								<div class="controls">
									<c:choose>
										<c:when test="${action=='create' || action=='edit'}">
											<sunivo:testProvinceSelectTag style="width: 220px;"
												required="true" name="provinceId"
												placeHolderMessageCode="省份" />
										</c:when>
										<c:otherwise>
											<span class="inline">-&nbsp;</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="span6 control-group">
								<label class="control-label">城市:</label>

								<div class="controls">
									<c:choose>
										<c:when test="${action=='create' || action=='edit'}">
											<sunivo:testCitySelectTag testProvinceId=""
												name="entity.cityId" value="${entity.cityId}"
												placeHolderMessageCode="地市" style="width: 220px;"
												required="true" />
											<font color="red"><form:errors
													path="testUserVo.entity.cityId" /></font>
										</c:when>
										<c:otherwise>
											<span class="inline">${entity.cityId}&nbsp;</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<script type="text/javascript">
		$(function() {
			$("select[name='provinceId']").change(function() {
				var provinceId = $(this).val();
				$.ajax({
					url : "${ctx}/testcity/ajax/testcity/" + provinceId,
					dataType : "text",
					contentType : "text/html; charset=UTF-8",
					success : function(data) {
						var cityIdSelect = $("select[name='entity\\.cityId']");
						cityIdSelect.html(data);
						refreshChosen(cityIdSelect);
					}
				});
			});
		});
	</script>
	<div id="popDivSection" class="modal hide fade" aria-hidden="true"
		style="width: 900px;" role="dialog" aria-labelledby="modal_title">
	</div>
</body>

</html>