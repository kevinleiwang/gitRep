<%@ page language="java" pageEncoding="UTF-8" %>
<%@include file="common.jsp" %>
<div id="modal_dialog" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="modal_title"
     aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h3 id="modal_title"></h3>
    </div>
    <div class="modal-body">
        <p id="modal_body"></p>
    </div>
    <div class="modal-footer">
        <button id="modal_ok_btn" class="btn btn-primary">
                        确认
        </button>
        <button id="modal_cancel_btn" class="btn" data-dismiss="modal" aria-hidden="true">
                        取消
        </button>
    </div>
</div>