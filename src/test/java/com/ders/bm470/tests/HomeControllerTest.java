package com.ders.bm470.tests;


import com.ders.bm470.controller.HomeController;
import com.ders.bm470.service.TestService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.ui.Model;

import java.security.Principal;
import java.util.Arrays;
import java.util.Collections;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class HomeControllerTest {

    @Mock
    private TestService testService;

    @Mock
    private Model model;

    @Mock
    private Principal principal;

    @InjectMocks
    private HomeController homeController;

    private com.ders.bm470.model.Test createTest(Long id, String name) {
        com.ders.bm470.model.Test test = new com.ders.bm470.model.Test();
        test.setId(id);
        test.setName(name);
        return test;
    }

    @Test
    void home_ShouldAddAttributesAndReturnHomeView_WhenUserIsAdmin() {
        // Arrange
        when(principal.getName()).thenReturn("admin");
        when(testService.getAllTests()).thenReturn(Arrays.asList(
                createTest(1L, "Test 1"),
                createTest(2L, "Test 2")
        ));

        // Act
        String viewName = homeController.home(model, principal);

        // Assert
        assertEquals("home", viewName);
        verify(model).addAttribute("tests", testService.getAllTests());
        verify(model).addAttribute("isAdmin", true);
    }

    @Test
    void home_ShouldAddAttributesAndReturnHomeView_WhenUserIsNotAdmin() {
        // Arrange
        when(principal.getName()).thenReturn("regularUser");
        when(testService.getAllTests()).thenReturn(Collections.singletonList(
                createTest(1L, "Test 1")
        ));

        // Act
        String viewName = homeController.home(model, principal);

        // Assert
        assertEquals("home", viewName);
        verify(model).addAttribute("tests", testService.getAllTests());
        verify(model).addAttribute("isAdmin", false);
    }

    @Test
    void home_ShouldWork_WhenPrincipalIsNull() {
        // Arrange
        when(testService.getAllTests()).thenReturn(Collections.emptyList());

        // Act
        String viewName = homeController.home(model, null);

        // Assert
        assertEquals("home", viewName);
        verify(model).addAttribute("tests", Collections.emptyList());
        verify(model).addAttribute("isAdmin", false);
    }
}