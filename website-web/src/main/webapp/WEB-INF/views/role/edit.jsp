<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />


<div id="editDialog" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px" closed="true" buttons="#editDialogButtons">
	<div class="ftitle">基础信息编辑</div>
	<form id="editForm" method=POST novalidate>
		<input type="hidden" name="_method" value="PUT" />
		
		<div class="fitem">
			<label>ID:</label>
			<input name="id" class="easyui-validatebox" required="true">
		</div>
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
<div id="editDialogButtons">
	<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-ok" onclick="javascript:doEdit();">保存</a>
	<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#editDialog').dialog('close');">取消</a>
</div>
	