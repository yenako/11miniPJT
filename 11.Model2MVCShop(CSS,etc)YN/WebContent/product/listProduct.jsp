<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="ko">
<%-- <%@include file= "/product/" %> --%>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>상품 목록조회</title>
	
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
	
	function fncGetProductList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
	   	$("#currentPage").val(currentPage)
		//document.detailForm.submit();		

		$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${param.menu }&sortBy=${param.sortBy}").submit();
	}


	$( function(){
		
		//$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");		
	
		//if(  !$( $("tr.ct_list_pop td:nth-child(3)").find('input')[0]).val()  ) {	
		//	$(this).css("color" , "green");
		//}

			$("button:contains('검색')").on("click", function(){
				fncGetProductList('1');
			});
			
			$("th:contains('가격') span:first").on("click", function(){
				$("#sorting").val("desc");
				alert("setting이 잘되엇나.. "+$("input:hidden[name='sorting']").val());
				self.location ="/product/listProduct?menu=${param.menu }&sortBy=desc"
			});
			
			$("th:contains('가격') span:last").on("click", function(){
				$("input:hidden[name='sorting']").val("asc");
				alert("setting이 잘되엇나.. "+$("input:hidden[name='sorting']").val());
				self.location ="/product/listProduct?menu=${param.menu }&sortBy=asc";
			});
			
			/* $("tr.ct_list_pop:contains('배송하기') ").on("click", function(){ 
			//$("#deliver").on("click", function(){
				self.location ="/purchase/updateTranCodeByProd?prodNo="+$(this).find("input[name='prodNo']").val()+"&tranCode=2";
			});

			console.log("input hidden prodNo2 :  "+$("tr.ct_list_pop:contains('배송하기') span:first").find('input').val()  );

			$("tr.ct_list_pop td:nth-child(2)").on("click", function(){
				if( ${ sessionScope.user.role eq 'admin'} || !$( $(this).find('input')[0]).val() ) {
					self.location ="/product/getProduct?prodNo="+$( $(this).find('input')[1]).val() +"&menu=${param.menu}"
					}
			}); */
	});
		
	$(document).ajaxComplete(function(){
	    // fire when any Ajax requests complete
		$("tr.ct_list_pop:contains('배송하기') ").on("click", function(){ 
			//$("#deliver").on("click", function(){
				self.location ="/purchase/updateTranCodeByProd?prodNo="+$(this).find("input[name='prodNo']").val()+"&tranCode=2";
			});

			console.log("input hidden prodNo2 :  "+$("tr.ct_list_pop:contains('배송하기') span:first").find('input').val()  );

			$("tr.ct_list_pop td:nth-child(2)").on("click", function(){
			 	if(  ${ sessionScope.user.role eq 'admin'} || !$( $(this).find('input')[0]).val() ) {
					self.location ="/product/getProduct?prodNo="+$( $(this).find('input')[1]).val() +"&menu=${param.menu}"
					}
			});
			
			$( "tr.ct_list_pop:contains('판매중') span" ).on("click" , function() {	
				alert("판매중을 클릭했습니다.");
				var prodNo = $( $(this).find('input')).val();
				console.log(prodNo);
				$.ajax(
						{
							url : "/product/json/getProduct/"+prodNo+"/manage" ,
							method : "GET" ,
							dataType : "json" ,
							async : false,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								
								alert(prodNo);+
								//Debug...
								alert(status);
								//Debug...
								alert("JSONData string : \n"+JSON.stringify(JSONData));
								//console.log("fileName : "+JSONData.fileName);
								var displayValue = "<img src =/images/uploadFiles/"
																+JSONData.fileName+"/>";
								//Debug...									
								//alert(displayValue);
								$("img").remove();
								$( "#image").html(displayValue);
							}
					});
			});
	});
			
		$( function(){		
			$( document ).tooltip();
	   	});	 
		

	
	$( function() {
		$( "#searchKeyword" ).on('keyup', function(){
					
					$.ajax(
							{
							url : "/product/json/getProdNames" ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								
									$(  "#searchKeyword"  ).autocomplete({	
										source:  JSONData
									});
							}
					  });//end of ajax
			});
	 });	
	
	
		/* $( function(){
			
			$( "tr.ct_list_pop:contains('판매중') span" ).on("click" , function() {	
				alert("판매중을 클릭했습니다.");
				var prodNo = $( $(this).find('input')).val();
				console.log(prodNo);
				$.ajax(
						{
							url : "/product/json/getProduct/"+prodNo+"/manage" ,
							method : "GET" ,
							dataType : "json" ,
							async : false,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								
								alert(prodNo);
								//Debug...
								alert(status);
								//Debug...
								alert("JSONData string : \n"+JSON.stringify(JSONData));
								//console.log("fileName : "+JSONData.fileName);
								var displayValue = "<img src =/images/uploadFiles/"
																+JSONData.fileName+"/>";
								//Debug...									
								//alert(displayValue);
								$("img").remove();
								$( "#image").html(displayValue);
							}
					});
			});
		}); */
	////////////////////////////////////////////////////////////////////////////////////////////////
		  
		  	var lastScrollTop = 0;
			var pageNo = 2;
			var no = 10;
		  	var scrollLocker = true;
		  

		    // 1. 스크롤 이벤트 발생
		    $(window).scroll(function(){ // ① 스크롤 이벤트 최초 발생
		    	
		    	
		        var currentScrollTop = $(window).scrollTop();
				
		        if( currentScrollTop - lastScrollTop > 0 ){
		            if ($(document).height() <= $(window).scrollTop() + $(window).height() + 10 && scrollLocker) { //+10  
		            	//var sort = $("#sorting").val();
		            	//alert(sort);
		            	scrollLocker = false;

		                $.ajax({
		                	url : "/product/json/listProduct/"+pageNo,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
		                    success : function(data){
		                        var str = "";
		                        if(data != ""){
		                        	
		                            $(data).each(
		                            		
		                               function(){		                            	
		                            	   no++;
		                            	   str +=  "<tr class='ct_list_pop' align='center' data-bno='"+pageNo+"'>"
	                                        +       "<td>"+no+ "</td>"
	                                        +       "<td align='left'> <a href='#' title='상품 설명 :"+this.prodDetail+"'>" + this.prodName + "</a> "
	                                        +			"<input type='hidden' value='"+this.proTranCode+"'/>"
               								+			"<input type='hidden' value='"+this.prodNo+"'/>"
	                                        +		"</td>"      			

	                                        +       "<td align='right'>" + this.priceAmount + "원 &nbsp;&nbsp;</td>"
	                                        +       "<td align='center'>" + this.manuDate + "</td>"
	                                        +		"<td align='center' >"	;

										if(this.proTranCode==null || this.proTranCode==""){
											str+= "<span>판매중<input type='hidden' value='"+this.prodNo+"'/></span>";
										}else {
			        						if( ${sessionScope.user.role=="admin"} ) {	//admin		        							
				        							if(this.proTranCode=="1  "){
		                            						str+="구매완료 &nbsp; "
		                            							+						"<span id=deliver>배송하기"
		        				                				+						"<input type='hidden' id='prodNo' name ='prodNo' value='"+this.prodNo+"'/>"
		        				                				+						"</span>";
	                      					      }else if(this.proTranCode=="2  "){
	                      	 				    		str+="배송중";
	                      					      }else{
	                      					    		str+="배송완료";
	                      					      }//end of else  
											}else{//user or empty
												str+= "재고없음";
											}	
			        					}//end if (product.proTranCode is not empty)
			        					str+= "</td></tr></tr><tr class='endIndex'></tr>";
		                                    
				        				}//end of function    				

		                             );// each
		                            $(".endIndex:last").after(str);
		                              
		                        }// if : data!=null
		                        else{ 
		                            alert("더 불러올 데이터가 없습니다.");
		                        }// else
		                        	pageNo++;
		    		            scrollLocker = true;
		                        
		                    }// success
				
		                });// end of ajax		    
		               
		             }//if		            
		            
		            lastScrollTop = currentScrollTop;
		        }
		       
		});// scroll event

	</script>
