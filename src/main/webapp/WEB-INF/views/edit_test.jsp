<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<layout:layout pageTitle="Testi Düzenle - ${test.name}">
    <c:choose>
        <%-- test modeli yoksa uyarı göster --%>
        <c:when test="${empty test}">
            <div class="alert alert-danger">
                Düzenlenecek test bulunamadı.
            </div>
        </c:when>

        <%-- test modeli geldiyse formu göster --%>
        <c:otherwise>
            <h2 class="mb-4">Testi Düzenle</h2>
            <form action="<c:url value='/tests/edit/${test.id}'/>" method="post">
                    <%-- CSRF açık ise aşağıdakini kullanabilirsiniz --%>
                    <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
                <div class="mb-3">
                    <label for="name" class="form-label">Test Adı</label>
                    <input
                            type="text"
                            class="form-control"
                            id="name"
                            name="name"
                            value="${test.name}"
                            required
                    />
                </div>
                <button type="submit" class="btn btn-primary">Güncelle</button>
                <a
                        href="<c:url value='/tests/detail/${test.id}'/>"
                        class="btn btn-secondary ms-2"
                >İptal</a
                >
            </form>
        </c:otherwise>
    </c:choose>
</layout:layout>
