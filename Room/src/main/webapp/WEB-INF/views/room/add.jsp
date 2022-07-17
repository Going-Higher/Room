<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
					<input type="radio" name="registerInfo" value="임대인">임대인
					<input type="radio" name="registerInfo" value="기존세입자">기존세입자
					<input type="radio" name="registerInfo" value="기타">기타<
				</div>
				<div>
					<label>위치정보:</label>
					<input type="text" id="hZipcode" placeholder="우편번호" name="address" value="우편번호">
					<input type="text" id="address1" placeholder="주소1" name="address1">
					<input type="text" id="address2" placeholder="주소2" name="address2">
				</div>
				<div>
					<label>계약형태:</label>
					<input type="radio" name="deal" value="전세">전세
					<input type="radio" name="deal" value="월세">월세
				</div>
				<div>
					<label>가격정보:</label>
					보증금 <input type="number" name="price" value="보증금"> 만원<br>
					월 <input type="number" name="monthPrice" value="월세"> 만원<br>
					<!-- 전세가 <input type="number" name="price2" value="전세"> 만원 -->
				</div>
				<div>
					<label>관리비:</label>
					월 <input type="number" name="cost" value="관리비"> 만원
					<!-- <input type="checkbox" name="cost" value="없음">없음 -->
				</div>
				<div>
					<label>관리비포함내역:</label>
					<input type="checkbox" name="costInfo" value="전기">전기
					<input type="checkbox" name="costInfo" value="가스">가스
					<input type="checkbox" name="costInfo" value="수도">수도
					<input type="checkbox" name="costInfo" value="인터넷">인터넷
					<input type="checkbox" name="costInfo" value="TV">TV
					<input type="checkbox" name="costInfo" value="청소">청소
				</div>
				<div>
					<label>입주가능일:</label>
					<input type="date" name="moveDate">
					<!-- <input type="radio" name="moveDate" value="즉시입주">즉시입주
					<input type="radio" name="moveDate" value=""><input type="date"><input type="checkbox">입주일협의가능 -->
				</div>
				<div>
					<label>층/건물층수:</label>
					<input type="number" name="myClass" value="해당층">/<input type="number" name="wholeClass" value="전체층">				
				</div>
				<div>
					<label>방거실형태:</label>
					<input type="radio" name="form" value="오픈형">오픈형
         			<input type="radio" name="form" value="분리형">분리형		
				</div>
				<div>
					<label>주차:</label>
					<input type="number" name="park" value="주차">대		
				</div>
				<div>
					<label>옵션정보:</label>
					<input type="checkbox" name="choiceOption" value="에어컨">에어컨
		            <input type="checkbox" name="choiceOption" value="냉장고">냉장고
		            <input type="checkbox" name="choiceOption" value="세탁기">세탁기
		            <input type="checkbox" name="choiceOption" value="인덕션">인덕션
		            <input type="checkbox" name="choiceOption" value="전자레인지">전자레인지
		            <input type="checkbox" name="choiceOption" value="책상">책상
		            <input type="checkbox" name="choiceOption" value="책장">책장
		            <input type="checkbox" name="choiceOption" value="침대">침대
		            <input type="checkbox" name="choiceOption" value="옷장">옷장
		            <input type="checkbox" name="choiceOption" value="신발장">신발장
		            <input type="checkbox" name="choiceOption" value="싱크대">싱크대		
				</div>
				<div>
					<label>상세정보:</label>
					<textarea rows="10" cols="100" name="boardCn"></textarea>		
				</div>
				<div>
					<label>사진등록:</label>
					<input type="file" name="atchFileId" value="첨부파일ID">		
				</div>				
				<div>
					<button>등록</button>
					<button type="button" onclick="history.back()">취소</button>
				</div>
			</form>
		</div>
	</div>
</body>

<script>
	$(document).ready(function(){
		//우편번호 검색
		$("#hZipcode").click(function(){
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
				document.getElementById('hZipcode').value = data.zonecode;
				document.getElementById("address1").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("address2").focus();
			}
		}).open();
	}
</script>
</html>