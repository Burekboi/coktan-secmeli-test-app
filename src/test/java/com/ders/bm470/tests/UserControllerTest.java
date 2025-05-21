package com.ders.bm470.tests;

import com.ders.bm470.controller.UserController;
import com.ders.bm470.model.TestResult;
import com.ders.bm470.model.User;
import com.ders.bm470.service.TestResultService;
import com.ders.bm470.service.TestService;
import com.ders.bm470.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.ui.Model;
import java.security.Principal;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UserControllerTest {

    @Mock
    private UserService userService;

    @Mock
    private TestService testService;

    @Mock
    private TestResultService testResultService;

    @Mock
    private Model model;

    @Mock
    private Principal principal;

    @InjectMocks
    private UserController userController;

    private User testUser;
    private List<TestResult> testResults;

    @BeforeEach
    void setUp() {
        testUser = new User();
        testUser.setUsername("testuser");
        testUser.setPassword("password123");

        TestResult result1 = new TestResult();
        TestResult result2 = new TestResult();
        testResults = Arrays.asList(result1, result2);
    }

    @Test
    void userHome_shouldAddTestsToModelAndReturnUserView() {
        // Arrange
        when(testService.getAllTests()).thenReturn(Arrays.asList());

        // Act
        String viewName = userController.userHome(model);

        // Assert
        assertEquals("user", viewName);
        verify(testService).getAllTests();
        verify(model).addAttribute("tests", Arrays.asList());
    }

    @Test
    void userProfile_shouldAddUserAndResultsToModelAndReturnProfileView() {
        // Arrange
        when(principal.getName()).thenReturn("testuser");
        when(userService.findByUsername("testuser")).thenReturn(testUser);
        when(testResultService.getResultsByUser(testUser)).thenReturn(testResults);

        // Act
        String viewName = userController.userProfile(model, principal);

        // Assert
        assertEquals("profile", viewName);
        verify(userService).findByUsername("testuser");
        verify(testResultService).getResultsByUser(testUser);
        verify(model).addAttribute("user", testUser);
        verify(model).addAttribute("results", testResults);
    }

}