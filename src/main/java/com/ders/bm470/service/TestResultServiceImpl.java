package com.ders.bm470.service;
import com.ders.bm470.repository.TestResultRepository;
import com.ders.bm470.repository.UserRepository;
import com.ders.bm470.model.TestResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import com.ders.bm470.model.User;




@Service
public class TestResultServiceImpl implements TestResultService {

    @Autowired
    private TestResultRepository testResultRepository;

    @Override
    @Transactional
    public void saveResult(TestResult result) {
        testResultRepository.save(result);
    }

    @Override
    public List<TestResult> getResultsByUser(User user) {
        return testResultRepository.findByUser(user);
    }
}
