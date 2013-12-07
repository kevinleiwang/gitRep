<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<body>
	<div class="row${fluid}">
		<div class="span12">
			<h3 class="page-title">${entity.id}</h3>
		</div>
	</div>
        弹出页面展示正常
	<div class="row${fluid}">
		<div class="span12">
			<div class="portlet box grey">
				<div class="portlet-body form">
					<input name="entity.id" type="hidden" value="${entity.id}" />
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">生日:</label>
							<fmt:formatDate value="${entity.birthDay}" pattern="yyyy-MM-dd" var="birthDay" />
							<div class="controls">
								<div class="input-append date date-picker" data-date=""
									data-date-format="yyyy-mm-dd" data-date-viewmode="years"
									data-date-minviewmode="days">
									<input id="birth_day" name="birthDay"
										class="m-wrap m-ctrl-medium required cdate" size="16"
										type="text"
										value="${birthDay}" />
									<span class="add-on"><i class="icon-th"></i></span> <font
										color="red"><form:errors
											path="testUserVo.entity.birthDay" /></font>
								</div>
								<div id="birthday" class="input-append date datetime-picker">
									<input class="m-wrap m-ctrl-medium required cdatetime"
										data-format="yyyy-MM-dd hh:mm:ss" type="text"> <span
										class="add-on"> <i class="icon-calendar"
										data-time-icon="icon-time" data-date-icon="icon-calendar">
									</i>
									</span>
								</div>
							</div>
						</div>
						<div class="span6 control-group">
							<label class="control-label">&nbsp;</label>

							<div class="controls">&nbsp;</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>