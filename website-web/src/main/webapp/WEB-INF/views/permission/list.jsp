<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Full Layout - jQuery EasyUI Demo Index</title>
	<script type="text/javascript" src="${ctx}/scripts/jquery.form.js"></script>
	<script type="text/javascript">
		$(function() { 
			doSearch();
		});
	</script>
</head>

<body>

	<div data-options="closable:true" style="padding:10px">
		<div class="demo-info" style="margin-bottom:10px">
			<div class="demo-tip icon-tip">&nbsp;</div>
			<div>Click the buttons on datagrid toolbar to do crud actions.</div>
		</div>
		
		<div id="tb">
			<div>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="toAdd()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编辑</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删除</a>
			</div>
			
			<div style="margin:8px">
				<form id="searchForm" name="searchForm" method="post" action="${ctx}/permission/list">
					<input type="hidden" id="pageIndex" name="pageIndex" value="1" />
					<input type="hidden" id="pageSize" name="pageSize" value="10" />
					
					名称: <input type="text" name="name" />
					编码: <input type="text" name="code" />
					<a href="javascript:doSearch();" class="easyui-linkbutton" iconCls="icon-search">查询</a>
				</form>
			</div>
		</div>
	
		<table id="dg" class="easyui-datagrid" data-options="pagination:true,singleSelect:true,fitColumns:true,toolbar:'#tb'">
			<thead>
				<tr>
					<th data-options="field:'id'" width="50">权限ID</th>
					<th data-options="field:'name'" width="100">权限名称</th>
					<th data-options="field:'code'" width="100">权限编码</th>
					<th data-options="field:'description'" width="100">权限描述</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<jsp:include page="add.jsp" />
	<jsp:include page="edit.jsp" />
	
	<script type="text/javascript">
		$(function() {
			$('#dg').datagrid('getPager').pagination({
				pageSize: $('#pageSize').val(),
				pageList: [10,20,30,50],
	           	onSelectPage: function(pageNumber, pageSize) {
	           		$('#pageIndex').val(pageNumber);
	           		$('#pageSize').val(pageSize);
	               	doSearch();
	           	}
	       	});
		});
		
		function doSearch() {
			$("#searchForm").ajaxSubmit(function(page) {
				$('#dg').datagrid('loadData', {'total':page.totalData, 'rows':page.resultList});
			});
		}
		
		var url;
        function toAdd() {
            $('#addDialog').dialog('open').dialog('setTitle','New User');
            $('#addForm').form('clear');
            url = '${ctx}/admin/new';
            $('#addForm').form('load', url);
        }
    </script>
	
</body>

</html>