<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Giriş Yap</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-4 bg-white border p-4 shadow-sm rounded">
            <h3 class="text-center mb-4">Giriş Yap</h3>

            <c:if test="${param.error != null}">
                <div class="alert alert-danger">Hatalı kullanıcı adı veya şifre!</div>
            </c:if>
            <c:if test="${param.logout != null}">
                <div class="alert alert-success">Çıkış yapıldı.</div>
            </c:if>

            <form method="post" action="<c:url value='/perform_login' />">

            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <div class="mb-3">
                    <label for="username" class="form-label">Kullanıcı Adı</label>
                    <input type="text" class="form-control" id="username" name="username" required />
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Şifre</label>
                    <input type="password" class="form-control" id="password" name="password" required />
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Giriş Yap</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
