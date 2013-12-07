

<body>
<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
$(document).ready(function () {
	SunivoUtil.ajaxTurn2Page("#on_select_side","${ctx}/lgsinquiry/selectAgentSection",0 );
	
	/* var leftSel = $("#selectL");
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
	 });  */
});

</script>
<script type="text/javascript" charset="UTF-8">
	function selectAgentByName(){
		var search_cusName = $("#search_cusName").val();
		search_cusName = search_cusName.replace(/(^\s*)|(\s*$)/g, "");
		var actUrl = "${ctx}/lgsinquiry/selectAgentSection?search_cusName=" + search_cusName;
		SunivoUtil.ajaxTurn2Page("#on_select_side",actUrl,0 );
	}
</script>
<div id="main">
<div id="assignAgentMessage" ></div>
<form id="inquiry_quote_add_form" name="inquiry_quote_add_form" valid action="${ctx}/lgsinquiry/updateagency" method="POST">
		<input type="text" value="${inquiryIdStr}" name="inquiryIdStr" id="inquiryIdStr" Style="display:none;">
	
	<div class="top_select_side_left" id="top_on_select_side" style="float:left; width:300px">
		<div class="select_side_left" id="on_select_side">
		</div>
	</div>
	
	<div class="select_opt" style="float:left; width:40px; height:100%; margin-top:100px">
	   <ul class="the-icons" style=""  >
	   	<!-- <li><i class="icon-circle-arrow-right"></i></li>
	   	<li><i class="icon-circle-arrow-left"></i></li> -->
	   	<div id="toright" title="添加" class="icon-circle-arrow-right" style="width:50px; height: 20px;  cursor: pointer;" ></div>
	   	<div id="toleft" title="移除" class="icon-circle-arrow-left" style="width:50px; height: 20px; margin-top: 20px; cursor: pointer; " ></div>
	    <!-- <p id="toright"  title="添加" style="font-family:应用字体;font-size:13px;font-weight:bold;font-style:normal;text-decoration:none;color:#3CA2E3;"></p>
	    <p id="toleft" title="移除" style="font-family:应用字体;font-size:13px;font-weight:bold;font-style:normal;text-decoration:none;color:#3CA2E3;"><--</p> -->
	   </ul>
	</div>
	
	<!-- <div  style="float:left; width:10px;margin-top:20px; "></div> -->
	<div class="select_side_right" style="float:left; width:250px;margin-top:20px; ">
	<span>已选择供应商</span>
	<br/>
	<select id="selectR" class="nochosen" name="selectR" multiple="multiple" style="width:250px; height:190px;">
	</select>
	</div>
	
</form>
</div>
	
</body>
