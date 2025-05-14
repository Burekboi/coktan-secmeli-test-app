package com.ders.bm470.tests;


import com.ders.bm470.controller.LoginController;
import com.ders.bm470.model.User;
import com.ders.bm470.service.UserService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.ui.Model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class LoginControllerTest {

    @Mock
    private UserService userService;

    @Mock
    private Model model;

    @InjectMocks
    private LoginController loginController;

    @Test
    void showLoginPage_ShouldReturnLoginView() {
        String viewName = loginController.showLoginPage();
        assertEquals("login", viewName);
    }

    @Test
    void showLoginPageLogout_ShouldReturnLoginView() {
        String viewName = loginController.showLoginPageLogout();
        assertEquals("login", viewName);
    }

    @Test
    void registerUser_WithExistingUsername_ShouldReturnError() {
        // Arrange
        User user = new User();
        user.setUsername("existingUser");
        when(userService.existsByUsername("existingUser")).thenReturn(true);

        // Act
        String viewName = loginController.registerUser(user, model);

        // Assert
        assertEquals("login", viewName);
        verify(model).addAttribute("error", "Bu kullanıcı adı zaten kullanılıyor.");
        verify(userService, never()).register(any(User.class));
    }

    @Test
    void registerUser_WithNewUsername_ShouldRegisterAndRedirect() {
        // Arrange
        User user = new User();
        user.setUsername("newUser");
        when(userService.existsByUsername("newUser")).thenReturn(false);
        doNothing().when(userService).register(any(User.class));

        // Act
        String viewName = loginController.registerUser(user, model);

        // Assert
        assertEquals("redirect:/login?registered", viewName);
        verify(userService).register(user);
        verify(model, never()).addAttribute(eq("error"), any());
    }
}