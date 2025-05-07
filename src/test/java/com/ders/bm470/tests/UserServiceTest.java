package com.ders.bm470.tests;

import com.ders.bm470.model.User;
import com.ders.bm470.repository.UserRepository;
import com.ders.bm470.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class UserServiceTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private UserService userService;

    @BeforeEach
    void init() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void findByUsername_shouldReturnCorrectUser() {
        User mockUser = new User();
        mockUser.setUsername("ayse");

        when(userRepository.findByUsername("ayse")).thenReturn(mockUser);

        User found = userService.findByUsername("ayse");

        assertNotNull(found);
        assertEquals("ayse", found.getUsername());
        verify(userRepository, times(1)).findByUsername("ayse");
    }
}
