<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
<html>
<head>
<title>구매 목록조회</title>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript">


function fncGetPurchaseList(currentPage) {
	$("#currentPage").val(currentPage);
	$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();
}

$( function(){
	 
	$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	
	$(".ct_list_pop td:nth-child(1)").css("color", "green");
	$(".ct_list_pop td:nth-child(1)").on("click", function(){
		self.location = "/purchase/getPurchase?tranNo="+$('input:hidden[name="tranNo"]', $(this)).val();
	});
	
	$(".ct_list_pop td:nth-child(3)").css("color", "green");
	$(".ct_list_pop td:nth-child(3)").on("click", function(){
		self.location = "/user/getUser?userId="+$('input:hidden[name="buyerId"]', $(this)).val();
	});
	
	$(".ct_list_pop td:nth-child(11)").css("color", "green");
	$(".ct_list_pop td:nth-child(11)").on("click", function(){
		self.location = "/purchase/updateTranCode?tranNo="+$('input:hidden[name="tranNoRe"]', $(this)).val()+"&tranCode=3";
	});
 });
 

// $( '#riverroad' ).tooltip( {
//     position: "center right",
//     opacity: 0.8
//   } ).dynamic( { bottom: { direction: 'down', bounce: true } } );

// $( "#riverroad").each(function() {
	$( function(){

//     $( this).tooltip({
//  	$( "#riverroad").tooltip({
	$( ".ct_list_pop td:nth-child(3)").tooltip({
		
		effect: 'fade', 
		content: function(){
    	 var userId = $(this).text().trim();
    	 
    	  console.log("in the function");
  		 $.ajax( {
					url : "/user/json/getUser/"+userId ,
					method : "GET" ,
					dataType : "json" ,
					async : false,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData , status) {
						
						 displayValue = "<h3>"
													+"아이디 : "+JSONData.userId+"<br/>"
													+"이  름 : "+JSONData.userName+"<br/>"
													+"이메일 : "+JSONData.email+"<br/>"
													+"ROLE : "+JSONData.role+"<br/>"
													+"등록일 : "+JSONData.regDate+"<br/>"
													+"</h3>";
						
//						$(".ct_list_pop td:nth-child(3)" ).tooltip( "option", "content", displayValue ).tooltip('close').tooltip('open');
// 						function reloadToolTip(text){
// 							  $('#mybody p').tooltip({contents:text}).tooltip('close').tooltip('open');
// 							}
					
						console.log("1 :"+displayValue);
						//$("h3").remove();
						//$( "#"+userId+"" ).html(displayValue);
					}

			}); 
  		return displayValue;
      }
    
    });//end of tooltip;

  });//end of function;



</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" >

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
				<c:if test="${sessionScope.user.role=='admin'}">
					<td width="93%" class="ct_ttl01">판매 목록조회</td>
				</c:if>
				<c:if test="${sessionScope.user.role!='admin'}">
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</c:if>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">
		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

<c:set var="i" value="0"/>
<c:forEach var="purchase" items="${list }">
		<c:set var="i" value="${i+1 }"/>
	<tr class="ct_list_pop">
		<td align="center">
			<!-- <a href="/purchase/getPurchase?tranNo=${purchase.tranNo }">${i }</a> -->
			${i }<input type="hidden" name="tranNo" id="tranNo" value="${purchase.tranNo }"/>
		</td>
		<td></td>
		<td align="center"><a id='riverroad' href='#' title='hi' >${purchase.buyer.userId }</a>
			<!-- <a href="/getUser.do?userId=${purchase.buyer.userId }">${purchase.buyer.userId }님</a> -->
			<input type="hidden" name="buyerId" value="${purchase.buyer.userId}"/>
		</td>
		<td></td>
		<td align="center">${purchase.purchaseProd.prodName}</td>
		<td></td>
		<td align="center">${purchase.receiverPhone}</td>
		<td></td>
		<td align="center">
		
		
			<c:choose>
				<c:when test="${purchase.tranCode=='1  ' }">
					현재 구매완료 상태 입니다.
				</c:when>
				<c:when test="${purchase.tranCode=='2  ' }">
					현재 배송중입니다.
				</c:when>
				<c:when test="${purchase.tranCode=='3  ' }">
					현재 배송완료 상태입니다.
				</c:when>
				<c:otherwise>
				purchase.tranCode가 1 ~3 이 아닙니다.
				</c:otherwise>
			</c:choose>
			
			
		</td>
		<td></td>
		<td align="left">
		
			<c:if test="${purchase.tranCode=='2  ' }">
				<!--  <a href="/purchase/updateTranCode?tranNo=${purchase.tranNo }&tranCode=3">물건도착</a>-->
				물건도착
				<input type="hidden" name="tranNoRe" value="${purchase.tranNo}"/>
			</c:if>
						
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
				<input type="hidden" id="currentPage" name ="currentPage" value=""/>
			<jsp:include page="../common/purchasePageNavigator.jsp"/>
		</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>
</div>
</body>
</html>