<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="X-UA-Compatible" content="IE-edge" />
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimun-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<title>매물목록</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/77c9453159.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/indigo.min.js"></script>
</head>

<body>

<header>
		<!-- Nav container -->
		<nav class="header">
			<!-- Logo with text -->
			<div class="header_logo">
				<i class="fab fa-accusoft"></i> <a href="/kopo">샤방샤방</a>
			</div>
			<!-- Menu -->
			<div class="gnb">
				<ul class="header_menu">
					<li><a href="/kopo#about">소개</a></li>
					<li><a href="room/list">매물관리</a></li>
					<li><a href="board/list">게시판</a></li>
					<li><c:choose>
							<c:when test="${empty USER_INFO.id}">
								<a href="/login/egovLoginUsr.do" class="login">로그인</a>
							</c:when>
							<c:otherwise>
								<a href="/login/actionLogout.do"> <c:out value="${USER_INFO.name}" />님 로그아웃</a>
							</c:otherwise>
					</c:choose></li>
				</ul>
			</div>
			<div class="menu-toggle-btn">
				<img src='<c:url value="/resources/images/menu_bar.png"/>'>
			</div>
		</nav>
	</header>
	
	<div class="dim"></div>
	<!-- 로그인 -->
	<div class="layer-popup layer-login" style="display: none;">
		<header class="layer-header">
			<span class="logo"> <span class="img-logo"> <img alt="" src='<c:url value="/resources/images/my_logo.png"/>'></span>
			</span>
			<button type="button" class="layer-close">
				<span>팝업 닫기</span>
			</button>
		</header>
		<div class="layer-body">
			<form action="/login/actionLogin.do" id="frmLogin" name="frmLogin" method="post" onsubmit="return vali()">
				<input type="hidden" name="userSe" value="USR" />
				<input type="hidden" name="retUrl" value="/board/selectList.do" />
				<fieldset>
					<!-- <legend>로그인을 위한 아아디/비밀번호 입력</legend> -->
					<div class="ipt-row">
						<input type="text" id="loginId" name="id" placeholder="아이디" required="required">
					</div>
					<div class="ipt-row">
						<input type="password" id="loginPw" name="password" placeholder="비밀번호" required="required">
					</div>
					<button type="submit" class="btn-login">
						<span>로그인</span>
					</button>
				</fieldset>
			</form>
		</div>
	</div>

<div>매물목록</div>

<div class="filter">
    <select>
      <option>계약형태</option>
      <option>월세</option>
      <option>전세</option>
    </select>
    <label>보증금</label>
    <input type="range" min="1" max="10" value="1">원
    <label>월세</label>
    <input type="range" min="1" max="10" value="1">원
    <button>초기화</button>
    <button>적용하기</button>        
</div>

<div>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>매물번호</th>
					<th>계약형태</th>
					<th>가격정보</th>
					<th>위치정보</th>
					<th>사진</th>
					<th>찜하기</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${list.size() < 6}">
					<tr>
						<td colspan="7">검색된 매물이 없습니다</td>
					</tr>					
				</c:if>
				
				<c:forEach var="item" items="${list}">
					<tr>
						<td><a href="update/${item.roomId}">${item.roomId}</a></td>
						<td>${item.deal}</td>
						<td>${item.price}/${item.monthPrice}</td>
						<td>${item.address1}</td>
						<td><img src="/kopo/upload/room_${item.roomId}.jpg" width="80" height="60"> ${item.atchFileId}</td>
						<td class="list_icon"><i class="fa-regular fa-heart"></i></td>
					</tr>					
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="7">
						<ul>
							<li><a href="?page=1">처음</a></li>
							<li><a href="?page=${pager.prev}">이전</a></li>
							
							<c:forEach var="page" items="${pager.list}">
								<li><a href="?page=${page}">${page}</a></li>
							</c:forEach>
							
							<li><a href="?page=${pager.next}">다음</a></li>
							<li><a href="?page=${pager.last}">마지막</a></li>
						</ul>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
	<div>
		<a href="add">등록</a>
	</div>			
</div>

<footer>
    <p>All Rights Reserved by 샤방샤방</p>
</footer>

<!-- ICONS -->
<script src="https://unpkg.com/ionicons@5.0.0/dist/ionicons.js"></script>

<script>
    $(".fa-heart").on("click", function(){
    		$(this).toggleClass("fa-regular fa-solid");
    })
</script>

</body>
</html>