<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<!DOCTYPE html >
<html>

<head> 
<title>상품등록</title>

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

function fncAddPurchase() {
	
	$('form').attr("method", "POST").attr("action", "/purchase/addPurchase").submit();
}

$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
	 $( "button.btn.btn-primary" ).on("click" , function() {
		fncAddPurchase();
	});
	
	 $( "a[href='#']" ).on("click" , function() {
		// history.go(-1);
		});
 });	

</script>
</head>

<body>

<!--  toolbar here -->
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">상품 구매</h3>
	       <h5 class="text-muted">아래에 <strong class="text-danger">구매 정보</strong>를 입력해 주세요.</h5>
	    </div>
	

<form name="addPurchase"  class="form-horizontal"  >
	<input type="hidden" name="prodNo" value="${product.prodNo}" />
	
		<div class="form-group">
		    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
		    <div class="col-xs-8 col-md-4">${product.prodNo}</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-xs-8 col-md-4">${product.prodName}</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-xs-8 col-md-4">${product.manuDate}</div>
		  </div>
		  
		   <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-xs-8 col-md-4">${product.price}</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
		    <div class="col-xs-8 col-md-4">${product.regDate}</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
		    <div class="col-xs-8 col-md-4">${user.userId}</div>
		    <input type="hidden" name="buyerId" value="${user.userId}" />
		  </div>
		  
		 <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
		    <div class="col-sm-4">
		    <select 	name="paymentOption"	id="paymentOption"	class="form-control" >
				<option value="1" selected="selected">현금구매</option>
				<option value="2">신용구매</option>
			</select>
		  	</div>
		</div>
		
		 <div class="form-group">
		    <label for=receiverName class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		    <div class="col-sm-4">
		    <input type="text" name="receiverName" id="receiverName" class="form-control"  
		    				placeholder="${user.userName}" value="${user.userName}" />
		 	</div>
		 </div>

		 <div class="form-group">
		    <label for=receiverPhone class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
		    <div class="col-sm-4">
		    <input type="text" name="receiverPhone" id="receiverPhone" class="form-control"  
		    				placeholder="${user.phone}" value="${user.phone}" />
		 	</div>
		 </div>

		 <div class="form-group">
		    <label for=divyAddr class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		    <div class="col-sm-4">
		    <input type="text" name="divyAddr" id="divyAddr" class="form-control"  
		    				placeholder="${user.addr}" value="${user.addr}" />
		 	</div>
		 </div>

		 <div class="form-group">
		    <label for=divyAddr class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		    <div class="col-sm-4">
		    <input type="text" name="divyRequest" id="divyRequest" class="form-control"  
		    				placeholder="" value="" />
		 	</div>
		 </div>
		 <div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="divyDate" name="divyDate" placeholder="" readonly="readonly">
			      &nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15" 
											onclick="show_calendar('document.addPurchase.divyDate', document.addPurchase.divyDate.value)"/>
		    </div>
		  </div>		 
		 
		 <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >구&nbsp;매</button>
			  <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
		    </div>
		  </div>
		  
	</form> 
		  
 </div><!--  end of container -->
 
</body>
</html>