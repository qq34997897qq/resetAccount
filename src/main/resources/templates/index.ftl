<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>Web Admin Kits</title>
    <link rel="stylesheet" href="${request.contextPath}/layui/css/layui.css">
    <link rel="stylesheet" href="${request.contextPath}/css/style.css">
</head>
<body>
<!-- layout admin -->
<div class="layui-layout layui-layout-admin">
    <!-- header -->
    <div class="layui-header my-header">
        <a href="/">
            <div class="my-header-logo">Web Admin Kits</div>
        </a>
        <div class="my-header-btn">
            <button class="layui-btn layui-btn-small btn-nav"><i class="layui-icon">&#xe65f;</i></button>
        </div>
    </div>
    <!-- side -->
    <div class="layui-side my-side">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree" lay-filter="side-main">
               <li class="layui-nav-item">
                    <a href="javascript:;"><i class="layui-icon">&#xe628;</i>Query Account</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" href-url="/weblogin/query_login_info"><i class="layui-icon">&#xe621;</i>Query Login</a></dd>
                        <dd><a href="javascript:;" href-url="/user/query_contact_info"><i class="layui-icon">&#xe621;</i>Query Contact</a></dd>
                    </dl>
               </li>
               <li class="layui-nav-item  layui-nav-itemed">
                    <a href="javascript:;"><i class="layui-icon">&#xe620;</i>Update Account</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" href-url="/weblogin/update_login_info"><i class="layui-icon">&#xe621;</i>Update Login</a></dd>
                        <dd><a href="javascript:;" href-url="/user/update_contact_info"><i class="layui-icon">&#xe621;</i>Update Contact</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>
    <!-- body -->
    <div class="layui-body my-body">
        <div class="layui-tab layui-tab-card my-tab" lay-filter="card" lay-allowClose="true">
            <ul class="layui-tab-title">
                <li class="layui-this" lay-id="1"><span><i class="layui-icon">&#xe638;</i>Welcome Page</span></li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <#include "welcome.ftl">
                </div>
            </div>
        </div>
	</div>
	<!-- /.main-content -->
    <!-- footer -->
    <div class="layui-footer my-footer">
       <p class="text-muted">&copy; Company 2018. 2GoTrade.</p>
    </div>
    <footer>
</footer>
</div>

<div class="my-dblclick-box none">
    <table class="layui-tab dblclick-tab">
        <tr class="card-refresh">
            <td><i class="layui-icon">&#x1002;</i>Refresh</td>
        </tr>
        <tr class="card-close">
            <td><i class="layui-icon">&#x1006;</i>Close</td>
        </tr>
        <tr class="card-close-all">
            <td><i class="layui-icon">&#x1006;</i>Close All</td>
        </tr>
    </table>
</div>

<script type="text/javascript" src="${request.contextPath}/layui/layui.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/vip_comm.js"></script>
</body>
</html>