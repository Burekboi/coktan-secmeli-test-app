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

        /* Navbar özelleştirmeleri */
        .navbar-brand { font-weight: bold; letter-spacing: 1px; }
        .nav-link { padding: 0.5rem 1rem; }
        .profile-dropdown .dropdown-toggle::after { margin-left: 0.5rem; }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="<c:url value='/home'/>">
            🏠 Test Uygulaması
        </a>
        <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#mainNavbar"
                aria-controls="mainNavbar"
                aria-expanded="false"
                aria-label="Toggle navigation"
        >
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNavbar">

            <ul class="navbar-nav ms-auto align-items-center">
                <!-- Dil Seçici -->
                <li class="nav-item dropdown me-3">
                    <a
                            class="nav-link dropdown-toggle"
                            href="#"
                            id="langDropdown"
                            role="button"
                            data-bs-toggle="dropdown"
                            aria-expanded="false"
                    >
                        <i class="bi bi-translate"></i> Dil
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="langDropdown">
                        <li><a class="dropdown-item" href="?lang=tr">Türkçe</a></li>
                        <li><a class="dropdown-item" href="?lang=en">English</a></li>
                    </ul>
                </li>

                <!-- Kullanıcı Profili -->
                <li class="nav-item dropdown profile-dropdown">
                    <a
                            class="nav-link dropdown-toggle d-flex align-items-center"
                            href="#"
                            id="userDropdown"
                            role="button"
                            data-bs-toggle="dropdown"
                            aria-expanded="false"
                    >
                        <img
                                src="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/icons/person-circle.svg"
                                alt="Profile"
                                width="24" height="24"
                                class="rounded-circle me-1"
                        />
                        <c:out value="${pageContext.request.userPrincipal.name}" default="Misafir"/>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <li>
                            <a class="dropdown-item" id="profile_navbar" href="<c:url value='/user/profile'/>">
                                Profilim
                            </a>
                        </li>
                        <li><hr class="dropdown-divider" id="menu-divider"></li>
                        <li>
                            <a class="dropdown-item text-danger" href="<c:url value='/logout'/>">
                                Çıkış Yap
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<main class="container mt-5">
    <jsp:doBody/>
</main>

<footer class="py-3 bg-light border-top mt-auto">
    <div class="container text-center">
        <span class="text-muted">© 2025 Test Uygulaması. Tüm hakları saklıdır.</span>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap Icons CDN (profil ikonu için) -->
<link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
/>
</body>
</html>
