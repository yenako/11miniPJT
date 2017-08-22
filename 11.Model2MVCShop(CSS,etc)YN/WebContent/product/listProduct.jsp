<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>��ǰ �����ȸ</title>
	
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
			$("td.ct_btn01:contains('�˻�')").on("click", function(){
				fncGetProductList('1');
			});
			
			$("td.ct_list_b:contains('����') span:first").on("click", function(){
				console.log($('input:hidden').val());
				self.location ="/product/listProduct?menu=${param.menu }&sortBy=desc"
			});
			
			$("td.ct_list_b:contains('����') span:last").on("click", function(){
				//console.log(${param.menu })
				self.location ="/product/listProduct?menu=${param.menu }&sortBy=asc";
			});
			
			$("tr.ct_list_pop:contains('����ϱ�') span:eq(1)").on("click", function(){   
				self.location ="/purchase/updateTranCodeByProd?prodNo="+$('input:hidden[name="prodNo2"]', $(this)).val()+"&tranCode=2";
			});
			console.log("input: hidden [0] �� : _"+$($('input:hidden').eq(0)).val()+"_");
			console.log("input: hidden [1] �� : "+$($('input:hidden').eq(1)).val());
			

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
			$( "tr.ct_list_pop:contains('�Ǹ���') span" ).on("click" , function() {
				alert("�Ǹ����� Ŭ���߽��ϴ�.");
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
		     
		    // 1. ��ũ�� �̺�Ʈ �߻�
		    $(window).scroll(function(){ // �� ��ũ�� �̺�Ʈ ���� �߻�
		         
		        var currentScrollTop = $(window).scrollTop();

		        if( currentScrollTop - lastScrollTop > 0 ){//down scrolling 
		            // down-scroll : ���� �Խñ� ������ ���� �ҷ��´�.
		            console.log("down-scroll");
		             
		            // 2. ���� ��ũ���� top ��ǥ��  > (�Խñ��� �ҷ��� ȭ�� height - ������â�� height) �Ǵ� ����
		            if ($(document).height() <= $(window).scrollTop() + $(window).height() + 100) {    //��ũ���� �� �ر��� �����ʾƵ� �Ǵ� ������ 100 
		                // 3. class�� scrolling�� ���� ��� �� �������� ��Ҹ� ������ ���� �װ��� data-bno�Ӽ� ���� �޾ƿ´�.
		                //      ��, ���� �ѷ��� �Խñ��� ������ bno���� �о���� ���̴�.( �� ������ �Խñ۵��� �������� ���� �ʿ��� �������̴�.)
		                console.log($(document).height() - $(window).height());
		            	console.log("amI working?");
		                var lastbno = $(".ct_list_pop:last").attr("data-bno");
		                console.log("lastbno : "+lastbno);
		                // 4. ajax�� �̿��Ͽ� ���� �ѷ��� �Խñ��� ������ bno�� ������ ������ �� ���� 20���� �Խù� �����͸� �޾ƿ´�.
		                $.ajax({
		                	url : "/product/json/listProduct/"+lastbno+"",
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
		                    success : function(data){// ajax �� ���������ÿ� ����� function�̴�. �� function�� �Ķ���ʹ� ������ ���� return���� �������̴�.
		                         
		                        var str = "";
		                         
		                        // 5. �޾ƿ� �����Ͱ� ""�̰ų� null�� �ƴ� ��쿡 DOM handling�� ���ش�.
		                        if(data != ""){
		                            //6. �����κ��� �޾ƿ� data�� list�̹Ƿ� �� ������ ���ҿ� �����Ϸ��� each���� ����Ѵ�.
		                            $(data).each(
		                                // 7. ���ο� �����͸� ���� html�ڵ������� ���ڿ��� ������ش�.
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
		                            // 8. �������� �ѷ����� �����͸� ����ְ�, <th>��� �ٷ� �ؿ� ������ ���� str��  �ѷ��ش�.
		                            //$(".listToChange").empty();// ������ �±� ���� ��� �ؽ�Ʈ�� �����.                       
		                            $(".ct_list_pop:last").after(str);
		                                 
		                        }// if : data!=null
		                        else{ // 9. ���� ������ ���� �޾ƿ� �����Ͱ� ������ �׳� �ƹ��͵� ��������..
		                            alert("�� �ҷ��� �����Ͱ� �����ϴ�.");
		                        }// else
		         
		                    }// success
		                });// end of ajax
		                 
		                // ���⼭ class�� listToChange�� ���� ���� ó���� ���� ã�Ƽ� �� ��ġ�� �̵�����.
		                var position = $(".listToChange:first").offset();// ��ġ ��
		                 
		                // �̵�  ���� ���� position.top px ��ġ�� ��ũ�� �ϴ� ���̴�. �װ� 500ms ���� �ִϸ��̼��� �̷����.
		                $('html,body').stop().animate({scrollTop : position.top }, 600, easeEffect); 
		     
		            }//if : ���� ��ũ���� top ��ǥ��  > (�Խñ��� �ҷ��� ȭ�� height - ������â�� height) �Ǵ� ����
		             console.log("if�� ��");
		            // lastScrollTop�� ���� currentScrollTop���� �������ش�.
		            lastScrollTop = currentScrollTop;
		        }// �ٿũ���� ����

		        else{
		      
		        }// else : �� ��ũ���� ����
		         
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
							��ǰ ����
						</c:if>
						<c:if test="${param.menu =='search'}">
							��ǰ �����ȸ
						</c:if>
						<c:if test="${param.menu !='search' && param.menu !='manage'}">
							menu�� ã�� ���߽��ϴ�.
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
					<option value="0" ${!empty search.searchCondition && search.searchCondition==0 ? "selected":"" }>��ǰ��ȣ</option>
					<option value="1"  ${!empty search.searchCondition && search.searchCondition==1 ? "selected":"" }>��ǰ��</option>
					<option value="2" ${!empty search.searchCondition && search.searchCondition==2? "selected":"" }>��ǰ����</option>
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
						�˻�
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
				��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����&nbsp; 
						<span>��</span>
						<span>��</span>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
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
	
		<td align="left">	<a href="#" title="��ǰ ���� : ${product.prodDetail }">${product.prodName}</a> 
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
		<td align="right">${product.priceAmount}�� &nbsp;&nbsp;</td>
		<td></td>
		<td align="center">${product.manuDate}</td>
		<td></td>
		<td align="center" >	
		
		
			<c:if test="${empty product.proTranCode}">
					<span>�Ǹ���<input type="hidden" value="${product.prodNo }"/></span>
			</c:if>
			<c:if test="${!empty product.proTranCode}">
			
				<c:if test="${sessionScope.user.role=='admin'}">
					<c:choose >
						<c:when test="${product.proTranCode=='1  ' }">
							���ſϷ� &nbsp; 
							 <span>����ϱ�  </apan>
							 
							<input type="hidden" id="prodNo2" name ="prodNo2" value="${product.prodNo }"/>
						</c:when>
						<c:when test="${product.proTranCode=='2  ' }">
							����� 
						</c:when>
						<c:otherwise>
							��ۿϷ�
						</c:otherwise>
					</c:choose>				
					</c:if>	
						
					<c:if test="${empty sessionScope.user || sessionScope.user.role=='user'}">
						������
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
