<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div data-options="region:'west',split:true" title="控制面板" style="width:250px;">
	<div class="easyui-accordion" data-options="fit:true,border:false">
		<div title="快捷方式" style="padding:10px;">
			<ul class="easyui-tree">
                <li>
                    <a href="${ctx}/admin" onclick="openTab(this);">用户管理</a>
                </li>
                <li>
                    <a href="${ctx}/role" onclick="openTab(this);">角色管理</a>
                </li>
                <li>
                    <a href="${ctx}/permission" onclick="openTab(this);">权限管理</a>
                </li>
                <li>
                    <a href="${ctx}/menu" onclick="openTab(this);">菜单管理</a>
                </li>
                <li>
                    <a href="${ctx}/log" onclick="openTab(this);">日志管理</a>
                </li>
                <li>
                    <a href="http://www.baidu.com" onclick="openTab(this);">Iframe演示</a>
                </li>
         	</ul>
		</div>
		<div title="系统管理" style="padding:10px;">
			<ul class="easyui-tree">
                <li>
                    <a href="http://www.baidu.com" onclick="openTab(this);">用户管理</a>
                </li>
                <li>
                    <a href="${ctx}/role" onclick="openTab(this);">角色管理</a>
                </li>
                <li>
                    <a href="http://www.baidu.com" onclick="openTab(this);">权限管理</a>
                </li>
                <li>
                    <a href="${ctx}/menu" onclick="openTab(this);">菜单管理</a>
                </li>
                <li>
                    <a href="${ctx}/log" onclick="openTab(this);">日志管理</a>
                </li>
         	</ul>
		</div>
		<div title="网站管理" style="padding:10px">
			<ul class="easyui-tree">
                <li>
                    <a href="#" onclick="alertMsg('title', 'message', 'info');">弹出框演示</a>
                </li>
         	</ul>
		</div>
		<div title="系统管理" style="padding:10px;">
			<ul class="easyui-tree">
                <li>
                    <a href="#" onclick="showMsg();">消息框演示</a>
                </li>
         	</ul>
		</div>
		<div title="网站管理" style="padding:10px">
			<ul class="easyui-tree">
                <li>
                    <a href="#" onclick="alertMsg('title', 'message', 'info');">弹出框演示</a>
                </li>
         	</ul>
		</div>
		<div title="系统管理" style="padding:10px;">
			<ul class="easyui-tree">
                <li>
                    <a href="#" onclick="showMsg();">消息框演示</a>
                </li>
         	</ul>
		</div>
		<div title="网站管理" style="padding:10px">
			<ul class="easyui-tree">
                <li>
                    <a href="#" onclick="alertMsg('title', 'message', 'info');">弹出框演示</a>
                </li>
         	</ul>
		</div>
		<div title="系统管理" style="padding:10px;">
			<ul class="easyui-tree">
                <li>
                    <a href="#" onclick="showMsg();">消息框演示</a>
                </li>
         	</ul>
		</div>
	</div>
</div>