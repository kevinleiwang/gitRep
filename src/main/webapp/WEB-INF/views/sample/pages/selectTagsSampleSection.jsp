<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>sunivo select tags sample</title>
</head>
<body>
	<div class="row-fluid">
		<div class="row-fluid">
			<div class="span12 control-group">

				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th>名称</th>
							<th>效果</th>
							<th>代码</th>
							<th>作者</th>
							<th>说明</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>航线下拉列表标签</td>
							<td><sunivo:shippinglineSelect name="shippingline" /></td>
							<td><c:out
									value='<sunivo:shippinglineSelect name="shippingline"/>' /></td>
							<td>chengjianfang</td>
							<td></td>
						</tr>
						<tr>
							<td class="span2">海港下拉列表标签</td>
							<td class="span2"><sunivo:shipPortSelect name="shipport" /></td>
							<td class="span3"><c:out
									value='<sunivo:shipPortSelect name="shipport" />' /></td>
							<td class="span1">chengjianfang</td>
							<td class="span4"></td>
						</tr>
						<tr>
							<td>进出口下拉列表标签</td>
							<td><sunivo:importExportFlagSelect name="importexportflag" /></td>
							<td><c:out
									value='<sunivo:importExportFlagSelect name="importexportflag" />' /></td>
							<td>chengjianfang</td>
							<td></td>
						</tr>
						<tr>
							<td>运输类型下拉列表标签</td>
							<td><sunivo:transportTypeFlagSelect name="transporttypeflag" /></td>
							<td><c:out
									value='<sunivo:transportTypeFlagSelect name="transporttypeflag" />' /></td>
							<td>chengjianfang</td>
							<td></td>
						</tr>
						<tr>
							<td>失效标识下拉列表标签</td>
							<td><sunivo:disabledFlagSelect name="disabledflag" value="1" /></td>
							<td><c:out
									value='<sunivo:disabledFlagSelect name="disabledflag" value="1"/>' /></td>
							<td>chengjianfang</td>
							<td>
								<li>取值0表示启用</li>
								<li>取值1表示停用</li>
							</td>
						</tr>
						<tr>
							<td>失效标识下拉列表标签</td>
							<td><sunivo:disabledFlag2Select name="disabledflag" value="1" /></td>
							<td><c:out
									value='<sunivo:disabledFlag2Select name="disabledflag" value="1"/>' /></td>
							<td>wanglei</td>
							<td>
								<li>取值0表示有效</li>
								<li>取值1表示无效</li>
							</td>
						</tr>
						<tr>
							<td>物流供应商列表标签</td>
							<td><sunivo:logisticsCompanySelect cusLogisticType="01" />
							<td><c:out
									value='<sunivo:logisticsCompanySelect cusLogisticType="01" />' /></td>
							<td>wanglei</td>
							<td>cusLogisticType：<br> 物流供应商代码 01 船公司 02 船代公司 03 货代公司
								04 快递公司 05 拖车公司 06 报关公司 07 航空公司 08 保险公司 09 其它 <br>isPartner：<br>是否合作物流供应商，1为是，0或者NULL为否
								这里我们定义为：0 不是合作物流供应商；1是合作物流供应商，2全部物流供应商
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>