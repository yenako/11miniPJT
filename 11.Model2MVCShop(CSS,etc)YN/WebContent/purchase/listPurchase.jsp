<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">


function fncGetUserList(currentPage) {
	$("#currentPage").val(currentPage);
	$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();
}

$( function(){
	 
	//$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	
	$(".ct_list_pop td:nth-child(1)").css("color", "green");
	$(".ct_list_pop td:nth-child(1)").on("click", function(){
		self.location = "/purchase/getPurchase?tranNo="+$('input:hidden[name="tranNo"]', $(this)).val();
	});
	
	$(".ct_list_pop td:nth-child(2)").css("color", "green");
	$(".ct_list_pop td:nth-child(2)").on("click", function(){
		self.location = "/user/getUser?userId="+$('input:hidden[name="buyerId"]', $(this)).val();
	});
	
	$(".ct_list_pop td:nth-child(6)").css("color", "green");
	$(".ct_list_pop td:nth-child(6)").on("click", function(){
		self.location = "/purchase/updateTranCode?tranNo="+$('input:hidden[name="tranNoRe"]', $(this)).val()+"&tranCode=3";
	});
 });
 

// $( '#riverroad' ).tooltip( {
//     position: "center right",
//     opacity: 0.8
//   } ).dynamic( { bottom: { direction: 'down', bounce: true } } );


$( function(){

	$( ".ct_list_pop td:nth-child(2)").tooltip({
		
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
													+"���̵� : "+JSONData.userId+"<br/>"
													+"��  �� : "+JSONData.userName+"<br/>"
													+"�̸��� : "+JSONData.email+"<br/>"
													+"ROLE : "+JSONData.role+"<br/>"
													+"����� : "+JSONData.regDate+"<br/>"
													+"</h3>";
						console.log("1 :"+displayValue);
					}

			}); 
  		return displayValue;
      }
    
    });//end of tooltip;

  });//end of function;


</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	
		<div class="page-header text-info">
		<c:if test="${sessionScope.user.role=='admin'}">
	       <h3>�ǸŸ����ȸ</h3>
	     </c:if>
	     <c:if test="${sessionScope.user.role!='admin'}">
	       <h3>���Ÿ����ȸ</h3>
	     </c:if>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		</div>
		
	<form name="detailForm">
	   <input type="hidden" id="currentPage" name ="currentPage" value=""/>  
	</form>
		
<table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th style="text-align:center">No</th>
            <th style="text-align:center" >ȸ�� ID</th>
            <th style="text-align:center">��ǰ��</th>
            <th style="text-align:center">��ȭ��ȣ</th>
            <th style="text-align:center">�����Ȳ</th>
            <th style="text-align:center">��������</th>
          </tr>
        </thead>
       
		<tbody>

		<c:set var="i" value="0"/>
		<c:forEach var="purchase" items="${list }">
			<c:set var="i" value="${i+1 }"/>
			<tr class="ct_list_pop">
			
			  <td align="center">
			  			${i }
			  			<input type="hidden" name="tranNo" value="${purchase.tranNo}"/>
			  </td>
			  <td align="center">
	  				<a id='riverroad' href='#' title='hi' >${purchase.buyer.userId }</a>
	  				<input type="hidden" name="buyerId" value="${purchase.buyer.userId}"/>
			  </td>
			  <td align="center">${purchase.purchaseProd.prodName}</td>
			  <td align="center">${purchase.receiverPhone}</td>
			  <td align="center">
				  <c:choose>
					<c:when test="${purchase.tranCode=='1  ' }">
						���� ���ſϷ� ���� �Դϴ�.
					</c:when>
					<c:when test="${purchase.tranCode=='2  ' }">
						���� ������Դϴ�.
					</c:when>
					<c:when test="${purchase.tranCode=='3  ' }">
						���� ��ۿϷ� �����Դϴ�.
					</c:when>
					<c:otherwise>
					purchase.tranCode�� 1 ~3 �� �ƴմϴ�.
					</c:otherwise>
				</c:choose>
			  </td>
			  <td align="center">
				<c:if test="${purchase.tranCode=='2  ' }">
					<!--  <a href="/purchase/updateTranCode?tranNo=${purchase.tranNo }&tranCode=3">���ǵ���</a>-->
					���ǵ���
					<input type="hidden" name="tranNoRe" value="${purchase.tranNo}"/>
				</c:if>	
			</td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
      </div>
 
<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->

</body>

</html>


