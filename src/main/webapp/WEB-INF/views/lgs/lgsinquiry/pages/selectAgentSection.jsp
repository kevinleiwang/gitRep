

<body>
<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
$(document).ready(function () {
	var leftSel = $("#selectL");
	 var rightSel = $("#selectR");
	 $("#toright").bind("click",function(){  
		  leftSel.find("option:selected").each(function(){
		   $(this).remove().appendTo(rightSel);
		  });
	 });
	 $("#toleft").bind("click",function(){  
		  rightSel.find("option:selected").each(function(){
		   $(this).remove().appendTo(leftSel);
		  });
	 });
	 leftSel.dblclick(function(){
		  $(this).find("option:selected").each(function(){
		   $(this).remove().appendTo(rightSel);
		  });
	 });
	 rightSel.dblclick(function(){
		  $(this).find("option:selected").each(function(){
		   $(this).remove().appendTo(leftSel);
		  });
	 });
	  $("#selectAgentByName").click(function(){
		 var search_cusName = $("#search_cusName").val();
		 if (undefined != search_cusName && null != search_cusName)
		 {
			 search_cusName = $.trim(search_cusName);
			 search_cusName=escape((encodeURIComponent(search_cusName)));
		 }	 
		 //if(search_cusName !=null && search_cusName != ""){
		 	SunivoUtil.ajaxTurn2Page("#on_select_side","${ctx}/lgsinquiry/selectAgentSection?search_cusName="+search_cusName,0 );
		 //}
	 }); 
});

</script>

<script type="text/javascript" charset="UTF-8">
/*  	function selectAgentByName(){
		var search_cusName = $("#search_cusName").val();
		search_cusName = search_cusName.replace(/(^\s*)|(\s*$)/g, "");
		var actUrl = "${ctx}/lgsinquiry/selectAgentSection?search_cusName=" + search_cusName;
		ajaxTurn2Page("#on_select_side",actUrl,0 );
	}  */
</script>

	<input type="text" value="${inquiryIdStr}" name="inquiryIdStr" id="inquiryIdStr" Style="display:none;">
	<sunivo:flushMessage/>
	选择供应商:<input type="text" name="search_Name" id="search_cusName" value="${search_cusName}" placeholder="客户名称" style="width: 100px;">
	<input type="button" onclick="" id="selectAgentByName" name="selectAgentByName" value="查找" />
	<br/>
	<select id="selectL" class="nochosen" name="selectL" multiple="multiple" style="width:280px; height:190px;">
		<c:forEach items="${customerList }" var="customer">
	    <option value="${customer.id }">${customer.cusName }</option>
	   </c:forEach>
	</select>
	<br/>
   	<div class="row${fluid}"  style="width:600px;">
	<sunivo:ajaxPagination baseUrl="${ctx}/lgsinquiry/selectAgentSection" contextSel="div.select_side_left"  page="${page}"/>
	</div>
	
</body>
