<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<jsp:include page="/WEB-INF/views/template/header.jsp" />
<!-- 내용 시작 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<div class="page-main">
	<br> <br> <br>
	<div class="container">
		<div class="row justify-content-md-center">
			<div class="col">
				<div class="card border-white" style="height: 37rem;">
					<div class="card-body text-center">
						<img src="${pageContext.request.contextPath}/upload/${md.md_photo2}" 
						class="card-img-top" style="width: 400px; height: 400px;">        
					</div>
					<br> <br> <br>
					<div class="text-sm-end text-secondary">상품 번호:
						no.${md.md_num}</div>
				</div>
			</div>
			<div class="col">

				<br>
				<p class="card-text fs-4 fw-bold">${md.md_name}</p>
				<hr>
				<form id="addCart" action="/mdCart/addCart" method="post">
					<input type="hidden" name="md_num" value="${md.md_num}" id="md_num">
					<input type="hidden" name="md_price" value="${md.md_price}"
						id="md_price"> <input type="hidden" name="md_quantity"
						value="${md.md_quantity}" id="md_quantity">
					<div>
						<b class="card-text fs-2">
						 <fmt:formatNumber value="${md.md_price}" />원
						</b>
					</div>
					<br> <br>
					<div class="card text-bg-light mb-3 border-0" style="width: 40rem;">
						<div class="card-body">
							<div>
								<span class="font-monospace text-dark fw-bold">택배</span> <span>3,000원
									(60,000원 이상 주문시 무료)</span>
							</div>
							<div>
								<span class="font-monospace text-dark fw-bold">원산지</span> <span>기타</span>
							</div>
							<div>
								<span class="font-monospace text-dark fw-bold">혜택</span> <span>무이자
									할부</span>
							</div>
						</div>
					</div>
					<br>
					<div>
						<div class="card text-bg-white mb-3 text-outline-bg-dark"
							style="width: 40rem;">
							<div class="card-body">
								<span> <span>재고 <span class="fw-bold text-primary"><fmt:formatNumber
												value="${md.md_quantity}" /> </span></span> <c:if
										test="${md.md_quantity > 0}">
										<span class="float-end"> <label for="order_quantity">구매수량</label>
											<input type="number" name="order_quantity" min="1"
											max="${md.md_quantity}" autocomplete="off"
											id="order_quantity" class="quantity-width">
										</span></span>
							</div>
						</div>
					</div>
					<br>
					<div>
						<span> <span class="text-start" id="sub_total">총
								상품금액</span> <b class="float-end">
								<fmt:formatNumber value="${md.md_price}" /> <span>원</span></b>
						</span>
					</div>
					<div>
						<span class="fs-4"> <span class="text-start" id="sub_total">총
								상품금액</span> <b class="float-end"><fmt:formatNumber
									value="${md.md_price}" /> <span>원</span></b>
						</span>
					</div>
					<br> <br>
					<div class="container text-center">
						<div class="row row-cols-2">
							<input type="submit" value="장바구니 담기"
								class="btn btn-outline-dark btn-lg col"> <input
								type="submit" value="바로구매" class="btn btn-dark btn-lg col"
								onclick="location.href='${pageContext.request.contextPath}/mdOrder/mdOrderPayment'">
						</div>
					</div>
					</c:if>
					<c:if test="${md.md_quantity <= 0}">
						<li class="align-center"><span class="sold-out">품절</span></li>
					</c:if>
				</form>
				<br>
				<div>

					<input type="submit" value="바로구매"
						class="btn btn-secondary btn-lg col"
						onclick="location.href='${pageContext.request.contextPath}/mdOrder/mdOrderPayment'">

					<br> <br> <br>
				</div>
			</div>
		</div>
		<br> <br> <br>

		<ul id="navbar2"
			class="nav justify-content-center nav-underline bg-dark">
			<li class="nav-item text-light"><a
				class="nav-link active text-light" aria-current="page"
				href="#scrollspyHeading1">상품정보</a></li>
			<li class="nav-item text-light"><a class="nav-link text-light"
				href="#scrollspyHeading2">상품리뷰</a></li>
			<li class="nav-item text-light"><a class="nav-link text-light"
				href="#scrollspyHeading3">상품문의</a></li>
			<li class="nav-item text-light"><a class="nav-link text-light"
				href="#scrollspyHeading4">배송/반품/교환</a></li>
		</ul>

		<div class="container">
			<div class="row justify-content-md-center">
				<div class="col">
					<div data-bs-spy="scroll" data-bs-target="#navbar2"
						data-bs-root-margin="0px 0px -40%" data-bs-smooth-scroll="true"
						class="scrollspy-example bg-body-tertiary p-3 rounded-2"
						tabindex="0">
						<h4 id="scrollspyHeading1" class="fw-bold">상세 이미지</h4>
						<br> <img
							src="${pageContext.request.contextPath}/image_upload/341390143.jpg"
							class=" mx-auto d-block"> <br> <br> <br> <br>
						<br> <br> <br> <br> <br>
						<h4 id="scrollspyHeading2" class="fw-bold">상품 리뷰</h4>
						<div class="row justify-content-between">
							<div class="col-4">상품을 구매한 분들이 작성한 리뷰 입니다.</div>
							<div class="col-4">
								<c:if test="${!empty user}">
									<input type="button" value="리뷰 작성"
										class="btn btn-secondary btn-sm float-end"
										onclick="location.href='/mdReview/reviewWrite'">
								</c:if>
							</div>
						</div>
						<hr>
						<p>
							<img
								src="${pageContext.request.contextPath}/image_upload/img6.jpg"
								style="width: 300px; height: 300px;">
						</p>
						<p>*리뷰 포토만 모아볼 수 있게 구현하기</p>
						<input type="button" value="리뷰목록 "
							class="btn btn-outline-secondary btn-sm"
							onclick="location.href='/mdReview/reviewList'"> <br>
						<br> <br>

						<hr>
						<br> <br>
						<h4 id="scrollspyHeading3" class="fw-bold">상품 문의</h4>
						<br>
						<h5 class="fw-bold text-primary">▶자주 하시는 질문과 답</h5>
						<hr>
						<br>
						<div>
							<div class="accordion" id="accordionPanelsStayOpenExample">
								<div class="accordion-item">
									<h2 class="accordion-header">
										<button class="accordion-button" type="button"
											data-bs-toggle="collapse"
											data-bs-target="#panelsStayOpen-collapseOne"
											aria-expanded="true"
											aria-controls="panelsStayOpen-collapseOne">
											<p class="text-end">
											<strong>[주문/결제/입금확인] </strong>
											배송/교환/반품 문의를 빠르게 확인하려면 어떻게 해야되나요?</p>
										</button>
									</h2>
									<div id="panelsStayOpen-collapseOne"
										class="accordion-collapse collapse show">
										<div class="accordion-body">배송, 교환, 반품의 경우 판매자 측으로 직접 연락
											시 고객센터를 통하지 않고 직접 판매자에게 빠르게 문의가 가능하여 반품 배송,교환,반품 일정을 보다 빠르게
											확인이 가능합니다. 
											<br><br>
											<strong>1.판매자 연락처 확인 방법 ( 판매자에게(구매 상품 발송 주체) 직접 유선 문의 가능 )</strong>
											<br>
											[Web] 
											<br> 공통:구매/구매 예정 상품 상품페이지>스크롤 다운 시 노출되는 검은색 띠 內 반품/교환 클릭>하단 판매자 정보 구매상품 판매자 연락처 
											: 로그인>오른쪽 상단 위 마이페이지>마이페이지>주문정보 오른쪽 끝
											업체정보 클릭 
											<br><br>
											[Mobile]
											<br> 공통:구매/구매 예정 상품 상품페이지>스크롤 다운 시 노출되는 검은색 띠 內
											판매정보 클릭 구매상품 판매자 연락처 : 로그인>아래 하단 마이페이지(사람모양)>주문내역> 문의 필요한
											주문정보 상세보기>판매자정보>전화하기 터치 
											<br><br>
											(판매자 노출정보 : 판매자명 / 상호,대표자 / 연락처 / 응대가능시간 / 응대불가시간 / E-mail / 사업자등록번호 등)
											<br><br>
											<strong>2.판매자 게시글 문의 방법</strong> 
											<br>
											공통 : 구매/구매 예정 상품 상세페이지>스크롤 다운 시 노출되는 검은색 띠 內>상품문의 (문의) >문의글
											작성(비밀글/일반글) 
											<br> 구매상품 : 로그인>마이페이지>상품문의 필요한 구매 상품 클릭> 구매상품페이지 노출 시
											스크롤 다운> 검은색 띠 內 상품문의>상품문의>문의글 작성(비밀글/일반글)
											<br> ( ※ 상품문의 작성 시 개인정보가 작성되지 않도록 주의 부탁 드립니다. )
											<br> <br> 
											2개월 경과 구매상품 문의가 필요한 경우 리스트 상단 취소 주문 건
											같이보기/구매내역 더보기>구매내역 더보기 클릭</div>
									</div>
								</div>
								<div class="accordion-item">
									<h2 class="accordion-header">
										<button class="accordion-button collapsed" type="button"
											data-bs-toggle="collapse"
											data-bs-target="#panelsStayOpen-collapseTwo"
											aria-expanded="false"
											aria-controls="panelsStayOpen-collapseTwo">
											<p class="text-end">
											<strong>[주문/결제/입금확인] </strong>
											내 주문내역 확인은 어디에서 가능한가요?</p>
											</button>
									</h2>
									<div id="panelsStayOpen-collapseTwo"
										class="accordion-collapse collapse">
										<div class="accordion-body">
											<p class="text-danger">주문한 내역은 인터파크 홈페이지 로그인 후 [마이페이지]에서 확인하실 수 있습니다.</p>
											<br><b class="text-primary">[주문내역 확인 방법]</b>
											<br><strong>[마이페이지 > 쇼핑내역 > 주문/배송조회]</strong> 에서 최근 2개월 주문내역을 확인하실 수 
											있으며, 이전 주문은 날짜를 지정하셔서 조회하시면 됩니다.
										</div>
									</div>
								</div>
								<div class="accordion-item">
									<h2 class="accordion-header">
										<button class="accordion-button collapsed" type="button"
											data-bs-toggle="collapse"
											data-bs-target="#panelsStayOpen-collapseThree"
											aria-expanded="false"
											aria-controls="panelsStayOpen-collapseThree">
											<p class="text-end">
											<strong>[배송문의] </strong>
											발송완료 상태인데 아직 상품을 받지 못했어요!</p>
											</button>
									</h2>
									<div id="panelsStayOpen-collapseThree"
										class="accordion-collapse collapse">
										<div class="accordion-body">
										발송완료는 판매업체에서 택배사로 상품을 넘어간 상태를 의미하며, 
										<p class="text-danger">발송완료일로부터 1 ~ 2일 이내에 상품을 받아보실 수 있습니다 </p>
										<br> <strong>[배송조회 하기]</strong>
										<br>  ① [마이페이지] > 쇼핑내역 > 주문/배송조회] 에서 배송확인을 원하시는 주문의 오른쪽 택배/구매확정 아래 택배사 클릭 시
											해당 택배사로 배송조회 화면으로 이동합니다.
											<br> ② 택배사 사이트로 화면 이동 후 배송현황 확인 가능하며, 발송된
											후에는 해당 택배사로 문의하셔야 더욱 빠르게 배송상태를 알아보실 수 있습니다.
											<br><br>
											<strong>[주문 상태가 발송완료이나 운송장번호가 조회되지 않는 것] </strong>
											 <br>① 발송완료 일이 당일인 경우 택배사에 운송장정보가 전산에 등록되지 않은
											것으로 다음날 다시 한 번 조회를 부탁드립니다. 
											<br>② 판매업체에서 직접 배송하는 상품은 배송조회가 안될 수 있습니다. 
											<br>③ 배송조회 후 판매업체에서 임의 혹은 실수로 운송장번호를 잘못 입력한 것으로 판단되면 마이페이지
											주문내역에서 [허위발송신고]를 하시거나 쇼핑 고객센터에 알려주시면 확인 후 배송현황을 안내해 드리겠습니다.</div>
									</div>
								</div>
								<div class="accordion-item">
									<h2 class="accordion-header">
										<button class="accordion-button collapsed" type="button"
											data-bs-toggle="collapse"
											data-bs-target="#panelsStayOpen-collapseFour"
											aria-expanded="false"
											aria-controls="panelsStayOpen-collapseFour">
											<p class="text-end">
											<strong>[회원정보/부가서비스] </strong>
											아이디 / 비밀번호를 잊어버린 경우 어떻게 확인 하나요?</p></button>
									</h2>
									<div id="panelsStayOpen-collapseFour"
										class="accordion-collapse collapse">
										<div class="accordion-body">
										<p class="text-danger">아이디를 잊어버리신 경우 <strong>[홈페이지]</strong> 를 통해 간단한 회원정보를 확인 후
										 회원가입 시 정보와 일치하면 아이디 / 비밀번호를 확인 및 재설정하실 수 있습니다.</p>
										<p class="fs-5 fw-bold">[아이디 / 비밀번호 찾는 방법] </p>
											<p class="text-danger">① [ 홈페이지 상단 오른쪽 > 로그인 클릭 > 아아디 찾기 Or 비밀번호 찾기 ] 클릭 시 </p>
											등록된 휴대폰, 이메일 또는 본인 인증을 통하여 아이디 확인 및 비밀번호 재설정이 가능합니다. 
											<br>이때, 아이디 일부가 개인정보보호를 위하여 아이디 뒷자리 일부가**로 표시되며, 
											<br>아이디 전체 확인 시, 아이디 전체 확인을 위한 본인 인증수단 중 한가지를 선택하여 확인해 주시면 됩니다. 
											<br>아이디 / 비밀번호 모두를 잊어버리신 경우 똑같은 인증 방식으로 찾으셔야 수월하게 아이디 확인 및 비밀번호 변경이 가능 합니다.
										</div>
									</div>
								</div>
								<div class="accordion-item">
									<h2 class="accordion-header">
										<button class="accordion-button collapsed" type="button"
											data-bs-toggle="collapse"
											data-bs-target="#panelsStayOpen-collapseFive"
											aria-expanded="false"
											aria-controls="panelsStayOpen-collapseFive">
											<p class="text-end">
											<strong>[주문/결제/입금확인] </strong>
											주문완료 후 배송지를 변경할 수 있나요?</p></button>
									</h2>
									<div id="panelsStayOpen-collapseFive"
										class="accordion-collapse collapse">
										<div class="accordion-body">
										주문완료 후에는 상품의 <strong>주문 상태에 따라 배송지 변경 여부가 결정되며,</strong>
										 인터파크 직배송 상품과 판매업체 <strong>배송 상품에 따라 배송지 변경 방법이 다릅니다.</strong>
										 
										 <br><br>
										  <Strong class="text-primary">[마이페이지] 에서 배송지 변경이 가능한 주문확인 및 변경 방법 </Strong>
											<br>① 주문 상태가 주문접수, 결제확인, 업체주문통보 상태이면
											[마이페이지]에서 변경 가능 
											<br>② [마이페이지 > 쇼핑내역 > 주문내역변경 ] 주문번호 선택 후 주문내역
											변경하기 클릭 후
											<br> ③ 이동한 화면 아래쪽 배송지 변경하기 버튼 클릭 ④ 새로운 배송지 정보 입력 후
											[배송지변경하기] 클릭 
											
											<br><br>
											<Strong class="text-primary">[마이페이지]에서 배송지 변경이 불가능한 주문확인 및 변경 방법 </Strong>
											<br>① 주문상태가 업체발송준비중, 배송 중 상태이면 [마이페이지] 에서 변경 불가능 
											<br>② 주문 상태가 업체발송준비 중이면, 판매업체 정보보기에 기재되어 있는 연락처로 직접 판매업체 연락 후 변경 요청 
											<br>③ 배송 중 상태에서는 배송지 변경 불가능
											
											<br><br>
											<strong class="text-primary">[배송지 변경 안내] </strong> 
											<br>① 한 주문번호당 하나의 배송지만 설정하실 수 있습니다.
											<br>② 여러 배송지로의배송을 원하신다면 각각 주문해 주시기 바랍니다. 
											<br>③ 주문접수 상태부터 업체주문통보 단계까지는 [마이페이지]에서 배송지 변경이 가능합니다.
											<br>④ 업체가 상품을 발송할 준비를 하고 있는 중 배송지 변경을 하시려면 별도로 업체에 연락을 하셔야 합니다.
											</div>
									</div>
								</div>
								<div class="accordion-item">
									<h2 class="accordion-header">
										<button class="accordion-button collapsed" type="button"
											data-bs-toggle="collapse"
											data-bs-target="#panelsStayOpen-collapseSix"
											aria-expanded="false"
											aria-controls="panelsStayOpen-collapseSix">
											<p class="text-end">
											<strong>[영수증] </strong>
											전자세금계산서는 신청 후 바로 발급이 가능 한가요?</p></button>
									</h2>
									<div id="panelsStayOpen-collapseSix"
										class="accordion-collapse collapse">
										<div class="accordion-body">
											<p class="text-danger">전자세금계산서는 결제 완료일 기준으로 발급 됩니다.</p>
											<strong>결제 완료 익월 6일까지 아래 경로를 통해서 신청 해주시기 바랍니다.
											<br>다만, 발급 불가 할 경우 고객센터를 통해서 확인해주시기 바랍니다.</strong>
											 <br><br>
											발급/출력(다운로드)은 [마이페이지 > 쇼핑내역 > 영수증 신청/발행 > 세금계산서] 에서 해당 기간 
											내에 확인하실 수 있습니다.
										</div>
									</div>
								</div>
								<div class="accordion-item">
									<h2 class="accordion-header">
										<button class="accordion-button collapsed" type="button"
											data-bs-toggle="collapse"
											data-bs-target="#panelsStayOpen-collapseSeven"
											aria-expanded="false"
											aria-controls="panelsStayOpen-collapseSeven">
											<p class="text-end">
											<strong>[영수증] </strong>
											거래증빙서류를 확인하려면 별도의 프로그램을 설치해야 하나요?</p></button>
									</h2>
									<div id="panelsStayOpen-collapseSeven"
										class="accordion-collapse collapse">
										<div class="accordion-body">
											증빙서류(입금증/현금영수증/신용카드매출전표/전자세금계산서)를 처음 다운로드 받으시면 고객님의 
											PC에 증빙서류 관리 프로그램(TS Viewer)이 자동 설치되기 때문에 별도로 설치하실 필요가 없으며, 
											<br>이후에는 파일만 받으시면 됩니다.
											<br><br>
											<strong>[TS Viewer (증빙서류 관리 프로그램)]</strong>
											<br>① 발급된 증빙서류를 PC에 다운로드 하시면 파일 형태의 문서로 PC에 저장됩니다. 
											<br>② 증빙서류가 PC에 저장되는 위치는“C\Windows\TopShield\전자 문서함"이며, 디스켓 등 별도 저장
											   장치에 저장하셔도 무관합니다.
											<br>③  PC에 저장된 증빙서류는 편리하게 보관할 수 있으며, 언제든지 출력할 수 있습니다.
											   단, 출력한 신용카드매출전표 및 전자세금계산서는 법적 증빙 효력이 없습니다.
											<br>④ Viewer가 자동으로 설치되지 않아 증빙서류가 다운로드가 되지 않을 경우 VIEWER 다운로드  를
											   클릭하신 후 실행 또는 다운 받으시고 PC에 설치하신 뒤 증빙서류를 다운로드 하시면 됩니다.
											<br>⑤증빙서류(입금증/현금영수증/신용카드매출전표/전자세금계산서)를 발급 하기 위해서는 
											  고객님의 PC에 증빙서류 관리 프로그램(TS Viewer)이 정상적으로 설치 되어야 하나 
											  비정상적으로 설치되면 발급이 불가능 합니다. 
											 <br> [제어판 > 프로그램추가/삭제] 에서 증빙서류 관리 프로그램(TS Viewer)를 삭제 후 
											  고객님의 PC에 서 다시 다운로드 하시면 정상적으로 발급이 됩니다.
										</div>
									</div>
								</div>
								<div class="accordion-item">
									<h2 class="accordion-header">
										<button class="accordion-button collapsed" type="button"
											data-bs-toggle="collapse"
											data-bs-target="#panelsStayOpen-collapseEight"
											aria-expanded="false"
											aria-controls="panelsStayOpen-collapseEight">
											<p class="text-end">
											<strong>[반품/교환/AS/환불] </strong>
												반품하기로 한 상품을 아직도 회수해 가지 않았어요!</p></button>
									</h2>
									<div id="panelsStayOpen-collapseEight"
										class="accordion-collapse collapse">
										<div class="accordion-body">
											반품 상품의 반송 방법은 <strong>고객님께서 직접 택배사를 이용해 반송하시는 방법</strong>과,
											<strong>업체가 보내는 택배서비스를 이용하시는 방법</strong>이 있습니다. 
											 <br><br>
											<strong>[회수 지연 시 처리 방법]</strong>
											<br>① 판매업체에 반품를 요청하시면 판매업체별로 제휴되어 있는 택배사에서 기사가 방문합니다.
											   회수가 지연되는 경우에는 해당 판매업체로 연락해 주셔야 합니다.
											   단, 판매업체 연락처가 확인되지 않거나, 통화가 어려우시면 인터파크 쇼핑 고객센터로 알려주세요.
											<br>② 고객님께서 직접 택배사를 선택하여 보내실 경우 회수를 요청한 해당 택배사로 연락하셔서
											   회수 지연을 알리고 다시 회수될 수 있도록 요청해 주셔야 합니다. 
											<br><br>
											<p class="text-primary">처음 반품/회수를 요청한 곳이 아닌 다른곳으로 회수를 요청하시면 이중으로 택배 기사가 방문
											할 수 있으니, 회수 요청 방법을 변경하시려면 처음에 반품/회수를 요청한 곳으로 연락하셔서
											철회하신 후 다시 요청해 주시기 바랍니다.</p>
											
											<p class="text-danger">반품접수 후 90일 이내에 반품이 완료되지 않으면 해당 주문은 정상 주문으로 자동 변경되어 판매업체로 
											상품대금이 정산될 수 있습니다.
											고객님께서는 반품접수 후 반품이 완료될 때까지 주문상태를 확인 부탁드립니다.</p>
										</div>
									</div>
								</div>

								<br> <br> <br>
							</div>
						</div>


						<br> <br> <br>
						<div>
							<h4 id="scrollspyHeading4" class="fw-bold">배송/반품/교환 안내</h4>
							<hr>
							<p class="fs-4 fw-bold text-primary text-opacity-75">배송안내</p>
							<table class="table table-striped-columns table-group-divider">
								<tr>
									<th class="text-center text-uppercase align-middle">배송구분</th>
									<td>판매자 배송
										<ul>
											<li>택배사 : CJ대한통운 (상황에 따라 배송 업체는 변경 될 수 있습니다.)</li>
											<li>배송비 : 4,000원</li>
										</ul>
									</td>
								</tr>
								<tr>
									<th class="text-center align-middle">배송안내</th>
									<td><ul>
											<li>판매자가 직접 배송하는 상품입니다.</li>
											<li>판매자 사정에 의하여 출고예상일이 변경되거나 품절이 발생될 수 있습니다.</li>
										</ul></td>
								</tr>
							</table>
							<br>
							<p class="fs-4 fw-bold text-primary text-opacity-75">반품/교환 안내</p>
							<p>※ 상품 설명에 반품/교환과 관련한 안내가 있는경우 아래 내용보다 우선합니다. (업체 사정에 따라 달라질
								수 있습니다)</p>
							<table class="table table-striped-columns table-group-divider">
								<tr>
									<th class="text-center align-middle">배송구분</th>
									<td>반품/교환 방법
										<ul>
											<li>마이페이지 > 반품/교환 신청 및 조회, 1:1 문의, 고객만족센터(1544-3800),
												중고샵(1566-4295)</li>
											<li>판매자 배송 상품은 판매자와 반품/교환이 협의된 상품에 한해 가능합니다.</li>
										</ul>
									</td>
								</tr>
								<tr>
									<th class="text-center align-middle">반품/교환 가능기간</th>
									<td><ul>
											<li>출고 완료 후 10일 이내의 주문 상품</li>
											<li>디지털 콘텐츠인 eBook의 경우 구매 후 7일 이내의 상품</li>
											<li>중고상품의 경우 출고 완료일로부터 6일 이내의 상품 (구매확정 전 상태)</li>
										</ul></td>
								</tr>
								<tr>
									<th class="text-center align-middle">반품/교환 비용</th>
									<td><ul>
											<li>고객의 단순변심 및 착오구매일 경우 상품 반송비용은 고객 부담임</li>
											<li>직수입양서/직수입일서중 일부는 변심 또는 착오로 취소시 해외주문취소수수료 20%를 부과할수
												있음 <br>단, 아래의 주문/취소 조건인 경우, 취소 수수료 면제 <br>-오늘 00시
												~ 06시 30분 주문을 오늘 오전 06시 30분 이전에 취소 <br>-오늘 06시 30분 이후
												주문을 익일 오전 06시 30분 이전에 취소
											</li>
											<li>직수입 음반/영상물/기프트 중 일부는 변심 또는 착오로 취소 시 해외주문취소수수료 30%를
												부과할 수 있음 <br>단, 당일 00시~13시 사이의 주문은 취소 수수료 면제
											</li>
											<li>박스 포장은 택배 배송이 가능한 규격과 무게를 준수하며, 고객의 단순변심 및 착오구매일 경우
												상품의 반송비용은 박스 당 부과됩니다.</li>
										</ul></td>
								</tr>
								<tr>
									<th class="text-center align-middle">반품/교환 불가사유</th>
									<td><ul>
											<li>소비자의 책임 있는 사유로 상품 등이 손실 또는 훼손된 경우</li>
											<li>소비자의 사용, 포장 개봉에 의해 상품 등의 가치가 현저히 감소한 경우 : 예) 화장품,
												식품, 가전제품, 전자책 단말기 등</li>
											<li>복제가 가능한 상품 등의 포장을 훼손한 경우 : 예) CD/LP, DVD/Blu-ray,
												소프트웨어, 만화책, 잡지, 영상 화보집</li>
											<li>소비자의 요청에 따라 개별적으로 주문 제작되는 상품의 경우</li>
											<li class="fw-bold">디지털 컨텐츠인 eBook, 오디오북 등을 1회 이상 다운로드를
												받았을 경우</li>
											<li>eBook 대여 상품은 대여 기간이 종료 되거나, 2회 이상 대여 했을 경우 취소 불가</li>
											<li>중고상품이 구매확정(자동 구매확정은 출고완료일로부터 7일)된 경우</li>
											<li>LP상품의 재생 불량 원인이 기기의 사양 및 문제인 경우 (All-in-One 일체형 일부
												보급형 오디오 모델 사용 등)</li>
											<li>시간의 경과에 의해 재판매가 곤란한 정도로 가치가 현저히 감소한 경우</li>
											<li>전자상거래 등에서의 소비자보호에 관한 법률이 정하는 소비자 청약철회 제한 내용에 해당되는 경우</li>
										</ul></td>
								</tr>
								<tr>
									<th class="text-center align-middle">소비자 피해보상</th>
									<td><ul>
											<li>상품의 불량에 의한 반품, 교환, A/S, 환불, 품질보증 및 피해보상 등에 관한 사항은
												소비자분쟁해결기준(공정거래위원회 고시)에 준하여 처리됨</li>
										</ul></td>
								</tr>
								<tr>
									<th class="text-center align-middle">환불 지연에 따른 배상</th>
									<td><ul>
											<li>대금 환불 및 환불 지연에 따른 배상금 지급 조건, 절차 등은 전자상거래 등에서의 소비자
												보호에 관한 법률에 따라 처리</li>
										</ul></td>
								</tr>
							</table>
							<br> <br> <br>
						</div>
					</div>
				</div>
			</div>
		</div>






	</div>
</div>
<!-- 내용 끝 -->