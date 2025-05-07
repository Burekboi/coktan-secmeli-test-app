package com.ders.bm470.tests;

import com.ders.bm470.repository.TestRepository;
import com.ders.bm470.service.TestServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.*;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

class TestServiceTest {

    @Mock
    private TestRepository testRepository;

    @InjectMocks
    private TestServiceImpl testService;

    @BeforeEach
    void init() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void saveTest_shouldCallRepositoryAndReturnSavedTest() {
        com.ders.bm470.model.Test test = new com.ders.bm470.model.Test();
        test.setName("Genel Kültür");

        when(testRepository.save(test)).thenReturn(test);

        com.ders.bm470.model.Test saved = testService.saveTest(test);

        assertEquals("Genel Kültür", saved.getName());
        verify(testRepository, times(1)).save(test);
    }
}
