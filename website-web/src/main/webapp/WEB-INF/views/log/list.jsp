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
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="doMonit();">监控</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="doDownload();">下载</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="doClear();">清空</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="doRemove();">删除</a>
			</div>
			
			<div style="margin:8px">
				<form id="searchForm" name="searchForm" method="post" action="${ctx}/log/list">
					<input type="hidden" id="pageIndex" name="pageIndex" value="1" />
					<input type="hidden" id="pageSize" name="pageSize" value="10" />
				</form>
			</div>
		</div>
		
		<table id="tg" class="easyui-treegrid" data-options="rownumbers:true, fitColumns:true, idField:'hash', treeField:'name', pagination:true">
	        <thead>
	            <tr>
	                <th data-options="field:'name',width:180">日志名称</th>
	                <th data-options="field:'lastModifiedTime',width:180">最后修改时间</th>
	                <th data-options="field:'absolutePath',width:180">路径</th>
	                <th data-options="field:'size',width:60,align:'right'">日志大小</th>
	            </tr>
	        </thead>
	    </table>
	</div>
	
	<script type="text/javascript">
		$(function() {
			$('#tg').treegrid('getPager').pagination({
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
				$('#tg').treegrid('loadData', {'total':page.totalData, 'rows':page.resultList});
			});
		}
	
        var url;
        function doMonit() {
            var row = $('#tg').datagrid('getSelected');
            if (row && !row.directory) {
            	url = '${ctx}/log/'+row.hash+'/monitor';
            	window.open(url);
            }
        }
        
        function doDownload() {
        	var row = $('#tg').datagrid('getSelected');
            if (row && !row.directory) {
            	url = '${ctx}/log/'+row.hash+'/download';
            	window.location.replace(url);
            }
        }
        
        function doClear() {
        	var row = $('#tg').datagrid('getSelected');
            if (row) {
            	var confirm = row.directory ? '确认清空整个文件夹?' : '确认清空?';
            	$.messager.confirm('Confirm', confirm, function(c) {
                    if (c) {
		            	url = '${ctx}/log/'+row.hash+'/clear';
		            	jQuery.post(url, {_method:'PUT'}, function(result) {
		       				if (result.success) {
		       					doSearch();
		       				} else {
		       					alertMsg('清空失败！', result.message, 'error'); 
		       				}
		       			});
                    }
            	});
            }
        }
        
        function doRemove(target) {
            var row = $('#tg').datagrid('getSelected');
            if (row) {
            	var confirm = row.directory ? '确认删除整个文件夹?' : '确认删除?';
                $.messager.confirm('Confirm', confirm, function(c) {
                    if (c) {
                    	url = '${ctx}/log/'+row.hash+'/remove';
                    	jQuery.post(url, {_method:'DELETE'}, function(result) {
		       				if (result.success) {
		       					doSearch();
		       				} else {
		       					alertMsg('删除失败！', result.message, 'error'); 
		       				}
		       			});
                    }
                });
            }
        }
    </script>
	
</body>

</html>