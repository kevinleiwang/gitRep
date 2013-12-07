
<body>
<%@include file="/WEB-INF/common/layouts/common.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<c:if test="${success eq 'no' }">
	excel中部分报价未被导入数据库，详情请下载结果文件！<a id='resultUrl' href='${ctx}/lgsquoteimport/download/${fileName }'>下载</a>
</c:if>
<c:if test="${success eq 'yes' }">
	报价导入成功
</c:if>

</body>