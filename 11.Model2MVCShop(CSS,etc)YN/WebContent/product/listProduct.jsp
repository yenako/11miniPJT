<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>상품 목록조회</title>
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript">
	
	function fncGetProductList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
	   	$("#currentPage").val(currentPage)
		//document.detailForm.submit();		

		$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${param.menu }&sortBy=${param.sortBy}").submit();
	}


	$( function(){
		
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");		
/* 	
		if(  !$( $("tr.ct_list_pop td:nth-child(3)").find('input')[0]).val()  ) {	
			$(this).css("color" , "green");
		}
*/
			$("td.ct_btn01:contains('검색')").on("click", function(){
				fncGetProductList('1');
			});
			
			$("td.ct_list_b:contains('가격') span:first").on("click", function(){
				console.log($('input:hidden').val());
				self.location ="/product/listProduct?menu=${param.menu }&sortBy=desc"
			});
			
			$("td.ct_list_b:contains('가격') span:last").on("click", function(){
				//console.log(${param.menu })
				self.location ="/product/listProduct?menu=${param.menu }&sortBy=asc";
			});
			
			$("tr.ct_list_pop:contains('배송하기') span:eq(1)").on("click", function(){   
				self.location ="/purchase/updateTranCodeByProd?prodNo="+$('input:hidden[name="prodNo2"]', $(this)).val()+"&tranCode=2";
			});
			console.log("input: hidden [0] 은 : _"+$($('input:hidden').eq(0)).val()+"_");
			console.log("input: hidden [1] 은 : "+$($('input:hidden').eq(1)).val());
			

			$("tr.ct_list_pop td:nth-child(3)").on("click", function(){
				if( ${ sessionScope.user.role eq 'admin'} || !$( $(this).find('input')[0]).val() ) {
					self.location ="/product/getProduct?prodNo="+$( $(this).find('input')[1]).val() +"&menu=${param.menu}"
					}
			});
	});
		
	
		$( function(){		
			$( document ).tooltip();
		});	
		

	
	$( function() {
		$( "input.ct_input_g" ).on('keyup', function(){
					
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
								
									$(  "input.ct_input_g"  ).autocomplete({	
										source:  JSONData
									});
							}
					  });//end of ajax
			});
	 });	
	
	
		$( function(){
			$( "tr.ct_list_pop:contains('판매중') span" ).on("click" , function() {
				alert("판매중을 클릭했습니다.");
				var prodNo = $( $(this).find('input')).val();
				console.log(prodNo);
				$.ajax(
						{
							url : "/product/json/getProduct/"+prodNo+"/manage" ,
							method : "GET" ,
							dataType : "json" ,
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
		});
	////////////////////////////////////////////////////////////////////////////////////////////////
		   var lastScrollTop = 0;
		    var easeEffect = 'easeInQuint';
		     
		    // 1. 스크롤 이벤트 발생
		    $(window).scroll(function(){ // ① 스크롤 이벤트 최초 발생
		         
		        var currentScrollTop = $(window).scrollTop();

		        if( currentScrollTop - lastScrollTop > 0 ){//down scrolling 
		            // down-scroll : 현재 게시글 다음의 글을 불러온다.
		            console.log("down-scroll");
		             
		            // 2. 현재 스크롤의 top 좌표가  > (게시글을 불러온 화면 height - 윈도우창의 height) 되는 순간
		            if ($(document).height() <= $(window).scrollTop() + $(window).height() + 100) {    //스크롤이 맨 밑까지 오지않아도 되는 여유분 100 
		                // 3. class가 scrolling인 것의 요소 중 마지막인 요소를 선택한 다음 그것의 data-bno속성 값을 받아온다.
		                //      즉, 현재 뿌려진 게시글의 마지막 bno값을 읽어오는 것이다.( 이 다음의 게시글들을 가져오기 위해 필요한 데이터이다.)
		                console.log($(document).height() - $(window).height());
		            	console.log("amI working?");
		                var lastbno = $(".ct_list_pop:last").attr("data-bno");
		                console.log("lastbno : "+lastbno);
		                // 4. ajax를 이용하여 현재 뿌려진 게시글의 마지막 bno를 서버로 보내어 그 다음 20개의 게시물 데이터를 받아온다.
		                $.ajax({
		                	url : "/product/json/listProduct/"+lastbno+"",
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
		                    success : function(data){// ajax 가 성공했을시에 수행될 function이다. 이 function의 파라미터는 서버로 부터 return받은 데이터이다.
		                         
		                        var str = "";
		                         
		                        // 5. 받아온 데이터가 ""이거나 null이 아닌 경우에 DOM handling을 해준다.
		                        if(data != ""){
		                            //6. 서버로부터 받아온 data가 list이므로 이 각각의 원소에 접근하려면 each문을 사용한다.
		                            $(data).each(
		                                // 7. 새로운 데이터를 갖고 html코드형태의 문자열을 만들어준다.
		                                function(){
		                                    console.log(this);     
		                                    str +=  "<tr class=" + "'listToChange'" + ">"
		                                        +       "<td class=" +  "'scrolling'" + " data-bno='" + this.pronNo +"'>"
		                                        +           this.bno
		                                        +       "</td>"
		                                        +       "<td>" + this.prodName + "</td>"      
		                                        +       "<td>" + this.regDate + "</td>"
		                                        +       "<td>" + this.prodNo + "</td>"
		                                 
		                                        +   "</tr>";
		                                         
		                            });// each
		                            // 8. 이전까지 뿌려졌던 데이터를 비워주고, <th>헤더 바로 밑에 위에서 만든 str을  뿌려준다.
		                            //$(".listToChange").empty();// 셀렉터 태그 안의 모든 텍스트를 지운다.                       
		                            $(".ct_list_pop:last").after(str);
		                                 
		                        }// if : data!=null
		                        else{ // 9. 만약 서버로 부터 받아온 데이터가 없으면 그냥 아무것도 하지말까..
		                            alert("더 불러올 데이터가 없습니다.");
		                        }// else
		         
		                    }// success
		                });// end of ajax
		                 
		                // 여기서 class가 listToChange인 것중 가장 처음인 것을 찾아서 그 위치로 이동하자.
		                var position = $(".listToChange:first").offset();// 위치 값
		                 
		                // 이동  위로 부터 position.top px 위치로 스크롤 하는 것이다. 그걸 500ms 동안 애니메이션이 이루어짐.
		                $('html,body').stop().animate({scrollTop : position.top }, 600, easeEffect); 
		     
		            }//if : 현재 스크롤의 top 좌표가  > (게시글을 불러온 화면 height - 윈도우창의 height) 되는 순간
		             console.log("if문 밖");
		            // lastScrollTop을 현재 currentScrollTop으로 갱신해준다.
		            lastScrollTop = currentScrollTop;
		        }// 다운스크롤인 상태

		        else{
		      
		        }// else : 업 스크롤인 상태
		         
		});// scroll event
		
		
	</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					
						<c:if test="${param.menu =='manage'}">
							상품 관리
						</c:if>
						<c:if test="${param.menu =='search'}">
							상품 목록조회
						</c:if>
						<c:if test="${param.menu !='search' && param.menu !='manage'}">
							menu를 찾지 못했습니다.
						</c:if>
					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
					<option value="0" ${!empty search.searchCondition && search.searchCondition==0 ? "selected":"" }>상품번호</option>
					<option value="1"  ${!empty search.searchCondition && search.searchCondition==1 ? "selected":"" }>상품명</option>
					<option value="2" ${!empty search.searchCondition && search.searchCondition==2? "selected":"" }>상품가격</option>
			</select>
			<input type="text" name="searchKeyword"  id="autoComplete"
						 value="${! empty search.searchKeyword ? search.searchKeyword : ""}"   
						 class="ct_input_g" style="width:200px; height:19px" />
		</td>
	
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >
				전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격&nbsp; 
						<span>▼</span>
						<span>▲</span>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
<%--
	for(int i=0; i<list.size(); i++) {
		Product vo = list.get(i);	
--%>	
<c:set var="i" value="0"/>
<c:forEach var="product" items="${list }">
	<c:set var="i" value="${i+1 }"/>
	<tr class="ct_list_pop" data-bno="${resultPage.currentPage}">
		<td align="center">${i }</td>
		<td></td>
	
		<td align="left">	<a href="#" title="상품 설명 : ${product.prodDetail }">${product.prodName}</a> 
				<input type="hidden" value="${product.proTranCode}"/>
				<input type="hidden" value="${product.prodNo }"/>
		
  <!--	
		<c:if test="${ sessionScope.user.role=='admin' || empty product.proTranCode}">
				<a href="/product/getProduct?prodNo=${product.prodNo }&menu=${param.menu}">
		</c:if>
				${product.prodName}</a>
	-->
		</td>
		<td></td>
		<td align="right">${product.priceAmount}원 &nbsp;&nbsp;</td>
		<td></td>
		<td align="center">${product.manuDate}</td>
		<td></td>
		<td align="center" >	
		
		
			<c:if test="${empty product.proTranCode}">
					<span>판매중<input type="hidden" value="${product.prodNo }"/></span>
			</c:if>
			<c:if test="${!empty product.proTranCode}">
			
				<c:if test="${sessionScope.user.role=='admin'}">
					<c:choose >
						<c:when test="${product.proTranCode=='1  ' }">
							구매완료 &nbsp; 
							 <span>배송하기  </apan>
							 
							<input type="hidden" id="prodNo2" name ="prodNo2" value="${product.prodNo }"/>
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
		<td id="image" colspan="5" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	</c:forEach>
	
	
	
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		<input type="hidden" id="currentPage" name ="currentPage" value=""/>
				<jsp:include page="../common/productPageNavigator.jsp"/>	
    	</td>
	</tr>
</table>

</form>

</div>
</body>
</html>
