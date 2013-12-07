<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>sunivo hession sample</title>
</head>
<body>
		<div class="row-fluid sunivoPage">
			<!-- 水平表单 begin -->
			<form class="form-horizontal valid" name="saveSample" method="post" action="${ctx}/sample/saveSample" >
				<!-- 页面内容置中，左右各留span1 -->
				<div class="span10 offset1">
					<!-- 页头  begin -->
					<div class="row-fluid">
						<div class="span12 sunivoTitle">
							<div class="span6">
								<h1 class="pageTitle">HESSION样例</h1>
							</div>
							<div class="span6" align="right"> 
								<i class="pull-right icon-save icon-2x pointer" style="margin-right: 20px;" title="保存" onclick="javascript:doSave();"></i> 
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
								<li class="active">hession样例</li>
							</ul>
						</div>
					</div>
					<!-- 面包屑 end -->
					<div class="sunivoBorder">
						<!-- 片段头 begin -->
						<div class="sectionTitle">
							<h5>用户基本信息</h5>
						</div>
						<!-- 片段头 end -->
						<div class="row-fluid">
							<div class="span6 control-group">
								<label class="control-label" for="sex">性别</label>
								<div class="controls">
									<!-- <select class="span10 chosen-with-diselect required" name="sex" id="sex">
										<option value="1" >男</option>
										<option value="2" >女</option>
									</select> -->
									<sunivo:logisticsCompanySelect name="11" cusLogisticType="03" clazz="required" />
									<%--<sunivo:shipPortSelect clazz="required" />
									<span></span> --%>
								</div>
								
							</div>
							<div class="span6 control-group">
								<label class="control-label" for="age">年龄</label>
								<div class="controls">
									<input type="text" class="span10 required positiveInteger" id="age" name="age" placeholder="年龄">
								</div>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span6 control-group">
								<label class="control-label" for="name">姓名</label>
								<div class="controls">
									<input type="text" class="span10 required" id="name" name="name" placeholder="姓名" >
								</div>
							</div>
							<div class="span6 control-group">
								<label class="control-label" for="birthday">生日</label>
								<div class="controls">
									<div class="span10 input-append date datetime-picker "  date-format="yyyy-mm-dd" date-minView="month">
										<input class="span* required" type="text" name="birthday" value="" id="birthday"
											readonly> <span class="add-on"><i
											class="icon-remove"></i></span> <span class="add-on"><i
											class="icon-calendar"></i></span>
									</div>
								</div>
							</div>
							<%-- <sunivo:flushMessage /> --%>
						</div>
					</div>
 					<div id="error_message" ></div>
				</div>
			</form>
			 
			<!-- 水平表单 end -->
	</div>
	
<script type="text/javascript">
	function ajaxJSONReq(url, data, doneCallback) {
	    $.ajax({
	        url: url,
	        type: "POST",
	        cache: false,
	        dataType: "json",
	        contentType: "application/json; charset=utf-8",
	        data: JSON.stringify(data)
	    }).done(function (data) {
	            if (doneCallback) {
	                doneCallback(data);
	            }
	        }
	    );
	}

	function doSave(){
		//ajax提交
		var name = $("input[name='name']").val();
		var age = $("input[name='age']").val();
		var sex = $("select[name='sex']").val();
		var birthday = $("select[name='birthday']").val();
		
		//alert($("form[name='saveSample']"));
		//提交之前先验证
		//$("form[name='saveSample']").valid();
		//直接表单提交看是否有验证
		$("form[name='saveSample']").submit();
		//SunivoUtil.showAlertMessage('#error_message','有错误了',4);
		return;
		
	 	$.ajax({
			url:'${ctx}/sample/saveSample',
			type:'post',
			//data:'name='+name+'&age='+age,
			data:$("form[name='saveSample']").serialize(),
		    success: function(msg){
			     //alert( "Data Saved: " + msg );
			     if(msg){
			    	 alert("增加客户成功"+msg);
			    	 //alert('增加客户成功！！！');
			     }
			}
	    });
	}
</script>
	
</body>
</html>