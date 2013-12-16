<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />


<div id="addDialog" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px" closed="true" buttons="#addDialogButtons">
	<form id="addForm" method=POST novalidate>
		<div class="fitem">
			<label>名称:</label>
			<input name="name" class="easyui-validatebox" required="true">
		</div>
		<div class="fitem">
			<label>编码:</label>
			<input name="code">
		</div>
		<div class="fitem">
			<label>描述:</label>
			<input name="description">
		</div>
	</form>
</div>
<div id="addDialogButtons">
	<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-ok" onclick="javascript:doAdd();">保存</a>
	<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#addDialog').dialog('close');">取消</a>
</div>
	