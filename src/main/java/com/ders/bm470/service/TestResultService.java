package com.ders.bm470.service;
import com.ders.bm470.model.TestResult;
import com.ders.bm470.repository.TestResultRepository;
import com.ders.bm470.repository.UserRepository;
import com.ders.bm470.model.User;
import java.util.Optional;
import java.util.List;

public interface TestResultService {
    void saveResult(TestResult result);
    List<TestResult> getResultsByUser(User user);
    Optional<TestResult> findLastResultForUser(Long testId, String username);
}
