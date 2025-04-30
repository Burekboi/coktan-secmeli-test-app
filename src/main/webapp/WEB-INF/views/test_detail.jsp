<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Test Detayı</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="bg-light">

<div class="container my-5">

    <!-- Test bulunamadıysa uyarı -->
    <c:if test="${empty test}">
        <div class="alert alert-danger">
            Aradığınız teste ulaşılamadı.
        </div>
    </c:if>

    <!-- Test varsa detayları göster -->
    <c:if test="${not empty test}">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>${test.name}</h2>
            <div>
                <a href="<c:url value='/tests/edit/${test.id}'/>" class="btn btn-sm btn-warning">Testi Düzenle</a>
                <a href="<c:url value='/tests/delete/${test.id}'/>"
                   class="btn btn-sm btn-danger"
                   onclick="return confirm('Testi silmek istediğinize emin misiniz?');">
                    Testi Sil
                </a>
                <a href="<c:url value='/questions/create?testId=${test.id}'/>"
                   class="btn btn-sm btn-info">Soru Ekle</a>
            </div>
        </div>

        <c:choose>
            <%-- Sorular varsa --%>
            <c:when test="${not empty test.questions}">
                <div class="accordion" id="questionsAccordion">
                    <c:forEach var="question" items="${test.questions}" varStatus="qs">
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="heading${question.id}">
                                <button class="accordion-button ${qs.index > 0 ? 'collapsed' : ''}"
                                        type="button"
                                        data-bs-toggle="collapse"
                                        data-bs-target="#collapse${question.id}"
                                        aria-expanded="${qs.index == 0}"
                                        aria-controls="collapse${question.id}">
                                    Soru ${qs.index + 1}: ${question.text}
                                </button>
                            </h2>
                            <div id="collapse${question.id}"
                                 class="accordion-collapse collapse ${qs.index == 0 ? 'show' : ''}"
                                 aria-labelledby="heading${question.id}"
                                 data-bs-parent="#questionsAccordion">
                                <div class="accordion-body">
                                    <ul class="list-group mb-3">
                                        <c:forEach var="choice" items="${question.choices}" varStatus="cs">
                                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                                    ${cs.index + 1}. ${choice.text}
                                                <span>
                                                    <a href="<c:url value='/choices/edit/${choice.id}'/>"
                                                       class="btn btn-sm btn-outline-warning">Düzenle</a>
                                                    <a href="<c:url value='/choices/delete/${choice.id}'/>"
                                                       class="btn btn-sm btn-outline-danger"
                                                       onclick="return confirm('Şıkkı silmek istediğinize emin misiniz?');">
                                                        Sil
                                                    </a>
                                                </span>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                    <a href="<c:url value='/choices/create?questionId=${question.id}'/>"
                                       class="btn btn-sm btn-secondary">Yeni Şık Ekle</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <%-- Sorular yoksa --%>
            <c:otherwise>
                <div class="alert alert-info">
                    Henüz bu teste bağlı soru yok.
                    <a href="<c:url value='/questions/create?testId=${test.id}'/>">İlk soruyu ekleyin.</a>
                </div>
            </c:otherwise>
        </c:choose>

    </c:if>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
