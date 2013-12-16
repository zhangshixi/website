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
			<div class="demo-tip icon-tip"></div>
			<div>Click the buttons on datagrid toolbar to do crud actions.</div>
		</div>
		
		<div id="tb">
			<div>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="toAdd();">新增</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="toEdit();">编辑</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="doRemove(this);">删除</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="">分配权限</a>
			</div>
			
			<div style="margin:8px">
				<form id="searchForm" name="searchForm" method="post" action="${ctx}/role/list">
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
					<th data-options="field:'id'" width="50">菜单ID</th>
					<th data-options="field:'name'" width="100">菜单名称</th>
					<th data-options="field:'code'" width="100">菜单编码</th>
					<th data-options="field:'description'" width="100">菜单链接</th>
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
		
		function doSearch(){
			$("#searchForm").ajaxSubmit(function(page){
				$('#dg').datagrid('loadData', {'total':page.totalData, 'rows':page.resultList});
			});
		}
	
        var url;
        function toAdd(){
            $('#addDialog').dialog('open').dialog('setTitle','New User');
            $('#addForm').form('clear');
            url = '${ctx}/role/new';
            $('#addForm').form('load', url);
        }
        function doAdd(){
            $('#addForm').form('submit',{
                url: url,
                onSubmit: function(){
                    return $(this).form('validate');
                },
                success: function(result){
                    var result = eval('('+result+')');
                    if (result.success){
                        $('#addDialog').dialog('close');      // close the dialog
                        doSearch();    // reload the user data
                    } else {
                    	alertMsg('Error', result.message, 'error'); 
                    }
                }
            });
        }
        
        function toEdit(){
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $('#editDialog').dialog('open').dialog('setTitle','编辑菜单');
                url = '${ctx}/role/'+row.id;
                $('#editForm').form('load', url);
            }
        }
        
        function doEdit(){
            $('#editForm').form('submit',{
                url: url,
                onSubmit: function(){
                    return $(this).form('validate');
                },
                success: function(result){
                    var result = eval('('+result+')');
                    if (result.success){
                        $('#editDialog').dialog('close');      // close the dialog
                        doSearch();    // reload the user data
                    } else {
                    	alertMsg('Error', result.message, 'error'); 
                    }
                }
            });
        }
        
        function doRemove(target) {
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $.messager.confirm('Confirm','确认删除?',function(r){
                    if (r){
                    	var form = document.createElement('form');
                		form.style.display = 'none';
                		form.setAttribute('method', 'POST');
                		target.parentNode.appendChild(form);
                		
                		var input = document.createElement('input');
                		input.setAttribute('type', 'hidden');
                		input.setAttribute('name', '_method');
                		input.setAttribute('value', 'DELETE');
                		form.appendChild(input);
                		
                		url = '${ctx}/role/'+row.id;
                		$(form).form('submit', {
                            url: url,
                            success: function(result) {
                                var result = eval('('+result+')');
                                if (result.success){
                                    doSearch();
                                } else {
                                	alertMsg('Error', result.message, 'error'); 
                                }
                            }
                		});
                    }
                });
            }
        }
    </script>
	
</body>

</html>