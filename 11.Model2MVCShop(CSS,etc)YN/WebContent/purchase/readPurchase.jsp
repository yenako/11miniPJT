<%@page import="com.model2.mvc.common.CommonUtil"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>

<script type="text/javascript" src="../javascript/calendar.js"></script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
 
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
	 $( "td.ct_btn01:contains('수정')" ).on("click" , function() {
		self.location="/purchase/updatePurchase?tranNo=${purchase.tranNo}";
	});
	
	 $( "td.ct_btn01:contains('확인')" ).on("click" , function() {
		 history.go(-1);
		});
 });	
 
</script>

<html>
<head>
<title>구매상세조회</title>
<link rel="stylesheet" href="/css/admin.css" type="text/css">
</head>
<body bgcolor="#ffffff" text="#000000">
<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td width="15" height="37">
		<img src="/images/ct_ttl_img01.gif"	width="15" height="37"/>
	</td>
<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td width="93%" class="ct_ttl01">구매상세조회</td>
	<td width="20%" align="right">&nbsp;</td>
</tr>
</table>
</td>
<td width="12" height="37">
<img src="/images/ct_ttl_img03.gif"	width="12" height="37"/>
</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
<tr>
<td height="1" colspan="3" bgcolor="D6D6D6"></td>
</tr>
<tr>
<td width="104" class="ct_write">
물품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
</td>
	<td bgcolor="D6D6D6" width="1"></td>
	<td class="ct_write01">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td width="105">${purchase.purchaseProd.prodNo }</td>
	<td></td>
</tr>
</table>
	</td>
</tr>
<tr>
<td height="1" colspan="3" bgcolor="D6D6D6"></td>
</tr>
			<tr>
				<td width="104" class="ct_write">
				구매자아이디 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.buyer.userId }</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">구매방법</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.paymentOption}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">구매자이름</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.receiverName}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">구매자연락처</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.receiverPhone}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">구매자주소</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.divyAddr}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">구매요청사항</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.divyRequest}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">배송희망일</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.divyDate}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">주문일</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.orderDate}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
			<tr>
				<td width="53%"></td>
				<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
					<!-- <a href="/purchase/updatePurchase?tranNo=${purchase.tranNo}"> -->
					수정
				</td>
			<td width="14" height="23">
			<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
			</td>
				<td width="30"></td>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
					<!-- <a href="javascript:history.go(-1);">확인</a> -->
					확인
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif"width="14" height="23"/>
				</td>
			</tr>
	</table>
</td>
</tr>
</table>
</body>
</html>