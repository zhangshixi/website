<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
    	
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<meta name="keywords" content="keywords" />
<meta name="description" content="Description" />

<link rel="stylesheet" type="text/css" href="${ctx}/easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/easyui/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/styles/main.css" />

<script type="text/javascript" src="${ctx}/scripts/jquery.js"></script>
<script type="text/javascript" src="${ctx}/easyui/jquery.easyui.js"></script>
<script type="text/javascript" src="${ctx}/easyui/easyui.extend.js"></script>
<script type="text/javascript" src="${ctx}/scripts/util.js"></script>
<script type="text/javascript">
	$(window).resize(function () {
		$('.easyui-datagrid').datagrid('resize');
		$('.easyui-treegrid').treegrid('resize');
	}); 
</script>