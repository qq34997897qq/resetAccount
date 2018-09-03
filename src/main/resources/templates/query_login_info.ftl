<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>Query Login</title>
<link rel="stylesheet" href="${request.contextPath}/layui/css/layui.css">
<link rel="stylesheet" href="${request.contextPath}/css/style.css">
</head>
<body class="body">
	<div class="layui-form layui-form-pane" action="">
		<div class="layui-form-item" pane="">
			<label class="layui-form-label">Query By</label>
			<div class="layui-input-block">
				<input type="radio" name="query_type" value="acc_num"
					title="Acc Num" checked="" id="acc_num"> <input
					type="radio" name="query_type" value="login_name"
					title="Login Name" id="login_name">
			</div>
		</div>
		<div class="layui-form-item" pane="">
			<label class="layui-form-label">Is From File</label>
			<div class="layui-input-block">
				<input type="radio" name="from_file" lay-filter="from_file"value="Y" title="Yes" id="byfile" > 
					<input type="radio"name="from_file" lay-filter="from_file" value="N" title="No"checked="" id="byhand">
			</div>
		</div>
		<div class="layui-form-item" id="divaccount">
			<label class="layui-form-label">Account</label>
			<div class="layui-input-block">
				<input type="text" id="account" name="account" autocomplete="off"
					placeholder="Please input acc number or login name, , multiple separate with ','"
					class="layui-input"  >
			</div>
		</div>
		<div class="layui-form-item" style="display:none" id="divfile">
			<label class="layui-form-label">Account File</label>
			<form id="uploadForm" method="post" enctype="multipart/form-data">
				<input type="file" id="file" name="file"  />
			</form> 
		</div>

		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" onclick="getLoginInfo()">Query</button>
				<button id="clear" class="layui-btn layui-btn-primary ">Clear</button>
			</div>
		</div>
	</div>
	<div id="fileResult"></div>
	
<script src="${request.contextPath}/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/js/jquery.min.js" charset="utf-8"></script>
<script src="${request.contextPath}/js/nav.js" charset="utf-8"></script>
<script>
	
		layui.use('form', function() {
			var form = layui.form;
			form.on('radio(from_file)',function(data){
				if(data.value=="Y"){
				 $("#divfile").show();
				 $("#divaccount").hide();
				}else{
				$("#divfile").hide();
				$("#divaccount").show();
				
				}
			});
		});
		
		$("#clear").click(function(){
			$("#fileResult").html("");
		});		

		function getLoginInfo() {

			if ($('#byfile').is(':checked')) {//文件
				getLoginInfoByFile();
			} else {
				getLoginInfoByHand();

			}
		}

		function getLoginInfoByFile() {

			var url;

			if ($('#acc_num').is(':checked')) {
				url = "/weblogin/query_login_info/file/acc_num";
			} else {
				url = "/weblogin/query_login_info/file/login_name;"
			}

			if ($("#file").val() != "") {
				var formData = new FormData($("#uploadForm")[0]);
				$.ajax({
							type : "POST",
							data : formData,
							processData : false,
							contentType : false,
							url : url,
							success : function(result) {
								showResult(result);
							}
						});

			} else {
				alert("请选择文件");
			}
		}

		function getLoginInfoByHand() {//查找 

			var url;
			var account = $("#account").val();
			if ($('#acc_num').is(':checked')) {
				url = "/weblogin/query_login_info/acc_num?account="+account;
			} else {
				url = "/weblogin/query_login_info/login_name?account="+account;
			}
			if (account == "") {
				alert("不能为空");
			} else {
				//$("#account").html("");
				$.ajax({
					type : "GET",
					contentType:"application/json; charset=utf-8",
					dataType : "json",
					url : url,
					success : function(result) {
						showResult(result);
					}
				});

			}

		}

		function showResult(result) { //结果显示

			str = "<table class='layui-table'>"
				+ "<colgroup>"
				+ "    <col width='150'>"
				+ "    <col width='150'>"
				+ "</colgroup>"
				+ "<thead>"
				+ "<tr>"
				+ "    <th>Acc Num</th>"
				+ "    <th>Login Name</th>"
				+ "</tr>"
				+ "</thead>";

			$.each(result, function(index, item) {
				str += "<tbody><tr>" + "<td>"
				+ item.accNum + "</td>"
				+ "<td>"
				+ item.loginName + "</td>"
				+ "</tr></tbody>"
			});

			str += "</table>";
			$("#fileResult").html(str);
		}

	</script>
</body>
</html>