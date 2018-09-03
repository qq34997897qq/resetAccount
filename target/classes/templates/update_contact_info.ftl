<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>Update Contact</title>
<link rel="stylesheet" href="${request.contextPath}/layui/css/layui.css">
<link rel="stylesheet" href="${request.contextPath}/css/style.css">
</head>
<body class="body">
	<div class="layui-form layui-form-pane" action="">

		<div class="layui-form-item" pane="">
			<label class="layui-form-label">Is From File</label>
        	<div class="layui-input-block">
          		<input type="radio" name="from_file" lay-filter="from_file" value="Y" title="Yes" id="byfile">
            	<input type="radio" name="from_file" lay-filter="from_file" value="N" title="No" checked="" id="byhand">
        	</div>
		</div>

		<div class="layui-form-item" id="divaccount">
			<label class="layui-form-label">Account</label>
			<div class="layui-input-block">
				<input type="text" name="account" id="account" autocomplete="off"
					placeholder="Please input acc number or login name, , multiple separate with ','"
					class="layui-input">
			</div>
		</div>
		<div class="layui-form-item" style="display:none" id="divfile">
			<label class="layui-form-label">Account Contact File</label>
			<form id="uploadForm" method="post" enctype="multipart/form-data">
				<input type="file" id="file" name="file" />
			</form>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">Email#1</label>
			<div class="layui-input-block">
				<input type="text" name="email1" id="email1" autocomplete="off"
					class="layui-input">
			</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">Email#2</label>
			<div class="layui-input-block">
				<input type="text" name="email2" id="email2" autocomplete="off"
					class="layui-input">
			</div>
		</div>


		<div class="layui-form-item">
			<label class="layui-form-label">AreaCode#1</label>
			<div class="layui-input-block">
				<input type="text" name="areaCode1" id="areaCode1"
					autocomplete="off" class="layui-input">
			</div>
			<label class="layui-form-label">Phone#1</label>
			<div class="layui-input-block">
				<input type="text" name="phone1" id="phone1" autocomplete="off"
					class="layui-input">
			</div>
		</div>


		<div class="layui-form-item">
			<label class="layui-form-label">AreaCode#2</label>
			<div class="layui-input-block">
				<input type="text" name="areaCode2" id="areaCode2"
					autocomplete="off" class="layui-input">
			</div>
			<label class="layui-form-label">Phone#2</label>
			<div class="layui-input-block">
				<input type="text" name="phone2" id="phone2" autocomplete="off"
					class="layui-input">
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" onclick="resetContactInfo()">Submit</button>
				<button id="clear" class="layui-btn layui-btn-primary">Clear</button>
				<button class="layui-btn">
					<a href="${request.contextPath}/model/acc_contact_template.xlsx"
						download="acc_contact_template.xlsx" style="color: #FFFFFF;">Download Account Contact File Template</a>
				</button>
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

		$("#clear").click(function() {
			$("#fileResult").html("");
		});

		function resetContactInfo() {//批量重置属性	

			if ($('#byfile').is(':checked')) {
				resetContactInfoByFile();
			} else {
				resetContactInfoByHand();

			}

		}

		function resetContactInfoByFile() {//通过文件设置属性

			var formData = new FormData($("#uploadForm")[0]);

			if ($("#file").val() == "") {
				alert("请上传文件");
			} else {

				$.ajax({
					type : "POST",
					contentType : "application/json; charset=utf-8",
					dataType : "json",
					data : formData,
					processData : false,
					contentType : false,
					url : "/user/update_contact_info/file/acc_num",
					success : function(result) {
						showResult(result);
					}

				});

			}

		}

		function resetContactInfoByHand() { //手动输入属性
			var data;

			if ($("#account").val() == "") {
				alert("不能有空");
			} else {

				data = JSON.stringify({
					accNum : $("#account").val(),
					email1 : $("#email1").val(),
					email2 : $("#email2").val(),
					areaCode1 : $("#areaCode1").val(),
					phone1 : $("#phone1").val(),
					areaCode2 : $("#areaCode2").val(),
					phone2 : $("#phone2").val(),
				});
				$.ajax({
					type : "POST",
					contentType : "application/json; charset=utf-8",
					dataType : "json",
					data : data,
					url : "/user/update_contact_info/acc_num",
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
			+ "    <th>Email#1</th>"
			+ "    <th>Email#2</th>"
			+ "    <th>AreeCode#1</th>"
			+ "    <th>Phone#1</th>"
			+ "    <th>AreaCode#2</th>"
			+ "    <th>Phone#2</th>"
			+ "</tr>"
			+ "</thead>";

		$.each(result, function(index, item) {
			str += "<tbody><tr>" + 
			"<td>"+ item.accNum + "</td>"+
			"<td>"+ item.email1 + "</td>"+ 
			"<td>"+ item.email2 + "</td>"+ 
			"<td>"+ item.areaCode1 + "</td>"+ 
			"<td>"+ item.phone1 + "</td>"+ 
			"<td>"+ item.areaCode2 + "</td>"+ 
			"<td>"+ item.phone2 + "</td>"+ 
			"</tr></tbody>"
		});

			str += "</table>";
			$("#fileResult").html(str);
		}
	</script>
</body>
</html>