<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Test Oluştur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="mb-4">Yeni Test Oluştur</h2>

    <form:form method="POST" action="${pageContext.request.contextPath}/tests/create" modelAttribute="test" class="bg-white p-4 rounded shadow-sm">

        <div class="mb-3">
            <form:label path="name" class="form-label">Test Adı:</form:label>
            <form:input path="name" cssClass="form-control" />
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-primary">Testi Kaydet</button>
        </div>

    </form:form>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
