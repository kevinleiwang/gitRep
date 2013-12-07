<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<title>用户列表</title>
</head>
<body>
	<div class="row${fluid}">
		<div class="span6">
			<h2 class="page-title">用户列表</h2>
		</div>
		<div class="span6 header_buttons">
			<a href="${ctx}/testuser?action=create" class="btn blue pull-right"><i
				class="icon-plus"></i></a>
		</div>
	</div>

	<div class="page-container">
		<div class="row${fluid}">
			<div class="span12">
				<form id="filterForm" class="form-inline filterForm"
					action="${ctx}/testuser" method="get">
					<input type="text" name="search_LIKE_id"
						value="${searchParams.LIKE_id}" class="m-wrap small"
						placeholder="ID"> <input type="text"
						name="search_LIKE_name" value="${searchParams.LIKE_name}"
						class="m-wrap small" placeholder="姓名"> <input type="text"
						name="search_LIKE_sex" value="${searchParams.LIKE_sex}"
						class="m-wrap small" placeholder="性别"> <input type="text"
						name="search_LIKE_birthDay"
						value="${searchParams.LIKE_birthDay}" class="m-wrap small"
						placeholder="生日">
					<div class="buttons pull-right">
						<i class="icon-search icon-2x pointer"
							onclick="$('#filterForm').submit();"></i>
					</div>
				</form>
			</div>
		</div>
		<table class="table table-striped table-advance table-hover">
			<thead>
				<tr>
					<th width="100">ID</th>
					<th width="100">姓名</th>
					<th width="100">性别</th>
					<th width="100">生日</th>
					<th width="100">城市</th>
					<th width="100">身高</th>
					<th width="100">体重</th>
					<th width="100">邮箱</th>
					<th width="100">密码</th>
					<th width="100">存款</th>
					<th width="100">备注</th>
					<th width="150">操作</th>
				</tr>
			</thead>
			<c:forEach items="${testUsers}" var="testUser">
				<tr>
					<td nowrap="nowrap"><a href="${ctx}/testuser/${testUser.id}">
							<c:if test="${null ne testUser.id && '' ne testUser.id}">
								<c:out value="${testUser.id}" />
							</c:if> <c:if test="${null eq testUser.id || '' eq testUser.id}">
							&nbsp;
						</c:if>
					</a></td>
					<td nowrap="nowrap"><c:if
							test="${null ne testUser.name && '' ne testUser.name}">
							<c:out value="${testUser.name}" />
						</c:if> <c:if test="${null eq testUser.name || '' eq testUser.name}">
							&nbsp;
						</c:if></td>
					<td nowrap="nowrap"><c:if
							test="${null ne testUser.sex && '' ne testUser.sex}">
							<c:out value="${testUser.sex.name}" />
						</c:if> <c:if test="${null eq testUser.sex || '' eq testUser.sex}">
							&nbsp;
						</c:if></td>
					<td nowrap="nowrap"><c:if
							test="${null ne testUser.birthDay && '' ne testUser.birthDay}">
							<%-- ${tradx:formatDate(testUser.birthDay, 'yyyy-MM-dd') } --%>
							<fmt:formatDate value="${testUser.birthDay}" pattern="yyyy-MM-dd" var="birthDay" />
							${birthDay}
						</c:if> <c:if
							test="${null eq testUser.birthDay || '' eq testUser.birthDay}">
							&nbsp;
						</c:if></td>
					<td nowrap="nowrap"><c:if
							test="${null ne testUser.cityId && '' ne testUser.cityId}">
							<c:out value="${testUser.cityId}" />
						</c:if> <c:if test="${null eq testUser.cityId || '' eq testUser.cityId}">
							&nbsp;
						</c:if></td>
					<td nowrap="nowrap"><c:if
							test="${null ne testUser.height && '' ne testUser.height}">
							<c:out value="${testUser.height}" />
						</c:if> <c:if test="${null eq testUser.height || '' eq testUser.height}">
							&nbsp;
						</c:if></td>
					<td nowrap="nowrap"><c:if
							test="${null ne testUser.weight && '' ne testUser.weight}">
							<c:out value="${testUser.weight}" />
						</c:if> <c:if test="${null eq testUser.weight || '' eq testUser.weight}">
							&nbsp;
						</c:if></td>
					<td nowrap="nowrap"><c:if
							test="${null ne testUser.email && '' ne testUser.email}">
							<c:out value="${testUser.email}" />
						</c:if> <c:if test="${null eq testUser.email || '' eq testUser.email}">
							&nbsp;
						</c:if></td>
					<td nowrap="nowrap"><c:if
							test="${null ne testUser.password && '' ne testUser.password}">
							<c:out value="${testUser.password}" />
						</c:if> <c:if
							test="${null eq testUser.password || '' eq testUser.password}">
							&nbsp;
						</c:if></td>
					<td nowrap="nowrap"><c:if
							test="${null ne testUser.deposit && '' ne testUser.deposit}">
							<c:out value="${testUser.deposit}" />
						</c:if> <c:if
							test="${null eq testUser.deposit || '' eq testUser.deposit}">
							&nbsp;
						</c:if></td>
					<td nowrap="nowrap"><c:if
							test="${null ne testUser.note && '' ne testUser.note}">
							<c:out value="${testUser.note}" />
						</c:if> <c:if test="${null eq testUser.note || '' eq testUser.note}">
							&nbsp;
						</c:if></td>
					<td nowrap="nowrap"><i class="icon-edit pointer icon-large"
						onclick="window.location='${ctx}/sample/${testUser.id}?action=edit'"></i>
						&nbsp;&nbsp; <i title="删除" class="icon-minus pointer icon-large"
						onclick="deleteById('${testUser.id}')"> </i></td>
				</tr>
			</c:forEach>
		</table>
		<div class="row${fluid}">
			<sunivo:pagination page="${page}" />
		</div>
	</div>
	<script type="text/javascript">
		var deleteById = function(testuserId) {
			createModal("删除用户", "确定要删除该用户？", function() {
				$.ajax({
					url : '${ctx}/sample/' + testuserId,
					type : "DELETE",
					dataType : "json",
					success : function() {
						window.location.reload();
					}
				});
			});
		};
	</script>
</body>
</html>
