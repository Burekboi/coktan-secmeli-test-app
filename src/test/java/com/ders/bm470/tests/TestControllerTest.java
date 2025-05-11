package com.ders.bm470.tests;


import com.ders.bm470.controller.TestController;
import com.ders.bm470.model.*;
import com.ders.bm470.service.TestService;
import com.ders.bm470.service.TestResultService;
import com.ders.bm470.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.ui.Model;
import org.springframework.web.server.ResponseStatusException;
import jakarta.servlet.http.HttpSession;
import java.security.Principal;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class TestControllerTest {

    @Mock private TestService testService;
    @Mock private UserService userService;
    @Mock private TestResultService testResultService;
    @Mock private Model model;
    @Mock private HttpSession session;
    @Mock private Principal principal;

    @InjectMocks private TestController testController;

    private com.ders.bm470.model.Test test;
    private User user;
    private Question question;
    private Choice correctChoice;

    @BeforeEach
    void setUp() {
        test = new com.ders.bm470.model.Test();
        test.setId(1L);
        test.setName("Sample Test");

        user = new User();
        user.setUsername("testuser");

        question = new Question();
        question.setId(1L);
        question.setText("Sample Question");

        correctChoice = new Choice();
        correctChoice.setId(1L);
        correctChoice.setText("Correct Answer");
        correctChoice.setCorrect(true);

        Choice wrongChoice1 = new Choice();
        wrongChoice1.setId(2L);
        wrongChoice1.setText("Wrong Answer 1");
        wrongChoice1.setCorrect(false);

        Choice wrongChoice2 = new Choice();
        wrongChoice2.setId(3L);
        wrongChoice2.setText("Wrong Answer 2");
        wrongChoice2.setCorrect(false);

        question.setChoices(Arrays.asList(
                correctChoice,
                wrongChoice1,
                wrongChoice2
        ));

        test.setQuestions(Collections.singletonList(question));
    }

    @Test
    void showCreateTestForm_ShouldReturnCreateTestView() {
        String viewName = testController.showCreateTestForm(model);
        assertEquals("create_test", viewName);
        verify(model).addAttribute(eq("test"), any(com.ders.bm470.model.Test.class));
    }

    @Test
    void createTest_ShouldRedirectToHome() {
        when(testService.saveTest(any(com.ders.bm470.model.Test.class))).thenReturn(test);
        String viewName = testController.createTest(test);
        assertEquals("redirect:/home", viewName);
        verify(testService).saveTest(test);
    }

    @Test
    void showTestDetail_WithValidId_ShouldReturnDetailView() {
        when(testService.getTestWithAllDetails(1L)).thenReturn(test);
        String viewName = testController.showTestDetail(1L, model);
        assertEquals("test_detail", viewName);
        verify(model).addAttribute("test", test);
    }

    @Test
    void showTestDetail_WithInvalidId_ShouldThrowException() {
        when(testService.getTestWithAllDetails(99L)).thenReturn(null);
        assertThrows(ResponseStatusException.class, () -> {
            testController.showTestDetail(99L, model);
        });
    }

    @Test
    void showEditTestForm_WithValidId_ShouldReturnEditView() {
        when(testService.getTestById(1L)).thenReturn(test);
        String viewName = testController.showEditTestForm(1L, model);
        assertEquals("edit_test", viewName);
        verify(model).addAttribute("test", test);
    }

    @Test
    void updateTest_ShouldRedirectToHome() {
        com.ders.bm470.model.Test existingTest = new com.ders.bm470.model.Test();
        existingTest.setId(1L);
        existingTest.setName("Old Name");

        when(testService.getTestWithAllDetails(1L)).thenReturn(existingTest);
        when(testService.saveTest(any(com.ders.bm470.model.Test.class))).thenReturn(existingTest);

        test.setName("New Name");
        String viewName = testController.updateTest(1L, test);

        assertEquals("redirect:/home", viewName);
        assertEquals("New Name", existingTest.getName());
        verify(testService).saveTest(existingTest);
    }

    @Test
    void deleteTest_ShouldRedirectToHome() {
        doNothing().when(testService).deleteTest(1L);
        String viewName = testController.deleteTest(1L);
        assertEquals("redirect:/home", viewName);
        verify(testService).deleteTest(1L);
    }

    @Test
    void solveTest_FirstQuestion_ShouldInitializeAnswers() {
        // Given
        when(testService.getTestWithAllDetails(1L)).thenReturn(test);

        // When
        String viewName = testController.solveTest(1L, 0, null, model, session);

        // Then
        assertEquals("solve", viewName);
        verify(session).setAttribute(eq("answers"), any(List.class));
        verify(model).addAttribute("testId", 1L);
        verify(model).addAttribute("questionIndex", 0);
        verify(model).addAttribute(eq("question"), any(Question.class));
    }

    @Test
    void saveAnswer_ShouldUpdateSessionAndRedirect() {
        List<String> answers = new ArrayList<>(Collections.nCopies(1, null));
        when(session.getAttribute("answers")).thenReturn(answers);

        String viewName = testController.saveAnswer(1L, 0, "Answer", session);

        assertEquals("redirect:/tests/solve/1?q=1", viewName);
        assertEquals("Answer", answers.get(0));
    }

    @Test
    void showSummary_ShouldCalculateResultsAndSave() {
        List<String> answers = Collections.singletonList("Correct Answer");
        when(testService.getTestWithAllDetails(1L)).thenReturn(test);
        when(principal.getName()).thenReturn("testuser");
        when(userService.findByUsername("testuser")).thenReturn(user);
        // Void metodlar için doNothing() kullanın
        doNothing().when(testResultService).saveResult(any(TestResult.class));

        String viewName = testController.showSummary(1L, answers, session, model, principal);

        assertEquals("summary", viewName);
        verify(model).addAttribute("correct", 1);
        verify(model).addAttribute("incorrect", 0);
        verify(testResultService).saveResult(any(TestResult.class));
        verify(session).removeAttribute("answers");
    }
}