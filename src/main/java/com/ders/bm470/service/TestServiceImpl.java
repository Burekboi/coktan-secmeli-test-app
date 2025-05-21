package com.ders.bm470.service;

import com.ders.bm470.model.Test;
import com.ders.bm470.repository.TestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class TestServiceImpl implements TestService {

    private final TestRepository testRepository;

    @Autowired
    public TestServiceImpl(TestRepository testRepository) {
        this.testRepository = testRepository;
        System.out.println("Injected TestRepository class: " + testRepository.getClass());
    }

    @Override
    public Test getTestWithAllDetails(Long id) {
        Test test = testRepository.findById(id).orElseThrow();
        test.getQuestions().forEach(q -> q.getChoices().size()); // Lazy fetch tetikleme
        return test;
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
    @Transactional
    public void deleteTest(Long id) {
        System.out.println(">>> SİLME İŞLEMİ ÇALIŞTI ID = " + id);
        testRepository.deleteById(id);

    }
}
