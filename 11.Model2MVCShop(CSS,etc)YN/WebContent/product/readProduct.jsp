<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	<!-- 예나 added -->
	<link rel="stylesheet" href="/css/comment.css" rel="stylesheet">
	<link rel="stylesheet" href="/css/comment.min.css" rel="stylesheet">
	<link rel="stylesheet" href="/css/icon.css" rel="stylesheet">
	<link rel="stylesheet" href="/css/icon.min.css" rel="stylesheet">
	
	<!--  예나 Added end-->
	
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
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

		<style>
 		body {
            padding-top : 50px;
        }
     </style>

<script type="text/javascript">

 	function fncAddComment(){
 		alert("#addComment 수행");
		var text =$("input[name='text']").val();
		
		if(text==null || text.length<1){
			alert("댓글내용을 입력해주세요.");
			return;
		}
		
		var sendData = {
										prodNo : $("input[name='prodNo']").val(),
										text : $("input[name='text']").val()
									};
		//ajax POST방식으로 add 수행.
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
				alert("#addComment 수행 전,");
				///1. db에 insert하는 부분 
				fncAddComment();
				
				//2. 새로운 list 불러오는 부분
				var prodNo = $("input[name='prodNo']").val();
				alert("이 상품의 prodNo는"+prodNo);
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
		                        }//end of if문
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
	       <h3 class=" text-info">상품상세조회</h3>
	       <h5 class="text-muted">선택하신 <strong class="text-danger">상품 정보</strong>는 다음과 같습니다.</h5>
	    </div>
	    
	<form class="form-horizontal" name="toPurchase">

	     <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
		<hr/>
	     <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상 품 명</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		<hr/>
	     <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품이미지</strong></div>
			<div class="col-xs-8 col-md-4"><img src ="/images/uploadFiles/${product.fileName}"/></div>
		</div>
		<hr/>
	     <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
		</div>
		<hr/>
	     <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}</div>
		</div>
		<hr/>
	     <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>
		</div>			
		<hr/>
	     <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div>	
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" id="purchase" class="btn btn-primary">구 매</button>&nbsp;
	  			<button type="button" id="back" class="btn btn-primary">이 전</button>
	  		</div>
		</div>

</form>
	<br/>
</div>


<c:if test="${commentList != null}">
<!--  여기부터 -->
<div class="ui comments" style="padding:60px;">
 <h3 class="ui dividing header">Comments</h3>
 
<c:forEach var="comment" items="${commentList}">
  <div class="comment">
    <a class="avatar">
      <img src="/images/userFaces/tom.jpg">
    </a>
    <div class="content">
      <a class="author"> ${comment.customerId}</a>
      <div class="metadata">
        <span class="date">${comment.regDate}</span>
      </div>
      <div class="text">
        ${comment.text }
      </div>
      <div class="actions">
        <a class="reply">Reply</a>
      </div>
    </div>
  </div>
  
  <div class="comment">
    <a class="avatar">
      <img src="/images/userFaces/nan.jpg">
    </a>
    <div class="content">
      <a class="author">Elliot Fu</a>
      <div class="metadata">
        <span class="date">Yesterday at 12:30AM</span>
      </div>
      <div class="text">
        <p>This has been very useful for my research. Thanks as well!</p>
      </div>
      <div class="actions">
        <a class="reply">Reply</a>
      </div>
    </div>
 <!--  
   <div class="comments">
      <div class="comment">
        <a class="avatar">
          <img src="/images/avatar/small/jenny.jpg">
        </a>
        <div class="content">
          <a class="author">Jenny Hess</a>
          <div class="metadata">
            <span class="date">Just now</span>
          </div>
          <div class="text">
            Elliot you are always so right :)
          </div>
          <div class="actions">
            <a class="reply">Reply</a>
          </div>
        </div>
      </div>
    </div> 
  -->
  </div>
</c:forEach>

  
  <form class="ui reply form">
    <div class="field">
      <textarea  class="form-control" id="textm" name="text" placeholder="여기에 댓글을 입력해주세요"> </textarea>
      	<input type="hidden" name="prodNo" value="${product.prodNo}">
    </div>
    <div class="ui blue labeled submit icon button">
      <i class="icon edit"></i> 댓글달기
    </div>
  </form>
  
    </div> 
   </c:if>


</body>
</html>