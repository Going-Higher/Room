<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title></title>
</head>
<body>
	<div>
		<div>매물 등록</div>
		<div>
			<form method="post" enctype="multipart/form-data">
				<div>
					<label>등록자정보:</label>
					<input type="radio" name="registerInfo" value="임대인" ${item.registerInfo == "임대인" ? "checked" : ""}>임대인
					<input type="radio" name="registerInfo" value="기존세입자" ${item.registerInfo == "기존세입자" ? "checked" : ""}>기존세입자
					<input type="radio" name="registerInfo" value="기타" ${item.registerInfo == "기타" ? "checked" : ""}>기타			
				</div>
				<div>
					<label>위치정보:</label>
					<input type="text" id="zipCode" placeholder="우편번호" name="zipCode" value="${item.zipCode}">
					<input type="text" id="address1" placeholder="주소1" name="address1" value="${item.address1}">
					<input type="text" id="address2" placeholder="주소2" name="address2" value="${item.address2}">
				</div>
				<div>
					<label>계약형태:</label>
					<input type="radio" name="deal" value="전세" ${item.deal == "전세" ? "checked" : ""}>전세
					<input type="radio" name="deal" value="월세" ${item.deal == "월세" ? "checked" : ""}>월세
				</div>
				<div>
					<label>가격정보:</label>
					<input type="number" name="price" value="${item.price}">만원
					<input type="number" name="monthPrice" value="${item.monthPrice}">만원
				</div>
				<div>
					<label>관리비:</label>
					<input type="number" name="cost" value="${item.cost}">만원
				</div>
				<div>
					<label>관리비포함내역:</label>
					<input type="checkbox" name="costInfo" value="전기" ${item.costInfo.contains("전기") ? "checked" : ""}>전기
					<input type="checkbox" name="costInfo" value="가스" ${item.costInfo.contains("가스") ? "checked" : ""}>가스
					<input type="checkbox" name="costInfo" value="수도" ${item.costInfo.contains("수도") ? "checked" : ""}>수도
					<input type="checkbox" name="costInfo" value="인터넷" ${item.costInfo.contains("인터넷") ? "checked" : ""}>인터넷
					<input type="checkbox" name="costInfo" value="TV" ${item.costInfo.contains("TV") ? "checked" : ""}>TV
					<input type="checkbox" name="costInfo" value="청소" ${item.costInfo.contains("청소") ? "checked" : ""}>청소
				</div>
				<div>
					<label>입주가능일:</label>					
					<input type="date" name="moveDate" value="${item.moveDate2Str}">
				</div>
				<div>
					<label>층/건물층수:</label>
					<input type="number" name="myClass" value="${item.myClass}">
					<input type="number" name="wholeClass" value="${item.wholeClass}">층
				</div>
				<div>
					<label>방거실형태:</label>
					<input type="radio" name="form" value="오픈형" ${item.form.contains("오픈형") ? "checked" : ""}>오픈형
         			<input type="radio" name="form" value="분리형" ${item.form.contains("분리형") ? "checked" : ""}>분리형		
				</div>
				<div>
					<label>주차:</label>
					<input type="number" name="park" value="${item.park}">
				</div>
				<div>
					<label>옵션정보:</label>
					<input type="checkbox" name="choiceOption" value="에어컨" ${item.choiceOption.contains("에어컨") ? "checked" : ""}>에어컨
		            <input type="checkbox" name="choiceOption" value="냉장고" ${item.choiceOption.contains("냉장고") ? "checked" : ""}>냉장고
		            <input type="checkbox" name="choiceOption" value="세탁기" ${item.choiceOption.contains("세탁기") ? "checked" : ""}>세탁기
		            <input type="checkbox" name="choiceOption" value="인덕션" ${item.choiceOption.contains("인덕션") ? "checked" : ""}>인덕션
		            <input type="checkbox" name="choiceOption" value="전자레인지" ${item.choiceOption.contains("전자레인지") ? "checked" : ""}>전자레인지
		            <input type="checkbox" name="choiceOption" value="책상" ${item.choiceOption.contains("책상") ? "checked" : ""}>책상
		            <input type="checkbox" name="choiceOption" value="책장" ${item.choiceOption.contains("책장") ? "checked" : ""}>책장
		            <input type="checkbox" name="choiceOption" value="침대" ${item.choiceOption.contains("침대") ? "checked" : ""}>침대
		            <input type="checkbox" name="choiceOption" value="옷장" ${item.choiceOption.contains("옷장") ? "checked" : ""}>옷장
		            <input type="checkbox" name="choiceOption" value="신발장" ${item.choiceOption.contains("신발장") ? "checked" : ""}>신발장
		            <input type="checkbox" name="choiceOption" value="싱크대" ${item.choiceOption.contains("싱크대") ? "checked" : ""}>싱크대
				</div>
				<div>
					<label>상세정보:</label>
					<input type="text" name="boardCn" value="${item.boardCn}">
				</div>
				<div>
					<label>사진등록:</label>					
					<input type="file" name="atchFileId" value="${item.atchFileId}">
					<div>
						<img src="/kopo/upload/room_${item.roomId}.jpg" width="400" height="300">
					</div>
				</div>
				
				<div>
					<button>변경</button>
					<button type="button" onclick="history.back()">취소</button>
					<button type="button"><a href="${pageContext.request.contextPath}/room/delete/${item.roomId}">삭제</a></button>
				</div>
			</form>
		</div>
	</div>
</body>

<script>
	$(document).ready(function(){
		//우편번호 검색
		$("#zipCode").click(function(){
			goPopup();
			return false;
		});
	});
	
	//다음 우편번호 API
	function goPopup() {
		new daum.Postcode({
			oncomplete: function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if(data.userSelectedType === 'R'){
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if(data.buildingName !== '' && data.apartment === 'Y'){
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if(extraAddr !== ''){
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					//document.getElementById("sample6_extraAddress").value = extraAddr;
				
				} else {
					//document.getElementById("sample6_extraAddress").value = '';
				}
				
				alert(data.zonecode);

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('zipCode').value = data.zonecode;
				document.getElementById("address1").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("address2").focus();
			}
		}).open();
	}
</script>
</html>