function openTab(target) {
	var icon = 'icon-ok';
	var title = $(target).html();
	
	if ($('#tabs').tabs('exists', title)) {
		$('#tabs').tabs('select', title);
	} else {
		$(target).attr('target', title);
		$('#tabs').tabs('add', {title:title, content:createFrame(title), closable:true, icon:icon});
		bindEvnet(title);
	}
}

function createFrame(title) {
	return '<iframe scrolling="auto" frameborder="0" name="'+title+'" style="width:100%;height:100%;"></iframe>';
}

function bindEvnet(title) {
	// close tab on double click
	$(".tabs-inner").dblclick(function() {
		$('#tabs').tabs('close', title);
	});
}

function alertMsg(title, message, type) {
	// type: error | info | question | warning
	$.messager.alert(title, message, type);
}

function showMsg() {
	$.messager.show({
		title:'My Title',
		msg:'Message will be closed after 4 seconds.',
		showType:'show'
	});
}
		