</head>

<body >

	<jsp:include page="/layout/toolbar.jsp" />
	
<div class="container">

	<div class="page-header text-info">
		<c:if test="${param.menu =='manage'}">
			 <h3>상품 관리</h3>
		</c:if>
		<c:if test="${param.menu =='search'}">
			<h3>상품 목록조회</h3>
		</c:if>
		<c:if test="${param.menu !='search' && param.menu !='manage'}">
			<h3>menu를 찾지 못했습니다.</h3>
		</c:if>
    </div>
    
      <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
	       <div class="col-md-6 text-right">
		    <form class="form-inline" name="detailForm">
		    
		    	<div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${!empty search.searchCondition && search.searchCondition==0 ? "selected":"" }>상품번호</option>
						<option value="1"  ${!empty search.searchCondition && search.searchCondition==1 ? "selected":"" }>상품명</option>
						<option value="2" ${!empty search.searchCondition && search.searchCondition==2? "selected":"" }>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="autoComplete">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
		    
		    		<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
		    		
		   </form>
		   </div> 
    </div><!-- end of < div class="row"> -->
    
    <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th style="text-align:center">No</th>
            <th style="text-align:center">상품명</th>
            <th style="text-align:center">가격&nbsp; <!-- td class="ct_list_b"  -->
						<span>▼</span>
						<span>▲</span>
						<input  type="hidden" id="sorting" name="sorting" value="">
			</th>
            <th style="text-align:center">등록일</th>
            <th style="text-align:center">현재상태</th>
          </tr>
        </thead>
        
        <!--  table body start.. -->
       <tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
		  
			<c:set var="i" value="${ i+1 }" />
			<tr class="ct_list_pop" data-bno="2">
			  <td align="center">${ i }</td>
			  <td align="left">	<a href="#" title="상품 설명 : ${product.prodDetail }">${product.prodName}</a> 
					  	<input type="hidden"  value="${product.proTranCode}"/>
						<input type="hidden" value="${product.prodNo }"/>
						
			 </td>
			  <td align="right">${product.priceAmount}원 &nbsp;&nbsp;</td>
			  <td align="center">${product.manuDate}</td>
			  
			<td align="center" >	
					<c:if test="${empty product.proTranCode}">
							<span>판매중<input type="hidden" value="${product.prodNo}"/></span>
					</c:if>
					<c:if test="${!empty product.proTranCode}">
					
						<c:if test="${sessionScope.user.role=='admin'}">
							<c:choose >
								<c:when test="${product.proTranCode=='1  ' }">
									구매완료 &nbsp; 
									 <span id="deliver">배송하기
									 	<input type="hidden" id="prodNo" name ="prodNo" value="${product.prodNo}"/>
									 </span>
								</c:when>
								<c:when test="${product.proTranCode=='2  ' }">
									배송중 
								</c:when>
								<c:otherwise>
									배송완료
								</c:otherwise>
							</c:choose>				
							</c:if>	
							
						<c:if test="${empty sessionScope.user || sessionScope.user.role=='user'}">
							재고없음
						</c:if>	
					</c:if>
			</td>
			<td><span id="image"></span>	</td>
			</tr>
			
<!-- 			<tr >
				<td><span id="image"></span></td>
			</tr> 
-->
          </c:forEach>
        <tr class="endIndex"></tr>
        </tbody>
      
      </table>

    

</div><!-- end of container -->
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- <jsp:include page="../common/productPageNavigator.jsp"/>	 -->
	<!-- PageNavigation End... -->


</body>

</html>
