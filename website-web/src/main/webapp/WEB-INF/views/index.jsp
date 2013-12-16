<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    	<jsp:include page="layout/head.jsp" />
    </head>
	
    <body class="easyui-layout">
    
		<jsp:include page="layout/nouth.jsp" />

		<jsp:include page="layout/left.jsp" />

		<jsp:include page="layout/center.jsp" />
		
		<jsp:include page="layout/south.jsp" />
		
    </body>
	
</html>