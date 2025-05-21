<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Giriş / Kayıt Ol</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .tab-button {
            width: 50%;
        }
        .active-tab {
            background-color: #0d6efd;
            color: white;
        }
    </style>
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5 bg-white border p-4 shadow-sm rounded">

<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<c:if test="${not empty success}">
    <div class="alert alert-success">${success}</div>
</c:if>
            <!-- Sekmeler -->
            <div class="d-flex mb-4">
                <button id="loginTab" class="btn tab-button active-tab" onclick="showForm('login')">Giriş Yap</button>
                <button id="registerTab" class="btn tab-button btn-outline-primary" onclick="showForm('register')">Kayıt Ol</button>
            </div>

            <!-- Giriş Formu -->
            <div id="loginForm">
                <h4 class="text-center mb-3">Giriş Yap</h4>

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

            <!-- Kayıt Formu -->
            <div id="registerForm" style="display: none;">
                <h4 class="text-center mb-3">Kayıt Ol</h4>

                <form method="post" action="<c:url value='/register' />">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <div class="mb-3">
                        <label for="firstName" class="form-label">Ad</label>
                         <input type="text" class="form-control" id="firstName" name="firstName" required />

                    </div>

                    <div class="mb-3">
                       <label for="lastName" class="form-label">Soyad</label>
                       <input type="text" class="form-control" id="lastName" name="lastName" required />
                    </div>

                    <div class="mb-3">
                        <label for="username" class="form-label">Kullanıcı Adı</label>
                        <input type="text" class="form-control" id="username" name="username" required />
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Şifre</label>
                        <input type="password" class="form-control" id="password" minlength="8" name="password" required />
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-success">Kayıt Ol</button>
                    </div>
                </form>

            </div>

        </div>
    </div>
</div>

<!-- Bootstrap + JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function showForm(formType) {
        const loginForm = document.getElementById('loginForm');
        const registerForm = document.getElementById('registerForm');
        const loginTab = document.getElementById('loginTab');
        const registerTab = document.getElementById('registerTab');

        if (formType === 'login') {
            loginForm.style.display = 'block';
            registerForm.style.display = 'none';
            loginTab.classList.add('active-tab');
            registerTab.classList.remove('active-tab');
        } else {
            loginForm.style.display = 'none';
            registerForm.style.display = 'block';
            loginTab.classList.remove('active-tab');
            registerTab.classList.add('active-tab');
        }
    }
</script>
</body>
</html>
