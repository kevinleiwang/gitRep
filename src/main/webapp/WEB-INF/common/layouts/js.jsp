<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="common.jsp"%>
<!-- BEGIN JAVASCRIPTS -->
<!-- Load javascripts at bottom, this will reduce page load time -->
<script type="text/javascript"
	src="${static_common}/script/jquery/jquery-1.10.2.min.js"></script>
<!-- 数字自动格式化 -->
<script type="text/javascript"
	src="${static_common}/script/auto-numeric/js/autoNumeric.js"></script>
<script type="text/javascript"
	src="${static_common}/script/bootstrap/js/bootstrap.min.js"></script>
<!-- 日历控件脚本 -->
<script type="text/javascript"
	src="${static_common}/script/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<!-- 开关控件脚本 -->
<script type="text/javascript"
	src="${static_common}/script/bootstrap-switch/js/bootstrap-switch.min.js"></script>
<!-- jQuery验证脚本 -->
<script
	src="${static_common}/script/jquery-validation-1.11.1/dist/jquery.validate.js"
	type="text/javascript"></script>
<!-- jQuery验证提示本地化 -->
<script
	src="${static_common}/script/jquery-validation-1.11.1/localization/messages_zh.js"
	type="text/javascript"></script>
<!-- 自定义jQuery验证脚本 -->
<script
	src="${static_common}/script/jquery-validation-1.11.1/jquery-validation-custom-rules.js"
	type="text/javascript"></script>
<!-- chosen脚本 -->
<script src="${static_common}/script/chosen_v1.0.0/chosen.jquery.min.js"
	type="text/javascript"></script>

<script type="text/javascript"
	src="${static_common}/customize/js/ajaxfileupload.js"></script>
<!-- 自定义初始化工具 -->
<script type="text/javascript"
	src="${static_common}/customize/js/sunivo.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		// 初始化页面
		Sunivo.init();
	});
</script>