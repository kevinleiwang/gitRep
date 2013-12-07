<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>个人中心</title>
<style type="text/css">
.error,.chzn-container .error {
	border: 1px solid red !important;
}
</style>
</head>
<body>
	<div class="row${fluid} list-maxwidth">
		<div class="span12">
			<div class="row${fluid} form-horizontal">
				<div class="span12">
					<div id="userProfileMessage"></div>
					<div class="portlet-header"></div>
					<form id="changePasswordForm" action="#" class="valid">
						<div class="row-fluid">
							<label class="control-label">当前密码：</label>
							<div class="controls">
								<input id="oldPassword" name="oldPassword" type="password"
									class="control-width text_input" required />
							</div>
						</div>
						<div class="row-fluid">
							<label class="control-label">新密码：</label>
							<div class="controls">
								<input id="password" name="passwrod" type="password"
									class="control-width" required />
							</div>
						</div>
						<div class="row-fluid">
							<label class="control-label">确认新密码：</label>
							<div class="controls">
								<input id="confirmPassword" name="confirmPassword"
									type="password" class="control-width" required />
							</div>
						</div>
						<div>
							<p>您的密码可以由大小写英文字母、数字及特殊字符组成，长度6－20位</p>
						</div>
					</form>
					<div id="error_message" ></div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>