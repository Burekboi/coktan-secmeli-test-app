<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="pageTitle" required="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>
        <c:choose>
            <c:when test="${not empty pageTitle}">${pageTitle}</c:when>
            <c:otherwise>Test Uygulaması</c:otherwise>
        </c:choose>
    </title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <style>
        /* Footer’un sayfa altına yapışması için */
        body { display: flex; flex-direction: column; min-height: 100vh; }
        main { flex: 1; }
    </style>
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="<c:url value='/home'/>">🏠 Anasayfa</a>
        <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navMenu"
        >
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
            <span class="navbar-text text-white me-3">
              <c:out value="${pageContext.request.userPrincipal.name}" default="Misafir"/>
            </span>
                </li>
                <li class="nav-item">
                    <a class="btn btn-outline-light" href="<c:url value='/logout'/>">
                        Çıkış Yap
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Ana içerik -->
<main class="container mt-5">
    <jsp:doBody/>
</main>

<!-- Minimalist Footer -->
<footer class="py-3 bg-light border-top">
    <div class="container text-center">
        <span class="text-muted">© 2025 Test Uygulaması. Tüm hakları saklıdır.</span>
    </div>
</footer>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"
></script>
</body>
</html>
