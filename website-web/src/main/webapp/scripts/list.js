var datagrid;
var treegrid;

$(function() {
	datagrid = $('.easyui-datagrid');
	treegrid = $('.easyui-treegrid');
	
	if (!isEmpty(datagrid)) {
		registDatagridPage();
		searchDatagrid();
	}
	
	if (!isEmpty(treegrid)) {
		registTreegridPage();
		searchTreegrid();
	}
});

function registDatagridPage() {
	datagrid.datagrid('getPager').pagination({
		pageSize: $('#pageSize').val(),
		pageList: [10,20,30,50],
		onSelectPage: function(pageNumber, pageSize) {
			$('#pageIndex').val(pageNumber);
			$('#pageSize').val(pageSize);
			searchDatagrid();
		}
	});
}

function registTreegridPage() {
	treegrid.treegrid('getPager').pagination({
		pageSize: $('#pageSize').val(),
		pageList: [10,20,30,50],
		onSelectPage: function(pageNumber, pageSize) {
			$('#pageIndex').val(pageNumber);
			$('#pageSize').val(pageSize);
			searchTreegrid();
		}
	});
}

function searchDatagrid() {
	$("#searchForm").ajaxSubmit(function(result) {
		datagrid.datagrid('loadData', {'total':result.totalData, 'rows':result.resultList});
	});
}

function searchTreegrid() {
	$("#searchForm").ajaxSubmit(function(result) {
		treegrid.treegrid('loadData', {'rows':result});
	});
}
