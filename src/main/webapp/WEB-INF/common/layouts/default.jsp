<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="common.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="head.jsp" %>
</head>

<body>
<%@include file="topbar.jsp" %>
<%@include file="js.jsp" %>
<div class="container${fluid}"
     style="margin-top: 50px; min-height: 540px;">
    <sitemesh:body/>
</div>
<%@ include file="modal-dialog.jsp" %>
<%@ include file="footer.jsp" %>
</body>
</html>