package com.ders.bm470.tests;


import com.ders.bm470.controller.QuestionController;
import com.ders.bm470.model.Question;
import com.ders.bm470.service.QuestionService;
import com.ders.bm470.service.TestService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.ui.Model;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class QuestionControllerTest {

    @Mock
    private QuestionService questionService;

    @Mock
    private TestService testService;

    @Mock
    private Model model;

    @InjectMocks
    private QuestionController questionController;

    private com.ders.bm470.model.Test test;
    private Question question;

    @BeforeEach
    void setUp() {
        test = new com.ders.bm470.model.Test();
        test.setId(1L);
        test.setName("Sample Test");

        question = new Question();
        question.setId(1L);
        question.setText("Sample Question");
        question.setTest(test);
    }

    @Test
    void showCreateForm_WithTestId_ShouldAddAttributes() {
        when(testService.getTestById(1L)).thenReturn(test);

        String viewName = questionController.showCreateForm(1L, model);

        assertEquals("create_question", viewName);
        verify(model).addAttribute(eq("question"), any(Question.class));
        verify(model).addAttribute("tests", test);
    }

    @Test
    void showCreateForm_WithoutTestId_ShouldAddAttributes() {
        String viewName = questionController.showCreateForm(null, model);

        assertEquals("create_question", viewName);
        verify(model).addAttribute(eq("question"), any(Question.class));
        verify(model, never()).addAttribute(eq("tests"), any());
    }

    @Test
    void createQuestion_ShouldSaveAndRedirect() {
        when(testService.getTestById(1L)).thenReturn(test);
        when(questionService.saveQuestion(any(Question.class))).thenReturn(question);

        String viewName = questionController.createQuestion(question, 1L);

        assertEquals("redirect:/tests/detail/1", viewName);
        verify(questionService).saveQuestion(question);
        assertEquals(test, question.getTest());
    }

    @Test
    void showEditForm_ShouldAddAttributes() {
        when(questionService.getQuestionById(1L)).thenReturn(question);
        when(testService.getTestById(1L)).thenReturn(test);

        String viewName = questionController.showEditForm(1L, model);

        assertEquals("redirect:/tests/detail/1", viewName);
        verify(model).addAttribute("question", question);
        verify(model).addAttribute("tests", test);
    }

    @Test
    void updateQuestion_ShouldUpdateAndRedirect() {
        Question existingQuestion = new Question();
        existingQuestion.setId(1L);
        existingQuestion.setText("Old Text");
        existingQuestion.setTest(test);

        when(questionService.getQuestionById(1L)).thenReturn(existingQuestion);
        when(questionService.saveQuestion(any(Question.class))).thenReturn(existingQuestion);

        String viewName = questionController.updateQuestion(1L, "New Text");

        assertEquals("redirect:/tests/detail/1", viewName);
        assertEquals("New Text", existingQuestion.getText());
        verify(questionService).saveQuestion(existingQuestion);
    }

    @Test
    void deleteQuestion_ShouldDeleteAndRedirect() {
        when(questionService.getQuestionById(1L)).thenReturn(question);

        String viewName = questionController.deleteQuestion(1L);

        assertEquals("redirect:/tests/detail/1", viewName);
        verify(questionService).deleteQuestionById(1L);
    }
}