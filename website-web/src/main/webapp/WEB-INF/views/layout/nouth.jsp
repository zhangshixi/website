<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div id="header" region="north" style="height:80%;">
	<div id="header-inner">
		<table cellpadding="0" cellspacing="0" style="width:100%;">
			<tbody>
				<tr>
					<td rowspan="2" style="width:20px;">
					</td>
					<td style="height:52px;">
						<div style="color:#fff;font-size:22px;font-weight:bold;">
							<a href="http://www.jeasyui.com/index.php" style="color:#fff;font-size:22px;font-weight:bold;text-decoration:none">jQuery EasyUI</a>
						</div>
						<div style="color:#fff">
							<a href="http://www.jeasyui.com/index.php" style="color:#fff;text-decoration:none">help you build web pages easily!</a>
						</div>
					</td>
					<td style="padding-right:5px;text-align:right;vertical-align:bottom;">
						<div id="topmenu">
							<a href="http://www.jeasyui.com/demo/main/index.php" onclick="openTab(this);">Home</a>
							<a href="http://www.jeasyui.com/demo/main/index.php" onclick="openTab(this);">Demo</a>
							<a href="http://www.jeasyui.com/tutorial/index.php" onclick="openTab(this);">Tutorial</a>
							<a href="http://www.jeasyui.com/documentation/index.php" onclick="openTab(this);">Documentation</a>
							<a href="http://www.jeasyui.com/download/index.php" onclick="openTab(this);">Download</a>
							<a href="http://www.jeasyui.com/extension/index.php" onclick="openTab(this);">Extension</a>
							<a href="http://www.jeasyui.com/contact.php" onclick="openTab(this);">Contact</a>
							<a href="http://www.jeasyui.com/forum/index.php" onclick="openTab(this);">Forum</a>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>