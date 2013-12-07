<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<body>
<style>
.modal-body {
	height: 250px;
}
</style>
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
				    <form name="testForm" id="testForm" >
					<input name="entity.id" type="hidden" value="${entity.id}" />
					<div class="row-fluid">
						<div class="span6 control-group">
							<label class="control-label">生日:</label>
							<fmt:formatDate value="${entity.birthDay}" pattern="yyyy-MM-dd" var="birthDay" />
							<div class="controls">
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
							<label class="control-label">性别</label>

							<div class="controls">
								<select name="sex" class="required" >
								    <option value="" >请选择</option>
									<option value="1" >男</option>
									<option value="2" >女</option>
								</select>
							</div>
						</div>
					</div>
					</form>
				</div>
			
			</div>
		</div>
	</div>
</body>