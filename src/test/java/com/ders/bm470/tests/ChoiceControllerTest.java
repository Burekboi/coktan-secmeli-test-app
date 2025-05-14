package com.ders.bm470.tests;


import com.ders.bm470.controller.ChoiceController;
import com.ders.bm470.model.Choice;
import com.ders.bm470.model.Question;
import com.ders.bm470.service.ChoiceService;
import com.ders.bm470.service.QuestionService;
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
class ChoiceControllerTest {

    @Mock
    private ChoiceService choiceService;

    @Mock
    private QuestionService questionService;

    @Mock
    private Model model;

    @InjectMocks
    private ChoiceController choiceController;

    private Question testQuestion;
    private Choice testChoice;
    private com.ders.bm470.model.Test test;

    @BeforeEach
    void setUp() {
        test = new com.ders.bm470.model.Test();
        test.setId(1L);

        testQuestion = new Question();
        testQuestion.setId(1L);
        testQuestion.setTest(test);

        testChoice = new Choice();
        testChoice.setId(1L);
        testChoice.setQuestion(testQuestion);
        testChoice.setText("Test Choice");
        testChoice.setCorrect(true);
    }

    @Test
    void showCreateForm_shouldAddAttributesAndReturnCreateChoiceView() {
        // Arrange
        when(questionService.getQuestionById(1L)).thenReturn(testQuestion);

        // Act
        String viewName = choiceController.showCreateForm(1L, model);

        // Assert
        assertEquals("create_choice", viewName);
        verify(questionService).getQuestionById(1L);
        verify(model).addAttribute(eq("choice"), any(Choice.class));
        verify(model).addAttribute(eq("question"), eq(testQuestion));
    }

    @Test
    void createChoice_shouldSaveChoiceAndRedirectToTestDetail() {
        // Arrange
        when(questionService.getQuestionById(1L)).thenReturn(testQuestion);

        // Act
        String redirectUrl = choiceController.createChoice(testChoice, 1L);

        // Assert
        assertEquals("redirect:/tests/detail/1", redirectUrl);
        verify(questionService).getQuestionById(1L);
        verify(choiceService).saveChoice(testChoice);
        assertEquals(testQuestion, testChoice.getQuestion());
    }

    @Test
    void showEditForm_shouldAddChoiceAndReturnEditChoiceView() {
        // Arrange
        when(choiceService.getChoiceById(1L)).thenReturn(testChoice);

        // Act
        String viewName = choiceController.showEditForm(1L, model);

        // Assert
        assertEquals("edit_choice", viewName);
        verify(choiceService).getChoiceById(1L);
        verify(model).addAttribute("choice", testChoice);
    }

    @Test
    void updateChoice_shouldUpdateChoiceAndRedirectToTestDetail() {
        // Arrange
        Choice updatedChoice = new Choice();
        updatedChoice.setText("Updated Choice");
        updatedChoice.setCorrect(false);

        when(choiceService.getChoiceById(1L)).thenReturn(testChoice);

        // Act
        String redirectUrl = choiceController.updateChoice(1L, updatedChoice);

        // Assert
        assertEquals("redirect:/tests/detail/1", redirectUrl);
        verify(choiceService).getChoiceById(1L);
        verify(choiceService).saveChoice(testChoice);
        assertEquals("Updated Choice", testChoice.getText());
        assertFalse(testChoice.isCorrect());
    }

    @Test
    void deleteChoice_shouldDeleteChoiceAndRedirectToTestDetail() {
        // Arrange
        when(choiceService.getChoiceById(1L)).thenReturn(testChoice);

        // Act
        String redirectUrl = choiceController.deleteChoice(1L);

        // Assert
        assertEquals("redirect:/tests/detail/1", redirectUrl);
        verify(choiceService).getChoiceById(1L);
        verify(choiceService).deleteChoiceById(1L);
    }

    @Test
    void showEditForm_shouldThrowExceptionWhenChoiceNotFound() {
        // Arrange
        when(choiceService.getChoiceById(1L)).thenReturn(null);

        // Act & Assert
        assertThrows(RuntimeException.class, () -> {
            choiceController.showEditForm(1L, model);
        });
    }

    @Test
    void deleteChoice_shouldThrowExceptionWhenChoiceNotFound() {
        // Arrange
        when(choiceService.getChoiceById(1L)).thenReturn(null);

        // Act & Assert
        assertThrows(RuntimeException.class, () -> {
            choiceController.deleteChoice(1L);
        });
    }
}