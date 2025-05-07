package com.ders.bm470.tests;

import com.ders.bm470.model.TestResult;
import com.ders.bm470.repository.TestResultRepository;
import com.ders.bm470.service.TestResultServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.*;

import static org.mockito.Mockito.*;

class TestResultServiceTest {

    @Mock
    private TestResultRepository testResultRepository;

    @InjectMocks
    private TestResultServiceImpl testResultService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void saveResult_shouldCallRepositorySave() {
        TestResult result = new TestResult();
        testResultService.saveResult(result);

        verify(testResultRepository, times(1)).save(result);
    }
}
