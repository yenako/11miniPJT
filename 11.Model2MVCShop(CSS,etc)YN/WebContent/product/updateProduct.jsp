<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<!DOCTYPE html >
<html>

<head> 
<title>상품수정</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
<!-- Bootstrap Dropdown Hover CSS -->
 <link href="/css/animate.min.css" rel="stylesheet">
 <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
 
  <!-- Bootstrap Dropdown Hover JS -->
 <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<script type="text/javascript" src="../javascript/calendar.js"></script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	
	<style>
		body{
			padding-top:50px;
		}
	</style>

<script type="text/javascript">

function fncUpdateProduct(){

 	var name = $("input[name='prodName']").val();
	var detail = $("input[name='prodDetail']").val();
	var manuDate = $("input[name='manuDate']").val();
	var price = $("input[name='price']").val();

	if(name == null || name.length<1){
		alert("상품명은 반드시 입력하여야 합니다.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("상품상세정보는 반드시 입력하여야 합니다.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("제조일자는 반드시 입력하셔야 합니다.");
		return;
	}
	if(price == null || price.length<1){
		alert("가격은 반드시 입력하셔야 합니다.");
		return;
	}
		
	$('form').attr("method", "POST").attr("action", "/product/updateProduct").submit();
}

$( function(){
	$("button.btn.btn-primary:first" ).on("click", function(){
		fncUpdateProduct();
	});
});

$( function(){
	$("button.btn.btn-primary:last").on("click", function(){
		window.history.go(-1);
	});
});


</script>
</head>

<body>
	<!--  toolbar here -->
	<jsp:include page="/layout/toolbar.jsp" />
	
<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">상품수정</h3>
	       <h5 class="text-muted">수정할 <strong class="text-danger">상품정보</strong>를 입력해 주세요.</h5>
	    </div>

	<form class="form-horizontal" name="detailForm"  enctype="multipart/form-data">
	
		<input type="hidden" name="prodNo" value="${product.prodNo}"/>

		 <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상 품 명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName"  
		      				placeholder="${product.prodName}" value="${product.prodName}" >
		    </div>
		  </div>
		  
		<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail"
		      				placeholder="${product.prodDetail}" value="${product.prodDetail}" >
		    </div>
		  </div>
		  
		 <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate"
		      				placeholder="${product.manuDate}" value="${product.manuDate}" >&nbsp;
		    	<img 	src="../images/ct_icon_date.gif" width="15" height="15" 
					onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)" />
		    </div>
		  </div>

		<div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price"
		      				placeholder="${product.price}" value="${product.price}" >&nbsp;원
		    </div>
		  </div>	  
		  
		 <div class="form-group">
		    <label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		    <div class="col-sm-4">
		      <input type="file" class="form-control" id="fileName" name="file"
		      				value="${product.fileName}"  >
		    </div>
		  </div>	
		  
		 <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >수 &nbsp;정</button>
			  <button type="button" class="btn btn-primary"  >취 &nbsp;소</button>
		    </div>
		  </div>
	</form> 
	
	 </div><!--  end of container -->
 
</body>
</html>	  
		  

