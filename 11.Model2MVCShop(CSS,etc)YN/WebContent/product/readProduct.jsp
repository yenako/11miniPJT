<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!--  not sure to leave it -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
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

		<style>
 		body {
            padding-top : 50px;
        }
     </style>

<script type="text/javascript">

 	function fncAddComment(){
 		alert("#addComment ����");
		var text =$("input[name='text']").val();
		
		if(text==null || text.length<1){
			alert("��۳����� �Է����ּ���.");
			return;
		}
		
		var sendData = {
										prodNo : $("input[name='prodNo']").val(),
										text : $("input[name='text']").val()
									};
		//ajax POST������� add ����.
		$.ajax(
				{
					url : "/product/json/addComment" ,
					method : "POST" ,
					data : JSON.stringify(sendData),
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData, status) {
						$("input[name='text']").val(null);
					}
			});
		
	} 


	$( function(){
	
		$("#purchase").on("click", function(){
			self.location ="/purchase/addPurchase?prodNo=${product.prodNo}";
		});
			
		$("#back").on("click", function(){
			history.go(-1);
		});
		
	})
	
	
	$( function(){
			
			$( "#addComment" ).on("click" , function() {	
				alert("#addComment ���� ��,");
				///1. db�� insert�ϴ� �κ� 
				fncAddComment();
				
				//2. ���ο� list �ҷ����� �κ�
				var prodNo = $("input[name='prodNo']").val();
				alert("�� ��ǰ�� prodNo��"+prodNo);
				$.ajax(
						{
							url : "/product/json/getCommentList/"+prodNo+"" ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData, status) {
		                        var str = "";
		                        if(JSONData != ""){
		                        	str+= "<table class='table table-hover table-striped' id='comList' > <tbody>";
		                        	
		                            $(JSONData).each(
		                               function(){
		                            	   str+= 	"<tr><td>"
							                	+			this.customerId+"&nbsp;"+ this.regDate
							                	+		"</td>"
							                	+		"<td>"
							                	+			this.text
							                	+		 "</td></tr>";

		                               }//end of function
		                              );
		                              str+="</tbody></table>";
		                        }//end of if��
		                        $("#comList").remove();
								$( "form[name='detailForm']").after(str);
							}
					});
			});
		});

	</script>
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	<div class="container">
		<div class="page-header">
	       <h3 class=" text-info">��ǰ����ȸ</h3>
	       <h5 class="text-muted">�����Ͻ� <strong class="text-danger">��ǰ ����</strong>�� ������ �����ϴ�.</h5>
	    </div>
	    
	<form class="form-horizontal" name="toPurchase">

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
	  			<button type="button" id="back" class="btn btn-primary">�� ��</button>
	  		</div>
		</div>

</form>
	<br/>
</div>

		<!-- NEW comment part here -->
	<form name="detailForm" >
		<div class="form-group">
	    	<label for="textm" class="col-sm-offset-1 col-sm-3 control-label">��۴ޱ�</label>
    		<span class="col-sm-4">
      			<input type="text" class="form-control" id="textm" name="text" placeholder="���⿡ ����� �Է����ּ���">
      			<input type="hidden" name="prodNo" value="${product.prodNo}">
    		</span>
   			 <button type="button" id="addComment" class="btn btn-primary"  >[��۵��]</button>
	 	 </div>
	</form>
	  
	<c:if test="${commentList != null}">
	 <table class="table table-hover table-striped" id="comList" >
			<tbody>
				<c:forEach var="comment" items="${commentList}">
					<tr>
						<td>
						${comment.customerId}&nbsp; ${comment.regDate}
						</td>
						<td>
						${comment.text }
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>


</body>
</html>