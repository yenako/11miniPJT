<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

		<style>
 		body {
            padding-top : 50px;
        }
     </style>

<script type="text/javascript">

	$( function(){
		

		//$("td:contains(����)").on("click", function(){
			$("button.btn.btn-primary:last").on("click", function(){
				history.go(-1);
			/* var test=window.history;
			alert(test); */
			});
		})
	
		
	$( function(){
		//$("td:contains(����)").on("click", function(){
			$("#purchase").on("click", function(){
			self.location ="/purchase/addPurchase?prodNo=${product.prodNo}";
		});
	})
	

	</script>
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	<div class="container">
		<div class="page-header">
	       <h3 class=" text-info">��ǰ����ȸ</h3>
	       <h5 class="text-muted">�����Ͻ� <strong class="text-danger">��ǰ ����</strong>�� ������ �����ϴ�.</h5>
	    </div>
	    
	<form class="form-horizontal">
	
	 
	     <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
		<hr/>
	     <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�� ǰ ��</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		<hr/>
	     <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ�̹���</strong></div>
			<div class="col-xs-8 col-md-4"><img src ="/images/uploadFiles/${product.fileName}"/></div>
		</div>
		<hr/>
	     <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ������</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
		</div>
		<hr/>
	     <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}</div>
		</div>
		<hr/>
	     <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>����</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>
		</div>			
		<hr/>
	     <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�������</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div>	
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" id="purchase" class="btn btn-primary">�� ��</button>&nbsp;
	  			<button type="button" class="btn btn-primary">�� ��</button>
	  		</div>
		</div>

</form>
	<br/>
</div>
</body>
</html>