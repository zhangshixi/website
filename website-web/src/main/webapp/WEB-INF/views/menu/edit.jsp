<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />


<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px" closed="true" buttons="#dlg-buttons">
	<div class="ftitle">基础信息编辑</div>
	<form id="fm" method=POST novalidate>
		<input type="hidden" name="_method" value="PUT" />
		
		<div class="fitem">
			<label>菜单ID:</label>
			<input name="id" class="easyui-validatebox" required="true">
		</div>
		<div class="fitem">
			<label>菜单名称:</label>
			<input name="name" class="easyui-validatebox" required="true">
		</div>
		<div class="fitem">
			<label>菜单编码:</label>
			<input name="code">
		</div>
		<div class="fitem">
			<label>链接:</label>
			<input name="link" class="easyui-validatebox">
		</div>
	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-ok" onclick="doEdit()">Save</a>
	<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>
</div>

<script type="text/javascript">
    var url;
    function saveUser(){
        $('#fm').form('submit',{
            url: url,
            onSubmit: function(){
                return $(this).form('validate');
            },
            success: function(result){
                var result = eval('('+result+')');
                if (result.errorMsg){
                    $.messager.show({
                        title: 'Error',
                        msg: result.errorMsg
                    });
                } else {
                    $('#dlg').dialog('close');      // close the dialog
                    $('#dg').datagrid('reload');    // reload the user data
                }
            }
        });
    }
</script>
	