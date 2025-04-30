<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Soru Oluştur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">Yeni Soru Oluştur</h2>

    <form:form method="POST"
               action="${pageContext.request.contextPath}/questions/create/${tests.id}"
               modelAttribute="question"
               class="bg-white p-4 rounded shadow-sm">

        <div class="mb-3">
            <form:label path="text" class="form-label">Soru Metni:</form:label>
            <form:input path="text" cssClass="form-control"/>
        </div>
        <div class="d-grid">
            <button type="submit" class="btn btn-primary">Soruyu Kaydet</button>
        </div>
    </form:form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
