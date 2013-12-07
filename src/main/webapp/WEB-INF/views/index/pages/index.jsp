<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>春宇物流管理系统 | 工作台</title>
<script type="text/javascript">
	$(document).ready(
		function(){
			$("#lgsinquiry").click(
					function (){
					window.location='${ctx}/lgsinquiry/';
				}	
			);
			$("#lgsAdvantageRouteSet").click(
					function (){
					window.location='${ctx}/lgsadvantagerouteset?search_EQ_disabled=0';
				}	
			);
			$("#lgsfclquoteinfo").click(
					function (){
					window.location='${ctx}/lgsfclquoteinfo?search_EQ_status=0';
				}	
			);
			$("#lgsport").click(
					function (){
					window.location='${ctx}/lgsport?search_EQ_status=0';
				}	
			);
			$("#lgsaddationquoteinfo").click(
					function (){
					window.location='${ctx}/lgsaddationquoteinfo?search_EQ_status=0';
				}	
			);
			$("#lgsrouteadditionquote").click(
					function (){
					window.location='${ctx}/lgsrouteadditionquote?search_EQ_status=0';
				}	
			);
			$("#lgsadditionquote").click(
					function (){
					window.location='${ctx}/lgsadditionquote/inquiryList';
				}	
			);
			var userAgent=navigator.userAgent.toLowerCase();
			var browser={
			                version: (userAgent.match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/) || [0, '0'])[1],
			                safari: /webkit/.test(userAgent),
			                opera: /opera/.test(userAgent),
			                msie: /msie/.test(userAgent) && !/opera/.test(userAgent),
			                mozilla: /mozilla/.test(userAgent) && !/(compatible|webkit)/.test(userAgent),
			                browser360: /360se/.test(userAgent)
						};
			 var flag = (browser.msie && browser.version == 10.0) || browser.mozilla;
			 if(!flag){
				 SunivoUtil.showAlertMessage($("#browserMessage"),"为了给您提供更好的用户体验，请使用以下浏览器：<ul></ul>"+
						 "&nbsp;&nbsp;&nbsp;&nbsp;<a href='http://download.microsoft.com/download/4/1/4/4149BFB1-AC27-401D-943F-DA1BBD0537C5/IE10-Windows6.1-x86-zh-cn.exe'>IE10下载(32位)</a>&nbsp;&nbsp;&nbsp;&nbsp;|"+
						 "&nbsp;&nbsp;&nbsp;&nbsp;<a href='http://download.microsoft.com/download/3/7/D/37DC542A-AE01-4E4B-99A0-FCFD5F7F19E7/IE10-Windows6.1-x64-zh-cn.exe'>IE10下载(64位)</a>&nbsp;&nbsp;&nbsp;&nbsp;|"+
						 "&nbsp;&nbsp;&nbsp;&nbsp;<a href='http://download.firefox.com.cn/releases/stub/official/zh-CN/Firefox-latest.exe'>火狐下载</a>","warn");
             }     
		}		
	);
</script>
</head>
<body>
	
	<div class="row-fluid index-row" style="margin-top:10px;">
		<div class="span10 offset1" >
			<div id="browserMessage"></div>
			<div class="span12 index-logo pull-left">
				<h1><i class="icon-flag"></i>&nbsp;&nbsp;&nbsp;&nbsp;春宇物流管理系统</h1>
			</div>
		</div>
	</div>
	<div class="row-fluid index-row" style="margin-top:70px;">
		<div class="span10 offset1" >
		<div class="span3 index-box" id="lgsfclquoteinfo">
				<p class="text-center"><span class="icon-money icon-4x"></span></p>
				<span class="box-name">海运费</span>
			</div>
			<div class="span3 index-box" id="lgsport">
				<p class="text-center"><span class="icon-money icon-4x"></span></p>
				<span class="box-name">本地费</span>
			</div>
			<div class="span3 index-box" id="lgsaddationquoteinfo">
				<p class="text-center"><span class="icon-money icon-4x"></span></p>
				<span class="box-name">附加费</span>
			</div>
			<div class="span3 index-box" id="lgsAdvantageRouteSet">
				<p class="text-center"><span class="icon-tasks icon-4x"></span></p>
				<span class="box-name">优势航线</span>
			</div>
			
		</div>
	</div>
	
	<div class="row-fluid index-row">
		<div class="span10 offset1">
			<!-- <div class="span3 index-box" id="lgsinquiry">
				<p class="text-center"><span class="icon-comments icon-4x"></span></p>
				<span class="box-name">物流询价</span>
			</div> -->
			<div class="span3 index-box" id="lgsrouteadditionquote">
				<p class="text-center"><span class="icon-cogs icon-4x"></span></p>
				<span class="box-name">按航线销售价制作</span>
			</div>
			<!-- <div class="span3 index-box">
				<p class="text-center"><span class="icon-user icon-4x"></span></p>
				<span class="box-name">个人中心</span>
			</div> -->
			<!-- <div class="span3 index-box" id="lgsadditionquote">
				<p class="text-center"><span class="icon-cog icon-4x"></span></p>
				<span class="box-name">按票销售价制作</span>
			</div> -->
			<div class="span3 index-closed-box">
				<span class="box-name"></span>
			</div>
			<div class="span3 index-closed-box">
				<span class="box-name"></span>
			</div>
			<div class="span3 index-closed-box">
				<span class="box-name"></span>
			</div>
		</div>
	</div>
	
	<div class="row-fluid index-row">
		<div class="span10 offset1">
			<div class="span3 index-closed-box">
				<span class="box-name"></span>
			</div>
			<div class="span3 index-closed-box">
				<span class="box-name"></span>
			</div>
			<div class="span3 index-closed-box">
				<span class="box-name"></span>
			</div>
			<div class="span3 index-closed-box">
				<span class="box-name"></span>
			</div>
			
		</div>
	</div>
</body>
</html>