
<body>
<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8" import="java.util.Date"%>

   <form id="upload_surcharge_file_form" name="upload_surcharge_file_form" class="valid"
		action="" method="POST" enctype="multipart/form-data">
		
		<table class="table table-bordered table-striped table_vam" id="dt_gal">
		<tr> 
			<td><span style="line-height:44px; color: red;" id="quote_message">请上传excel文件</span></td>
			<td><span style="line-height:44px;"><input 
				type="file" id="file" name="file" onchange="ajaxFileUpload()"/></span>
	        </td>
			<%-- <td><input type="button" onclick="uploadfile('${ctx}');" value="导入报价"></td> --%>
		</tr>
		</table>
		<table class="table table-bordered table-striped table_vam" id="dt_gal2">
			<thead>
				<tr>
					<th>上传结果导出</th>
				</tr>
				<tr>
					<td><textarea name="describe" id="describe" style="width: 500px;" readonly></textarea></td>
				</tr>
			</thead>
		</table>
	</form>
	
	
	<script type="text/javascript">
	function ajaxFileUpload(){
		
		var fileStr = document.getElementById("file").value;
		if (null == fileStr || "" == fileStr || undefined == fileStr)
		{
				//alert("请选择文件!");		
    			$("#quote_message").text("请选择文件!");
				return;
		}
		var fileType = fileStr.substring(fileStr.lastIndexOf(".") + 1);
		if ("xls" != fileType && "xlsx" != fileType)
		{
				//alert("上传文件类型错误!");
    			$("#quote_message").text("上传文件类型错误!");
				return;
		}
		$("#quote_message").text("请上传excel文件");
        $("#modal_ok_btn").show();
	}
	
	function uploadfile(ctx){
		
		var fileStr = document.getElementById("file").value;
		if (null == fileStr || "" == fileStr || undefined == fileStr)
		{
				alert("请选择文件!");		
				return;
		}
		var fileType = fileStr.substring(fileStr.lastIndexOf(".") + 1);
		if ("xls" != fileType && "xlsx" != fileType)
		{
				alert("上传文件类型错误!");
				return;
		}
		if(!confirm('确定导入报价？')){
			return ;
		}
		
		document.getElementById('upload_surcharge_file_form').action = ctx + "/${action}" ;
		document.getElementById('upload_surcharge_file_form').submit();
	}
	</script>
</body>