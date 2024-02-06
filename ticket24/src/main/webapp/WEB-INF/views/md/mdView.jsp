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
				<div class="card" style="height: 37rem;">
					<div class="card-body text-center">
						<img
							src="${pageContext.request.contextPath}/image_upload/img6.jpg"
							class="card-img-center" style="width: 300px; height: 300px;">
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
				<span> <span class="card-text fs-2 fw-bolder">${md.md_price}</span>
					<span class="card-text fs-2 fw-bolder">원</span>
				</span> <br> <br>
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
				<p class="text-center">수량 선택 버튼 구현 예정</p>
				<br>
				<div>
					<span class="text-start">총 상품금액</span> <span class="float-end">${md.md_price}원</span>
				</div>
				<div>
					<strong class="text-start fs-4">총 할인금액</strong> <strong
						class="float-end fs-4">${md.md_price}원</strong>
				</div>
				<br>
				<div>
					<div class="d-grid gap-2 col-8 mx-auto">
						
						<div class="md-detail">
						<form id="addCart" action="/mdCart/addCart" method="post">
							<input type="hidden" name="md_num" value="${md.md_num}"
								id="md_num">
							 <input type="hidden" name="md_price" value="${md.md_price}" id="md_price">
							 <input type="hidden" name="md_quantity" value="${md.md_quantity}"
								id="md_quantity">
							<ul>
								<li class="card-text fs-2 fw-bolder"><b class="card-text fs-2 fw-bolder"><fmt:formatNumber value="${md.md_price}" />원</b></li>
								<li>재고 : <span><fmt:formatNumber
											value="${md.md_quantity}" /></span></li>
											
								<c:if test="${md.md_quantity > 0}">
									<li><label for="order_quantity">구매수량</label> <input
										type="number" name="order_quantity" min="1"
										max="${md.md_quantity}" autocomplete="off" id="order_quantity"
										class="quantity-width"></li>
									<li><span id="sub_total">총주문 금액 : ${md.md_price}원</span></li>
									<li><input type="submit" class="btn btn-outline-secondary" value="장바구니에 담기"
									></li>	
									<li><input type="submit" class="btn btn-secondary btn-lg" value="바로구매"></li>
								</c:if>
								<c:if test="${md.md_quantity <= 0}">
									<li class="align-center"><span class="sold-out">품절</span>
									</li>
								</c:if>
							</ul>
						</form>
						</div>


						<input type="submit" value="장바구니 담기"
							class="btn btn-outline-secondary"
							onclick="location.href='#">
						<button class="btn btn-secondary btn-lg" type="button">바로구매</button>
					</div>

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
						<ul>
							<li>구매한 상품의 취소/반품은 마이쿠팡 구매내역에서 신청 가능합니다.</li>
							<li>상품문의 및 후기게시판을 통해 취소나 환불, 반품 등은 처리되지 않습니다.</li>
							<li class="fw-bold">가격, 판매자, 교환/환불 및 배송 등 해당 상품 자체와 관련 없는
								문의는 고객센터 내 1:1 문의하기를 이용해주세요.</li>
							<li class="fw-bold">"해당 상품 자체"와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배
								등의 글은 예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수 있습니다.</li>
							<li>공개 게시판이므로 전화번호, 메일 주소 등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.</li>
						</ul>
						<hr>
						<p>
							<img
								src="${pageContext.request.contextPath}/image_upload/img6.jpg"
								style="width: 300px; height: 300px;">
						</p>


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
							<br>
							<br>
							<br>
						</div>
					</div>
				</div>
			</div>
		</div>






	</div>
</div>
<!-- 내용 끝 -->