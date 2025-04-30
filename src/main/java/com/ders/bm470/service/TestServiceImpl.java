package com.ders.bm470.service;

import com.ders.bm470.model.Test;
import com.ders.bm470.repository.TestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TestServiceImpl implements TestService {

    private final TestRepository testRepository;

    @Autowired
    public TestServiceImpl(TestRepository testRepository) {
        this.testRepository = testRepository;
        System.out.println("Injected TestRepository class: " + testRepository.getClass());
    }

    @Override
    @Transactional(readOnly = true)
    public Test getTestWithAllDetails(Long id) {
        return testRepository.findById(id)
                .map(test -> {
                    // questions ve her bir question'ın choices listesini initialize et
                    test.getQuestions().forEach(q -> q.getChoices().size());
                    return test;
                })
                .orElse(null);
    }

    @Override
    @Transactional
    public Test saveTest(Test test) {
        System.out.println("Saving test");
        return testRepository.save(test);
    }

    @Override
    public List<Test> getAllTests() {
        return testRepository.findAll();
    }

    @Override
    public Test getTestById(Long id) {
        return testRepository.findById(id).orElse(null);
    }

    @Override
    public void deleteTest(Long id) {
        testRepository.deleteById(id);
    }
}
