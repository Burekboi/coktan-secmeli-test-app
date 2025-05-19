<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page    contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:setLocale value="${param.lang}" scope="session"/>
<fmt:setBundle basename="messages"/>



<layout:layout pageTitle='<fmt:message key="page.testDetail"/> – ${test.name}'>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty test and empty errorMessage}">
            <div class="alert alert-danger">
                <fmt:message key="error.testNotFound"/>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Header & Actions -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>${test.name}</h2>
                <div class="btn-group btn-group-sm">
                    <button type="button"
                            class="btn btn-info create-question-btn"
                            data-test-id="${test.id}">
                        <fmt:message key="button.newQuestion"/>
                    </button>
                    <button type="button"
                            class="btn btn-warning edit-test-btn"
                            data-test-id="${test.id}"
                            data-test-name="${test.name}">
                        <fmt:message key="button.editTest"/>
                    </button>
                    <button type="button"
                            class="btn btn-danger delete-test-btn"
                            data-delete-url="${ctx}/tests/delete/${test.id}">
                        <fmt:message key="button.deleteTest"/>
                    </button>
                </div>
            </div>

            <!-- Questions Accordion -->
            <div class="accordion" id="questionsAccordion">
                <c:forEach var="question" items="${test.questions}" varStatus="qs">
                    <div class="accordion-item">
                        <h2 class="accordion-header d-flex justify-content-between align-items-center"
                            id="heading${question.id}">
                            <button class="accordion-button ${qs.index > 0 ? 'collapsed' : ''}"
                                    type="button"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#collapse${question.id}"
                                    aria-expanded="${qs.index == 0}"
                                    aria-controls="collapse${question.id}">
                                <fmt:message key="label.questionNumber">
                                    <fmt:param>${qs.index + 1}</fmt:param>
                                </fmt:message>
                                : ${question.text}
                            </button>
                            <div class="btn-group btn-group-sm">
                                <button type="button"
                                        class="btn btn-outline-warning edit-question-btn"
                                        data-question-id="${question.id}"
                                        data-question-text="${fn:escapeXml(question.text)}">
                                    <fmt:message key="button.editQuestion"/>
                                </button>
                                <button type="button"
                                        class="btn btn-outline-danger delete-question-btn"
                                        data-delete-url="${ctx}/questions/delete/${question.id}">
                                    <fmt:message key="button.deleteQuestion"/>
                                </button>
                            </div>
                        </h2>
                        <div id="collapse${question.id}"
                             class="accordion-collapse collapse ${qs.index == 0 ? 'show' : ''}"
                             aria-labelledby="heading${question.id}"
                             data-bs-parent="#questionsAccordion">
                            <div class="accordion-body">
                                <ul class="list-group mb-3">
                                    <c:forEach var="choice" items="${question.choices}" varStatus="cs">
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                            <fmt:message key="label.choiceNumber">
                                                <fmt:param>${cs.index + 1}</fmt:param>
                                            </fmt:message>
                                            . ${choice.text}
                                            <div class="btn-group btn-group-sm">
                                                <button type="button"
                                                        class="btn btn-outline-warning edit-choice-btn"
                                                        data-choice-id="${choice.id}"
                                                        data-choice-text="${fn:escapeXml(choice.text)}"
                                                        data-choice-correct="${choice.correct}">
                                                    <fmt:message key="button.editChoice"/>
                                                </button>
                                                <button type="button"
                                                        class="btn btn-outline-danger delete-choice-btn"
                                                        data-delete-url="${ctx}/choices/delete/${choice.id}">
                                                    <fmt:message key="button.deleteChoice"/>
                                                </button>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                                <button type="button"
                                        class="btn btn-secondary add-choice-btn"
                                        data-question-id="${question.id}">
                                    <fmt:message key="button.addChoice"/>
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Modals -->
    <!-- deleteTestModal.jsp -->
    <div class="modal fade" id="confirmDeleteTestModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><fmt:message key="modal.deleteTestTitle"/></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body"><fmt:message key="modal.deleteTestBody"/></div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal"><fmt:message key="button.cancel"/></button>
                    <button class="btn btn-danger" id="confirmDeleteTestBtn"><fmt:message key="button.delete"/></button>
                </div>
            </div>
        </div>
    </div>

    <!-- deleteQuestionModal.jsp -->
    <div class="modal fade" id="confirmDeleteQuestionModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><fmt:message key="modal.deleteQuestionTitle"/></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body"><fmt:message key="modal.deleteQuestionBody"/></div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal"><fmt:message key="button.cancel"/></button>
                    <button class="btn btn-danger" id="confirmDeleteQuestionBtn"><fmt:message key="button.delete"/></button>
                </div>
            </div>
        </div>
    </div>

    <!-- deleteChoiceModal.jsp -->
    <div class="modal fade" id="confirmDeleteChoiceModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><fmt:message key="modal.deleteChoiceTitle"/></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body"><fmt:message key="modal.deleteChoiceBody"/></div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal"><fmt:message key="button.cancel"/></button>
                    <button class="btn btn-danger" id="confirmDeleteChoiceBtn"><fmt:message key="button.delete"/></button>
                </div>
            </div>
        </div>
    </div>

    <!-- editQuestionModal.jsp -->
    <div class="modal fade" id="editQuestionModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="editQuestionForm" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title"><fmt:message key="modal.editQuestionTitle"/></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label"><fmt:message key="label.questionText"/></label>
                            <input type="text" class="form-control" id="questionTextEdit" name="text" required/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal"><fmt:message key="button.cancel"/></button>
                        <button class="btn btn-primary"><fmt:message key="button.update"/></button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- editChoiceModal.jsp -->
    <div class="modal fade" id="editChoiceModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="editChoiceForm" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title"><fmt:message key="modal.editChoiceTitle"/></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label"><fmt:message key="label.choiceText"/></label>
                            <input type="text" class="form-control" id="choiceTextEdit" name="text" required/>
                        </div>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="choiceCorrectEdit" name="correct"/>
                            <label class="form-check-label"><fmt:message key="label.choiceCorrect"/></label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal"><fmt:message key="button.cancel"/></button>
                        <button class="btn btn-primary"><fmt:message key="button.update"/></button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- createQuestionModal.jsp -->
    <div class="modal fade" id="createQuestionModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="createQuestionForm" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title"><fmt:message key="modal.newQuestionTitle"/></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label"><fmt:message key="label.questionText"/></label>
                            <input type="text" class="form-control" id="questionTextCreate" name="text" required/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal"><fmt:message key="button.cancel"/></button>
                        <button class="btn btn-primary"><fmt:message key="button.create"/></button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- addChoiceModal.jsp -->
    <div class="modal fade" id="addChoiceModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="addChoiceForm" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title"><fmt:message key="modal.newChoiceTitle"/></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label"><fmt:message key="label.choiceText"/></label>
                            <input type="text" class="form-control" id="choiceTextAdd" name="text" required/>
                        </div>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="choiceCorrectAdd" name="correct"/>
                            <label class="form-check-label"><fmt:message key="label.choiceCorrect"/></label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal"><fmt:message key="button.cancel"/></button>
                        <button class="btn btn-primary"><fmt:message key="button.create"/></button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const byId = id => document.getElementById(id);
            const ctx  = '${ctx}';

            // Test delete
            let testDeleteUrl;
            const testModal = new bootstrap.Modal(byId('confirmDeleteTestModal'));
            document.querySelectorAll('.delete-test-btn').forEach(b => {
                b.addEventListener('click', () => {
                    testDeleteUrl = b.getAttribute('data-delete-url');
                    testModal.show();
                });
            });
            byId('confirmDeleteTestBtn').addEventListener('click', () => {
                if (testDeleteUrl) location.href = testDeleteUrl;
            });

            // Question delete
            let questionDeleteUrl;
            const qModal = new bootstrap.Modal(byId('confirmDeleteQuestionModal'));
            document.querySelectorAll('.delete-question-btn').forEach(b => {
                b.addEventListener('click', () => {
                    questionDeleteUrl = b.getAttribute('data-delete-url');
                    qModal.show();
                });
            });
            byId('confirmDeleteQuestionBtn').addEventListener('click', () => {
                if (questionDeleteUrl) location.href = questionDeleteUrl;
            });

            // Choice delete
            let choiceDeleteUrl;
            const cDelModal = new bootstrap.Modal(byId('confirmDeleteChoiceModal'));
            document.querySelectorAll('.delete-choice-btn').forEach(b => {
                b.addEventListener('click', () => {
                    choiceDeleteUrl = b.getAttribute('data-delete-url');
                    cDelModal.show();
                });
            });
            byId('confirmDeleteChoiceBtn').addEventListener('click', () => {
                if (choiceDeleteUrl) location.href = choiceDeleteUrl;
            });

            // Question edit
            const qEditModal = new bootstrap.Modal(byId('editQuestionModal'));
            const qForm     = byId('editQuestionForm');
            document.querySelectorAll('.edit-question-btn').forEach(b => {
                b.addEventListener('click', () => {
                    const id  = b.getAttribute('data-question-id');
                    const txt = b.getAttribute('data-question-text');
                    qForm.setAttribute('action', ctx + '/questions/edit/' + id);
                    byId('questionTextEdit').value = txt;
                    qEditModal.show();
                });
            });

            // Choice edit
            const cEditModal = new bootstrap.Modal(byId('editChoiceModal'));
            const cForm      = byId('editChoiceForm');
            document.querySelectorAll('.edit-choice-btn').forEach(b => {
                b.addEventListener('click', () => {
                    const id   = b.getAttribute('data-choice-id');
                    const txt  = b.getAttribute('data-choice-text');
                    const corr = b.getAttribute('data-choice-correct') === 'true';
                    cForm.setAttribute('action', ctx + '/choices/edit/' + id);
                    byId('choiceTextEdit').value      = txt;
                    byId('choiceCorrectEdit').checked = corr;
                    cEditModal.show();
                });
            });

            // Choice add
            const addModal = new bootstrap.Modal(byId('addChoiceModal'));
            const addForm  = byId('addChoiceForm');
            document.querySelectorAll('.add-choice-btn').forEach(b => {
                b.addEventListener('click', () => {
                    const qid = b.getAttribute('data-question-id');
                    addForm.setAttribute('action', ctx + '/choices/create/' + qid);
                    addModal.show();
                });
            });

            // Question create
            const createModal = new bootstrap.Modal(byId('createQuestionModal'));
            const createForm  = byId('createQuestionForm');
            document.querySelectorAll('.create-question-btn').forEach(b => {
                b.addEventListener('click', () => {
                    const tid = b.getAttribute('data-test-id');
                    createForm.setAttribute('action', ctx + '/questions/create/' + tid);
                    createModal.show();
                });
            });
        });
    </script>
</layout:layout>
