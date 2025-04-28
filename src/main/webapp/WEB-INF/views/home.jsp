<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Ana Sayfa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Test Uygulaması</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <span class="navbar-text text-white me-3">
                        ${pageContext.request.userPrincipal.name}
                    </span>
                </li>
                <li class="nav-item">
                    <a class="btn btn-outline-light" href="<c:url value='/logout' />">Çıkış Yap</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Ana İçerik -->
<div class="container mt-5">
    <div class="row justify-content-center">

        <c:choose>
            <c:when test="${isAdmin}">
                <!-- Admin Paneli -->
                <div class="col-md-10">
                    <div class="card shadow-sm">
                        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                            <h4 class="mb-0">Test Yönetimi</h4>
                            <a href="<c:url value='/tests/create' />" class="btn btn-light btn-sm">Yeni Test Oluştur</a>
                        </div>
                        <div class="card-body">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Test Adı</th>
                                    <th>İşlemler</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="test" items="${tests}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${test.name}</td>
                                        <td>
                                            <a href="<c:url value='/tests/edit/${test.id}' />" class="btn btn-sm btn-warning">Düzenle</a>
                                            <a href="<c:url value='/tests/delete/${test.id}' />" class="btn btn-sm btn-danger" onclick="return confirm('Testi silmek istediğinize emin misiniz?');">Sil</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Kullanıcı Paneli -->
                <div class="col-md-8">
                    <div class="card shadow-sm">
                        <div class="card-header bg-success text-white">
                            <h4>Test Çözme Paneli</h4>
                        </div>
                        <div class="card-body">
                            <ul class="list-group list-group-flush">
                                <c:forEach var="test" items="${tests}">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                            ${test.name}
                                        <a href="<c:url value='/tests/solve/${test.id}' />" class="btn btn-sm btn-success">Testi Çöz</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
