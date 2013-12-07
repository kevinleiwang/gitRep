<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>sunivo view tags sample</title>
</head>
<body>
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
						<td>币种展示标签</td>
						<td>
							<ol>
								<li>编码:<sunivo:currencyView showType="code" value="1" />
								<li>中文名称:<sunivo:currencyView showType="cn" value="1" />
								<li>英文名称:<sunivo:currencyView showType="en" value="1" />
								<li>币种符号:<sunivo:currencyView showType="symbol" value="1" />
								<li>默认展示币种符号:<sunivo:currencyView showType="非法类型" value="1" />
							</ol>
						</td>
						<td>
							<ol>
								<li>编码:&nbsp;&nbsp;&nbsp;&nbsp;<c:out
										value='<sunivo:currencyView showType="code" value="1" />' /></li>
								<li>中文名称:&nbsp;&nbsp;&nbsp;&nbsp;<c:out
										value='<sunivo:currencyView showType="cn" value="1" />' /></li>
								<li>英文名称:&nbsp;&nbsp;&nbsp;&nbsp;<c:out
										value='<sunivo:currencyView showType="en" value="1" />' /></li>
								<li>币种符号:&nbsp;&nbsp;&nbsp;&nbsp;<c:out
										value='<sunivo:currencyView showType="symbol" value="1" />' /></li>
								<li>默认展示币种符号:&nbsp;&nbsp;&nbsp;&nbsp;<c:out
										value='<sunivo:currencyView showType="非法类型" value="1" />' /></li>
							</ol>
						</td>
						<td>chengjianfang</td>
						<td>根据不同的需求展示不同的币种标识</td>
					</tr>
					<tr>
						<td>客户展示标签</td>
						<td><sunivo:customerView value="21" /></td>
						<td><c:out value='<sunivo:customerView value="21" />' /></td>
						<td>chengjianfang</td>
						<td>客户：<br>物流供应商，金融供应商，结算客户，<br>bpo客户，采购商，产品供应商
						</td>
					</tr>
					<tr>
						<td>千分位展示标签</td>
						<td><sunivo:moneyFormatView money="1234567890.1234" /></td>
						<td><c:out
								value='<sunivo:moneyFormatView money="1234567890.1294"/>' /></td>
						<td>wanglei</td>
						<td>不管有多少位小数，只保留两位</td>
					</tr>
					<tr>
						<td>数字格式化标签</td>
						<td>
							<ol>
								<li><sunivo:numberFormatView value="1234567890.1234" /></li>
								<li><sunivo:numberFormatView value="1234567890.1234"
										decimaDigits="1" /></li>
								<li><sunivo:numberFormatView value="1234567890.1234"
										decimaDigits="0" /></li>
								<li><sunivo:numberFormatView value="1234567890.1234"
										decimaDigits="-1" /></li>
							</ol>
						</td>
						<td>
							<ol>
								<li><c:out
										value='<sunivo:numberFormatView value="1234567890.1234" />' />></li>
								<li><c:out
										value='<sunivo:numberFormatView value="1234567890.1234"
										decimaDigits="1" />' /></li>
								<li><c:out
										value='<sunivo:numberFormatView value="1234567890.1234"
										decimaDigits="0" />' /></li>
								<li><c:out
										value='<sunivo:numberFormatView value="1234567890.1234"
										decimaDigits="-1" />' /></li>
							</ol>
						</td>
						<td>chengjianfang</td>
						<td>默认两位小数，当小数位数错误时，使用默认小数位数</td>
					</tr>
					<tr>
						<td>进出口展示标签</td>
						<td><sunivo:importExportFlagView value="1" /></td>
						<td><c:out value='<sunivo:importExportFlagView value="1"/>' /></td>
						<td>chengjianfang</td>
						<td></td>
					</tr>
					<tr>
						<td>运输类型展示标签</td>
						<td><sunivo:transportTypeFlagView value="1" /></td>
						<td><c:out value='<sunivo:transportTypeFlagView value="1"/>' /></td>
						<td>chengjianfang</td>
						<td></td>
					</tr>
					<tr>
						<td>失效标识展示标签</td>
						<td><sunivo:disabledFlagView value="0" /></td>
						<td><c:out
								value='<sunivo:disabledFlagView value="0" />' /></td>
						<td>chengjianfang</td>
						<td>
							<li>取值0表示启用</li>
							<li>取值1表示停用</li>
							<li>取值0(启用)时，如果当 前日期超过失效时间的日期，则为已过期</li>
						</td>
					</tr>
					<tr>
						<td>航线展示标签</td>
						<td><sunivo:shippinglineView value="1" /></td>
						<td><c:out value='<sunivo:shippinglineView value="1" />' /></td>
						<td>chengjianfang</td>
						<td></td>
					</tr>
					<tr>
						<td>港口展示标签</td>
						<td><sunivo:shipPortView value="200000001" /></td>
						<td><c:out value='<sunivo:shipPortView value="200000001" />' /></td>
						<td>chengjianfang</td>
						<td></td>
					</tr>
					<tr>
						<td>箱型展示标签</td>
						<td><sunivo:containersizeView value="3" /></td>
						<td><c:out value='<sunivo:containersizeView value="3" />' /></td>
						<td>chengjianfang</td>
						<td></td>
					</tr>
					<tr>
						<td>过长字符串截取标签</td>
						<td><sunivo:lengthLimter maxLen="10" value="测试测试测试测试测试测试" /></td>
						<td><c:out
								value='<sunivo:lengthLimter maxLen="10" value="测试测试测试测试测试测试"/>' /></td>
						<td>wanglei</td>
						<td>
							<li>maxLen:设置最大长度，超过此最大长度，截取并用'...'代替</li>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>