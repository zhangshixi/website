<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Full Layout - jQuery EasyUI Demo Index</title>
	<script type="text/javascript" src="${ctx}/scripts/jquery.form.js"></script>
	<script type="text/javascript" src="${ctx}/scripts/list.js"></script>
	<script type="text/javascript" src="${ctx}/scripts/website.js"></script>
</head>

<body>

	<div data-options="closable:true" style="padding:10px">
		<div class="demo-info" style="margin-bottom:10px">
			<div class="demo-tip icon-tip">&nbsp;</div>
			<div>Click the buttons on datagrid toolbar to do crud actions.</div>
		</div>
		
		<div id="tb">
			<div>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="toAdd()">New User</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">Edit User</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">Remove User</a>
			</div>
			
			<div style="margin:8px">
				<form id="searchForm" name="searchForm" method="post" action="${ctx}/admin/list">
					<input type="hidden" id="pageIndex" name="pageIndex" value="1" />
					<input type="hidden" id="pageSize" name="pageSize" value="10" />
					
					真实姓名: <input type="text" name="realName" />
					电子邮件: <input type="text" name="email" />
					手机号码: <input type="text" name="mobile" />
					<a href="javascript:doSearch();" class="easyui-linkbutton" iconCls="icon-search">查询</a>
				</form>
			</div>
		</div>
	
		<table id="dg" class="easyui-datagrid" data-options="pagination:true,singleSelect:true,fitColumns:true,toolbar:'#tb'">
			<thead>
				<tr>
					<th data-options="field:'id'" width="50">管理员ID</th>
					<th data-options="field:'loginName'" width="100">登陆名称</th>
					<th data-options="field:'realName'" width="100">真实姓名</th>
					<th data-options="field:'mobile'" width="100">手机号码</th>
					<th data-options="field:'email'" width="100">电子邮件</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<jsp:include page="add.jsp" />
	<jsp:include page="edit.jsp" />
	
	<script type="text/javascript">
		var url;
        function toAdd() {
            $('#addDialog').dialog('open');
            $('#addForm').form('clear');
            url = $('#addForm').attr('action');
            $('#addForm').form('load', url);
        }
    </script>
	
</body>

</html>