<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>

<layout:layout pageTitle="Kullanıcı Profili">
    <div class="container my-5">
        <div class="profile-header d-flex align-items-center gap-4 mb-4">
            <div class="avatar rounded-circle" style="
                width: 90px;
                height: 90px;
                background-color: #ccc;
                background-image: url('https://www.gravatar.com/avatar?d=mp');
                background-size: cover;">
            </div>
            <div class="user-info">
                <h2 class="mb-1">${user.firstName} ${user.lastName}</h2>
                <h5 class="text-muted">@${user.username}</h5>
            </div>
        </div>

        <div class="stats">
            <h4 class="mb-3 border-bottom pb-2">Çözdüğü Testler</h4>
            <div class="table-responsive">
                <table class="table table-striped align-middle">
                    <thead class="table-light">
                    <tr>
                        <th>Test Adı</th>
                        <th>Doğru</th>
                        <th>Yanlış</th>
                        <th>Puan</th>
                        <th>Çözüm Tarihi</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="result" items="${results}">
                        <tr>
                            <td>${result.test.name}</td>
                            <td class="text-success fw-semibold">${result.correctCount}</td>
                            <td class="text-danger fw-semibold">${result.incorrectCount}</td>
                            <td class="text-primary fw-bold">
                                <c:set var="total" value="${result.correctCount + result.incorrectCount}" />
                                <c:choose>
                                    <c:when test="${total > 0}">
                                        <fmt:formatNumber value="${(result.correctCount * 100.0) / total}" maxFractionDigits="1"/>%
                                    </c:when>
                                    <c:otherwise>0%</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <fmt:formatDate value="${result.createdAt}" pattern="dd.MM.yyyy HH:mm" />
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty results}">
                        <tr>
                            <td colspan="5" class="text-center text-muted">Henüz test çözülmemiş.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</layout:layout>
