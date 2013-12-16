<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Full Layout - jQuery EasyUI Demo Index</title>
	<script type="text/javascript" src="${ctx}/scripts/jquery.form.js"></script>
	<script type="text/javascript" src="${ctx}/scripts/list.js"></script>
</head>

<body>
	<div data-options="closable:true" style="padding:10px">
		<div class="demo-info" style="margin-bottom:10px">
			<div class="demo-tip icon-tip"></div>
			<div>Click the buttons on datagrid toolbar to do crud actions.</div>
		</div>
		
		<div id="tb">
			<div>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编辑</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删除</a>
			</div>
			
			<div style="margin:8px">
				<form id="searchForm" name="searchForm" method="post" action="menu/list">
					<input type="hidden" id="pageIndex" name="pageIndex" value="1" />
					<input type="hidden" id="pageSize" name="pageSize" value="10" />
				
					名称: <input type="text" id="name" />
					编码: <input type="text" id="code" />
					<a href="javascript:doSearch();" class="easyui-linkbutton" iconCls="icon-search">查询</a>
				</form>
			</div>
		</div>
		
		<table id="tg" class="easyui-treegrid" data-options="fitColumns:true, idField:'id', treeField:'name', toolbar:'#tb'">
			<thead>
				<tr>
					<th data-options="field:'id'" width="30">菜单ID</th>
					<th data-options="field:'name'" width="100">菜单名称</th>
					<th data-options="field:'code'" width="100">菜单编码</th>
					<th data-options="field:'sequence'" width="100">排序值</th>
					<th data-options="field:'display'" formatter="formatDisplay" width="100">是否显示</th>
					<th data-options="field:'link'" width="100">菜单链接</th>
					<th field="updateAdmin" formatter="formatAdminName" width="100">操作人</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<jsp:include page="edit.jsp" />
	
	<script type="text/javascript">
		function formatDisplay(display) {
			var icon = display ? '是' : '否';
			return icon;
		}
	
		function formatAdminName(admin) {
			return admin.loginName;
		}
		
// 		$(function() {
// 			$('#tg').treegrid('getPager').pagination({
// 				pageSize: $('#pageSize').val(),
// 				pageList: [10,20,30,50],
//                	onSelectPage: function(pageNumber, pageSize) {
//                		$('#pageIndex').val(pageNumber);
//                		$('#pageSize').val(pageSize);
//                    	doSearch();
//                	}
//            	});
// 		});
		
// 		function doSearch(){
// 			$("#searchForm").ajaxSubmit(function(resultList){
// 				$('#tg').treegrid('loadData', {'rows':resultList});
// 			});
// 		}
	
	
        var url;
        function newUser(){
            $('#dlg').dialog('open').dialog('setTitle','New User');
            $('#fm').form('clear');
            url = 'save_user.php';
        }
        function editUser(){
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $('#dlg').dialog('open').dialog('setTitle','编辑菜单');
                url = 'menu/'+row.id;
                $('#fm').form('load', url);
            }
        }
        function destroyUser(){
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $.messager.confirm('Confirm','确认删除?',function(r){
                    if (r){
                        $.post('destroy_user.php',{id:row.id},function(result){
                            if (result.success){
                                $('#dg').datagrid('reload');    // reload the user data
                            } else {
                                $.messager.show({    // show error message
                                    title: 'Error',
                                    msg: result.errorMsg
                                });
                            }
                        },'json');
                    }
                });
            }
        }
    </script>
	
</body>

</html>