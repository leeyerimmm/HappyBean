<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    request.setCharacterEncoding("UTF-8");
%>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" href="${pageContext.request.contextPath}/images/common/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/my/manager.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" />
    <script src="https://cdn.ckeditor.com/ckeditor5/29.1.0/classic/ckeditor.js"></script>
    <title>해피빈 관리자 : 펀딩 등록</title>        
    <style>
        .ck.ck-editor {
            max-width: 100%;
        }
        .ck-editor__editable {
            min-height: 500px;
        }
    </style>
</head>
<body>
    <jsp:include page="/views/header.jsp"/> 
    <div id="wrap" class="w_max">
        <jsp:include page="/views/admin_nav.jsp"/>
        <div style="align-self: flex-start; flex-grow: 2">
            <section id="item_write_wrap">
                <h2 class="funding_title">기부 아이템 등록</h2>
                <form action="donation_write_proc.jsp" method="post" autocomplete="off" accept-charset="utf-8">
                    <table class="write" style="width: 100%;">
                        <colgroup>
                            <td style="width: 15%"></td>
                            <td style="width: 35%"></td>
                            <td style="width: 15%"></td>
                            <td style="width: 35%"></td>
                        </colgroup>
                        <tr>
                            <th>구분</th>
                            <td>
					<select name="category" id="category">
					    <option>선택하세요</option>
					   	<option value="가족·여성">가족·여성</option>
					    <option value="시민사회">시민사회</option>
					    <option value="환경">환경</option>
					    <option value="어르신">어르신</option>
					    <option value="다문화">다문화</option>
					    <option value="아동·청소년">아동·청소년</option>
					    <option value="동물">동물</option>
					    <option value="장애인">장애인</option>
					    <option value="기타">기타</option>
					</select>


														

  </td>
            <th>진행유무</th>
            <td>
                <select name="status" id="status">
                    <option>선택하세요</option>
                    <option value="진행중">진행중</option>
                    <option value="종료됨">종료</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>제목</th>
            <td colspan="3">
                <input type="text" name="title" id="title" required/>
            </td>
        </tr>
        <tr>
            <th>이미지명</th>
            <td>
                <input type="text" name="thumb" id="thumb" placeholder="ex : image01.jpg" required/>
            </td>
            <th>서브 이미지</th>
            <td>
                <input type="text" name="sub_images" id="sub_images" placeholder="ex : image01.jpg" required/>
            </td>
        </tr>
        <tr>
            <th>주최자</th>
            <td colspan="3">
                <input type="text" name="company" id="company" required/>
            </td>
        </tr>
        <tr>
            <th>시작일</th>
            <td>
                <input type="date" name="startDate" id="start_date" required/>
            </td>
            <th>종료일</th>
            <td>
                <input type="date" name="endDate" id="end_date" required/>
            </td>
        </tr>
        <tr>
            <th>목표금액</th>
            <td>
                <input type="number" name="goal_amount" id="goal_amount" required/>
            </td>
            <th>사업 기간</th>
            <td>
                <input type="text" name="project_duration" id="project_duration" placeholder="ex : 2024.12.01 ~ 2025.03.31" required/>
            </td>
        </tr>
        <tr>
            <th>사업 대상</th>
            <td>
                <input type="text" name="target_group" id="target_group" placeholder="ex : 취약계층 어르신" required/>
            </td>
            <th>사업 대상 수</th>
            <td>
                <input type="number" name="target_count" id="target_count" placeholder="ex : 1" required/>
            </td>
        </tr>

 <tr>
            <th>세부 항목 목록</th>
            <td colspan="3">
                <input type="text" name="cost_details" id="cost_details" placeholder="세부 항목을 '|'로 구분하여 입력하세요. ex : 사업비|경상운영비" required/>
            </td>
        </tr>
        <tr>
            <th>세부 항목 내용</th>
            <td colspan="3">
                <input type="text" name="cost_descriptions" id="cost_descriptions" placeholder="항목 내용을 '|'로 구분하여 입력하세요. ex : 재활치료비|긴급생계비" required/>
            </td>
        </tr>
        <tr>
            <th>세부 항목 금액</th>
            <td colspan="3">
                <input type="text" name="cost_amounts" id="cost_amounts" placeholder="항목 금액을 '|'로 구분하여 입력하세요. ex : 4800000|3615000" required/>
            </td>
        </tr>
                <tr>
            <th>기대 효과</th>
            <td colspan="3">
                <input type="text" name="expected_effect" id="expected_effect" placeholder="기대 효과를 '|'로 구분하여 입력하세요. ex : 의료비 지원으로 증상 완화|생계비 지원으로 안정적인 생계 유지" required/>
            </td>
        </tr>
                        <tr>
                            <td colspan="4" style="height:500px;">
                                <textarea name="description" id="description" style="width:100%; height:500px;"placeholder="본문을 '|'로 구분하여 입력하세요."></textarea>
                            </td>
                            <script>
                                ClassicEditor
                                .create( document.querySelector( '#description' ))
                                .catch( error => {
                                    console.error( error );
                                });
                            </script>
                        </tr>                            
                    </table>
                    <div class="btn_box">
                        <button type="submit">작성완료</button>
                        <button type="reset">재 작성</button>
                    </div>
                </form>            
            </div>
        </div>
    <jsp:include page="/views/footer.jsp"/>
</body>
</html>
